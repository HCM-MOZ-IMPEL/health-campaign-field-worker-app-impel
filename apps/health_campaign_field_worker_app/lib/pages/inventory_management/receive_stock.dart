import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_dialog.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management/blocs/record_stock.dart';
import 'package:inventory_management/models/entities/stock.dart';
import 'package:inventory_management/models/entities/transaction_reason.dart';
import 'package:inventory_management/models/entities/transaction_type.dart';
import 'package:inventory_management/utils/i18_key_constants.dart' as i18;
import '../../utils/i18_key_constants.dart' as i18_local;
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18_reg;
import 'package:inventory_management/utils/utils.dart';
import 'package:registration_delivery/widgets/localized.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:collection/collection.dart';

import '../../blocs/auth/auth.dart';
import '../../router/app_router.dart';
import '../../utils/extensions/extensions.dart';

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
  State<ReceiveStockPage> createState() => _ReceiveStockPageState();
}

class _ReceiveStockPageState extends LocalizedState<ReceiveStockPage>
    with SingleTickerProviderStateMixin {
  late final List<FormGroup> _forms;
  late TabController _tabController;

  final String _actualQuantityReceivedKey = 'actualQuantityReceived';
  final String _commentsKey = 'comments';

  @override
  void initState() {
    super.initState();
    context
        .read<AuthBloc>()
        .add(const AuthUpdateProductSKUCountsEvent(skuCounts: {}));
    _forms = widget.stockRecords.map((stock) {
      return FormGroup({
        _actualQuantityReceivedKey: FormControl<int>(
          validators: [
            Validators.required,
            Validators.min(1),
          ],
        ),
        _commentsKey: FormControl<String>(),
      });
    }).toList();

    _tabController =
        TabController(length: widget.stockRecords.length, vsync: this);
  }

  @override
  void dispose() {
    for (final form in _forms) {
      form.dispose();
    }
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmission(List<StockModel> stockRecords) async {
    final theme = Theme.of(context);
    // Validate current form
    final currentForm = _forms[_tabController.index];
    currentForm.markAllAsTouched();
    final quantityReceived =
        currentForm.control(_actualQuantityReceivedKey).value;
    final stockQuantity =
        int.tryParse(stockRecords[_tabController.index].quantity ?? '0') ?? 0;
    final currentComment = currentForm.control(_commentsKey).value;
    if ((quantityReceived == null ||
            (quantityReceived is int && quantityReceived < stockQuantity)) &&
        (currentComment == null || currentComment.trim() == '')) {
      await DigitToast.show(context,
          options: DigitToastOptions('Comment is required', true, theme));
      return;
    }
    if (quantityReceived == null ||
        (quantityReceived is int && quantityReceived > stockQuantity)) {
      await DigitToast.show(context,
          options: DigitToastOptions(
              'Received quantity can not be more than issued quantity',
              true,
              theme));
      return;
    }

    if (!currentForm.valid) {
      return;
    }

    if (_tabController.index < widget.stockRecords.length - 1) {
      // Move to next tab
      _tabController.animateTo(_tabController.index + 1);
    } else {
      final shouldSubmit = await DigitDialog.show<bool>(
        context,
        options: DigitDialogOptions(
          titleText: localizations.translate(
            i18_reg.deliverIntervention.dialogTitle,
          ),
          contentText: localizations.translate(
            i18_reg.deliverIntervention.dialogContent,
          ),
          primaryAction: DigitDialogActions(
            label: localizations.translate(
              i18.common.coreCommonSubmit,
            ),
            action: (ctx) {
              Navigator.of(ctx, rootNavigator: true).pop(true);
            },
          ),
          secondaryAction: DigitDialogActions(
            label: localizations.translate(
              i18.common.coreCommonGoback,
            ),
            action: (ctx) {
              Navigator.of(ctx, rootNavigator: true).pop(false);
            },
          ),
        ),
      );

      if (!shouldSubmit!) return;
      // Final submission - validate all forms
      bool allValid = true;
      for (int i = 0; i < _forms.length; i++) {
        _forms[i].markAllAsTouched();
        if (!_forms[i].valid) {
          allValid = false;
          _tabController.animateTo(i);
          break;
        }
      }

      if (!allValid) {
        return;
      }

      // Proceed with final submission
      context.read<RecordStockBloc>().add(
            RecordStockSaveTransactionDetailsEvent(
              dateOfRecord: DateTime.now(),
              facilityModel: FacilityModel(
                id: context.loggedInUserUuid,
              ),
              primaryId: context.loggedInUserUuid,
              primaryType: "STAFF",
            ),
          );

      final updatedStocks = widget.stockRecords.map((stock) {
        final additionalFields = stock.additionalFields?.fields ?? [];
        int index = widget.stockRecords.indexOf(stock);
        final form = _forms[widget.stockRecords.indexOf(stock)];

        final newFields = [
          ...additionalFields.where((field) =>
              field.key != _actualQuantityReceivedKey &&
              field.key != _commentsKey),
          AdditionalField(_actualQuantityReceivedKey,
              form.control(_actualQuantityReceivedKey).value.toString()),
          if (form.control(_commentsKey).value != null)
            AdditionalField(_commentsKey, form.control(_commentsKey).value),
          const AdditionalField('received', 'true'),
        ];

        return stock.copyWith(
          id: null,
          rowVersion: 1,
          referenceId: context.projectId,
          clientReferenceId: IdGen.i.identifier,
          transactionType: TransactionType.received.toValue(),
          transactionReason: TransactionReason.received.toValue(),
          quantity: form.control(_actualQuantityReceivedKey).value.toString(),
          additionalFields: stock.additionalFields?.copyWith(
            fields: newFields,
          ),
          dateOfEntry: DateTime.now().millisecondsSinceEpoch,
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

      for (final stock in updatedStocks) {
        context.read<RecordStockBloc>().add(
              RecordStockSaveStockDetailsEvent(
                stockModel: stock,
              ),
            );
        context.read<RecordStockBloc>().add(
              const RecordStockCreateStockEntryEvent(),
            );

        final totalQty = int.parse(_forms[updatedStocks.indexOf(stock)]
            .control(_actualQuantityReceivedKey)
            .value
            .toString());

        Map<String, int> skuCounts = context
            .getAllProductSkuCounts()
            .map((key, value) => MapEntry(key, value));

        String productName = stock.additionalFields?.fields
            .firstWhereOrNull((element) => element.key == "productName")
            ?.value;

        skuCounts[productName] = totalQty;

        context.read<AuthBloc>().add(
              AuthUpdateProductSKUCountsEvent(
                skuCounts: skuCounts,
              ),
            );
      }
      await Future.delayed(const Duration(milliseconds: 500));
      context.router.push(
        CustomAcknowledgementRoute(
            mrnNumber: widget.mrnNumber,
            stockRecords: updatedStocks,
            entryType: StockRecordEntryType.receipt),
      );
    }
  }

  Widget _buildProductTab(StockModel stock) {
    final index = widget.stockRecords.indexOf(stock);
    final productName = stock.additionalFields?.fields
            .firstWhere(
              (field) => field.key == 'productName',
              orElse: () => const AdditionalField('productName', ''),
            )
            .value
            ?.toString() ??
        '';

    String? batchNumber = stock.additionalFields?.fields
        .firstWhere(
          (field) => field.key == 'batchNumber',
          orElse: () => const AdditionalField('batchNumber', ''),
        )
        .value;

    String? wayBillNumber = stock.wayBillNumber;

    return ReactiveForm(
      formGroup: _forms[index],
      child: Column(
        children: [
          DigitCard(
            padding: const EdgeInsets.all(16),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: productName == 'SPAQ 1' || productName == 'SPAQ 2'
                          ? Colors.orange
                          : productName == 'Red VAS'
                              ? Colors.red
                              : productName == 'Blue VAS'
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (wayBillNumber != null && wayBillNumber.isNotEmpty)
                    InputField(
                      type: InputType.text,
                      label: localizations.translate(
                          i18_local.inventoryReportDetails.waybillNumberText),
                      initialValue: wayBillNumber,
                      isDisabled: true,
                      readOnly: true,
                    ),
                  if (wayBillNumber != null && wayBillNumber.isNotEmpty)
                    const SizedBox(height: 12),
                  if (batchNumber != null && batchNumber.isNotEmpty)
                    InputField(
                      type: InputType.text,
                      label: localizations.translate(
                          i18_local.inventoryReportDetails.batchNumberText),
                      initialValue: batchNumber,
                      isDisabled: true,
                      readOnly: true,
                    ),
                  if (batchNumber != null && batchNumber.isNotEmpty)
                    const SizedBox(height: 12),
                  InputField(
                    type: InputType.text,
                    label: localizations.translate(i18_local
                        .inventoryReportDetails.quantityReceivedByWarehouse),
                    initialValue: stock.quantity ?? '',
                    isDisabled: true,
                    readOnly: true,
                  ),
                  const SizedBox(height: 12),
                  ReactiveWrapperField(
                    formControlName: _actualQuantityReceivedKey,
                    builder: (field) => InputField(
                      initialValue: _forms[index]
                          .control(_actualQuantityReceivedKey)
                          .value
                          ?.toString(),
                      type: InputType.text,
                      label: localizations.translate(i18_local
                          .inventoryReportDetails.actualQuantityReceived),
                      errorMessage: field.errorText,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]'),
                        ),
                        LengthLimitingTextInputFormatter(9),
                      ],
                      onChange: (value) {
                        if (value != null && value.isNotEmpty) {
                          _forms[index]
                              .control(_actualQuantityReceivedKey)
                              .value = int.tryParse(value);
                        } else {
                          _forms[index]
                              .control(_actualQuantityReceivedKey)
                              .value = null;
                        }
                        setState(() {});
                      },
                    ),
                    validationMessages: {
                      'required': (_) => 'Quantity is required',
                      'min': (_) => 'Must be at least 1',
                      'number': (_) => 'Must be a valid number',
                    },
                  ),
                  const SizedBox(height: 12),
                  ReactiveWrapperField(
                    formControlName: _commentsKey,
                    builder: (field) => InputField(
                      initialValue:
                          _forms[index].control(_commentsKey).value?.toString(),
                      type: InputType.textArea,
                      label: localizations.translate(
                          i18_local.inventoryReportDetails.commentsText),
                      errorMessage: field.errorText,
                      onChange: (value) => field.control.value = value,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final senderIdToShowOnTab = widget.stockRecords.first.senderId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Records - ${widget.mrnNumber}'),
        bottom: TabBar(
          controller: _tabController,
          tabs: widget.stockRecords.map((stock) {
            final productName = stock.additionalFields?.fields
                    .firstWhere(
                      (field) => field.key == 'productName',
                      orElse: () => AdditionalField('productName', ''),
                    )
                    .value
                    ?.toString() ??
                '';
            return Tab(text: productName);
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          DigitCard(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.translate(i18_local
                        .inventoryReportDetails.stockReceiptDetailsText),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: Text(localizations.translate(i18_local
                              .acknowledgementSuccess.mrnNumberLabel))),
                      Expanded(child: Text(widget.mrnNumber)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          child: Text(localizations.translate(i18_local
                              .inventoryReportDetails.receivedFromText))),
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.stockRecords.map((stock) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildProductTab(stock),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DigitButton(
              label: _tabController.index < widget.stockRecords.length - 1
                  ? localizations.translate(i18.common.coreCommonNext)
                  : localizations.translate(i18.common.coreCommonSubmit),
              onPressed: () => _handleSubmission(widget.stockRecords),
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
            ),
          ),
        ],
      ),
    );
  }
}
