import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_stepper.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_scanner/blocs/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:registration_delivery/models/entities/deliver_strategy_type.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/extensions/extensions.dart';
import 'package:registration_delivery/utils/utils.dart';

import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../blocs/app_initialization/app_initialization.dart';
import '../../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../../router/app_router.dart';
import '../../../utils/constants.dart';
import '../../../utils/i18_key_constants.dart' as i18_local;

import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/component_wrapper/product_variant_bloc_wrapper.dart';
import 'package:registration_delivery/widgets/localized.dart';
import '../../../widgets/widgets_bednet/custom_resource_beneficiary_card.dart';
import '../custom_qr_scanner.dart';

@RoutePage()
class CustomDeliverInterventionBednetPage extends LocalizedStatefulWidget {
  final bool isEditing;

  const CustomDeliverInterventionBednetPage({
    super.key,
    super.appLocalizations,
    this.isEditing = false,
  });

  @override
  State<CustomDeliverInterventionBednetPage> createState() =>
      CustomDeliverInterventionBednetPageState();
}

class CustomDeliverInterventionBednetPageState
    extends LocalizedState<CustomDeliverInterventionBednetPage> {
  // Constants for form control keys
  static const _resourceDeliveredKey = 'resourceDelivered';
  static const _quantityDistributedKey = 'quantityDistributed';
  static const _deliveryCommentKey = 'deliveryComment';
  static const _doseAdministrationKey = 'doseAdministered';
  final clickedStatus = ValueNotifier<bool>(false);
  var bednetCount = 0;
  var bednetScanned = 0;
  static const _qrCodesKey = "qrCodes";

  // Variable to track dose administration status
  bool deliveryCommentRequired = false;

  // List of controllers for form elements
  final List _controllers = [];

// Initialize the currentStep variable to keep track of the current step in a process.
  int currentStep = 0;

  @override
  void initState() {
    context.read<LocationBloc>().add(const LoadLocationEvent());
    super.initState();
  }

  Future<void> handleCapturedLocationState(
    LocationState locationState,
    BuildContext context,
    DeliverInterventionState deliverInterventionState,
    FormGroup form,
    HouseholdMemberWrapper householdMember,
    ProjectBeneficiaryModel projectBeneficiary,
    List<AdditionalField> codeAdditionalFields,
  ) async {
    final lat = locationState.latitude;
    final long = locationState.longitude;
    context.read<DeliverInterventionBloc>().add(
          DeliverInterventionSubmitEvent(
              task: _getTaskModel(
                context,
                form: form,
                oldTask: RegistrationDeliverySingleton().beneficiaryType ==
                        BeneficiaryType.household
                    ? deliverInterventionState.tasks?.lastOrNull
                    : null,
                projectBeneficiaryClientReferenceId:
                    projectBeneficiary.clientReferenceId,
                dose: deliverInterventionState.dose,
                cycle: deliverInterventionState.cycle,
                deliveryStrategy: DeliverStrategyType.direct.toValue(),
                address: householdMember.members?.first.address?.first,
                latitude: lat,
                longitude: long,
                codes: codeAdditionalFields,
              ),
              isEditing: (deliverInterventionState.tasks ?? []).isNotEmpty &&
                      RegistrationDeliverySingleton().beneficiaryType ==
                          BeneficiaryType.household
                  ? true
                  : false,
              boundaryModel: RegistrationDeliverySingleton().boundary!,
              navigateToSummary: false,
              householdMemberWrapper: householdMember),
        );
    context.router.push(
        CustomHouseholdAcknowledgementBednetRoute(enableViewHousehold: false));
  }

  void handleLocationState(
    LocationState locationState,
    BuildContext context,
    DeliverInterventionState deliverInterventionState,
    FormGroup form,
    HouseholdMemberWrapper householdMember,
    ProjectBeneficiaryModel projectBeneficiary,
    List<AdditionalField> codeAdditionalFields,
  ) {
    if (context.mounted) {
      DigitComponentsUtils().showLocationCapturingDialog(
          context,
          localizations.translate(i18.common.locationCapturing),
          DigitSyncDialogType.inProgress);

      Future.delayed(const Duration(seconds: 2), () {
        // After delay, hide the initial dialog
        DigitComponentsUtils().hideDialog(context);
        handleCapturedLocationState(
            locationState,
            context,
            deliverInterventionState,
            form,
            householdMember,
            projectBeneficiary,
            codeAdditionalFields);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<StepsModel> generateSteps(int numberOfDoses) {
      return List.generate(numberOfDoses, (index) {
        return StepsModel(
          title:
              '${localizations.translate(i18.deliverIntervention.dose)}${index + 1}',
          number: (index + 1).toString(),
        );
      });
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: ProductVariantBlocWrapper(
        child: BlocBuilder<HouseholdOverviewBloc, HouseholdOverviewState>(
          builder: (context, state) {
            final householdMemberWrapper = state.householdMemberWrapper;
            final memberCount =
                householdMemberWrapper.household?.memberCount ?? 0;
            bednetCount =
                min(memberCount / 2, Constants.maxBednetCount).round();

            final projectBeneficiary =
                RegistrationDeliverySingleton().beneficiaryType !=
                        BeneficiaryType.individual
                    ? [householdMemberWrapper.projectBeneficiaries!.first]
                    : householdMemberWrapper.projectBeneficiaries
                        ?.where(
                          (element) =>
                              element.beneficiaryClientReferenceId ==
                              state.selectedIndividual?.clientReferenceId,
                        )
                        .toList();

            return Scaffold(
              body: state.loading
                  ? const Center(child: CircularProgressIndicator())
                  : BlocBuilder<DeliverInterventionBloc,
                      DeliverInterventionState>(
                      builder: (context, deliveryInterventionState) {
                        List<DeliveryProductVariant>? productVariants =
                            RegistrationDeliverySingleton()
                                        .selectedProject
                                        ?.additionalDetails
                                        ?.projectType
                                        ?.cycles
                                        ?.isNotEmpty ==
                                    true
                                ? (fetchProductVariant(
                                        RegistrationDeliverySingleton()
                                                .selectedProject
                                                ?.additionalDetails
                                                ?.projectType
                                                ?.cycles![
                                                    deliveryInterventionState
                                                            .cycle -
                                                        1]
                                                .deliveries?[
                                            deliveryInterventionState.dose - 1],
                                        state.selectedIndividual,
                                        state.householdMemberWrapper.household)
                                    ?.productVariants)
                                : RegistrationDeliverySingleton()
                                    .selectedProject
                                    ?.additionalDetails
                                    ?.projectType
                                    ?.resources
                                    ?.map((r) => DeliveryProductVariant(
                                        productVariantId: r.productVariantId))
                                    .toList();

                        if ((productVariants ?? []).isEmpty &&
                            context.mounted) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            DigitToast.show(
                              context,
                              options: DigitToastOptions(
                                localizations.translate(
                                  i18.deliverIntervention
                                      .checkForProductVariantsConfig,
                                ),
                                true,
                                theme,
                              ),
                            );
                          });
                        }

                        return BlocBuilder<ProductVariantBloc,
                            ProductVariantState>(
                          builder: (context, productState) {
                            return productState.maybeWhen(
                              orElse: () => const Offstage(),
                              fetched: (productVariantsValue) {
                                final variant = productState.whenOrNull(
                                  fetched: (productVariants) {
                                    final filteredProductVariants =
                                        productVariants
                                            .where((product) =>
                                                product.sku !=
                                                Constants.vechileSKU)
                                            .toList();
                                    return filteredProductVariants;
                                  },
                                );
                                return BlocBuilder<DigitScannerBloc,
                                        DigitScannerState>(
                                    builder: (context, scannerState) {
                                  return ReactiveFormBuilder(
                                    form: () => buildForm(
                                      context,
                                      productVariants,
                                      variant,
                                    ),
                                    builder: (context, form, child) {
                                      return ScrollableContent(
                                        enableFixedButton: true,
                                        footer: BlocBuilder<
                                            DeliverInterventionBloc,
                                            DeliverInterventionState>(
                                          builder: (context, state) {
                                            return DigitCard(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, kPadding, 0, 0),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      kPadding, 0, kPadding, 0),
                                              child: ValueListenableBuilder(
                                                valueListenable: clickedStatus,
                                                builder: (context,
                                                    bool isClicked, _) {
                                                  return BlocBuilder<
                                                          LocationBloc,
                                                          LocationState>(
                                                      builder: (context,
                                                          locationState) {
                                                    return DigitElevatedButton(
                                                      onPressed: isClicked
                                                          ? null
                                                          : () async {
                                                              form.markAllAsTouched();
                                                              if (!form.valid) {
                                                                return;
                                                              }
                                                              bednetScanned =
                                                                  scannerState
                                                                      .barCodes
                                                                      .length;

                                                              final List<
                                                                      GS1Barcode>
                                                                  barcodes =
                                                                  scannerState
                                                                      .barCodes;

                                                              List<AdditionalField>
                                                                  codeAdditionalFields =
                                                                  [];

                                                              for (var element
                                                                  in barcodes) {
                                                                List<String>
                                                                    keys = [];
                                                                List<String>
                                                                    values = [];
                                                                for (var e
                                                                    in element
                                                                        .elements
                                                                        .entries) {
                                                                  e.value
                                                                      .rawData;
                                                                  keys.add(
                                                                    e.key
                                                                        .toString(),
                                                                  );
                                                                  values.add(
                                                                    e.value.data
                                                                        .toString(),
                                                                  );
                                                                }

                                                                codeAdditionalFields
                                                                    .add(
                                                                  AdditionalField(
                                                                    keys.join(
                                                                        '|'),
                                                                    values.join(
                                                                        '|'),
                                                                  ),
                                                                );
                                                              }
                                                              final deliveredProducts =
                                                                  ((form.control(_resourceDeliveredKey)
                                                                              as FormArray)
                                                                          .value
                                                                      as List<
                                                                          ProductVariantModel?>);
                                                              final hasEmptyResources =
                                                                  hasEmptyOrNullResources(
                                                                      deliveredProducts);
                                                              final hasZeroQuantity =
                                                                  hasEmptyOrZeroQuantity(
                                                                      form);
                                                              final hasDuplicates =
                                                                  hasDuplicateResources(
                                                                      deliveredProducts,
                                                                      form);
                                                              if (hasEmptyResources) {
                                                                await DigitToast
                                                                    .show(
                                                                  context,
                                                                  options:
                                                                      DigitToastOptions(
                                                                    localizations.translate(i18
                                                                        .deliverIntervention
                                                                        .resourceDeliveredValidation),
                                                                    true,
                                                                    theme,
                                                                  ),
                                                                );
                                                              } else if (hasDuplicates) {
                                                                await DigitToast
                                                                    .show(
                                                                  context,
                                                                  options:
                                                                      DigitToastOptions(
                                                                    localizations.translate(i18
                                                                        .deliverIntervention
                                                                        .resourceDuplicateValidation),
                                                                    true,
                                                                    theme,
                                                                  ),
                                                                );
                                                              } else if (hasZeroQuantity) {
                                                                await DigitToast
                                                                    .show(
                                                                  context,
                                                                  options:
                                                                      DigitToastOptions(
                                                                    localizations.translate(i18
                                                                        .deliverIntervention
                                                                        .resourceCannotBeZero),
                                                                    true,
                                                                    theme,
                                                                  ),
                                                                );
                                                              }
                                                              // info : show dialog stating more bednet scanned then the permissible count
                                                              else if (bednetScanned >
                                                                  bednetCount) {
                                                                await DigitToast
                                                                    .show(
                                                                  context,
                                                                  options:
                                                                      DigitToastOptions(
                                                                    localizations.translate(i18_local
                                                                        .deliverIntervention
                                                                        .bednetScanMoreThanCount),
                                                                    true,
                                                                    theme,
                                                                  ),
                                                                );
                                                              } else {
                                                                final shouldSubmit =
                                                                    await DigitDialog
                                                                        .show<
                                                                            bool>(
                                                                  context,
                                                                  options:
                                                                      DigitDialogOptions(
                                                                    titleText:
                                                                        localizations
                                                                            .translate(
                                                                      i18.deliverIntervention
                                                                          .dialogTitle,
                                                                    ),
                                                                    contentText:
                                                                        localizations
                                                                            .translate(
                                                                      i18.deliverIntervention
                                                                          .dialogContent,
                                                                    ),
                                                                    primaryAction:
                                                                        DigitDialogActions(
                                                                      label: localizations
                                                                          .translate(
                                                                        i18.common
                                                                            .coreCommonSubmit,
                                                                      ),
                                                                      action:
                                                                          (context) {
                                                                        clickedStatus.value =
                                                                            true;
                                                                        Navigator
                                                                            .of(
                                                                          context,
                                                                          rootNavigator:
                                                                              true,
                                                                        ).pop(
                                                                            true);
                                                                      },
                                                                    ),
                                                                    secondaryAction:
                                                                        DigitDialogActions(
                                                                      label: localizations
                                                                          .translate(
                                                                        i18.common
                                                                            .coreCommonCancel,
                                                                      ),
                                                                      action: (context) =>
                                                                          Navigator
                                                                              .of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true,
                                                                      ).pop(false),
                                                                    ),
                                                                  ),
                                                                );
                                                                if ((shouldSubmit ??
                                                                        false) &&
                                                                    context
                                                                        .mounted) {
                                                                  context
                                                                      .read<
                                                                          LocationBloc>()
                                                                      .add(
                                                                          const LoadLocationEvent());
                                                                  handleLocationState(
                                                                    locationState,
                                                                    context,
                                                                    deliveryInterventionState,
                                                                    form,
                                                                    householdMemberWrapper,
                                                                    projectBeneficiary!
                                                                        .first,
                                                                    codeAdditionalFields,
                                                                  );
                                                                }
                                                              }
                                                            },
                                                      child: Center(
                                                        child: Text(
                                                          localizations
                                                              .translate(
                                                            i18.common
                                                                .coreCommonSubmit,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        header: const Column(children: [
                                          BackNavigationHelpHeaderWidget(
                                            showHelp: false,
                                            showBackNavigation: false,
                                          ),
                                        ]),
                                        children: [
                                          Column(
                                            children: [
                                              DigitCard(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      localizations.translate(
                                                        i18.deliverIntervention
                                                            .deliveryDetailsLabel,
                                                      ),
                                                      style: theme.textTheme
                                                          .headlineLarge,
                                                    ),
                                                    DigitTableCard(
                                                      element: {
                                                        localizations.translate(
                                                                i18_local
                                                                    .deliverIntervention
                                                                    .memberCountText):
                                                            householdMemberWrapper
                                                                    .household
                                                                    ?.memberCount ??
                                                                localizations
                                                                    .translate(i18
                                                                        .common
                                                                        .coreCommonNA),
                                                        localizations.translate(
                                                                i18_local
                                                                    .deliverIntervention
                                                                    .bednetCountText):
                                                            bednetCount,
                                                      },
                                                    ),
                                                    ..._controllers.map((e) =>
                                                        CustomResourceBeneficiaryCard(
                                                            form: form,
                                                            bednetCount:
                                                                bednetCount,
                                                            cardIndex:
                                                                _controllers
                                                                    .indexOf(e),
                                                            totalItems:
                                                                _controllers
                                                                    .length,
                                                            onDelete: (index) {
                                                              (form.control(
                                                                _resourceDeliveredKey,
                                                              ) as FormArray)
                                                                  .removeAt(
                                                                index,
                                                              );
                                                              (form.control(
                                                                _quantityDistributedKey,
                                                              ) as FormArray)
                                                                  .removeAt(
                                                                index,
                                                              );
                                                              _controllers
                                                                  .removeAt(
                                                                index,
                                                              );
                                                              setState(() {
                                                                _controllers;
                                                              });
                                                            },
                                                            onQuantityUpdate:
                                                                () {
                                                              final quantity = (((form
                                                                          .control(
                                                                              _quantityDistributedKey)
                                                                      as FormArray)
                                                                  .value)?[0]) as int;
                                                              if (quantity ==
                                                                  bednetCount) {
                                                                setState(() {
                                                                  deliveryCommentRequired =
                                                                      false;
                                                                  (form.control(
                                                                    _deliveryCommentKey,
                                                                  )).value =
                                                                      null;

                                                                  (form.control(
                                                                    _deliveryCommentKey,
                                                                  )).setValidators(
                                                                    [],
                                                                    updateParent:
                                                                        true,
                                                                    autoValidate:
                                                                        true,
                                                                  );
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  deliveryCommentRequired =
                                                                      true;

                                                                  (form.control(
                                                                    _deliveryCommentKey,
                                                                  )).setValidators(
                                                                    [
                                                                      Validators
                                                                          .required
                                                                    ],
                                                                    updateParent:
                                                                        true,
                                                                    autoValidate:
                                                                        true,
                                                                  );
                                                                  (form.control(
                                                                    _deliveryCommentKey,
                                                                  )).touched;
                                                                });
                                                              }
                                                            })),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          kPadding,
                                                          kPadding,
                                                          kPadding,
                                                          0),
                                                      child: scannerState
                                                              .qrCodes
                                                              .isNotEmpty
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3,
                                                                  child: Text(
                                                                    localizations
                                                                        .translate(
                                                                      i18.deliverIntervention
                                                                          .voucherCode,
                                                                    ),
                                                                    style: theme
                                                                        .textTheme
                                                                        .headlineSmall,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    bottom:
                                                                        kPadding *
                                                                            2,
                                                                  ),
                                                                  child:
                                                                      IconButton(
                                                                    color: theme
                                                                        .colorScheme
                                                                        .secondary,
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .edit),
                                                                    onPressed:
                                                                        () {
                                                                      final quantity =
                                                                          (((form.control(_quantityDistributedKey) as FormArray).value)?[0])
                                                                              as int;

                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                        //[TODO: Add the route to auto_route]
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              CustomDigitScannerPage(
                                                                            quantity:
                                                                                quantity,
                                                                            isGS1code:
                                                                                true,
                                                                            singleValue:
                                                                                quantity < 2,
                                                                            isEditEnabled:
                                                                                true,
                                                                            manualEnabled:
                                                                                false,
                                                                          ),
                                                                          settings:
                                                                              const RouteSettings(name: '/qr-scanner'),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],

                                                              // ignore: no-empty-block
                                                            )
                                                          : DigitOutlineIconButton(
                                                              buttonStyle:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                  // [TODO: Add the route to auto_route]
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CustomDigitScannerPage(
                                                                      quantity:
                                                                          bednetCount,
                                                                      isGS1code:
                                                                          true,
                                                                      singleValue:
                                                                          bednetCount <
                                                                              2,
                                                                      isEditEnabled:
                                                                          true,
                                                                      manualEnabled:
                                                                          false,
                                                                    ),
                                                                    settings:
                                                                        const RouteSettings(
                                                                            name:
                                                                                '/qr-scanner'),
                                                                  ),
                                                                );
                                                              },
                                                              icon:
                                                                  Icons.qr_code,
                                                              label:
                                                                  localizations
                                                                      .translate(
                                                                i18_local
                                                                    .deliverIntervention
                                                                    .scanBednet,
                                                              ),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              DigitCard(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    BlocBuilder<
                                                        AppInitializationBloc,
                                                        AppInitializationState>(
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is! AppInitialized) {
                                                          return const Offstage();
                                                        }

                                                        final deliveryCommentOptions = state
                                                                .appConfiguration
                                                                .deliveryCommentOptions ??
                                                            <DeliveryCommentOptions>[];

                                                        return DigitReactiveSearchDropdown<
                                                            String>(
                                                          label: localizations
                                                              .translate(
                                                            i18.deliverIntervention
                                                                .deliveryCommentLabel,
                                                          ),
                                                          form: form,
                                                          enabled:
                                                              deliveryCommentRequired,
                                                          isRequired:
                                                              deliveryCommentRequired,
                                                          menuItems:
                                                              deliveryCommentOptions
                                                                  .map((e) {
                                                            return e.code;
                                                          }).toList(),
                                                          formControlName:
                                                              _deliveryCommentKey,
                                                          valueMapper: (value) =>
                                                              localizations
                                                                  .translate(
                                                            value,
                                                          ),
                                                          emptyText: localizations
                                                              .translate(i18
                                                                  .common
                                                                  .noMatchFound),
                                                          validationMessage:
                                                              localizations
                                                                  .translate(
                                                            i18.common
                                                                .corecommonRequired,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }

  addController(FormGroup form) {
    (form.control(_resourceDeliveredKey) as FormArray)
        .add(FormControl<ProductVariantModel>());
    (form.control(_quantityDistributedKey) as FormArray)
        .add(FormControl<int>(value: 0, validators: [Validators.min(1)]));
  }

  bool hasEmptyOrZeroQuantity(FormGroup form) {
    final quantityDistributedArray =
        form.control(_quantityDistributedKey) as FormArray;

    // Check if any quantity is zero or null
    return quantityDistributedArray.value?.any((e) => e == 0 || e == null) ??
        true;
  }

  bool hasEmptyOrNullResources(List<ProductVariantModel?> deliveredProducts) {
    final Map<String?, List<ProductVariantModel?>> groupedVariants = {};
    if (deliveredProducts.isNotEmpty) {
      for (final variant in deliveredProducts) {
        final productId = variant?.productId;
        if (productId != null) {
          groupedVariants.putIfAbsent(productId, () => []);
          groupedVariants[productId]?.add(variant);
        }
      }
      bool hasDuplicateProductIdOrNoProductId =
          deliveredProducts.any((ele) => ele?.productId == null);

      return hasDuplicateProductIdOrNoProductId;
    }

    return true;
  }

  bool hasDuplicateResources(
      List<ProductVariantModel?> deliveredProducts, FormGroup form) {
    final resourceDeliveredArray =
        form.control(_resourceDeliveredKey) as FormArray;
    final Set<String?> uniqueProductIds = {};

    for (int i = 0; i < resourceDeliveredArray.value!.length; i++) {
      final productId = deliveredProducts[i]?.id;
      if (productId != null) {
        if (uniqueProductIds.contains(productId)) {
          // Duplicate found
          return true;
        } else {
          uniqueProductIds.add(productId);
        }
      }
    }
    return false;
  }

  // ignore: long-parameter-list
  TaskModel _getTaskModel(
    BuildContext context, {
    required FormGroup form,
    TaskModel? oldTask,
    int? cycle,
    int? dose,
    String? deliveryStrategy,
    String? projectBeneficiaryClientReferenceId,
    AddressModel? address,
    double? latitude,
    double? longitude,
    List<AdditionalField>? codes,
  }) {
    // Initialize task with oldTask if available, or create a new one
    var task = oldTask;
    var clientReferenceId = task?.clientReferenceId ?? IdGen.i.identifier;
    task ??= TaskModel(
      projectBeneficiaryClientReferenceId: projectBeneficiaryClientReferenceId,
      clientReferenceId: clientReferenceId,
      address: address?.copyWith(
        relatedClientReferenceId: clientReferenceId,
      ),
      tenantId: RegistrationDeliverySingleton().tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
      ),
      clientAuditDetails: ClientAuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
      ),
    );

    // Extract productvariantList from the form
    final productvariantList =
        ((form.control(_resourceDeliveredKey) as FormArray).value
            as List<ProductVariantModel?>);
    final deliveryComment = form.control(_deliveryCommentKey).value as String?;

    // Update the task with information from the form and other context
    task = task.copyWith(
      projectId: RegistrationDeliverySingleton().projectId,
      resources: productvariantList
          .map((e) => TaskResourceModel(
                taskclientReferenceId: clientReferenceId,
                clientReferenceId: IdGen.i.identifier,
                productVariantId: e?.id,
                isDelivered: true,
                deliveryComment: deliveryComment != null &&
                        deliveryComment.trim().toString().isNotEmpty
                    ? deliveryComment
                    : null,
                taskId: task?.id,
                tenantId: RegistrationDeliverySingleton().tenantId,
                rowVersion: oldTask?.rowVersion ?? 1,
                quantity: (((form.control(_quantityDistributedKey) as FormArray)
                        .value)?[productvariantList.indexOf(e)])
                    .toString(),
                clientAuditDetails: ClientAuditDetails(
                  createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
                  createdTime: context.millisecondsSinceEpoch(),
                ),
                auditDetails: AuditDetails(
                  createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
                  createdTime: context.millisecondsSinceEpoch(),
                ),
              ))
          .toList(),
      address: address?.copyWith(
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
      status: Status.administeredSuccess.toValue(),
      additionalFields: TaskAdditionalFields(
        version: task.additionalFields?.version ?? 1,
        fields: [
          AdditionalField(
            RegistrationDeliveryEnums.name.toValue(),
            RegistrationDeliverySingleton().loggedInUser?.name,
          ),
          AdditionalField(
            AdditionalFieldsType.dateOfDelivery.toValue(),
            DateTime.now().millisecondsSinceEpoch.toString(),
          ),
          AdditionalField(
            AdditionalFieldsType.dateOfAdministration.toValue(),
            DateTime.now().millisecondsSinceEpoch.toString(),
          ),
          AdditionalField(
            AdditionalFieldsType.dateOfVerification.toValue(),
            DateTime.now().millisecondsSinceEpoch.toString(),
          ),
          AdditionalField(
            AdditionalFieldsType.cycleIndex.toValue(),
            "0${cycle ?? 1}",
          ),
          AdditionalField(
            AdditionalFieldsType.doseIndex.toValue(),
            "0${dose ?? 1}",
          ),
          AdditionalField(
            AdditionalFieldsType.deliveryStrategy.toValue(),
            deliveryStrategy,
          ),
          if (latitude != null)
            AdditionalField(
              AdditionalFieldsType.latitude.toValue(),
              latitude,
            ),
          if (longitude != null)
            AdditionalField(
              AdditionalFieldsType.longitude.toValue(),
              longitude,
            ),
          if (deliveryComment != null &&
              deliveryComment.trim().toString().isNotEmpty)
            AdditionalField(
              AdditionalFieldsType.deliveryComment.toValue(),
              deliveryComment,
            ),
          if (codes != null && codes.isNotEmpty) ...codes
        ],
      ),
    );

    return task;
  }

// This method builds a form used for delivering interventions.

  FormGroup buildForm(
    BuildContext context,
    List<DeliveryProductVariant>? productVariants,
    List<ProductVariantModel>? variants,
  ) {
    final bloc = context.read<DeliverInterventionBloc>().state;
    final overViewbloc = context.read<HouseholdOverviewBloc>().state;
    _controllers.forEachIndexed((index, element) {
      _controllers.removeAt(index);
    });

    // Add controllers for each product variant to the _controllers list.
    if (_controllers.isEmpty) {
      final int r = RegistrationDeliverySingleton()
                  .selectedProject
                  ?.additionalDetails
                  ?.projectType
                  ?.cycles ==
              null
          ? 1
          : fetchProductVariant(
                      RegistrationDeliverySingleton()
                          .selectedProject
                          ?.additionalDetails
                          ?.projectType
                          ?.cycles![bloc.cycle - 1]
                          .deliveries?[bloc.dose - 1],
                      overViewbloc.selectedIndividual,
                      overViewbloc.householdMemberWrapper.household)!
                  .productVariants
                  ?.length ??
              0;

      _controllers.addAll(List.generate(r, (index) => index)
          .mapIndexed((index, element) => index));
    }

    return fb.group(<String, Object>{
      _doseAdministrationKey: FormControl<String>(
        value:
            '${localizations.translate(i18.deliverIntervention.cycle)} ${bloc.cycle == 0 ? (bloc.cycle + 1) : bloc.cycle}'
                .toString(),
        validators: [],
      ),
      _deliveryCommentKey: FormControl<String>(
        value: RegistrationDeliverySingleton().beneficiaryType !=
                BeneficiaryType.individual
            ? (bloc.tasks?.lastOrNull?.additionalFields?.fields
                            .where((a) =>
                                a.key ==
                                AdditionalFieldsType.deliveryComment.toValue())
                            .toList() ??
                        [])
                    .isNotEmpty
                ? bloc.tasks?.lastOrNull?.additionalFields?.fields
                    .where((a) =>
                        a.key == AdditionalFieldsType.deliveryComment.toValue())
                    .first
                    .value
                : ''
            : null,
        validators: [],
      ),
      _resourceDeliveredKey: FormArray<ProductVariantModel>(
        [
          ..._controllers.map((e) => FormControl<ProductVariantModel>(
                value: variants != null && variants.length < _controllers.length
                    ? variants.last
                    : (variants != null &&
                            _controllers.indexOf(e) < variants.length
                        ? variants.firstWhereOrNull(
                            (element) =>
                                element.id ==
                                productVariants
                                    ?.elementAt(_controllers.indexOf(e))
                                    .productVariantId,
                          )
                        : null),
              )),
        ],
      ),
      _quantityDistributedKey: FormArray<int>([
        ..._controllers.mapIndexed(
          (i, e) => FormControl<int>(
            value: RegistrationDeliverySingleton().beneficiaryType !=
                    BeneficiaryType.individual
                ? bednetCount
                : 0,
            validators: [Validators.min(1)],
          ),
        ),
      ]),
    });
  }
}
