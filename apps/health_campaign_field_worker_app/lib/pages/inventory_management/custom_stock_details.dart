import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
// import 'package:digit_ui_components/widgets/atoms/digit_reactive_dropdown.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_scanner/blocs/scanner.dart';

import '../../blocs/inventory_management/stock_bloc.dart';
import '../../router/app_router.dart';
import '../../utils/constants.dart';
import '../../utils/extensions/extensions.dart';
import 'custom_stock_details_in_tabs.dart';
import 'qr_scanner.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/services/location_bloc.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/utils/component_utils.dart';
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:inventory_management/inventory_management.dart';
import 'package:inventory_management/router/inventory_router.gm.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:inventory_management/utils/i18_key_constants.dart' as i18;
import 'package:inventory_management/widgets/localized.dart';
import 'package:inventory_management/blocs/product_variant.dart';
import 'package:inventory_management/blocs/record_stock.dart';
import 'package:inventory_management/widgets/back_navigation_help_header.dart';

import '../../utils/i18_key_constants.dart' as i18_local;
import '../../utils/utils_smc/i18_key_constants.dart' as i18_local_smc;

@RoutePage()
class CustomStockDetailsPage extends LocalizedStatefulWidget {
  const CustomStockDetailsPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<CustomStockDetailsPage> createState() => CustomStockDetailsPageState();
}

class CustomStockDetailsPageState
    extends LocalizedState<CustomStockDetailsPage> {
  static const _productVariantKey = 'productVariant';
  static const _secondaryPartyKey = 'secondaryParty';
  static const _vehicleNumberKey = 'vehicleNumber';
  static const _typeOfTransportKey = 'typeOfTransport';
  static const _driverNameKey = 'driverName';
  static const _deliveryTeamKey = 'deliveryTeam';
  bool deliveryTeamSelected = false;
  String? selectedFacilityId;
  List<InventoryTransportTypes> transportTypes = [];

  List<GS1Barcode> scannedResources = [];
  TextEditingController controller1 = TextEditingController();

  FormGroup _form(StockRecordEntryType stockType) {
    return fb.group({
      _productVariantKey: FormControl<List<ProductVariantModel>>(
        value: [],
        validators: [
          Validators.required,
        ],
      ),
      _secondaryPartyKey: FormControl<String>(
        validators: [Validators.required],
      ),
      _vehicleNumberKey: FormControl<String>(),
      _typeOfTransportKey: FormControl<String>(),
      _driverNameKey: FormControl<String>(
        validators: [],
      ),
      _deliveryTeamKey: FormControl<String>(
        validators: deliveryTeamSelected ? [Validators.required] : [],
      ),
    });
  }

  @override
  void initState() {
    clearQRCodes();
    transportTypes = InventorySingleton().transportType;
    context.read<LocationBloc>().add(const LoadLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final isHealthFacilitySupervisor = context.isSpaqManager;
    final isCommunitySupervisor = context.isCommunitySupervisor;
    final isCommunityDistributor = context.isCommunityDistributor;
    bool isWareHouseMgr = InventorySingleton().isWareHouseMgr;
    final isBednetManager = context.isBednetManager;

    return PopScope(
      onPopInvoked: (didPop) {
        final stockState = context.read<RecordStockBloc>().state;
        if (stockState.primaryId != null) {
          context.read<DigitScannerBloc>().add(
                DigitScannerEvent.handleScanner(
                  barCode: [],
                  qrCode: [stockState.primaryId.toString()],
                ),
              );
        }
      },
      child: Scaffold(
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            return BlocConsumer<RecordStockBloc, RecordStockState>(
              listener: (context, stockState) {
                stockState.mapOrNull(
                  persisted: (value) {
                    final parent = context.router.parent() as StackRouter;
                    // todo : verify this , not needed now as routing done from stock details tab page
                    // parent.replace(
                    //   InventoryAcknowledgementRoute(),
                    // );
                  },
                );
              },
              builder: (context, stockState) {
                StockRecordEntryType entryType = stockState.entryType;

                const module = i18.stockDetails;

                String pageTitleMain = module.transactionDetailsLabel;
                String pageTitle;
                String quantityCountLabel;
                String? quantityPartialCountLabel;
                String? transactionReasonLabel;
                String? transactionReason;
                String transactionType;

                List<String>? reasons;

                switch (entryType) {
                  case StockRecordEntryType.receipt:
                    pageTitle = module.receivedPageTitle;
                    quantityCountLabel =
                        i18.inventoryReportDetails.receiptQuantityLabel;
                    transactionType = TransactionType.received.toValue();

                    break;
                  case StockRecordEntryType.dispatch:
                    pageTitle = InventorySingleton().isDistributor
                        ? module.returnedPageTitle
                        : module.issuedPageTitle;
                    quantityCountLabel = InventorySingleton().isDistributor
                        ? module.returnedPageTitle
                        : i18.inventoryReportDetails.returnedQuantityLabel;
                    quantityPartialCountLabel = i18_local
                        .inventoryReportDetails.partialReturnedQuantityLabel;
                    transactionType = TransactionType.dispatched.toValue();

                    break;
                  case StockRecordEntryType.returned:
                    pageTitle = module.returnedPageTitle;
                    quantityCountLabel =
                        i18.inventoryReportDetails.returnedQuantityLabel;
                    quantityPartialCountLabel = i18_local
                        .inventoryReportDetails.partialReturnedQuantityLabel;
                    transactionType = TransactionType.received.toValue();

                    break;
                  case StockRecordEntryType.loss:
                    pageTitle = module.lostPageTitle;
                    quantityCountLabel = module.quantityLostLabel;
                    transactionReasonLabel = module.transactionReasonLost;
                    transactionType = TransactionType.dispatched.toValue();

                    reasons = [
                      TransactionReason.lostInStorage.toValue(),
                      TransactionReason.lostInTransit.toValue(),
                    ];
                    break;
                  case StockRecordEntryType.damaged:
                    pageTitle = module.damagedPageTitle;
                    quantityCountLabel = module.quantityDamagedLabel;
                    transactionReasonLabel = module.transactionReasonDamaged;
                    transactionType = TransactionType.dispatched.toValue();

                    reasons = [
                      TransactionReason.damagedInStorage.toValue(),
                      TransactionReason.damagedInTransit.toValue(),
                    ];
                    break;
                }

                transactionReasonLabel ??= '';

                return ReactiveFormBuilder(
                  form: () => _form(entryType),
                  builder: (context, form, child) {
                    return BlocBuilder<DigitScannerBloc, DigitScannerState>(
                        builder: (context, scannerState) {
                      if (scannerState.barCodes.isNotEmpty) {
                        scannedResources.clear();
                        scannedResources.addAll(scannerState.barCodes);
                      }

                      return ScrollableContent(
                        header: Column(children: [
                          BackNavigationHelpHeaderWidget(
                            showHelp: false,
                            handleBack: () {
                              final stockState =
                                  context.read<RecordStockBloc>().state;
                              if (stockState.primaryId != null) {
                                context.read<DigitScannerBloc>().add(
                                      DigitScannerEvent.handleScanner(
                                        barCode: [],
                                        qrCode: [
                                          stockState.primaryId.toString()
                                        ],
                                      ),
                                    );
                              }
                            },
                          ),
                        ]),
                        enableFixedDigitButton: true,
                        footer: DigitCard(
                          margin: const EdgeInsets.fromLTRB(0, spacer2, 0, 0),
                          children: [
                            ReactiveFormConsumer(builder: (BuildContext context,
                                FormGroup form, Widget? child) {
                              if (form
                                      .control(_deliveryTeamKey)
                                      .value
                                      .toString()
                                      .isEmpty ||
                                  form.control(_deliveryTeamKey).value ==
                                      null ||
                                  scannerState.qrCodes.isNotEmpty) {
                                form.control(_deliveryTeamKey).value =
                                    scannerState.qrCodes.isNotEmpty
                                        ? scannerState.qrCodes.last
                                        : '';
                              }
                              return DigitButton(
                                type: DigitButtonType.primary,
                                size: DigitButtonSize.large,
                                mainAxisSize: MainAxisSize.max,
                                onPressed: () async {
                                  form.markAllAsTouched();
                                  if (!form.valid) {
                                    return;
                                  }
                                  if (form
                                      .control(_productVariantKey)
                                      .value
                                      .isEmpty) {
                                    Toast.showToast(
                                      context,
                                      type: ToastType.error,
                                      message: localizations.translate(
                                        i18_local.stockDetails.productRequired,
                                      ),
                                    );
                                    return;
                                  }
                                  if (deliveryTeamSelected &&
                                      form
                                          .control(_deliveryTeamKey)
                                          .value
                                          .isEmpty) {
                                    Toast.showToast(
                                      context,
                                      type: ToastType.error,
                                      message: localizations.translate(
                                        i18.stockDetails.teamCodeRequired,
                                      ),
                                    );
                                    return;
                                  }
                                  final primaryId =
                                      BlocProvider.of<RecordStockBloc>(
                                    context,
                                  ).state.primaryId;
                                  final secondaryParty =
                                      selectedFacilityId != null
                                          ? FacilityModel(
                                              id: selectedFacilityId.toString(),
                                            )
                                          : null;
                                  final deliveryTeamName = form
                                      .control(_deliveryTeamKey)
                                      .value as String?;

                                  if (deliveryTeamSelected &&
                                      (form
                                                  .control(
                                                    _deliveryTeamKey,
                                                  )
                                                  .value ==
                                              null ||
                                          form
                                              .control(_deliveryTeamKey)
                                              .value
                                              .toString()
                                              .trim()
                                              .isEmpty)) {
                                    Toast.showToast(
                                      context,
                                      type: ToastType.error,
                                      message: localizations.translate(
                                        i18.stockDetails.teamCodeRequired,
                                      ),
                                    );
                                  } else if ((primaryId ==
                                          secondaryParty?.id) ||
                                      (primaryId == deliveryTeamName)) {
                                    Toast.showToast(
                                      context,
                                      type: ToastType.error,
                                      message: localizations.translate(
                                        i18.stockDetails
                                            .senderReceiverValidation,
                                      ),
                                    );
                                  } else {
                                    // Logger().d(
                                    //     "This is the form data ${form.control(_productVariantKey).value as List<ProductVariantModel>}");
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    context
                                        .read<LocationBloc>()
                                        .add(const LoadLocationEvent());

                                    DigitComponentsUtils.showDialog(
                                        context,
                                        localizations.translate(
                                            i18.common.locationCapturing),
                                        DialogType.inProgress);
                                    Future.delayed(const Duration(seconds: 2),
                                        () async {
                                      DigitComponentsUtils.hideDialog(context);
                                      final bloc =
                                          context.read<RecordStockBloc>();

                                      // todo nik to be moved to next page logic
                                      final productVariant = form
                                          .control(_productVariantKey)
                                          .value as List<ProductVariantModel>;

                                      switch (entryType) {
                                        case StockRecordEntryType.receipt:
                                          transactionReason = TransactionReason
                                              .received
                                              .toValue();
                                          break;
                                        case StockRecordEntryType.dispatch:
                                          transactionReason = null;
                                          break;
                                        case StockRecordEntryType.returned:
                                          transactionReason = TransactionReason
                                              .returned
                                              .toValue();
                                          break;
                                        default:
                                          transactionReason = null;

                                          break;
                                      }

                                      final typeOfTransport = form
                                          .control(_typeOfTransportKey)
                                          .value as String?;

                                      final vehicleNumber = form
                                          .control(_vehicleNumberKey)
                                          .value as String?;

                                      final driverName = form
                                          .control(_driverNameKey)
                                          .value as String?;

                                      final lat = locationState.latitude;
                                      final lng = locationState.longitude;

                                      final hasLocationData =
                                          lat != null && lng != null;

                                      // final comments = form
                                      //     .control(_commentsKey)
                                      //     .value as String?;

                                      final deliveryTeamName = form
                                          .control(_deliveryTeamKey)
                                          .value as String?;

                                      final primaryType =
                                          BlocProvider.of<RecordStockBloc>(
                                        context,
                                      ).state.primaryType;

                                      final primaryId =
                                          BlocProvider.of<RecordStockBloc>(
                                        context,
                                      ).state.primaryId;

                                      if (form.valid) {
                                        final selectedProducts = form
                                            .control(_productVariantKey)
                                            .value as List<ProductVariantModel>;

                                        context.read<StockBloc>().add(
                                              StockSelectedEvent(
                                                selectedProducts:
                                                    selectedProducts,
                                                secondaryPartyType:
                                                    deliveryTeamSelected
                                                        ? "STAFF"
                                                        : "WAREHOUSE",
                                                receivedFrom: (deliveryTeamSelected
                                                        ? deliveryTeamName
                                                        : selectedFacilityId) ??
                                                    "",
                                                typeOfTransport:
                                                    typeOfTransport,
                                                vehicleNumber: vehicleNumber,
                                                driverName: driverName,
                                              ),
                                            );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                              value: context.read<StockBloc>(),
                                              child: DynamicTabsPage(),
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  }
                                },
                                // isDisabled: !form.valid,
                                label: localizations
                                    .translate(i18.common.coreCommonNext),
                              );
                            })
                          ],
                        ),
                        children: [
                          DigitCard(
                            margin: const EdgeInsets.all(spacer2),
                            children: [
                              Text(
                                localizations.translate(pageTitleMain),
                                style: textTheme.headingXl,
                              ),
                              BlocBuilder<InventoryProductVariantBloc,
                                  InventoryProductVariantState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => const Offstage(),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    empty: () => Center(
                                      child: Text(localizations.translate(
                                        i18.stockDetails.noProductsFound,
                                      )),
                                    ),
                                    fetched: (productVariants) {
                                      List<ProductVariantModel>
                                          filteredProductVariants =
                                          productVariants
                                              .whereNot((element) =>
                                                  element.sku ==
                                                  Constants.vehicleSKU)
                                              .toList();

                                      if (!context.isCommunitySupervisor) {
                                        if (context.isSmcAndBednetFlow &&
                                            isBednetManager) {
                                          filteredProductVariants =
                                              filteredProductVariants
                                                  .whereNot((variant) =>
                                                      variant.sku!.contains(
                                                          Constants
                                                              .spaqConstantCapital) ||
                                                      variant.sku!.contains(
                                                          Constants
                                                              .spaqConstant))
                                                  .toList();
                                        } else {
                                          filteredProductVariants =
                                              filteredProductVariants
                                                  .where((variant) =>
                                                      variant.sku!.contains(
                                                          Constants
                                                              .spaqConstantCapital) ||
                                                      variant.sku!.contains(
                                                          Constants
                                                              .spaqConstant))
                                                  .toList();
                                        }
                                      }
                                      if (filteredProductVariants.isEmpty) {
                                        return Container();
                                      }
                                      return ReactiveWrapperField(
                                        formControlName: _productVariantKey,
                                        validationMessages: {
                                          'required': (object) =>
                                              '${i18_local_smc.stockDetails.selectProductLabelSMC}_IS_REQUIRED',
                                        },
                                        showErrors: (control) =>
                                            control.invalid && control.touched,
                                        builder: (field) {
                                          return LabeledField(
                                            label: localizations.translate(
                                              i18_local_smc.stockDetails
                                                  .selectProductLabelSMC,
                                            ),
                                            isRequired: true,
                                            child: MultiSelectDropDown(
                                              // errorText: field.errorText,
                                              selectionType:
                                                  SelectionType.defaultSelect,
                                              options: filteredProductVariants
                                                  .map((variant) {
                                                return DropdownItem(
                                                  name: localizations.translate(
                                                      variant.sku ??
                                                          variant.id),
                                                  code: variant.id,
                                                );
                                              }).toList(),

                                              onOptionSelected:
                                                  (List<DropdownItem>
                                                      selectedOptionsList) {
                                                final selectedVariants =
                                                    selectedOptionsList
                                                        .map((item) {
                                                  return productVariants
                                                      .firstWhere((variant) =>
                                                          variant.id ==
                                                          item.code);
                                                }).toList();
                                                field.control.value =
                                                    selectedVariants;
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              BlocBuilder<FacilityBloc, FacilityState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                      orElse: () => const Offstage(),
                                      loading: () => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                      fetched: (facilities, allFacilities) {
                                        List<FacilityModel> filteredFacilities =
                                            [];
                                        var address = context.selectedProject
                                            .address?.boundaryType;
                                        if (context.selectedProject.address
                                                    ?.boundaryType ==
                                                Constants.administrativePost &&
                                            !context.isCommunitySupervisor) {
                                          filteredFacilities = (entryType ==
                                                      StockRecordEntryType
                                                          .receipt ||
                                                  entryType ==
                                                      StockRecordEntryType
                                                          .dispatch)
                                              ? facilities
                                                  .where((element) =>
                                                      element.usage ==
                                                      Constants
                                                          .provincialWarehouse)
                                                  .toList()
                                              : [];
                                        } else if (context
                                            .isCommunitySupervisor) {
                                          filteredFacilities = (entryType ==
                                                      StockRecordEntryType
                                                          .receipt ||
                                                  entryType ==
                                                      StockRecordEntryType
                                                          .dispatch)
                                              ? facilities
                                                  .where((element) =>
                                                      element.usage ==
                                                      Constants.healthFacility)
                                                  .toList()
                                              : [];
                                        } else {
                                          filteredFacilities = [];
                                        }

                                        facilities = ((isHealthFacilitySupervisor ||
                                                        isCommunitySupervisor) &&
                                                    entryType ==
                                                        StockRecordEntryType
                                                            .returned) ||
                                                (isCommunityDistributor &&
                                                    entryType ==
                                                        StockRecordEntryType
                                                            .dispatch)
                                            ? []
                                            : filteredFacilities.isEmpty
                                                ? facilities
                                                : filteredFacilities;

                                        final teamFacilities =
                                            (context.isCommunitySupervisor &&
                                                    entryType ==
                                                        StockRecordEntryType
                                                            .dispatch)
                                                ? [
                                                    FacilityModel(
                                                      id: 'Delivery Team',
                                                      name: 'Team',
                                                    ),
                                                  ]
                                                : [
                                                    FacilityModel(
                                                      id: 'Supervisor Team',
                                                      name: 'Team',
                                                    ),
                                                  ];
                                        teamFacilities.addAll(
                                          facilities,
                                        );
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: spacer4,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                clearQRCodes();
                                                form
                                                    .control(_deliveryTeamKey)
                                                    .value = '';

                                                final facility =
                                                    await context.router.push(
                                                        CustomInventoryFacilitySelectionRoute(
                                                  facilities: ((isHealthFacilitySupervisor ||
                                                                  isCommunitySupervisor) &&
                                                              entryType !=
                                                                  StockRecordEntryType
                                                                      .receipt) ||
                                                          (isCommunityDistributor &&
                                                              entryType ==
                                                                  StockRecordEntryType
                                                                      .dispatch)
                                                      ? teamFacilities
                                                      : facilities,
                                                )) as FacilityModel?;

                                                if (facility == null) return;
                                                form
                                                        .control(_secondaryPartyKey)
                                                        .value =
                                                    localizations.translate(
                                                  'FAC_${facility.id}',
                                                );

                                                // Keeping this prefix for all facilities
                                                String facilityPrefix = 'FAC_';
                                                controller1.text =
                                                    localizations.translate(
                                                        '$facilityPrefix${facility.id}');
                                                setState(() {
                                                  selectedFacilityId =
                                                      facility.id;
                                                });
                                                if (facility.name == 'Team') {
                                                  setState(() {
                                                    deliveryTeamSelected = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    deliveryTeamSelected =
                                                        false;
                                                  });
                                                }
                                              },
                                              child: IgnorePointer(
                                                child: ReactiveWrapperField(
                                                    formControlName:
                                                        _secondaryPartyKey,
                                                    validationMessages: {
                                                      'required': (object) =>
                                                          localizations
                                                              .translate(
                                                            '${i18.individualDetails.nameLabelText}_IS_REQUIRED',
                                                          ),
                                                    },
                                                    showErrors: (control) =>
                                                        control.invalid &&
                                                        control.touched,
                                                    builder: (field) {
                                                      return InputField(
                                                        type: InputType.search,
                                                        isRequired: true,
                                                        label: (entryType ==
                                                                    StockRecordEntryType
                                                                        .dispatch &&
                                                                InventorySingleton()
                                                                    .isDistributor)
                                                            ? localizations
                                                                .translate(i18
                                                                    .stockDetails
                                                                    .selectTransactingPartyReturned)
                                                            : localizations
                                                                .translate(
                                                                '${pageTitle}_${i18.stockReconciliationDetails.stockLabel}',
                                                              ),
                                                        onChange: (value) {
                                                          field.control
                                                              .markAsTouched();
                                                        },
                                                        controller: controller1,
                                                        errorMessage:
                                                            field.errorText,
                                                      );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                              Visibility(
                                visible: deliveryTeamSelected,
                                child: ReactiveWrapperField(
                                    formControlName: _deliveryTeamKey,
                                    builder: (field) {
                                      final textController =
                                          TextEditingController(
                                        text: field.control.value?.toString() ??
                                            '',
                                      );
                                      field.control.valueChanges
                                          .listen((value) {
                                        if (textController.text != value) {
                                          textController.text = value ?? '';
                                        }
                                      });
                                      return InkWell(
                                        onTap: () async {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const DigitScannerPage(
                                                quantity: 1,
                                                isGS1code: false,
                                                singleValue: true,
                                              ),
                                              settings: const RouteSettings(
                                                  name: '/qr-scanner'),
                                            ),
                                          );
                                        },
                                        child: IgnorePointer(
                                          child: InputField(
                                            type: InputType.search,
                                            label: localizations.translate(
                                              i18_local_smc.stockDetails
                                                  .teamCodeLabelSMC,
                                            ),
                                            isRequired: deliveryTeamSelected,
                                            controller: textController,
                                            suffixIcon: Icons.qr_code_2,
                                            onSuffixTap: (value) {
                                              //[TODO: Add route to auto_route]
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DigitScannerPage(
                                                    quantity: 1,
                                                    isGS1code: false,
                                                    singleValue: true,
                                                  ),
                                                  settings: const RouteSettings(
                                                      name: '/qr-scanner'),
                                                ),
                                              );
                                            },
                                            onChange: (val) {
                                              String? value = val;
                                              if (value != null &&
                                                  value.trim().isNotEmpty) {
                                                context
                                                    .read<DigitScannerBloc>()
                                                    .add(
                                                      DigitScannerEvent
                                                          .handleScanner(
                                                        barCode: [],
                                                        qrCode: [value],
                                                        manualCode: value,
                                                      ),
                                                    );
                                              } else {
                                                clearQRCodes();
                                              }
                                              field.didChange(value);
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              if (!deliveryTeamSelected)
                                transportTypes.isNotEmpty
                                    ? ReactiveWrapperField(
                                        formControlName: _typeOfTransportKey,
                                        builder: (field) {
                                          return LabeledField(
                                            label: localizations.translate(
                                              i18_local.stockDetails
                                                  .transportTypeLabel,
                                            ),
                                            child: DigitDropdown(
                                              emptyItemText:
                                                  localizations.translate(
                                                i18.common.noMatchFound,
                                              ),
                                              items: transportTypes.map((type) {
                                                return DropdownItem(
                                                  name: localizations
                                                      .translate(type.name),
                                                  code: type.code,
                                                );
                                              }).toList(),
                                              selectedOption: (form
                                                          .control(
                                                              _typeOfTransportKey)
                                                          .value !=
                                                      null)
                                                  ? DropdownItem(
                                                      name: localizations
                                                          .translate(form
                                                              .control(
                                                                  _typeOfTransportKey)
                                                              .value),
                                                      code: form
                                                          .control(
                                                              _typeOfTransportKey)
                                                          .value)
                                                  : const DropdownItem(
                                                      name: '', code: ''),
                                              onSelect: (value) {
                                                field.control.value =
                                                    value.name;
                                                form
                                                    .control(
                                                        _typeOfTransportKey)
                                                    .value = value.code;
                                                form
                                                    .control(
                                                        _typeOfTransportKey)
                                                    .updateValue(value.code);
                                                setState(() {});
                                              },
                                            ),
                                          );
                                        },
                                      )
                                    : const Offstage(),
                              if (!deliveryTeamSelected)
                                ReactiveWrapperField(
                                    formControlName: _vehicleNumberKey,
                                    builder: (field) {
                                      return InputField(
                                        type: InputType.text,
                                        label: localizations.translate(
                                          i18.stockDetails.vehicleNumberLabel,
                                        ),
                                        onChange: (val) {
                                          field.control.value = val;
                                        },
                                      );
                                    }),
                              if (!deliveryTeamSelected)
                                ReactiveWrapperField(
                                    formControlName: _driverNameKey,
                                    builder: (field) {
                                      return InputField(
                                        type: InputType.text,
                                        label: localizations.translate(
                                          i18_local
                                              .stockDetails.driverNameLabel,
                                        ),
                                        onChange: (val) {
                                          field.control.value = val;
                                        },
                                      );
                                    }),
                            ],
                          ),
                        ],
                      );
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  num _getQuantityCount(Iterable<StockModel> stocks) {
    return stocks.fold<num>(
      0.0,
      (old, e) => (num.tryParse(e.quantity ?? '') ?? 0.0) + old,
    );
  }

  void clearQRCodes() {
    context.read<DigitScannerBloc>().add(const DigitScannerEvent.handleScanner(
          barCode: [],
          qrCode: [],
        ));
  }

  /// This function processes a list of GS1 barcodes and returns a map where the keys and values are joined by '|'.
  ///
  /// It takes a list of GS1Barcode objects as a parameter. Each GS1Barcode object represents a barcode that has been scanned.
  ///
  /// The function first initializes two empty lists: one for the keys and one for the values.
  ///
  /// It then iterates over each barcode in the list. For each barcode, it iterates over each element in the barcode.
  /// Each element is a MapEntry object, where the key is the identifier of the data field and the value is the data itself.
  ///
  /// The function adds the key and value of each element to the respective lists. The key and value are both converted to strings.
  ///
  /// After all barcodes have been processed, the function returns a map where the keys and values are joined by '|'.
  ///
  /// @param barCodes The list of GS1Barcode objects to be processed.
  /// @return A map where the keys and values are joined by '|'.
  AdditionalField addBarCodesToFields(List<GS1Barcode> barCodes) {
    List<String> keys = [];
    List<String> values = [];
    for (var element in barCodes) {
      for (var e in element.elements.entries) {
        keys.add(e.key.toString());
        values.add(e.value.data.toString());
      }
    }
    return AdditionalField(keys.join('|'), values.join('|'));
  }
}
