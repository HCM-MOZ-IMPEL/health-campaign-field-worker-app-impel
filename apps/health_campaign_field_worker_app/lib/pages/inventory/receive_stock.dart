import 'package:auto_route/auto_route.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management/blocs/record_stock.dart';
import 'package:inventory_management/models/entities/stock.dart';
import 'package:inventory_management/models/entities/transaction_reason.dart';
import 'package:inventory_management/models/entities/transaction_type.dart';
import 'package:inventory_management/utils/i18_key_constants.dart' as i18;
import '../../utils/i18_key_constants.dart' as i18_local;
import 'package:inventory_management/utils/utils.dart';
import 'package:registration_delivery/widgets/localized.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../blocs/auth/auth.dart';
import '../../router/app_router.dart';
import '../../utils/constants.dart';
import '../../utils/extensions/extensions.dart';
import 'package:collection/collection.dart';
import '../../utils/utils.dart';

import '../../widgets/custom_back_navigation.dart';

@RoutePage()
class ReceiveStockPage extends LocalizedStatefulWidget {
  final String mrnNumber;
  final List<StockModel> stockRecords;

  const ReceiveStockPage({
    super.key,
    super.appLocalizations,
    required this.mrnNumber,
    required this.stockRecords,
  });

  @override
  State<ReceiveStockPage> createState() => _ViewStockRecordsLGAPageState();
}

class _ViewStockRecordsLGAPageState extends LocalizedState<ReceiveStockPage> {
  late final FormGroup _form;
  late final Map<String, int> _issuedQuantities;
  bool _commentsRequired = false;
  bool isSubmitClicked = false;
  List<String> skuList = [];

  @override
  void initState() {
    super.initState();
    context
        .read<AuthBloc>()
        .add(const AuthUpdateProductSkuCountsEvent(skuCountUpdates: {}));
    _issuedQuantities = {
      for (final stock in widget.stockRecords)
        stock.additionalFields?.fields
                .firstWhereOrNull((f) => f.key == 'productName')
                ?.value
                .toString() ??
            '': int.tryParse(stock.quantity ?? '0') ?? 0
    };
    _form = FormGroup({
      'quantityReceived': FormControl<int>(
        validators: [
          Validators.required,
          Validators.min(1),
          Validators.delegate((control) {
            final productName = widget
                    .stockRecords.first.additionalFields?.fields
                    .firstWhereOrNull((f) => f.key == 'productName')
                    ?.value
                    .toString() ??
                '';
            final issued = _issuedQuantities[productName] ?? 0;
            final received = control.value ?? 0;
            if (received > issued) {
              return {'maxIssued': true};
            }
            return null;
          })
        ],
      ),
      'comments': FormControl<String>(),
    });
    _form.control('quantityReceived').valueChanges.listen((value) {
      final received = value ?? 0;
      final productName = widget.stockRecords.first.additionalFields?.fields
              .firstWhereOrNull((f) => f.key == 'productName')
              ?.value
              .toString() ??
          '';
      final issued = _issuedQuantities[productName] ?? 0;
      final required = received < issued;
      if (_commentsRequired != required) {
        setState(() {
          _commentsRequired = required;
        });
      }
    });
    _form.control('comments').setValidators([
      Validators.delegate((control) {
        final received = _form.control('quantityReceived').value ?? 0;
        final productName = widget.stockRecords.first.additionalFields?.fields
                .firstWhereOrNull((f) => f.key == 'productName')
                ?.value
                .toString() ??
            '';
        final issued = _issuedQuantities[productName] ?? 0;
        if (received < issued &&
            (control.value == null || control.value.isEmpty)) {
          control.markAllAsTouched();
          return {'requiredIfShort': true};
        }
        return null;
      })
    ]);
    _form.control('quantityReceived').valueChanges.listen((value) {
      _form.control('comments').updateValueAndValidity();
    });
    final recordStockBloc = BlocProvider.of<RecordStockBloc>(context);
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _handleSubmission() async {
    if (_form.valid && !isSubmitClicked) {
      isSubmitClicked = true;
      final updatedStocks = widget.stockRecords.map((stock) {
        final additionalFields = stock.additionalFields?.fields ?? [];

        final newFields = [
          ...additionalFields.where((field) =>
              field.key != 'quantityReceived' && field.key != 'comments'),
          AdditionalField('quantityReceived',
              _form.control('quantityReceived').value.toString()),
          AdditionalField(
            'quantitySent',
            stock.quantity ?? '',
          ),
          if (_form.control('comments').value != null)
            AdditionalField('comments', _form.control('comments').value),
        ];

        return stock.copyWith(
          id: null,
          rowVersion: 1,
          clientReferenceId: IdGen.i.identifier,
          transactionType: TransactionType.received.toValue(),
          transactionReason: TransactionReason.received.toValue(),
          quantity: _form.control('quantityReceived').value.toString(),
          additionalFields: stock.additionalFields?.copyWith(
            fields: newFields,
          ),
          auditDetails: AuditDetails(
            createdBy: InventorySingleton().loggedInUserUuid,
            createdTime: context.millisecondsSinceEpoch(),
            lastModifiedBy: InventorySingleton().loggedInUserUuid,
            lastModifiedTime: context.millisecondsSinceEpoch(),
          ),
          clientAuditDetails: ClientAuditDetails(
            createdBy: InventorySingleton().loggedInUserUuid,
            createdTime: context.millisecondsSinceEpoch(),
            lastModifiedBy: InventorySingleton().loggedInUserUuid,
            lastModifiedTime: context.millisecondsSinceEpoch(),
          ),
        );
      }).toList();

      final stockState = context.read<RecordStockBloc>().state;
      for (final stock in updatedStocks) {
        final bloc = RecordStockBloc(
          stockRepository: context.repository<StockModel, StockSearchModel>(),
          RecordStockCreateState(
            entryType: stockState.entryType,
            projectId: InventorySingleton().projectId,
            dateOfRecord: DateTime.now(),
            facilityModel: stockState.facilityModel ??
                FacilityModel(
                  id: stockState.primaryId ?? context.loggedInUserUuid,
                ),
            primaryId: stockState.primaryId,
            primaryType: stockState.primaryType,
          ),
        );

        bloc.add(
          RecordStockSaveStockDetailsEvent(
            stockModel: stock,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 500), () {});
        bloc.add(
          const RecordStockCreateStockEntryEvent(),
        );

        bloc.close();

        //TODO: old
        // context.read<RecordStockBloc>().add(
        //       RecordStockSaveStockDetailsEvent(
        //         stockModel: stock,
        //       ),
        //     );
        // context.read<RecordStockBloc>().add(
        //       const RecordStockCreateStockEntryEvent(),
        //     );

        // end of it
        // if (InventorySingleton().isDistributor) {
        final totalQty =
            int.parse(_form.control('quantityReceived').value.toString());

        Map<String, int> skuCounts = context
            .getAllProductSkuCounts()
            .map((key, value) => MapEntry(key, value));

        if (skuCounts.isNotEmpty) {
          skuList = skuCounts.keys.toList();
        }

        String productName = stock.additionalFields?.fields
            .firstWhereOrNull((element) => element.key == "productName")
            ?.value;
        if (skuList.contains(productName)) {
          skuCounts[productName] = (skuCounts[productName] ?? 0) + totalQty;
        }
        context.read<AuthBloc>().add(
              AuthUpdateProductSkuCountsEvent(
                skuCountUpdates: skuCounts,
              ),
            );
        await Future.delayed(const Duration(milliseconds: 500));
        // _tabController.animateTo(_tabController.index + 1);
        // await Future.delayed(const Duration(milliseconds: 500));
        // context.read<RecordStockBloc>().add(
        //       const RecordStockCreateStockEntryEvent(),
        //     );
        // }
      }

      context.router.push(
        CustomAcknowledgementRoute(
            mrnNumber: widget.mrnNumber,
            stockRecords: updatedStocks,
            entryType: StockRecordEntryType.receipt),
      );
    } else {
      _form.markAllAsTouched();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Assumption sender receiver Id not changed ,
    //using the same as downloaded stock data
    // and this flow is for stock receipt for LGA
    final senderIdToShowOnTab = widget.stockRecords.first.senderId;
    bool commentRequired = false;
    var isDistributorOrTeamSupervisor =
        context.isCDD || context.isTeamSupervisor ? false : true;

    return Scaffold(
      body: ScrollableContent(
        header: const Column(
          children: [
            CustomBackNavigationHelpHeaderWidget(),
          ],
        ),
        children: [
          ReactiveForm(
            formGroup: _form,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DigitCard(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.translate(i18_local
                                .stockDetails.stockDetailsReceiptLabel),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(localizations.translate(
                                      i18_local.stockDetails.mrnNumberLabel))),
                              Expanded(child: Text(widget.mrnNumber)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(localizations.translate(i18_local
                                      .inventoryReportDetails
                                      .receivedFromText))),
                              // TODO : verify this , showing senderId here
                              Expanded(
                                child: Text(localizations
                                    .translate('FAC_$senderIdToShowOnTab')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...widget.stockRecords.map((stock) {
                    final productName = stock.additionalFields?.fields
                            .firstWhere(
                              (field) => field.key == 'productName',
                              orElse: () =>
                                  const AdditionalField('productName', ''),
                            )
                            .value
                            ?.toString() ??
                        '';

                    return Column(
                      children: [
                        DigitCard(
                          padding: const EdgeInsets.all(16),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localizations.translate(productName),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: productName == 'SPAQ 1' ||
                                            productName == 'SPAQ 2'
                                        ? Colors.orange
                                        : productName == 'Red VAS'
                                            ? Colors.red
                                            : productName == 'Blue VAS'
                                                ? Colors.blue
                                                : Theme.of(context)
                                                    .primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                if (isDistributorOrTeamSupervisor) ...[
                                  InputField(
                                    type: InputType.text,
                                    label:
                                        '${localizations.translate(i18.stockDetails.waybillNumberLabel)}*',
                                    initialValue: stock.wayBillNumber ?? '',
                                    isDisabled: true,
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 12),
                                  InputField(
                                    type: InputType.text,
                                    label: localizations.translate(
                                      i18_local.stockDetails.batchNumberLabel,
                                    ),
                                    initialValue: stock.additionalFields?.fields
                                            .firstWhere(
                                              (field) =>
                                                  field.key == 'batchNumber',
                                              orElse: () =>
                                                  const AdditionalField(
                                                      'batchNumber', ''),
                                            )
                                            .value
                                            ?.toString() ??
                                        '',
                                    isDisabled: true,
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                InputField(
                                  type: InputType.text,
                                  label:
                                      '${localizations.translate(i18_local.stockDetails.quantitySentByWarehouse)}*',
                                  initialValue: stock.quantity ?? '',
                                  isDisabled: true,
                                  readOnly: true,
                                ),
                                const SizedBox(height: 12),
                                ReactiveWrapperField(
                                  formControlName: 'quantityReceived',
                                  builder: (field) => InputField(
                                    type: InputType.text,
                                    label: localizations.translate(i18_local
                                        .stockDetails.actualQuantityReceived),
                                    errorMessage: field.errorText,
                                    keyboardType: TextInputType.number,
                                    isRequired: true,
                                    onChange: (value) {
                                      if (value != null && value.isNotEmpty) {
                                        field.control.value =
                                            int.tryParse(value);
                                      } else {
                                        field.control.value = null;
                                      }
                                    },
                                  ),
                                  validationMessages: {
                                    'required': (_) => localizations.translate(
                                        i18_local
                                            .stockDetails.qantityRequiredError),
                                    'min': (_) => localizations.translate(
                                        i18_local.stockDetails.minNumber),
                                    'number': (_) => localizations.translate(
                                        i18_local
                                            .stockDetails.validNumberError),
                                    'maxIssued': (_) => localizations.translate(
                                        i18_local.stockDetails
                                            .receivedQuantityError),
                                  },
                                ),
                                const SizedBox(height: 12),
                                ReactiveWrapperField(
                                  formControlName: 'comments',
                                  validationMessages: {
                                    'requiredIfShort': (_) =>
                                        localizations.translate(i18_local
                                            .stockDetails
                                            .commentRequiredErrorLessQuantity),
                                  },
                                  builder: (field) => InputField(
                                    isRequired: _commentsRequired,
                                    type: InputType.textArea,
                                    label:
                                        '${localizations.translate(i18.stockDetails.commentsLabel)}',
                                    errorMessage: field.errorText,
                                    onChange: (value) =>
                                        field.control.value = value,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  DigitButton(
                    label: localizations.translate(i18.common.coreCommonSubmit),
                    onPressed: _handleSubmission,
                    type: DigitButtonType.primary,
                    size: DigitButtonSize.large,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
