// // import 'package:auto_route/auto_route.dart';
// // import 'package:collection/collection.dart';
// // import 'package:digit_components/digit_components.dart';
// // import 'package:digit_components/widgets/atoms/digit_toaster.dart';
// // import 'package:digit_components/widgets/digit_sync_dialog.dart';
// // import 'package:digit_data_model/data_model.dart';
// // import 'package:digit_scanner/blocs/scanner.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
// // import 'package:inventory_management/blocs/stock_reconciliation.dart';
// // import 'package:inventory_management/inventory_management.dart'
// //     hide CustomValidator;
// // import 'package:inventory_management/router/inventory_router.gm.dart';
// // import 'package:reactive_forms/reactive_forms.dart';

// // import 'package:inventory_management/utils/i18_key_constants.dart' as i18;
// // import 'package:registration_delivery/registration_delivery.dart';
// // import '../../../utils/constants.dart';
// // import '../../../utils/extensions/extensions.dart';
// // import '../../../utils/i18_key_constants.dart' as i18_local;

// // import '../../../utils/utils.dart' show CustomValidator;
// // import '../../../widgets/localized.dart';
// // import '../../../router/app_router.dart';
// // import 'package:inventory_management/blocs/product_variant.dart';
// // import 'package:inventory_management/blocs/record_stock.dart';
// // import 'package:inventory_management/widgets/back_navigation_help_header.dart';

// // import '../../custom_digit_scanner.dart';

// // @RoutePage()
// // class CustomStockDetailsBednetPage extends LocalizedStatefulWidget {
// //   const CustomStockDetailsBednetPage({
// //     super.key,
// //     super.appLocalizations,
// //   });

// //   @override
// //   State<CustomStockDetailsBednetPage> createState() =>
// //       CustomStockDetailsBednetPageState();
// // }

// // class CustomStockDetailsBednetPageState
// //     extends LocalizedState<CustomStockDetailsBednetPage> {
// //   static const _productVariantKey = 'productVariant';
// //   static const _secondaryPartyKey = 'secondaryParty';
// //   static const _transactionQuantityKey = 'quantity';
// //   static const _transactionReasonKey = 'transactionReason';
// //   static const _waybillNumberKey = 'waybillNumber';
// //   static const _waybillQuantityKey = 'waybillQuantity';
// //   static const _vehicleNumberKey = 'vehicleNumber';
// //   static const _typeOfTransportKey = 'typeOfTransport';
// //   static const _driverNameKey = 'driverName';
// //   static const _commentsKey = 'comments';
// //   static const _deliveryTeamKey = 'deliveryTeam';
// //   static const _supervisorKey = 'supervisor';
// //   static const localMonitor = 'LocalMonitor';
// //   bool deliveryTeamSelected = false;
// //   bool localMonitorSelected = false;
// //   bool supervisorSelected = false;
// //   bool commentRequired = false;
// //   bool byHand = false;
// //   String? selectedFacilityId;
// //   List<InventoryTransportTypes> transportTypes = [];

// //   List<GS1Barcode> scannedResources = [];
// //   List<Map<String, dynamic>? Function(AbstractControl<dynamic>)>
// //       driverNameValidations = [];
// //   int maxCount = 100000000;

// //   FormGroup _form(StockRecordEntryType stockType,
// //       List<ProductVariantModel> productVariants) {
// //     return fb.group({
// //       _productVariantKey:
// //           FormControl<ProductVariantModel>(value: productVariants.first),
// //       _secondaryPartyKey: FormControl<String>(
// //         validators: [Validators.required],
// //       ),
// //       _transactionQuantityKey: FormControl<int>(validators: [
// //         Validators.number(),
// //         Validators.required,
// //         Validators.min(1),
// //         Validators.max(maxCount),
// //       ]),
// //       _transactionReasonKey: FormControl<String>(),
// //       _waybillNumberKey: FormControl<String>(
// //         validators: [
// //           Validators.delegate(
// //               (validator) => CustomValidator.requiredMin2(validator)),
// //           Validators.maxLength(200)
// //         ],
// //       ),
// //       _waybillQuantityKey: FormControl<int>(),
// //       _vehicleNumberKey: FormControl<String>(),
// //       _typeOfTransportKey: FormControl<String>(),
// //       _driverNameKey: FormControl<String>(
// //         validators: [],
// //       ),
// //       _commentsKey: FormControl<String>(),
// //       _deliveryTeamKey: FormControl<String>(),
// //       _supervisorKey: FormControl<String>(),
// //     });
// //   }

// //   @override
// //   void initState() {
// //     clearQRCodes();
// //     transportTypes = InventorySingleton().transportType;
// //     context.read<LocationBloc>().add(const LoadLocationEvent());
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final stockReconciliationBloc =
// //         BlocProvider.of<StockReconciliationBloc>(context);

// //     bool isWareHouseMgr = InventorySingleton().isWareHouseMgr;
// //     if (isWareHouseMgr) {
// //       driverNameValidations = [
// //         Validators.required,
// //         Validators.minLength(2),
// //         Validators.maxLength(200),
// //       ];
// //     } else {
// //       driverNameValidations = [];
// //     }
// //     final parser = GS1BarcodeParser.defaultParser();

//     return PopScope(
//       onPopInvoked: (didPop) {
//         final stockState = context.read<RecordStockBloc>().state;
//         if (stockState.primaryId != null) {
//           context.read<DigitScannerBloc>().add(
//                 DigitScannerEvent.handleScanner(
//                   barCode: [],
//                   qrCode: [stockState.primaryId.toString()],
//                 ),
//               );
//         }
//       },
//       child: Scaffold(
//         body: BlocBuilder<LocationBloc, LocationState>(
//           builder: (context, locationState) {
//             return BlocBuilder<InventoryProductVariantBloc,
//                 InventoryProductVariantState>(
//               builder: (context, productState) {
//                 return productState.maybeWhen(
//                   orElse: () => const Offstage(),
//                   loading: () => const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                   empty: () => Center(
//                     child: Text(localizations.translate(
//                       i18.stockDetails.noProductsFound,
//                     )),
//                   ),
//                   fetched: (productVariants) {
//                     final filteredProductVariants = productVariants
//                         .where((product) => product.sku != Constants.vechileSKU)
//                         .toList();
//                     return BlocConsumer<RecordStockBloc, RecordStockState>(
//                       listener: (context, stockState) {
//                         stockState.mapOrNull(
//                           persisted: (value) {
//                             final parent =
//                                 context.router.parent() as StackRouter;
//                             parent.replace(
//                               InventoryAcknowledgementRoute(),
//                             );
//                           },
//                         );
//                       },
//                       builder: (context, stockState) {
//                         StockRecordEntryType entryType = stockState.entryType;

// //                         const module = i18.stockDetails;

// //                         String pageTitle;
// //                         String transactionPartyLabel;
// //                         String quantityCountLabel;
// //                         String? transactionReasonLabel;
// //                         String? transactionReason;
// //                         String transactionType;

// //                         List<String>? reasons;

// //                         switch (entryType) {
// //                           case StockRecordEntryType.receipt:
// //                             pageTitle = module.receivedPageTitle;
// //                             transactionPartyLabel =
// //                                 module.selectTransactingPartyReceived;
// //                             quantityCountLabel = module.quantityReceivedLabel;
// //                             transactionType =
// //                                 TransactionType.received.toValue();

// //                             break;
// //                           case StockRecordEntryType.dispatch:
// //                             pageTitle = i18_local
// //                                 .stockDetails.stockIssuedBednetDetailsLabel;
// //                             transactionPartyLabel =
// //                                 module.selectTransactingPartyIssued;
// //                             quantityCountLabel = module.quantitySentLabel;
// //                             transactionType =
// //                                 TransactionType.dispatched.toValue();

// //                             break;
// //                           case StockRecordEntryType.returned:
// //                             pageTitle = module.returnedPageTitle;
// //                             transactionPartyLabel =
// //                                 module.selectTransactingPartyReturned;
// //                             quantityCountLabel = module.quantityReturnedLabel;
// //                             transactionType =
// //                                 TransactionType.received.toValue();
// //                             break;
// //                           case StockRecordEntryType.loss:
// //                             pageTitle = module.lostPageTitle;
// //                             quantityCountLabel = module.quantityLostLabel;
// //                             transactionReasonLabel =
// //                                 module.transactionReasonLost;
// //                             transactionType =
// //                                 TransactionType.dispatched.toValue();

// //                             reasons = [
// //                               TransactionReason.lostInStorage.toValue(),
// //                               TransactionReason.lostInTransit.toValue(),
// //                             ];
// //                             break;
// //                           case StockRecordEntryType.damaged:
// //                             pageTitle = module.damagedPageTitle;
// //                             transactionPartyLabel = module
// //                                 .selectTransactingPartyReceivedFromDamaged;
// //                             quantityCountLabel = module.quantityDamagedLabel;
// //                             transactionReasonLabel =
// //                                 module.transactionReasonDamaged;
// //                             transactionType =
// //                                 TransactionType.dispatched.toValue();

// //                             reasons = [
// //                               TransactionReason.damagedInStorage.toValue(),
// //                               TransactionReason.damagedInTransit.toValue(),
// //                             ];
// //                             break;
// //                         }

// //                         transactionReasonLabel ??= '';

//                         return ReactiveFormBuilder(
//                           form: () => _form(entryType, filteredProductVariants),
//                           builder: (context, form, child) {
//                             return BlocBuilder<DigitScannerBloc,
//                                     DigitScannerState>(
//                                 builder: (context, scannerState) {
//                               if (scannerState.barCodes.isNotEmpty) {
//                                 scannedResources.clear();
//                                 scannedResources.addAll(scannerState.barCodes);
//                               }

// //                               return ScrollableContent(
// //                                 header: Column(children: [
// //                                   BackNavigationHelpHeaderWidget(
// //                                     handleBack: () {
// //                                       final stockState =
// //                                           context.read<RecordStockBloc>().state;
// //                                       if (stockState.primaryId != null) {
// //                                         context.read<DigitScannerBloc>().add(
// //                                               DigitScannerEvent.handleScanner(
// //                                                 barCode: [],
// //                                                 qrCode: [
// //                                                   stockState.primaryId
// //                                                       .toString()
// //                                                 ],
// //                                               ),
// //                                             );
// //                                       }
// //                                     },
// //                                   ),
// //                                 ]),
// //                                 enableFixedButton: true,
// //                                 footer: DigitCard(
// //                                   margin: const EdgeInsets.fromLTRB(
// //                                       0, kPadding, 0, 0),
// //                                   padding: const EdgeInsets.fromLTRB(
// //                                     kPadding,
// //                                     0,
// //                                     kPadding,
// //                                     0,
// //                                   ),
// //                                   child: ReactiveFormConsumer(
// //                                       builder: (context, form, child) {
// //                                     if (!InventorySingleton().isDistributor &&
// //                                         !isWareHouseMgr) {
// //                                       if (form
// //                                               .control(_deliveryTeamKey)
// //                                               .value
// //                                               .toString()
// //                                               .isEmpty ||
// //                                           form
// //                                                   .control(_deliveryTeamKey)
// //                                                   .value ==
// //                                               null ||
// //                                           scannerState.qrCodes.isNotEmpty) {
// //                                         form.control(_deliveryTeamKey).value =
// //                                             scannerState.qrCodes.isNotEmpty
// //                                                 ? scannerState.qrCodes.last
// //                                                 : '';
// //                                       }
// //                                     } else {
// //                                       if (form
// //                                               .control(_supervisorKey)
// //                                               .value
// //                                               .toString()
// //                                               .isEmpty ||
// //                                           form.control(_supervisorKey).value ==
// //                                               null ||
// //                                           scannerState.qrCodes.isNotEmpty) {
// //                                         form.control(_supervisorKey).value =
// //                                             scannerState.qrCodes.isNotEmpty
// //                                                 ? scannerState.qrCodes.last
// //                                                 : '';
// //                                       }
// //                                     }

// //                                     return DigitElevatedButton(
// //                                       onPressed: !form.valid
// //                                           ? null
// //                                           : () async {
// //                                               form.markAllAsTouched();
// //                                               if (!form.valid) {
// //                                                 return;
// //                                               }

// //                                               String? commentValue = form
// //                                                   .control(_commentsKey)
// //                                                   .value as String?;

// //                                               if (commentValue != null &&
// //                                                   commentValue.isEmpty) {
// //                                                 commentValue = null;
// //                                               }

// //                                               if (commentValue != null &&
// //                                                   commentValue.length < 2) {
// //                                                 await DigitToast.show(
// //                                                   context,
// //                                                   options: DigitToastOptions(
// //                                                     localizations.translate(
// //                                                       i18_local
// //                                                           .deliverIntervention
// //                                                           .deliveryCommentRequired,
// //                                                     ),
// //                                                     true,
// //                                                     theme,
// //                                                   ),
// //                                                 );

// //                                                 return;
// //                                               }
// //                                               final primaryId = BlocProvider.of<
// //                                                   RecordStockBloc>(
// //                                                 context,
// //                                               ).state.primaryId;
// //                                               final secondaryParty =
// //                                                   selectedFacilityId != null
// //                                                       ? FacilityModel(
// //                                                           id: selectedFacilityId
// //                                                               .toString(),
// //                                                         )
// //                                                       : null;

// //                                               if (deliveryTeamSelected &&
// //                                                   (form
// //                                                               .control(
// //                                                                 _deliveryTeamKey,
// //                                                               )
// //                                                               .value ==
// //                                                           null ||
// //                                                       form
// //                                                           .control(
// //                                                               _deliveryTeamKey)
// //                                                           .value
// //                                                           .toString()
// //                                                           .trim()
// //                                                           .isEmpty)) {
// //                                                 DigitToast.show(
// //                                                   context,
// //                                                   options: DigitToastOptions(
// //                                                     localizations.translate(
// //                                                       i18.stockDetails
// //                                                           .teamCodeRequired,
// //                                                     ),
// //                                                     true,
// //                                                     theme,
// //                                                   ),
// //                                                 );
// //                                               } else if (supervisorSelected &&
// //                                                   (form
// //                                                               .control(
// //                                                                 _supervisorKey,
// //                                                               )
// //                                                               .value ==
// //                                                           null ||
// //                                                       form
// //                                                           .control(
// //                                                               _supervisorKey)
// //                                                           .value
// //                                                           .toString()
// //                                                           .trim()
// //                                                           .isEmpty)) {
// //                                                 DigitToast.show(
// //                                                   context,
// //                                                   options: DigitToastOptions(
// //                                                     localizations.translate(
// //                                                       i18_local.stockDetails
// //                                                           .supervisorCodeRequired,
// //                                                     ),
// //                                                     true,
// //                                                     theme,
// //                                                   ),
// //                                                 );
// //                                               } else if ((primaryId ==
// //                                                   secondaryParty?.id)) {
// //                                                 DigitToast.show(
// //                                                   context,
// //                                                   options: DigitToastOptions(
// //                                                     localizations.translate(
// //                                                       i18.stockDetails
// //                                                           .senderReceiverValidation,
// //                                                     ),
// //                                                     true,
// //                                                     theme,
// //                                                   ),
// //                                                 );
// //                                               } else {
// //                                                 FocusManager
// //                                                     .instance.primaryFocus
// //                                                     ?.unfocus();
// //                                                 context.read<LocationBloc>().add(
// //                                                     const LoadLocationEvent());
// //                                                 DigitComponentsUtils()
// //                                                     .showLocationCapturingDialog(
// //                                                         context,
// //                                                         localizations.translate(i18
// //                                                             .common
// //                                                             .locationCapturing),
// //                                                         DigitSyncDialogType
// //                                                             .inProgress);
// //                                                 Future.delayed(
// //                                                     const Duration(seconds: 2),
// //                                                     () async {
// //                                                   DigitComponentsUtils()
// //                                                       .hideDialog(context);
// //                                                   final bloc = context
// //                                                       .read<RecordStockBloc>();

// //                                                   final productVariant = form
// //                                                           .control(
// //                                                               _productVariantKey)
// //                                                           .value
// //                                                       as ProductVariantModel;

// //                                                   switch (entryType) {
// //                                                     case StockRecordEntryType
// //                                                           .receipt:
// //                                                       transactionReason =
// //                                                           TransactionReason
// //                                                               .received
// //                                                               .toValue();
// //                                                       break;
// //                                                     case StockRecordEntryType
// //                                                           .dispatch:
// //                                                       transactionReason = null;
// //                                                       break;
// //                                                     case StockRecordEntryType
// //                                                           .returned:
// //                                                       transactionReason =
// //                                                           TransactionReason
// //                                                               .returned
// //                                                               .toValue();
// //                                                       break;
// //                                                     default:
// //                                                       transactionReason = form
// //                                                           .control(
// //                                                             _transactionReasonKey,
// //                                                           )
// //                                                           .value as String?;
// //                                                       break;
// //                                                   }

// //                                                   final quantity = form
// //                                                       .control(
// //                                                           _transactionQuantityKey)
// //                                                       .value;

// //                                                   final waybillNumber = form
// //                                                       .control(
// //                                                           _waybillNumberKey)
// //                                                       .value as String?;

// //                                                   final waybillQuantity = form
// //                                                       .control(
// //                                                           _waybillQuantityKey)
// //                                                       .value;

// //                                                   final vehicleNumber = form
// //                                                       .control(
// //                                                           _vehicleNumberKey)
// //                                                       .value as String?;

// //                                                   final lat =
// //                                                       locationState.latitude;
// //                                                   final lng =
// //                                                       locationState.longitude;

// //                                                   final hasLocationData =
// //                                                       lat != null &&
// //                                                           lng != null;

// //                                                   final comments = form
// //                                                       .control(_commentsKey)
// //                                                       .value as String?;

// //                                                   final driverName = (form
// //                                                           .control(
// //                                                               _driverNameKey)
// //                                                           .value as String?)
// //                                                       ?.trim();

// //                                                   String? deliveryTeamName =
// //                                                       form
// //                                                           .control(
// //                                                               _deliveryTeamKey)
// //                                                           .value as String?;
// //                                                   String? distributorUsername;
// //                                                   if (deliveryTeamName !=
// //                                                       null) {
// //                                                     distributorUsername =
// //                                                         deliveryTeamName
// //                                                             .split(Constants
// //                                                                 .pipeSeparator)
// //                                                             .first;
// //                                                     deliveryTeamName =
// //                                                         deliveryTeamName
// //                                                             .split(Constants
// //                                                                 .pipeSeparator)
// //                                                             .last;
// //                                                   }

// //                                                   String? supervisor = form
// //                                                       .control(_supervisorKey)
// //                                                       .value as String?;

// //                                                   String? supervisorUsername;

// //                                                   if (supervisor != null) {
// //                                                     supervisorUsername =
// //                                                         supervisor
// //                                                             .split(Constants
// //                                                                 .pipeSeparator)
// //                                                             .first;
// //                                                     supervisor = supervisor
// //                                                         .split(Constants
// //                                                             .pipeSeparator)
// //                                                         .last;
// //                                                   }

// //                                                   if (isWareHouseMgr &&
// //                                                       !deliveryTeamSelected &&
// //                                                       !supervisorSelected &&
// //                                                       quantity != null &&
// //                                                       waybillQuantity != null) {
// //                                                     int quantityValue =
// //                                                         int.parse(quantity
// //                                                             .toString());
// //                                                     int wayBillQuantityValue =
// //                                                         int.parse(
// //                                                             waybillQuantity
// //                                                                 .toString());

// //                                                     if (quantityValue !=
// //                                                             wayBillQuantityValue &&
// //                                                         comments == null) {
// //                                                       DigitToast.show(
// //                                                         context,
// //                                                         options:
// //                                                             DigitToastOptions(
// //                                                           localizations
// //                                                               .translate(
// //                                                             i18_local
// //                                                                 .stockDetails
// //                                                                 .stockMismatchCommentRequried,
// //                                                           ),
// //                                                           true,
// //                                                           theme,
// //                                                         ),
// //                                                       );
// //                                                       return;
// //                                                     }
// //                                                   }

// //                                                   String? senderId;
// //                                                   String? senderType;
// //                                                   String? receiverId;
// //                                                   String? receiverType;

// //                                                   final primaryType =
// //                                                       BlocProvider.of<
// //                                                           RecordStockBloc>(
// //                                                     context,
// //                                                   ).state.primaryType;

// //                                                   final primaryId = BlocProvider
// //                                                       .of<RecordStockBloc>(
// //                                                     context,
// //                                                   ).state.primaryId;

// //                                                   switch (entryType) {
// //                                                     case StockRecordEntryType
// //                                                           .receipt:
// //                                                     case StockRecordEntryType
// //                                                           .loss:
// //                                                     case StockRecordEntryType
// //                                                           .damaged:
// //                                                     case StockRecordEntryType
// //                                                           .returned:
// //                                                       if (deliveryTeamSelected ||
// //                                                           supervisorSelected) {
// //                                                         senderId =
// //                                                             deliveryTeamSelected
// //                                                                 ? deliveryTeamName
// //                                                                 : supervisor;
// //                                                         senderType = "STAFF";
// //                                                       } else {
// //                                                         senderId =
// //                                                             secondaryParty?.id;
// //                                                         senderType =
// //                                                             "WAREHOUSE";
// //                                                       }
// //                                                       receiverId = primaryId;
// //                                                       receiverType =
// //                                                           primaryType;

// //                                                       break;
// //                                                     case StockRecordEntryType
// //                                                           .dispatch:
// //                                                       if (deliveryTeamSelected ||
// //                                                           supervisorSelected) {
// //                                                         receiverId =
// //                                                             deliveryTeamSelected
// //                                                                 ? deliveryTeamName
// //                                                                 : supervisor;
// //                                                         ;
// //                                                         receiverType = "STAFF";
// //                                                       } else {
// //                                                         receiverId =
// //                                                             secondaryParty?.id;
// //                                                         receiverType =
// //                                                             "WAREHOUSE";
// //                                                       }
// //                                                       senderId = primaryId;
// //                                                       senderType = primaryType;
// //                                                       break;
// //                                                   }

// //                                                   if (senderId == receiverId) {
// //                                                     DigitToast.show(
// //                                                       context,
// //                                                       options:
// //                                                           DigitToastOptions(
// //                                                         localizations.translate(
// //                                                           i18.stockDetails
// //                                                               .senderReceiverValidation,
// //                                                         ),
// //                                                         true,
// //                                                         theme,
// //                                                       ),
// //                                                     );
// //                                                     return;
// //                                                   }

// //                                                   final stockReconciliationState =
// //                                                       stockReconciliationBloc
// //                                                           .state;

// //                                                   if (stockReconciliationState
// //                                                               .stockInHand <
// //                                                           int.parse(quantity
// //                                                               .toString()) &&
// //                                                       entryType ==
// //                                                           StockRecordEntryType
// //                                                               .dispatch) {
// //                                                     final alert =
// //                                                         await DigitDialog.show<
// //                                                             bool>(
// //                                                       context,
// //                                                       options:
// //                                                           DigitDialogOptions(
// //                                                         titleText: localizations
// //                                                             .translate(
// //                                                           i18_local.stockDetails
// //                                                               .countDialogTitle,
// //                                                         ),
// //                                                         contentText:
// //                                                             localizations
// //                                                                 .translate(
// //                                                                   i18_local
// //                                                                       .stockDetails
// //                                                                       .countContent,
// //                                                                 )
// //                                                                 .replaceAll(
// //                                                                   '{}',
// //                                                                   stockReconciliationState
// //                                                                       .stockInHand
// //                                                                       .toString(),
// //                                                                 ),
// //                                                         primaryAction:
// //                                                             DigitDialogActions(
// //                                                           label: localizations
// //                                                               .translate(
// //                                                             i18_local
// //                                                                 .stockDetails
// //                                                                 .countDialogSuccess,
// //                                                           ),
// //                                                           action: (context) {
// //                                                             Navigator.of(
// //                                                               context,
// //                                                               rootNavigator:
// //                                                                   true,
// //                                                             ).pop(false);
// //                                                           },
// //                                                         ),
// //                                                       ),
// //                                                     );

// //                                                     if (!(alert ?? false)) {
// //                                                       return;
// //                                                     }
// //                                                   }

// //                                                   final stockModel = StockModel(
// //                                                     clientReferenceId:
// //                                                         IdGen.i.identifier,
// //                                                     productVariantId:
// //                                                         productVariant.id,
// //                                                     transactionReason:
// //                                                         transactionReason,
// //                                                     transactionType:
// //                                                         transactionType,
// //                                                     referenceId:
// //                                                         stockState.projectId,
// //                                                     referenceIdType: 'PROJECT',
// //                                                     quantity:
// //                                                         quantity.toString(),
// //                                                     wayBillNumber:
// //                                                         waybillNumber != null
// //                                                             ? waybillNumber
// //                                                                     .toString()
// //                                                                     .trim()
// //                                                                     .isEmpty
// //                                                                 ? null
// //                                                                 : waybillNumber
// //                                                                     .toString()
// //                                                                     .trim()
// //                                                             : null,
// //                                                     receiverId: receiverId,
// //                                                     receiverType: receiverType,
// //                                                     senderId: senderId,
// //                                                     senderType: senderType,
// //                                                     auditDetails: AuditDetails(
// //                                                       createdBy:
// //                                                           InventorySingleton()
// //                                                               .loggedInUserUuid,
// //                                                       createdTime: context
// //                                                           .millisecondsSinceEpoch(),
// //                                                     ),
// //                                                     clientAuditDetails:
// //                                                         ClientAuditDetails(
// //                                                       createdBy:
// //                                                           InventorySingleton()
// //                                                               .loggedInUserUuid,
// //                                                       createdTime: context
// //                                                           .millisecondsSinceEpoch(),
// //                                                       lastModifiedBy:
// //                                                           InventorySingleton()
// //                                                               .loggedInUserUuid,
// //                                                       lastModifiedTime: context
// //                                                           .millisecondsSinceEpoch(),
// //                                                     ),
// //                                                     additionalFields:
// //                                                         StockAdditionalFields(
// //                                                       version: 1,
// //                                                       fields: [
// //                                                         AdditionalField(
// //                                                           InventoryManagementEnums
// //                                                               .name
// //                                                               .toValue(),
// //                                                           InventorySingleton()
// //                                                               .loggedInUser
// //                                                               ?.name,
// //                                                         ),
// //                                                         if (waybillQuantity !=
// //                                                                 null &&
// //                                                             waybillQuantity
// //                                                                 .toString()
// //                                                                 .trim()
// //                                                                 .isNotEmpty)
// //                                                           AdditionalField(
// //                                                             'waybill_quantity',
// //                                                             waybillQuantity
// //                                                                 .toString(),
// //                                                           ),
// //                                                         if (vehicleNumber !=
// //                                                                 null &&
// //                                                             vehicleNumber
// //                                                                 .trim()
// //                                                                 .isNotEmpty)
// //                                                           AdditionalField(
// //                                                             'vehicle_number',
// //                                                             vehicleNumber,
// //                                                           ),
// //                                                         if (comments != null &&
// //                                                             comments
// //                                                                 .trim()
// //                                                                 .isNotEmpty)
// //                                                           AdditionalField(
// //                                                             'comments',
// //                                                             comments,
// //                                                           ),
// //                                                         if (deliveryTeamName !=
// //                                                                 null &&
// //                                                             deliveryTeamName
// //                                                                 .trim()
// //                                                                 .isNotEmpty)
// //                                                           AdditionalField(
// //                                                             'deliveryTeam',
// //                                                             deliveryTeamName,
// //                                                           ),
// //                                                         if (distributorUsername !=
// //                                                                 null &&
// //                                                             distributorUsername
// //                                                                 .trim()
// //                                                                 .isNotEmpty)
// //                                                           AdditionalField(
// //                                                             Constants
// //                                                                 .distributorUsername,
// //                                                             distributorUsername,
// //                                                           ),
// //                                                         if (supervisorUsername !=
// //                                                                 null &&
// //                                                             supervisorUsername
// //                                                                 .trim()
// //                                                                 .isNotEmpty)
// //                                                           AdditionalField(
// //                                                             Constants
// //                                                                 .supervisorUsername,
// //                                                             supervisorUsername,
// //                                                           ),
// //                                                         if (driverName !=
// //                                                                 null &&
// //                                                             driverName
// //                                                                 .isNotEmpty)
// //                                                           AdditionalField(
// //                                                             'driver_name',
// //                                                             driverName,
// //                                                           ),
// //                                                         if (hasLocationData) ...[
// //                                                           AdditionalField(
// //                                                             'lat',
// //                                                             lat,
// //                                                           ),
// //                                                           AdditionalField(
// //                                                             'lng',
// //                                                             lng,
// //                                                           ),
// //                                                         ],
// //                                                         if (scannerState
// //                                                             .barCodes
// //                                                             .isNotEmpty)
// //                                                           addBarCodesToFields(
// //                                                               scannerState
// //                                                                   .barCodes),
// //                                                       ],
// //                                                     ),
// //                                                   );

// //                                                   bloc.add(
// //                                                     RecordStockSaveStockDetailsEvent(
// //                                                       stockModel: stockModel,
// //                                                     ),
// //                                                   );

// //                                                   final submit =
// //                                                       await DigitDialog.show<
// //                                                           bool>(
// //                                                     context,
// //                                                     options: DigitDialogOptions(
// //                                                       key: const Key(
// //                                                           'submitDialog'),
// //                                                       titleText: localizations
// //                                                           .translate(
// //                                                         i18.stockDetails
// //                                                             .dialogTitle,
// //                                                       ),
// //                                                       contentText: localizations
// //                                                           .translate(
// //                                                         i18.stockDetails
// //                                                             .dialogContent,
// //                                                       ),
// //                                                       primaryAction:
// //                                                           DigitDialogActions(
// //                                                         label: localizations
// //                                                             .translate(
// //                                                           i18.common
// //                                                               .coreCommonSubmit,
// //                                                         ),
// //                                                         action: (context) {
// //                                                           Navigator.of(
// //                                                             context,
// //                                                             rootNavigator: true,
// //                                                           ).pop(true);
// //                                                         },
// //                                                       ),
// //                                                       secondaryAction:
// //                                                           DigitDialogActions(
// //                                                         label: localizations
// //                                                             .translate(
// //                                                           i18.common
// //                                                               .coreCommonCancel,
// //                                                         ),
// //                                                         action: (context) =>
// //                                                             Navigator.of(
// //                                                           context,
// //                                                           rootNavigator: true,
// //                                                         ).pop(false),
// //                                                       ),
// //                                                     ),
// //                                                   );

//                                                   if (submit ?? false) {
//                                                     bloc.add(
//                                                       const RecordStockCreateStockEntryEvent(),
//                                                     );
//                                                   }
//                                                 });
//                                               }
//                                             },
//                                       child: Center(
//                                         child: Text(
//                                           localizations.translate(
//                                               i18.common.coreCommonSubmit),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                                 children: [
//                                   DigitCard(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           localizations.translate(pageTitle),
//                                           style: theme.textTheme.displayMedium,
//                                         ),
//                                         DigitReactiveDropdown<
//                                             ProductVariantModel>(
//                                           key: const Key(_productVariantKey),
//                                           formControlName: _productVariantKey,
//                                           label: localizations.translate(
//                                             i18_local.stockDetails
//                                                 .selectProductBednetLabel,
//                                           ),
//                                           isRequired: true,
//                                           isDisabled: true,
//                                           valueMapper: (value) {
//                                             return localizations.translate(
//                                               value.sku ?? value.id,
//                                             );
//                                           },
//                                           menuItems: filteredProductVariants,
//                                           onChanged: (value) {
//                                             stockReconciliationBloc.add(
//                                               StockReconciliationSelectProductEvent(
//                                                 value.id,
//                                                 isDistributor:
//                                                     !InventorySingleton()
//                                                         .isWareHouseMgr!,
//                                               ),
//                                             );
//                                           },
//                                           validationMessages: {
//                                             'required': (object) =>
//                                                 localizations.translate(i18
//                                                     .common.corecommonRequired)
//                                           },
//                                         ),
//                                         if ([
//                                           StockRecordEntryType.loss,
//                                           StockRecordEntryType.damaged,
//                                         ].contains(entryType))
//                                           DigitReactiveDropdown<String>(
//                                             key: const Key(
//                                                 _transactionReasonKey),
//                                             label: localizations.translate(
//                                               transactionReasonLabel ??
//                                                   'Reason',
//                                             ),
//                                             menuItems: reasons ?? [],
//                                             formControlName:
//                                                 _transactionReasonKey,
//                                             valueMapper: (value) =>
//                                                 localizations.translate(value),
//                                             isRequired: true,
//                                           ),
//                                         BlocBuilder<FacilityBloc,
//                                             FacilityState>(
//                                           builder: (context, state) {
//                                             return state.maybeWhen(
//                                                 orElse: () => const Offstage(),
//                                                 loading: () => const Center(
//                                                       child:
//                                                           CircularProgressIndicator(),
//                                                     ),
//                                                 fetched: (facilities,
//                                                     allFacilities1) {
//                                                   List<FacilityModel>
//                                                       allFacilities = [];

//                                                   String? boundaryLevel =
//                                                       RegistrationDeliverySingleton()
//                                                           .selectedProject
//                                                           ?.address
//                                                           ?.boundaryType;
//                                                   if (isWareHouseMgr) {
//                                                     if (boundaryLevel ==
//                                                         Constants
//                                                             .provincialBoundaryLevel) {
//                                                       if (stockState
//                                                               .entryType ==
//                                                           StockRecordEntryType
//                                                               .receipt) {
//                                                         allFacilities.addAll(
//                                                             allFacilities1
//                                                                 .where((element) =>
//                                                                     element
//                                                                         .usage ==
//                                                                     Constants
//                                                                         .nationalWarehouse)
//                                                                 .toList());
//                                                       } else {
//                                                         allFacilities.addAll(
//                                                             allFacilities1
//                                                                 .where((element) =>
//                                                                     element
//                                                                         .usage ==
//                                                                     Constants
//                                                                         .districWarehouse)
//                                                                 .toList());
//                                                       }
//                                                     } else if (boundaryLevel ==
//                                                             Constants
//                                                                 .districtBoundaryLevel &&
//                                                         !context
//                                                             .isLocalMonitor) {
//                                                       if (stockState
//                                                               .entryType ==
//                                                           StockRecordEntryType
//                                                               .receipt) {
//                                                         allFacilities.addAll(
//                                                             allFacilities1
//                                                                 .where((element) =>
//                                                                     element
//                                                                         .usage ==
//                                                                     Constants
//                                                                         .provincialWarehouse)
//                                                                 .toList());
//                                                       } else {
//                                                         // info add satellite facilities
//                                                         allFacilities.addAll(
//                                                             allFacilities1
//                                                                 .where((element) =>
//                                                                     element
//                                                                         .usage ==
//                                                                     Constants
//                                                                         .warehouse)
//                                                                 .toList());
//                                                         if (stockState
//                                                                 .entryType ==
//                                                             StockRecordEntryType
//                                                                 .dispatch) {
//                                                           allFacilities.addAll(
//                                                               allFacilities1
//                                                                   .where((element) =>
//                                                                       element
//                                                                           .usage ==
//                                                                       Constants
//                                                                           .provincialWarehouse)
//                                                                   .toList());
//                                                         }
//                                                       }
//                                                     } else if (boundaryLevel ==
//                                                             Constants
//                                                                 .administrativeProviceBoundaryLevel &&
//                                                         !context
//                                                             .isLocalMonitor) {
//                                                       if (stockState
//                                                               .entryType ==
//                                                           StockRecordEntryType
//                                                               .receipt) {
//                                                         allFacilities.addAll(
//                                                             allFacilities1
//                                                                 .where((element) =>
//                                                                     element
//                                                                         .usage ==
//                                                                     Constants
//                                                                         .districWarehouse)
//                                                                 .toList());
//                                                       } else {
//                                                         // info add lm to list
//                                                         allFacilities.addAll(
//                                                             allFacilities1.where(
//                                                                 (element) =>
//                                                                     element
//                                                                         .usage ==
//                                                                     Constants
//                                                                         .localMonitor));
//                                                         if (stockState
//                                                                 .entryType ==
//                                                             StockRecordEntryType
//                                                                 .dispatch) {
//                                                           allFacilities.addAll(
//                                                               allFacilities1
//                                                                   .where((element) =>
//                                                                       element
//                                                                           .usage ==
//                                                                       Constants
//                                                                           .districWarehouse)
//                                                                   .toList());
//                                                         }
//                                                       }
//                                                     } else if (context
//                                                         .isLocalMonitor) {
//                                                       if (stockState
//                                                               .entryType ==
//                                                           StockRecordEntryType
//                                                               .receipt) {
//                                                         // info add satellite facilities
//                                                         allFacilities.addAll(
//                                                             allFacilities1
//                                                                 .where((element) =>
//                                                                     element
//                                                                         .usage ==
//                                                                     Constants
//                                                                         .warehouse)
//                                                                 .toList());
//                                                       } else {
//                                                         // info adding delivery team to the list for local monitor (for issue/dispatch entrytype)
//                                                         allFacilities.addAll(
//                                                             allFacilities1
//                                                                 .where((element) =>
//                                                                     element
//                                                                         .usage ==
//                                                                     Constants
//                                                                         .deliveryTeamFilter)
//                                                                 .toList());
//                                                         if (stockState
//                                                                 .entryType ==
//                                                             StockRecordEntryType
//                                                                 .dispatch) {
//                                                           // info add satellite facilities
//                                                           allFacilities.addAll(
//                                                               allFacilities1
//                                                                   .where((element) =>
//                                                                       element
//                                                                           .usage ==
//                                                                       Constants
//                                                                           .warehouse)
//                                                                   .toList());
//                                                         }
//                                                       }
//                                                     } else {
//                                                       allFacilities.addAll(
//                                                           allFacilities1);
//                                                     }
//                                                   } else {
//                                                     allFacilities
//                                                         .addAll(allFacilities1);
//                                                   }
//                                                   // Info remove delivery team for all transactions and all role
//                                                   if (allFacilities
//                                                       .isNotEmpty) {
//                                                     allFacilities.removeWhere(
//                                                         (element) =>
//                                                             element.id ==
//                                                             "Delivery Team");
//                                                   }
//                                                   return InkWell(
//                                                     onTap: () async {
//                                                       clearQRCodes();
//                                                       stockReconciliationBloc
//                                                           .add(
//                                                         StockReconciliationSelectProductEvent(
//                                                           filteredProductVariants
//                                                               .first.id,
//                                                           isDistributor:
//                                                               !InventorySingleton()
//                                                                   .isWareHouseMgr!,
//                                                         ),
//                                                       );
//                                                       form
//                                                           .control(
//                                                               _deliveryTeamKey)
//                                                           .value = '';

// //                                                       final facility = await context
// //                                                               .router
// //                                                               .push(CustomInventoryFacilitySelectionBednetRoute(
// //                                                                   facilities:
// //                                                                       allFacilities))
// //                                                           as FacilityModel?;

// //                                                       // info bool to decide if lm selected then handle the fields isRequired
// //                                                       if (facility != null) {
// //                                                         localMonitorSelected =
// //                                                             facility.usage ==
// //                                                                 Constants
// //                                                                     .localMonitor;
// //                                                       }

// //                                                       if (facility == null)
// //                                                         return;
// //                                                       form
// //                                                           .control(
// //                                                               _secondaryPartyKey)
// //                                                           .value = facility
// //                                                               .name ??
// //                                                           localizations
// //                                                               .translate(
// //                                                             'FAC_${facility.id}',
// //                                                           );

// //                                                       setState(() {
// //                                                         selectedFacilityId =
// //                                                             facility.id;
// //                                                       });
// //                                                       if (facility.id ==
// //                                                           'Delivery Team') {
// //                                                         setState(() {
// //                                                           deliveryTeamSelected =
// //                                                               true;
// //                                                           supervisorSelected =
// //                                                               false;
// //                                                           updateCommentValidation(
// //                                                               isWareHouseMgr,
// //                                                               form);
// //                                                           form
// //                                                               .control(
// //                                                             _waybillNumberKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                           form
// //                                                               .control(
// //                                                             _waybillQuantityKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                           form
// //                                                               .control(
// //                                                             _typeOfTransportKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                           removeVehicleValidation(
// //                                                               form);

// //                                                           form
// //                                                               .control(
// //                                                             _deliveryTeamKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [
// //                                                               Validators
// //                                                                   .required
// //                                                             ],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );

// //                                                           form
// //                                                               .control(
// //                                                                 _deliveryTeamKey,
// //                                                               )
// //                                                               .touched;

// //                                                           form
// //                                                               .control(
// //                                                             _supervisorKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                         });
// //                                                       } else if (facility.id ==
// //                                                           localMonitor) {
// //                                                         setState(() {
// //                                                           supervisorSelected =
// //                                                               true;
// //                                                           deliveryTeamSelected =
// //                                                               false;
// //                                                           updateCommentValidation(
// //                                                               isWareHouseMgr,
// //                                                               form);
// //                                                           form
// //                                                               .control(
// //                                                             _waybillNumberKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                           form
// //                                                               .control(
// //                                                             _waybillQuantityKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                           form
// //                                                               .control(
// //                                                             _typeOfTransportKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                           removeVehicleValidation(
// //                                                               form);
// //                                                           form
// //                                                               .control(
// //                                                             _deliveryTeamKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );

// //                                                           form
// //                                                               .control(
// //                                                             _supervisorKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [
// //                                                               Validators
// //                                                                   .required
// //                                                             ],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );

// //                                                           form
// //                                                               .control(
// //                                                                 _supervisorKey,
// //                                                               )
// //                                                               .touched;
// //                                                         });
// //                                                       } else if (context
// //                                                           .isLocalMonitor) {
// //                                                         setState(() {
// //                                                           form
// //                                                               .control(
// //                                                             _waybillNumberKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                           form
// //                                                               .control(
// //                                                             _waybillQuantityKey,
// //                                                           )
// //                                                               .setValidators(
// //                                                             [],
// //                                                             updateParent: true,
// //                                                             autoValidate: true,
// //                                                           );
// //                                                         });
// //                                                       } else {
// //                                                         setState(() {
// //                                                           deliveryTeamSelected =
// //                                                               false;
// //                                                           supervisorSelected =
// //                                                               false;
// //                                                           updateCommentValidation(
// //                                                               isWareHouseMgr,
// //                                                               form);

// //                                                           if (isWareHouseMgr) {
// //                                                             if (localMonitorSelected) {
// //                                                               form
// //                                                                   .control(
// //                                                                 _waybillNumberKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                               form
// //                                                                   .control(
// //                                                                 _waybillQuantityKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                             } else {
// //                                                               form
// //                                                                   .control(
// //                                                                 _waybillNumberKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [
// //                                                                   Validators
// //                                                                       .required,
// //                                                                   Validators
// //                                                                       .minLength(
// //                                                                           2),
// //                                                                   Validators
// //                                                                       .maxLength(
// //                                                                           200),
// //                                                                 ],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                               form
// //                                                                   .control(
// //                                                                 _waybillQuantityKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [
// //                                                                   Validators
// //                                                                       .required,
// //                                                                   Validators
// //                                                                       .number(),
// //                                                                   Validators
// //                                                                       .min(0),
// //                                                                   Validators.max(
// //                                                                       maxCount),
// //                                                                 ],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                             }
// //                                                             form
// //                                                                 .control(
// //                                                               _typeOfTransportKey,
// //                                                             )
// //                                                                 .setValidators(
// //                                                               [
// //                                                                 Validators
// //                                                                     .required,
// //                                                               ],
// //                                                               updateParent:
// //                                                                   true,
// //                                                               autoValidate:
// //                                                                   true,
// //                                                             );
// //                                                             final transportTypeValue =
// //                                                                 form
// //                                                                         .control(
// //                                                                           _typeOfTransportKey,
// //                                                                         )
// //                                                                         .value
// //                                                                     as String?;
// //                                                             if (transportTypeValue ==
// //                                                                 Constants
// //                                                                     .byHand) {
// //                                                               byHand = true;
// //                                                               removeVehicleValidation(
// //                                                                   form);
// //                                                             } else {
// //                                                               byHand = false;
// //                                                               addVehicleValidations(
// //                                                                   form);
// //                                                             }

// //                                                             form
// //                                                                 .control(
// //                                                                   _waybillNumberKey,
// //                                                                 )
// //                                                                 .touched;
// //                                                             form
// //                                                                 .control(
// //                                                                   _waybillQuantityKey,
// //                                                                 )
// //                                                                 .touched;
// //                                                             form
// //                                                                 .control(
// //                                                                   _typeOfTransportKey,
// //                                                                 )
// //                                                                 .touched;
// //                                                           }
// //                                                         });

// //                                                         form
// //                                                             .control(
// //                                                           _deliveryTeamKey,
// //                                                         )
// //                                                             .setValidators(
// //                                                           [],
// //                                                           updateParent: true,
// //                                                           autoValidate: true,
// //                                                         );

// //                                                         form
// //                                                             .control(
// //                                                           _supervisorKey,
// //                                                         )
// //                                                             .setValidators(
// //                                                           [],
// //                                                           updateParent: true,
// //                                                           autoValidate: true,
// //                                                         );
// //                                                       }
// //                                                     },
// //                                                     child: IgnorePointer(
// //                                                       child: DigitTextFormField(
// //                                                         key: const Key(
// //                                                             _secondaryPartyKey),
// //                                                         hideKeyboard: true,
// //                                                         label: localizations
// //                                                             .translate(
// //                                                           '${pageTitle}_${i18.stockReconciliationDetails.stockLabel}',
// //                                                         ),
// //                                                         isRequired: true,
// //                                                         validationMessages: {
// //                                                           'required': (object) =>
// //                                                               localizations
// //                                                                   .translate(
// //                                                                 '${i18.individualDetails.nameLabelText}_IS_REQUIRED',
// //                                                               ),
// //                                                         },
// //                                                         suffix: const Padding(
// //                                                           padding:
// //                                                               EdgeInsets.all(
// //                                                                   8.0),
// //                                                           child: Icon(
// //                                                               Icons.search),
// //                                                         ),
// //                                                         formControlName:
// //                                                             _secondaryPartyKey,
// //                                                         onTap: () async {
// //                                                           clearQRCodes();
// //                                                           stockReconciliationBloc
// //                                                               .add(
// //                                                             StockReconciliationSelectProductEvent(
// //                                                               productVariants
// //                                                                   .first.id,
// //                                                               isDistributor:
// //                                                                   !InventorySingleton()
// //                                                                       .isWareHouseMgr!,
// //                                                             ),
// //                                                           );
// //                                                           form
// //                                                               .control(
// //                                                                   _deliveryTeamKey)
// //                                                               .value = '';

// //                                                           final facility =
// //                                                               await context
// //                                                                   .router
// //                                                                   .push(
// //                                                             CustomInventoryFacilitySelectionBednetRoute(
// //                                                               facilities:
// //                                                                   allFacilities,
// //                                                             ),
// //                                                           ) as FacilityModel?;

// //                                                           if (facility == null)
// //                                                             return;
// //                                                           form
// //                                                               .control(
// //                                                                   _secondaryPartyKey)
// //                                                               .value = facility
// //                                                                   .name ??
// //                                                               localizations
// //                                                                   .translate(
// //                                                                 'FAC_${facility.id}',
// //                                                               );

// //                                                           setState(() {
// //                                                             selectedFacilityId =
// //                                                                 facility.id;
// //                                                           });
// //                                                           if (facility.id ==
// //                                                               'Delivery Team') {
// //                                                             setState(() {
// //                                                               deliveryTeamSelected =
// //                                                                   true;
// //                                                               supervisorSelected =
// //                                                                   false;
// //                                                               updateCommentValidation(
// //                                                                   isWareHouseMgr,
// //                                                                   form);
// //                                                               form
// //                                                                   .control(
// //                                                                 _waybillNumberKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                               form
// //                                                                   .control(
// //                                                                 _waybillQuantityKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                               form
// //                                                                   .control(
// //                                                                 _typeOfTransportKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );

// //                                                               removeVehicleValidation(
// //                                                                   form);

// //                                                               form
// //                                                                   .control(
// //                                                                 _deliveryTeamKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [
// //                                                                   Validators
// //                                                                       .required
// //                                                                 ],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );

// //                                                               form
// //                                                                   .control(
// //                                                                     _deliveryTeamKey,
// //                                                                   )
// //                                                                   .touched;

// //                                                               form
// //                                                                   .control(
// //                                                                 _supervisorKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                             });
// //                                                           } else if (facility
// //                                                                   .id ==
// //                                                               localMonitor) {
// //                                                             setState(() {
// //                                                               supervisorSelected =
// //                                                                   true;
// //                                                               deliveryTeamSelected =
// //                                                                   false;
// //                                                               updateCommentValidation(
// //                                                                   isWareHouseMgr,
// //                                                                   form);
// //                                                               form
// //                                                                   .control(
// //                                                                 _waybillNumberKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                               form
// //                                                                   .control(
// //                                                                 _waybillQuantityKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                               form
// //                                                                   .control(
// //                                                                 _typeOfTransportKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );
// //                                                               removeVehicleValidation(
// //                                                                   form);
// //                                                               form
// //                                                                   .control(
// //                                                                 _deliveryTeamKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );

// //                                                               form
// //                                                                   .control(
// //                                                                 _supervisorKey,
// //                                                               )
// //                                                                   .setValidators(
// //                                                                 [
// //                                                                   Validators
// //                                                                       .required
// //                                                                 ],
// //                                                                 updateParent:
// //                                                                     true,
// //                                                                 autoValidate:
// //                                                                     true,
// //                                                               );

// //                                                               form
// //                                                                   .control(
// //                                                                     _supervisorKey,
// //                                                                   )
// //                                                                   .touched;
// //                                                             });
// //                                                           } else {
// //                                                             setState(() {
// //                                                               deliveryTeamSelected =
// //                                                                   false;
// //                                                               supervisorSelected =
// //                                                                   false;
// //                                                               updateCommentValidation(
// //                                                                   isWareHouseMgr,
// //                                                                   form);
// //                                                               if (isWareHouseMgr) {
// //                                                                 if (localMonitorSelected) {
// //                                                                   form
// //                                                                       .control(
// //                                                                     _waybillNumberKey,
// //                                                                   )
// //                                                                       .setValidators(
// //                                                                     [],
// //                                                                     updateParent:
// //                                                                         true,
// //                                                                     autoValidate:
// //                                                                         true,
// //                                                                   );
// //                                                                   form
// //                                                                       .control(
// //                                                                     _waybillQuantityKey,
// //                                                                   )
// //                                                                       .setValidators(
// //                                                                     [],
// //                                                                     updateParent:
// //                                                                         true,
// //                                                                     autoValidate:
// //                                                                         true,
// //                                                                   );
// //                                                                 } else {
// //                                                                   form
// //                                                                       .control(
// //                                                                     _waybillNumberKey,
// //                                                                   )
// //                                                                       .setValidators(
// //                                                                     [
// //                                                                       Validators
// //                                                                           .required,
// //                                                                       Validators
// //                                                                           .minLength(
// //                                                                               2),
// //                                                                       Validators
// //                                                                           .maxLength(
// //                                                                               200),
// //                                                                     ],
// //                                                                     updateParent:
// //                                                                         true,
// //                                                                     autoValidate:
// //                                                                         true,
// //                                                                   );
// //                                                                   form
// //                                                                       .control(
// //                                                                     _waybillQuantityKey,
// //                                                                   )
// //                                                                       .setValidators(
// //                                                                     [
// //                                                                       Validators
// //                                                                           .required,
// //                                                                       Validators
// //                                                                           .number(),
// //                                                                       Validators
// //                                                                           .min(
// //                                                                               0),
// //                                                                       Validators
// //                                                                           .max(
// //                                                                               maxCount),
// //                                                                     ],
// //                                                                     updateParent:
// //                                                                         true,
// //                                                                     autoValidate:
// //                                                                         true,
// //                                                                   );
// //                                                                 }

// //                                                                 form
// //                                                                     .control(
// //                                                                   _typeOfTransportKey,
// //                                                                 )
// //                                                                     .setValidators(
// //                                                                   [
// //                                                                     Validators
// //                                                                         .required,
// //                                                                   ],
// //                                                                   updateParent:
// //                                                                       true,
// //                                                                   autoValidate:
// //                                                                       true,
// //                                                                 );

// //                                                                 final transportTypeValue =
// //                                                                     form
// //                                                                             .control(
// //                                                                               _typeOfTransportKey,
// //                                                                             )
// //                                                                             .value
// //                                                                         as String?;
// //                                                                 if (transportTypeValue ==
// //                                                                     Constants
// //                                                                         .byHand) {
// //                                                                   byHand = true;
// //                                                                   removeVehicleValidation(
// //                                                                       form);
// //                                                                 } else {
// //                                                                   byHand =
// //                                                                       false;
// //                                                                   addVehicleValidations(
// //                                                                       form);
// //                                                                 }

// //                                                                 form
// //                                                                     .control(
// //                                                                       _waybillNumberKey,
// //                                                                     )
// //                                                                     .touched;
// //                                                                 form
// //                                                                     .control(
// //                                                                       _waybillQuantityKey,
// //                                                                     )
// //                                                                     .touched;
// //                                                                 form
// //                                                                     .control(
// //                                                                       _typeOfTransportKey,
// //                                                                     )
// //                                                                     .touched;
// //                                                               }
// //                                                             });

// //                                                             form
// //                                                                 .control(
// //                                                               _deliveryTeamKey,
// //                                                             )
// //                                                                 .setValidators(
// //                                                               [],
// //                                                               updateParent:
// //                                                                   true,
// //                                                               autoValidate:
// //                                                                   true,
// //                                                             );

// //                                                             form
// //                                                                 .control(
// //                                                               _supervisorKey,
// //                                                             )
// //                                                                 .setValidators(
// //                                                               [],
// //                                                               updateParent:
// //                                                                   true,
// //                                                               autoValidate:
// //                                                                   true,
// //                                                             );
// //                                                           }
// //                                                         },
// //                                                       ),
// //                                                     ),
// //                                                   );
// //                                                 });
// //                                           },
// //                                         ),
// //                                         Visibility(
// //                                           visible: deliveryTeamSelected,
// //                                           child: InkWell(
// //                                             onTap: () async {
// //                                               Navigator.of(context).push(
// //                                                 MaterialPageRoute(
// //                                                   builder: (context) =>
// //                                                       const CustomDigitScannerPage(
// //                                                     quantity: 1,
// //                                                     isGS1code: false,
// //                                                     singleValue: true,
// //                                                   ),
// //                                                   settings: const RouteSettings(
// //                                                       name:
// //                                                           '/custom-qr-scanner'),
// //                                                 ),
// //                                               );
// //                                             },
// //                                             child: IgnorePointer(
// //                                               child: DigitTextFormField(
// //                                                 label: localizations.translate(
// //                                                   i18.stockReconciliationDetails
// //                                                       .teamCodeLabel,
// //                                                 ),
// //                                                 onChanged: (val) {
// //                                                   String? value =
// //                                                       val.value as String?;
// //                                                   if (value != null &&
// //                                                       value.trim().isNotEmpty) {
// //                                                     context
// //                                                         .read<
// //                                                             DigitScannerBloc>()
// //                                                         .add(
// //                                                           DigitScannerEvent
// //                                                               .handleScanner(
// //                                                             barCode: [],
// //                                                             qrCode: [value],
// //                                                             manualCode: value,
// //                                                           ),
// //                                                         );
// //                                                   } else {
// //                                                     clearQRCodes();
// //                                                   }
// //                                                 },
// //                                                 suffix: IconButton(
// //                                                   onPressed: () {
// //                                                     //[TODO: Add route to auto_route]
// //                                                     Navigator.of(context).push(
// //                                                       MaterialPageRoute(
// //                                                         builder: (context) =>
// //                                                             const CustomDigitScannerPage(
// //                                                           quantity: 1,
// //                                                           isGS1code: false,
// //                                                           singleValue: true,
// //                                                         ),
// //                                                         settings:
// //                                                             const RouteSettings(
// //                                                                 name:
// //                                                                     '/custom-qr-scanner'),
// //                                                       ),
// //                                                     );
// //                                                   },
// //                                                   icon: Icon(
// //                                                     Icons.qr_code_2,
// //                                                     color: theme
// //                                                         .colorScheme.secondary,
// //                                                   ),
// //                                                 ),
// //                                                 isRequired:
// //                                                     deliveryTeamSelected,
// //                                                 maxLines: 3,
// //                                                 formControlName:
// //                                                     _deliveryTeamKey,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Visibility(
// //                                           visible: supervisorSelected,
// //                                           child: InkWell(
// //                                             onTap: () async {
// //                                               Navigator.of(context).push(
// //                                                 MaterialPageRoute(
// //                                                   builder: (context) =>
// //                                                       const CustomDigitScannerPage(
// //                                                     quantity: 1,
// //                                                     isGS1code: false,
// //                                                     singleValue: true,
// //                                                   ),
// //                                                   settings: const RouteSettings(
// //                                                       name:
// //                                                           '/custom-qr-scanner'),
// //                                                 ),
// //                                               );
// //                                             },
// //                                             child: IgnorePointer(
// //                                               child: DigitTextFormField(
// //                                                 label: localizations.translate(
// //                                                   i18_local.stockDetails
// //                                                       .monitorCodeLabel,
// //                                                 ),
// //                                                 onChanged: (val) {
// //                                                   String? value =
// //                                                       val.value as String?;
// //                                                   if (value != null &&
// //                                                       value.trim().isNotEmpty) {
// //                                                     context
// //                                                         .read<
// //                                                             DigitScannerBloc>()
// //                                                         .add(
// //                                                           DigitScannerEvent
// //                                                               .handleScanner(
// //                                                             barCode: [],
// //                                                             qrCode: [value],
// //                                                             manualCode: value,
// //                                                           ),
// //                                                         );
// //                                                   } else {
// //                                                     clearQRCodes();
// //                                                   }
// //                                                 },
// //                                                 suffix: IconButton(
// //                                                   onPressed: () {
// //                                                     //[TODO: Add route to auto_route]
// //                                                     Navigator.of(context).push(
// //                                                       MaterialPageRoute(
// //                                                         builder: (context) =>
// //                                                             const CustomDigitScannerPage(
// //                                                           quantity: 1,
// //                                                           isGS1code: false,
// //                                                           singleValue: true,
// //                                                         ),
// //                                                         settings:
// //                                                             const RouteSettings(
// //                                                                 name:
// //                                                                     '/custom-qr-scanner'),
// //                                                       ),
// //                                                     );
// //                                                   },
// //                                                   icon: Icon(
// //                                                     Icons.qr_code_2,
// //                                                     color: theme
// //                                                         .colorScheme.secondary,
// //                                                   ),
// //                                                 ),
// //                                                 isRequired: supervisorSelected,
// //                                                 maxLines: 3,
// //                                                 formControlName: _supervisorKey,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         DigitTextFormField(
// //                                           key: const Key(
// //                                               _transactionQuantityKey),
// //                                           formControlName:
// //                                               _transactionQuantityKey,
// //                                           keyboardType: const TextInputType
// //                                               .numberWithOptions(
// //                                             decimal: true,
// //                                           ),
// //                                           inputFormatters: [
// //                                             FilteringTextInputFormatter.allow(
// //                                               RegExp(r'[0-9]'),
// //                                             ),
// //                                           ],
// //                                           isRequired: true,
// //                                           validationMessages: {
// //                                             "number": (object) =>
// //                                                 localizations.translate(
// //                                                   '${quantityCountLabel}_ERROR',
// //                                                 ),
// //                                             "max": (object) =>
// //                                                 localizations.translate(
// //                                                   '${quantityCountLabel}_MAX_ERROR',
// //                                                 ),
// //                                             "min": (object) =>
// //                                                 localizations.translate(
// //                                                   '${quantityCountLabel}_MIN_ERROR',
// //                                                 ),
// //                                           },
// //                                           onChanged: (val) {
// //                                             setState(() {
// //                                               updateCommentValidation(
// //                                                   isWareHouseMgr, form);
// //                                             });
// //                                           },
// //                                           label: localizations.translate(
// //                                             quantityCountLabel,
// //                                           ),
// //                                         ),
// //                                         if (isWareHouseMgr &&
// //                                             !context.isLocalMonitor)
// //                                           DigitTextFormField(
// //                                             key: const Key(_waybillNumberKey),
// //                                             label: localizations.translate(
// //                                               i18.stockDetails
// //                                                   .waybillNumberLabel,
// //                                             ),
// //                                             isRequired: (isWareHouseMgr &&
// //                                                     !supervisorSelected &&
// //                                                     !deliveryTeamSelected) &&
// //                                                 !(context.isLocalMonitor) &&
// //                                                 !localMonitorSelected,
// //                                             formControlName: _waybillNumberKey,
// //                                             validationMessages: {
// //                                               'required': (object) =>
// //                                                   localizations.translate(
// //                                                     i18.common
// //                                                         .corecommonRequired,
// //                                                   ),
// //                                               'maxLength': (object) =>
// //                                                   localizations
// //                                                       .translate(i18.common
// //                                                           .maxCharsRequired)
// //                                                       .replaceAll('{}', '200'),
// //                                               'min2': (object) => localizations
// //                                                   .translate(i18
// //                                                       .common.min2CharsRequired)
// //                                                   .replaceAll('{}', ''),
// //                                             },
// //                                           ),
// //                                         if (isWareHouseMgr &&
// //                                             !context.isLocalMonitor)
// //                                           DigitTextFormField(
// //                                             label: localizations.translate(
// //                                               i18.stockDetails
// //                                                   .quantityOfProductIndicatedOnWaybillLabel,
// //                                             ),
// //                                             isRequired: isWareHouseMgr &&
// //                                                 !supervisorSelected &&
// //                                                 !deliveryTeamSelected &&
// //                                                 !(context.isLocalMonitor) &&
// //                                                 !localMonitorSelected,
// //                                             formControlName:
// //                                                 _waybillQuantityKey,
// //                                             inputFormatters: [
// //                                               FilteringTextInputFormatter.allow(
// //                                                 RegExp(r'[0-9]'),
// //                                               ),
// //                                             ],
// //                                             keyboardType: const TextInputType
// //                                                 .numberWithOptions(
// //                                               decimal: true,
// //                                             ),
// //                                             validationMessages: {
// //                                               'required': (object) =>
// //                                                   localizations.translate(
// //                                                     i18.common
// //                                                         .corecommonRequired,
// //                                                   ),
// //                                               "number": (object) =>
// //                                                   localizations.translate(
// //                                                     '${quantityCountLabel}_ERROR',
// //                                                   ),
// //                                               "max": (object) =>
// //                                                   localizations.translate(
// //                                                     '${quantityCountLabel}_MAX_ERROR',
// //                                                   ),
// //                                               "min": (object) =>
// //                                                   localizations.translate(
// //                                                     '${quantityCountLabel}_MIN_ERROR',
// //                                                   ),
// //                                             },
// //                                             onChanged: (val) {
// //                                               setState(() {
// //                                                 updateCommentValidation(
// //                                                     isWareHouseMgr, form);
// //                                               });
// //                                             },
// //                                           ),
// //                                         if (isWareHouseMgr)
// //                                           transportTypes.isNotEmpty
// //                                               ? DigitReactiveDropdown<String>(
// //                                                   key: const Key(
// //                                                       _typeOfTransportKey),
// //                                                   isRequired: isWareHouseMgr &&
// //                                                       !supervisorSelected &&
// //                                                       !deliveryTeamSelected,
// //                                                   label:
// //                                                       localizations.translate(
// //                                                     i18.stockDetails
// //                                                         .transportTypeLabel,
// //                                                   ),
// //                                                   valueMapper: (e) => e,
// //                                                   onChanged: (value) {
// //                                                     final transportTypeValue =
// //                                                         form
// //                                                             .control(
// //                                                               _typeOfTransportKey,
// //                                                             )
// //                                                             .value as String?;
// //                                                     if (transportTypeValue ==
// //                                                         Constants.byHand) {
// //                                                       setState(() {
// //                                                         byHand = true;
// //                                                         removeVehicleValidation(
// //                                                             form);
// //                                                       });
// //                                                     } else {
// //                                                       setState(() {
// //                                                         byHand = false;
// //                                                         if (!supervisorSelected &&
// //                                                             !deliveryTeamSelected) {
// //                                                           addVehicleValidations(
// //                                                               form);
// //                                                         } else {
// //                                                           removeVehicleValidation(
// //                                                               form);
// //                                                         }
// //                                                       });
// //                                                     }
// //                                                   },
// //                                                   initialValue: transportTypes
// //                                                       .firstOrNull?.name,
// //                                                   menuItems: transportTypes.map(
// //                                                     (e) {
// //                                                       return localizations
// //                                                           .translate(e.name);
// //                                                     },
// //                                                   ).toList(),
// //                                                   formControlName:
// //                                                       _typeOfTransportKey,
// //                                                   validationMessages: {
// //                                                     'required': (object) =>
// //                                                         localizations.translate(
// //                                                           i18.common
// //                                                               .corecommonRequired,
// //                                                         ),
// //                                                   },
// //                                                 )
// //                                               : const Offstage(),
// //                                         if (isWareHouseMgr && !byHand)
// //                                           DigitTextFormField(
// //                                             label: localizations.translate(
// //                                               i18_local
// //                                                   .stockDetailsReceiptShowcase
// //                                                   .driverName,
// //                                             ),
// //                                             isRequired: isWareHouseMgr &&
// //                                                 !supervisorSelected &&
// //                                                 !deliveryTeamSelected &&
// //                                                 !byHand,
// //                                             formControlName: _driverNameKey,
// //                                             validationMessages: {
// //                                               'required': (object) =>
// //                                                   localizations.translate(
// //                                                     i18.common
// //                                                         .corecommonRequired,
// //                                                   ),
// //                                               'maxLength': (object) =>
// //                                                   localizations
// //                                                       .translate(i18.common
// //                                                           .maxCharsRequired)
// //                                                       .replaceAll('{}', '200'),
// //                                               'min2': (object) => localizations
// //                                                   .translate(i18
// //                                                       .common.min2CharsRequired)
// //                                                   .replaceAll('{}', ''),
// //                                             },
// //                                           ),
// //                                         if (isWareHouseMgr && !byHand)
// //                                           DigitTextFormField(
// //                                             label: localizations.translate(
// //                                               i18.stockDetails
// //                                                   .vehicleNumberLabel,
// //                                             ),
// //                                             isRequired: isWareHouseMgr &&
// //                                                 !supervisorSelected &&
// //                                                 !deliveryTeamSelected &&
// //                                                 !byHand,
// //                                             formControlName: _vehicleNumberKey,
// //                                             validationMessages: {
// //                                               'required': (object) =>
// //                                                   localizations.translate(
// //                                                     i18.common
// //                                                         .corecommonRequired,
// //                                                   ),
// //                                               'maxLength': (object) =>
// //                                                   localizations
// //                                                       .translate(i18.common
// //                                                           .maxCharsRequired)
// //                                                       .replaceAll('{}', '200'),
// //                                               'min2': (object) => localizations
// //                                                   .translate(i18
// //                                                       .common.min2CharsRequired)
// //                                                   .replaceAll('{}', ''),
// //                                             },
// //                                           ),
// //                                         DigitTextFormField(
// //                                           label: localizations.translate(
// //                                             i18.stockDetails.commentsLabel,
// //                                           ),
// //                                           minLines: 2,
// //                                           maxLines: 3,
// //                                           formControlName: _commentsKey,
// //                                           isRequired: commentRequired,
// //                                           // info handle the scenario where comment required error was set true when transportType in hand
// //                                           onChanged: (formGroup) {
// //                                             form.control(_commentsKey).value =
// //                                                 formGroup.value;
// //                                           },
// //                                           validationMessages: {
// //                                             'required': (object) =>
// //                                                 localizations.translate(
// //                                                   i18.common.corecommonRequired,
// //                                                 ),
// //                                             'min2': (object) => localizations
// //                                                 .translate(i18
// //                                                     .common.min2CharsRequired)
// //                                                 .replaceAll('{}', ''),
// //                                           },
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ],
// //                               );
// //                             });
// //                           },
// //                         );
// //                       },
// //                     );
// //                   },
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   void updateCommentValidation(bool isWareHouseMgr, FormGroup form) {
// //     if (isWareHouseMgr && !supervisorSelected && !deliveryTeamSelected) {
// //       final quantity =
// //           (form.control(_transactionQuantityKey).value ?? 0) as int;

// //       final waybillQuantity =
// //           (form.control(_waybillQuantityKey).value ?? 0) as int;

// //       if (form.control(_waybillQuantityKey).value != null &&
// //           quantity != waybillQuantity) {
// //         setState(() {
// //           commentRequired = true;
// //         });
// //         form
// //             .control(
// //           _commentsKey,
// //         )
// //             .setValidators(
// //           [
// //             Validators.required,
// //             Validators.delegate(
// //                 (validator) => CustomValidator.requiredMin2(validator)),
// //           ],
// //           updateParent: true,
// //           autoValidate: true,
// //         );
// //         form
// //             .control(
// //               _commentsKey,
// //             )
// //             .touched;
// //       } else {
// //         setState(() {
// //           commentRequired = false;
// //         });
// //         form
// //             .control(
// //           _commentsKey,
// //         )
// //             .setValidators(
// //           [
// //             Validators.delegate(
// //                 (validator) => CustomValidator.requiredMin2(validator)),
// //           ],
// //           updateParent: true,
// //           autoValidate: true,
// //         );

// //         form
// //             .control(
// //               _commentsKey,
// //             )
// //             .touched;
// //       }
// //     } else {
// //       setState(() {
// //         commentRequired = false;
// //       });
// //       form
// //           .control(
// //         _commentsKey,
// //       )
// //           .setValidators(
// //         [
// //           Validators.delegate(
// //               (validator) => CustomValidator.requiredMin2(validator)),
// //         ],
// //         updateParent: true,
// //         autoValidate: true,
// //       );

// //       form
// //           .control(
// //             _commentsKey,
// //           )
// //           .touched;
// //     }
// //   }

// //   void addVehicleValidations(FormGroup form) {
// //     form
// //         .control(
// //       _vehicleNumberKey,
// //     )
// //         .setValidators(
// //       [
// //         Validators.required,
// //         Validators.minLength(2),
// //         Validators.maxLength(200),
// //       ],
// //       updateParent: true,
// //       autoValidate: true,
// //     );

// //     form
// //         .control(
// //       _driverNameKey,
// //     )
// //         .setValidators(
// //       [
// //         Validators.required,
// //         Validators.minLength(2),
// //         Validators.maxLength(200),
// //       ],
// //       updateParent: true,
// //       autoValidate: true,
// //     );

// //     form
// //         .control(
// //           _vehicleNumberKey,
// //         )
// //         .touched;

// //     form
// //         .control(
// //           _driverNameKey,
// //         )
// //         .touched;
// //   }

// //   void removeVehicleValidation(FormGroup form) {
// //     form
// //         .control(
// //       _vehicleNumberKey,
// //     )
// //         .setValidators(
// //       [],
// //       updateParent: true,
// //       autoValidate: true,
// //     );

// //     form
// //         .control(
// //       _driverNameKey,
// //     )
// //         .setValidators(
// //       [],
// //       updateParent: true,
// //       autoValidate: true,
// //     );
// //   }

// //   void clearQRCodes() {
// //     context.read<DigitScannerBloc>().add(const DigitScannerEvent.handleScanner(
// //           barCode: [],
// //           qrCode: [],
// //         ));
// //   }

// //   /// This function processes a list of GS1 barcodes and returns a map where the keys and values are joined by '|'.
// //   ///
// //   /// It takes a list of GS1Barcode objects as a parameter. Each GS1Barcode object represents a barcode that has been scanned.
// //   ///
// //   /// The function first initializes two empty lists: one for the keys and one for the values.
// //   ///
// //   /// It then iterates over each barcode in the list. For each barcode, it iterates over each element in the barcode.
// //   /// Each element is a MapEntry object, where the key is the identifier of the data field and the value is the data itself.
// //   ///
// //   /// The function adds the key and value of each element to the respective lists. The key and value are both converted to strings.
// //   ///
// //   /// After all barcodes have been processed, the function returns a map where the keys and values are joined by '|'.
// //   ///
// //   /// @param barCodes The list of GS1Barcode objects to be processed.
// //   /// @return A map where the keys and values are joined by '|'.
// //   AdditionalField addBarCodesToFields(List<GS1Barcode> barCodes) {
// //     List<String> keys = [];
// //     List<String> values = [];
// //     for (var element in barCodes) {
// //       for (var e in element.elements.entries) {
// //         keys.add(e.key.toString());
// //         values.add(e.value.data.toString());
// //       }
// //     }
// //     return AdditionalField(keys.join('|'), values.join('|'));
// //   }
// // }
