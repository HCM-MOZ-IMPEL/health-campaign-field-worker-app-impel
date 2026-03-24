import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/utils/extensions/extensions.dart';

import 'package:registration_delivery/blocs/app_localization.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/models/entities/side_effect.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../models/entities/additional_fields_type.dart';
import '../../models/entities/entities_smc/identifier_types.dart'
    as identifier_types;
import '../../models/entities/entities_smc/intervention_types.dart';
import '../../utils/utils_smc/i18_key_constants.dart' as i18_local;
import '../../router/app_router.dart';
import '../action_card/action_card.dart';
import 'package:digit_ui_components/utils/date_utils.dart'
    as digit_ui_date_utils;
import '../../utils/utils_smc/utils_smc.dart'
    show
        allDosesDelivered,
        assessmentOnchoPending,
        assessmentSMCPending,
        checkIfBeneficiaryIneligibleOncho,
        checkIfBeneficiaryReferredOncho,
        checkIfBeneficiaryRefusedOncho,
        checkStatusSMC,
        fetchProductVariantSMC,
        isSmcAndBednetFlow,
        isSmcAndOnchoFlow,
        checkEligibilityForAgeAndSideEffectOncho,
        checkStatusOncho,
        fetchProductVariantForProjectType;

class CustomMemberCardSMC extends StatelessWidget {
  final String name;
  final String? gender;
  final int? years;
  final int? months;
  final bool isHead;
  final IndividualModel individual;
  final List<ProjectBeneficiaryModel>? projectBeneficiaries;
  final bool isDelivered;

  final VoidCallback setAsHeadAction;
  final VoidCallback editMemberAction;
  final VoidCallback deleteMemberAction;
  final RegistrationDeliveryLocalization localizations;
  final List<TaskModel>? tasks;
  final List<SideEffectModel>? sideEffects;
  final bool isNotEligible;
  final bool isBeneficiaryRefused;
  final bool isBeneficiaryReferred;
  final bool isBeneficiaryIneligible;
  final String? projectBeneficiaryClientReferenceId;

  const CustomMemberCardSMC({
    super.key,
    required this.individual,
    required this.name,
    this.gender,
    this.years,
    this.isHead = false,
    this.months,
    required this.localizations,
    required this.isDelivered,
    required this.setAsHeadAction,
    required this.editMemberAction,
    required this.deleteMemberAction,
    this.projectBeneficiaries,
    this.tasks,
    this.isNotEligible = false,
    this.projectBeneficiaryClientReferenceId,
    this.isBeneficiaryRefused = false,
    this.isBeneficiaryReferred = false,
    this.isBeneficiaryIneligible = false,
    this.sideEffects,
  });

  List<TaskModel>? _getSMCStatusData(BuildContext context) {
    // todo correct this logic when there are multiple tasks for different cycles. currently it is assumed that there will be only one task for smc intervention type and if there are multiple tasks, it will filter based on the cycle id in additional field which might not be correct always as there can be multiple tasks for smc with same cycle id as well
    // final tasks = this
    //     .tasks
    //     ?.where((e) =>
    //         e.additionalFields?.fields
    //             .where((field) =>
    //                 field.key ==
    //                     AdditionalFieldsType.interventionType.toValue() &&
    //                 int.tryParse(field.value) == context.selectedCycle?.id)
    //             .isNotEmpty ??
    //         false)
    //     .toList();

    return tasks?.where((e) {
      final interventionField = e.additionalFields?.fields.firstWhereOrNull(
        (element) =>
            element.key == AdditionalFieldsType.interventionType.toValue(),
      );

      // If field is missing → assume SMC
      if (interventionField == null) {
        return true;
      }

      // If field exists → must be SMC
      return interventionField.value == InterventionTypes.smc.toValue();
    }).toList();
  }

  List<TaskModel>? _getOnchoStatusData() {
    return tasks
        ?.where((e) =>
            e.additionalFields?.fields.firstWhereOrNull(
              (element) =>
                  element.key ==
                      AdditionalFieldsType.interventionType.toValue() &&
                  element.value == InterventionTypes.oncho.toValue(),
            ) !=
            null)
        .toList();
  }

  List<TaskModel>? _getBednetStatusData() {
    return tasks
        ?.where((e) =>
            e.additionalFields?.fields.firstWhereOrNull(
              (element) =>
                  element.key ==
                      AdditionalFieldsType.interventionType.toValue() &&
                  element.value == InterventionTypes.bednet.toValue(),
            ) !=
            null)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final beneficiaryType = RegistrationDeliverySingleton().beneficiaryType;

    final smcAndOnchoFlow = isSmcAndOnchoFlow(context);
    final smcAndBednetFlow = isSmcAndBednetFlow(context);

    if (smcAndOnchoFlow) {
      return smcAndOnchoFlowWidget(context, theme, beneficiaryType);
    } else if (smcAndBednetFlow) {
      return smcAndBednetFlowWidget(context, theme, beneficiaryType);
    } else {
      return smcFlowWidget(context, theme, beneficiaryType);
    }
  }

  Container smcFlowWidget(
      BuildContext context, ThemeData theme, BeneficiaryType? beneficiaryType) {
    bool smcAssessmentPendingStatus =
        assessmentSMCPending(tasks, context.selectedCycle);

    String? beneficiaryId = individual.identifiers
        ?.lastWhereOrNull(
          (e) =>
              e.identifierType == IdentifierTypes.uniqueBeneficiaryID.toValue(),
        )
        ?.identifierId;

    return Container(
      decoration: BoxDecoration(
        color: DigitTheme.instance.colorScheme.background,
        border: Border.all(
          color: DigitTheme.instance.colorScheme.outline,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      margin: DigitTheme.instance.containerMargin,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  individual.identifiers != null
                      ? Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: DigitTheme.instance.colorScheme.primary,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(kPadding),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                kPadding,
                              ),
                              child: Text(
                                beneficiaryId ??
                                    localizations
                                        .translate(i18.common.noResultsFound),
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        )
                      : const Offstage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: kPadding, top: kPadding),
                          child: Text(
                            name,
                            style: theme.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ((!isCurrentCycleData(context, tasks ?? []) ||
                      (tasks ?? [])
                              .where(
                                (element) =>
                                    element.status ==
                                    Status.administeredSuccess.toValue(),
                              )
                              .lastOrNull ==
                          null))
                  ? Positioned(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: DigitIconButton(
                          buttonDisabled: (projectBeneficiaries ?? []).isEmpty,
                          onPressed: (projectBeneficiaries ?? []).isEmpty
                              ? null
                              : () => DigitActionDialog.show(
                                    context,
                                    widget: ActionCard(
                                      items: [
                                        ActionCardModel(
                                          icon: Icons.edit,
                                          label: localizations.translate(
                                            i18.memberCard
                                                .editIndividualDetails,
                                          ),
                                          action: editMemberAction,
                                        ),
                                      ],
                                    ),
                                  ),
                          iconText: localizations.translate(
                            i18.memberCard.editDetails,
                          ),
                          icon: Icons.edit,
                        ),
                      ),
                    )
                  : const Offstage()
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: DigitTheme.instance.containerMargin,
                  child: Text(
                    gender != null
                        ? localizations
                            .translate('CORE_COMMON_${gender?.toUpperCase()}')
                        : ' -- ',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    years != null && months != null
                        ? " | $years ${localizations.translate(i18.memberCard.deliverDetailsYearText)} $months ${localizations.translate(i18.memberCard.deliverDetailsMonthsText)}"
                        : "|   --",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kPadding / 2,
            ),
            child: Offstage(
              offstage: beneficiaryType != BeneficiaryType.individual,
              child: !isDelivered ||
                      isNotEligible ||
                      isBeneficiaryRefused ||
                      isBeneficiaryIneligible ||
                      isBeneficiaryReferred
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: DigitIconButton(
                        icon: Icons.info_rounded,
                        iconSize: 20,
                        iconText: localizations.translate(
                          isHead
                              ? i18_local.householdOverView
                                  .householdOverViewHouseholderHeadLabelSMC
                              : (isNotEligible || isBeneficiaryIneligible)
                                  ? i18_local.householdOverView
                                      .householdOverViewNotEligibleIconLabelSMC
                                  : isBeneficiaryReferred
                                      ? i18_local.householdOverView
                                          .householdOverViewBeneficiaryReferredLabelSMC
                                      : isBeneficiaryRefused
                                          ? i18_local.householdOverView
                                              .householdOverViewBeneficiaryRefusedLabelSMC
                                          : i18_local.householdOverView
                                              .householdOverViewNotDeliveredIconLabelSMC,
                        ),
                        iconTextColor: theme.colorScheme.error,
                        iconColor: theme.colorScheme.error,
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: DigitIconButton(
                        icon: Icons.check_circle,
                        iconText: localizations.translate(
                          i18_local.householdOverView
                              .householdOverViewDeliveredIconLabelSMC,
                        ),
                        iconSize: 20,
                        iconTextColor:
                            DigitTheme.instance.colorScheme.onSurfaceVariant,
                        iconColor:
                            DigitTheme.instance.colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),
          ),
          Offstage(
            offstage: beneficiaryType != BeneficiaryType.individual ||
                isNotEligible ||
                isBeneficiaryRefused ||
                isBeneficiaryIneligible ||
                isBeneficiaryReferred,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  (isNotEligible ||
                              isBeneficiaryRefused ||
                              isBeneficiaryIneligible ||
                              isBeneficiaryReferred) &&
                          checkStatusSMC(tasks, context.selectedCycle)
                      ? const Offstage()
                      : !isNotEligible
                          ? DigitElevatedButton(
                              onPressed: beneficiaryId != null
                                  ? ((projectBeneficiaries ?? []).isEmpty)
                                      ? null
                                      : () {
                                          final bloc = context
                                              .read<HouseholdOverviewBloc>();

                                          bloc.add(
                                            HouseholdOverviewEvent
                                                .selectedIndividual(
                                              individualModel: individual,
                                            ),
                                          );
                                          bloc.add(HouseholdOverviewReloadEvent(
                                            projectId:
                                                RegistrationDeliverySingleton()
                                                    .projectId!,
                                            projectBeneficiaryType:
                                                RegistrationDeliverySingleton()
                                                        .beneficiaryType ??
                                                    BeneficiaryType.individual,
                                          ));

                                          if (smcAssessmentPendingStatus) {
                                            context.router.push(
                                                VaccineInformationCaptureRoute(
                                              projectBeneficiaryClientReferenceId:
                                                  projectBeneficiaryClientReferenceId,
                                              individual: individual,
                                              interventionType:
                                                  InterventionTypes.smc,
                                            ));
                                            // context.router.push(
                                            //     EligibilityChecklistViewRoute(
                                            //   projectBeneficiaryClientReferenceId:
                                            //       projectBeneficiaryClientReferenceId,
                                            //   individual: individual,
                                            // ));
                                          } else {
                                            context.router.push(
                                                BeneficiaryDetailsRoute());
                                          }
                                        }
                                  : () {
                                      showGenerateBeneficiaryIdDialog(context);
                                    },
                              child: Center(
                                child: Text(
                                  allDosesDelivered(
                                            tasks,
                                            context.selectedCycle,
                                            sideEffects,
                                            individual,
                                          ) &&
                                          !checkStatusSMC(
                                            tasks,
                                            context.selectedCycle,
                                          )
                                      ? localizations.translate(
                                          i18.householdOverView
                                              .viewDeliveryLabel,
                                        )
                                      : localizations.translate(
                                          i18_local.householdOverView
                                              .householdOverViewActionTextSMC,
                                        ),
                                ),
                              ),
                            )
                          : const Offstage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container smcAndBednetFlowWidget(
      BuildContext context, ThemeData theme, BeneficiaryType? beneficiaryType) {
    bool smcAssessmentPendingStatus =
        assessmentSMCPending(tasks, context.selectedCycle);

    String? beneficiaryId = individual.identifiers
        ?.lastWhereOrNull(
          (e) =>
              e.identifierType == IdentifierTypes.uniqueBeneficiaryID.toValue(),
        )
        ?.identifierId;

    return Container(
      decoration: BoxDecoration(
        color: DigitTheme.instance.colorScheme.background,
        border: Border.all(
          color: DigitTheme.instance.colorScheme.outline,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      margin: DigitTheme.instance.containerMargin,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  individual.identifiers != null
                      ? Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: DigitTheme.instance.colorScheme.primary,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(kPadding),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                kPadding,
                              ),
                              child: Text(
                                beneficiaryId ??
                                    localizations
                                        .translate(i18.common.noResultsFound),
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        )
                      : const Offstage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: kPadding, top: kPadding),
                          child: Text(
                            name,
                            style: theme.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ((!isCurrentCycleData(context, tasks ?? []) ||
                      (tasks ?? [])
                              .where(
                                (element) =>
                                    element.status ==
                                    Status.administeredSuccess.toValue(),
                              )
                              .lastOrNull ==
                          null))
                  ? Positioned(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: DigitIconButton(
                          buttonDisabled: (projectBeneficiaries ?? []).isEmpty,
                          onPressed: (projectBeneficiaries ?? []).isEmpty
                              ? null
                              : () => DigitActionDialog.show(
                                    context,
                                    widget: ActionCard(
                                      items: [
                                        ActionCardModel(
                                          icon: Icons.edit,
                                          label: localizations.translate(
                                            i18.memberCard
                                                .editIndividualDetails,
                                          ),
                                          action: editMemberAction,
                                        ),
                                      ],
                                    ),
                                  ),
                          iconText: localizations.translate(
                            i18.memberCard.editDetails,
                          ),
                          icon: Icons.edit,
                        ),
                      ),
                    )
                  : const Offstage()
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: DigitTheme.instance.containerMargin,
                  child: Text(
                    gender != null
                        ? localizations
                            .translate('CORE_COMMON_${gender?.toUpperCase()}')
                        : ' -- ',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    years != null && months != null
                        ? " | $years ${localizations.translate(i18.memberCard.deliverDetailsYearText)} $months ${localizations.translate(i18.memberCard.deliverDetailsMonthsText)}"
                        : "|   --",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kPadding / 2,
            ),
            child: Offstage(
              offstage: beneficiaryType != BeneficiaryType.individual,
              child: !isDelivered ||
                      isNotEligible ||
                      isBeneficiaryRefused ||
                      isBeneficiaryIneligible ||
                      isBeneficiaryReferred
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: DigitIconButton(
                        icon: Icons.info_rounded,
                        iconSize: 20,
                        iconText: localizations.translate(
                          isHead
                              ? i18_local.householdOverView
                                  .householdOverViewHouseholderHeadLabelSMC
                              : (isNotEligible || isBeneficiaryIneligible)
                                  ? i18_local.householdOverView
                                      .householdOverViewNotEligibleIconLabelSMC
                                  : isBeneficiaryReferred
                                      ? i18_local.householdOverView
                                          .householdOverViewBeneficiaryReferredLabelSMC
                                      : isBeneficiaryRefused
                                          ? i18_local.householdOverView
                                              .householdOverViewBeneficiaryRefusedLabelSMC
                                          : i18_local.householdOverView
                                              .householdOverViewNotDeliveredIconLabelSMC,
                        ),
                        iconTextColor: theme.colorScheme.error,
                        iconColor: theme.colorScheme.error,
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: DigitIconButton(
                        icon: Icons.check_circle,
                        iconText: localizations.translate(
                          i18_local.householdOverView
                              .householdOverViewDeliveredIconLabelSMC,
                        ),
                        iconSize: 20,
                        iconTextColor:
                            DigitTheme.instance.colorScheme.onSurfaceVariant,
                        iconColor:
                            DigitTheme.instance.colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),
          ),
          Offstage(
            offstage: beneficiaryType != BeneficiaryType.individual ||
                isNotEligible ||
                isBeneficiaryRefused ||
                isBeneficiaryIneligible ||
                isBeneficiaryReferred,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  (isNotEligible ||
                              isBeneficiaryRefused ||
                              isBeneficiaryIneligible ||
                              isBeneficiaryReferred) &&
                          checkStatusSMC(tasks, context.selectedCycle)
                      ? const Offstage()
                      : !isNotEligible
                          ? DigitElevatedButton(
                              onPressed: beneficiaryId != null
                                  ? ((projectBeneficiaries ?? []).isEmpty)
                                      ? null
                                      : () {
                                          final bloc = context
                                              .read<HouseholdOverviewBloc>();

                                          bloc.add(
                                            HouseholdOverviewEvent
                                                .selectedIndividual(
                                              individualModel: individual,
                                            ),
                                          );
                                          bloc.add(HouseholdOverviewReloadEvent(
                                            projectId:
                                                RegistrationDeliverySingleton()
                                                    .projectId!,
                                            projectBeneficiaryType:
                                                RegistrationDeliverySingleton()
                                                        .beneficiaryType ??
                                                    BeneficiaryType.individual,
                                          ));
                                          // TODO : pass valid intervention type based on the card type
                                          if (smcAssessmentPendingStatus) {
                                            context.router.push(
                                                VaccineInformationCaptureRoute(
                                                    projectBeneficiaryClientReferenceId:
                                                        projectBeneficiaryClientReferenceId,
                                                    individual: individual,
                                                    interventionType:
                                                        InterventionTypes.smc));
                                            // context.router.push(
                                            //     EligibilityChecklistViewRoute(
                                            //   projectBeneficiaryClientReferenceId:
                                            //       projectBeneficiaryClientReferenceId,
                                            //   individual: individual,
                                            // ));
                                          } else {
                                            context.router.push(
                                                BeneficiaryDetailsRoute());
                                          }
                                        }
                                  : () {
                                      showGenerateBeneficiaryIdDialog(context);
                                    },
                              child: Center(
                                child: Text(
                                  allDosesDelivered(
                                            tasks,
                                            context.selectedCycle,
                                            sideEffects,
                                            individual,
                                          ) &&
                                          !checkStatusSMC(
                                            tasks,
                                            context.selectedCycle,
                                          )
                                      ? localizations.translate(
                                          i18.householdOverView
                                              .viewDeliveryLabel,
                                        )
                                      : localizations.translate(
                                          i18_local.householdOverView
                                              .householdOverViewActionTextSMC,
                                        ),
                                ),
                              ),
                            )
                          : const Offstage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container smcAndOnchoFlowWidget(
      BuildContext context, ThemeData theme, BeneficiaryType? beneficiaryType) {
    digit_ui_date_utils.DigitDOBAgeConvertor age = _getCalculatedAge();
    final ageInYears = age.years;
    final ageInMonths = age.months;
    List<TaskModel>? smcTasks = _getSMCStatusData(context);
    List<TaskModel>? onchoTasks = _getOnchoStatusData();

    ProjectTypeModel? smcProjectType = RegistrationDeliverySingleton()
        .selectedProject
        ?.additionalDetails
        ?.projectType;

    // assumed it is onchoAdditionalProjectType , because above already checked if it is oncho flow or not

    ProjectTypeModel? onchoAdditionalProjectType =
        RegistrationDeliverySingleton()
            .selectedProject
            ?.additionalDetails
            ?.additionalProjectType;
    bool smcAssessmentPendingStatus =
        assessmentSMCPending(smcTasks, context.selectedCycle);

    bool onchoAssessmentPendingStatus =
        assessmentOnchoPending(onchoTasks, context.selectedCycle);

    bool isNotEligibleOncho =
        (RegistrationDeliverySingleton().projectType?.cycles != null
            ? !checkEligibilityForAgeAndSideEffectOncho(
                digit_ui_date_utils.DigitDOBAgeConvertor(
                  years: ageInYears,
                  months: ageInMonths,
                ),
                onchoAdditionalProjectType,
                (onchoTasks ?? []).isNotEmpty ? onchoTasks!.lastOrNull : null,
                null,
              )
            : false);
    isNotEligibleOncho = isNotEligibleOncho ||
        fetchProductVariantForProjectType(
                onchoAdditionalProjectType, individual, null, onchoTasks) ==
            null;

    bool inBeneficiaryEligibleOncho =
        checkIfBeneficiaryIneligibleOncho(onchoTasks);
    bool beneficiaryReferredOncho = checkIfBeneficiaryReferredOncho(onchoTasks);
    bool beneficiaryRefusedOncho = checkIfBeneficiaryRefusedOncho(onchoTasks);
    bool checkStatusForOncho =
        !checkStatusOncho(onchoTasks, context.selectedCycle);
    bool isOnchoDelivered =
        onchoTasks != null && onchoTasks.isNotEmpty && checkStatusForOncho;

    bool isSmcDeliveryCards = fetchProductVariantForProjectType(
            smcProjectType, individual, null, smcTasks) !=
        null;
    bool isOnchoDeliveryCards = fetchProductVariantForProjectType(
            onchoAdditionalProjectType, individual, null, null) !=
        null;

    String? beneficiaryId = individual.identifiers
        ?.lastWhereOrNull(
          (e) =>
              e.identifierType == IdentifierTypes.uniqueBeneficiaryID.toValue(),
        )
        ?.identifierId;

    final onchoAllDoseDelivered = allDosesDelivered(
      onchoTasks,
      context.selectedCycle,
      sideEffects,
      individual,
    );
    final checkOnchoStatus = checkStatusOncho(
      onchoTasks,
      context.selectedCycle,
    );

    // handles only smc and oncho , no other type

    InterventionTypes? interventionType = isSmcDeliveryCards
        ? InterventionTypes.smc
        : isOnchoDeliveryCards
            ? InterventionTypes.oncho
            : InterventionTypes.smc;

    return Container(
      decoration: BoxDecoration(
        color: DigitTheme.instance.colorScheme.background,
        border: Border.all(
          color: DigitTheme.instance.colorScheme.outline,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      margin: DigitTheme.instance.containerMargin,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  individual.identifiers != null
                      ? Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: DigitTheme.instance.colorScheme.primary,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(kPadding),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                kPadding,
                              ),
                              child: Text(
                                beneficiaryId ??
                                    localizations
                                        .translate(i18.common.noResultsFound),
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        )
                      : const Offstage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: kPadding, top: kPadding),
                          child: Text(
                            name,
                            style: theme.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _shouldShowEditButton(context)
                  ? Positioned(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: DigitIconButton(
                          buttonDisabled: (projectBeneficiaries ?? []).isEmpty,
                          onPressed: (projectBeneficiaries ?? []).isEmpty
                              ? null
                              : () => DigitActionDialog.show(
                                    context,
                                    widget: ActionCard(
                                      items: [
                                        ActionCardModel(
                                          icon: Icons.edit,
                                          label: localizations.translate(
                                            i18.memberCard
                                                .editIndividualDetails,
                                          ),
                                          action: editMemberAction,
                                        ),
                                      ],
                                    ),
                                  ),
                          iconText: localizations.translate(
                            i18.memberCard.editDetails,
                          ),
                          icon: Icons.edit,
                        ),
                      ),
                    )
                  : const Offstage()
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: DigitTheme.instance.containerMargin,
                  child: Text(
                    gender != null
                        ? localizations
                            .translate('CORE_COMMON_${gender?.toUpperCase()}')
                        : ' -- ',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    years != null && months != null
                        ? " | $years ${localizations.translate(i18.memberCard.deliverDetailsYearText)} $months ${localizations.translate(i18.memberCard.deliverDetailsMonthsText)}"
                        : "|   --",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kPadding / 2,
            ),
            child: Offstage(
              offstage: beneficiaryType != BeneficiaryType.individual,
              child: Column(
                children: [
                  _buildStatusIndicator(
                    isDelivered:
                        isSmcDeliveryCards ? isDelivered : isOnchoDelivered,
                    isNotEligible:
                        isSmcDeliveryCards ? isNotEligible : isNotEligibleOncho,
                    isBeneficiaryRefused: isSmcDeliveryCards
                        ? isBeneficiaryRefused
                        : beneficiaryRefusedOncho,
                    isBeneficiaryIneligible: isSmcDeliveryCards
                        ? isBeneficiaryIneligible
                        : inBeneficiaryEligibleOncho,
                    isBeneficiaryReferred: isSmcDeliveryCards
                        ? isBeneficiaryReferred
                        : beneficiaryReferredOncho,
                    isHead: isHead,
                    interventionType: isSmcDeliveryCards
                        ? InterventionTypes.smc.toValue()
                        : InterventionTypes.oncho.toValue(),
                    context: context,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
          isSmcDeliveryCards
              ? Offstage(
                  offstage: beneficiaryType != BeneficiaryType.individual ||
                      _isErrorStatus(
                        isNotEligible: isNotEligible,
                        isBeneficiaryRefused: isBeneficiaryRefused,
                        isBeneficiaryIneligible: isBeneficiaryIneligible,
                        isBeneficiaryReferred: isBeneficiaryReferred,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        (isNotEligible ||
                                    isBeneficiaryRefused ||
                                    isBeneficiaryIneligible ||
                                    isBeneficiaryReferred) &&
                                checkStatusSMC(tasks, context.selectedCycle)
                            ? const Offstage()
                            : !isNotEligible
                                ? DigitElevatedButton(
                                    onPressed: beneficiaryId != null &&
                                            (projectBeneficiaries ?? [])
                                                .isNotEmpty
                                        ? () => _handleBeneficiaryAction(
                                              context: context,
                                              isAssessmentPending:
                                                  smcAssessmentPendingStatus,
                                              beneficiaryId: beneficiaryId,
                                              interventionType:
                                                  interventionType,
                                            )
                                        : beneficiaryId == null
                                            ? () =>
                                                showGenerateBeneficiaryIdDialog(
                                                    context)
                                            : null,
                                    child: Center(
                                      child: Text(
                                        allDosesDelivered(
                                                  tasks,
                                                  context.selectedCycle,
                                                  sideEffects,
                                                  individual,
                                                ) &&
                                                !checkStatusSMC(
                                                  tasks,
                                                  context.selectedCycle,
                                                )
                                            ? localizations.translate(
                                                i18.householdOverView
                                                    .viewDeliveryLabel,
                                              )
                                            : localizations.translate(
                                                i18_local.householdOverView
                                                    .householdOverViewActionTextSMC,
                                              ),
                                      ),
                                    ),
                                  )
                                : const Offstage(),
                      ],
                    ),
                  ),
                )
              : Offstage(
                  offstage: beneficiaryType != BeneficiaryType.individual ||
                      _isErrorStatus(
                        isNotEligible: isNotEligibleOncho,
                        isBeneficiaryRefused: beneficiaryRefusedOncho,
                        isBeneficiaryIneligible: inBeneficiaryEligibleOncho,
                        isBeneficiaryReferred: beneficiaryReferredOncho,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        (isNotEligibleOncho ||
                                    beneficiaryRefusedOncho ||
                                    inBeneficiaryEligibleOncho ||
                                    beneficiaryReferredOncho) &&
                                checkOnchoStatus
                            ? const Offstage()
                            : !isNotEligibleOncho
                                ? DigitElevatedButton(
                                    onPressed: beneficiaryId != null &&
                                            (projectBeneficiaries ?? [])
                                                .isNotEmpty
                                        ? () => _handleBeneficiaryAction(
                                              context: context,
                                              isAssessmentPending:
                                                  onchoAssessmentPendingStatus,
                                              beneficiaryId: beneficiaryId,
                                              interventionType:
                                                  interventionType,
                                            )
                                        : beneficiaryId == null
                                            ? () =>
                                                showGenerateBeneficiaryIdDialog(
                                                    context)
                                            : null,
                                    child: Center(
                                      child: Text(
                                        !checkOnchoStatus
                                            ? localizations.translate(
                                                i18.householdOverView
                                                    .viewDeliveryLabel,
                                              )
                                            : localizations.translate(
                                                i18_local.householdOverView
                                                    .householdOverViewActionTextOncho,
                                              ),
                                      ),
                                    ),
                                  )
                                : const Offstage(),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  digit_ui_date_utils.DigitDOBAgeConvertor _getCalculatedAge() {
    if (individual.dateOfBirth == null) {
      return digit_ui_date_utils.DigitDOBAgeConvertor(
          years: 0, months: 0, days: 0);
    }

    final dateTime =
        digit_ui_date_utils.DigitDateUtils.getFormattedDateToDateTime(
              individual.dateOfBirth!,
            ) ??
            DateTime.now();

    return digit_ui_date_utils.DigitDateUtils.calculateAge(dateTime);
  }

  bool _shouldShowEditButton(BuildContext context) {
    return !isCurrentCycleData(context, tasks ?? []) ||
        (tasks ?? [])
                .where((element) =>
                    element.status == Status.administeredSuccess.toValue())
                .lastOrNull ==
            null;
  }

  bool _isErrorStatus({
    required bool isNotEligible,
    required bool isBeneficiaryRefused,
    required bool isBeneficiaryIneligible,
    required bool isBeneficiaryReferred,
  }) {
    return isNotEligible ||
        isBeneficiaryRefused ||
        isBeneficiaryIneligible ||
        isBeneficiaryReferred;
  }

  void _handleBeneficiaryAction({
    required BuildContext context,
    required bool isAssessmentPending,
    required String? beneficiaryId,
    required InterventionTypes interventionType,
  }) {
    if (beneficiaryId == null) {
      showGenerateBeneficiaryIdDialog(context);
      return;
    }

    final bloc = context.read<HouseholdOverviewBloc>();
    bloc.add(
        HouseholdOverviewEvent.selectedIndividual(individualModel: individual));
    bloc.add(HouseholdOverviewReloadEvent(
      projectId: RegistrationDeliverySingleton().projectId!,
      projectBeneficiaryType: RegistrationDeliverySingleton().beneficiaryType ??
          BeneficiaryType.individual,
    ));

    if (isAssessmentPending) {
      context.router.push(VaccineInformationCaptureRoute(
        projectBeneficiaryClientReferenceId:
            projectBeneficiaryClientReferenceId,
        individual: individual,
        interventionType: interventionType,
      ));
    } else {
      context.router.push(BeneficiaryDetailsRoute());
    }
  }

  showGenerateBeneficiaryIdDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            localizations
                .translate(i18_local.common.generateBeneficiaryIdTitle),
            style: theme.textTheme.headlineMedium,
          ),
          content: Text(
            localizations
                .translate(i18_local.common.generateBeneficiaryIdMessage),
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            DigitElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                localizations.translate(i18.common.coreCommonOk),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isCurrentCycleData(BuildContext context, List<TaskModel> task) {
    if (task.isEmpty) return true;
    final currentCycle = context.selectedCycle;
    final taskCycleIndex = task.last.additionalFields?.fields
        .firstWhereOrNull(
          (e) => e.key == AdditionalFieldsType.cycleIndex.toValue(),
        )
        ?.value;
    if (taskCycleIndex != null && currentCycle != null) {
      if (int.tryParse(taskCycleIndex) == currentCycle.id) {
        return true;
      }
    }
    return false;
  }

  Widget _buildStatusIndicator({
    required bool isDelivered,
    required bool isNotEligible,
    required bool isBeneficiaryRefused,
    required bool isBeneficiaryIneligible,
    required bool isBeneficiaryReferred,
    required bool isHead,
    required String interventionType,
    required BuildContext context,
    required ThemeData theme,
  }) {
    final isErrorStatus = !isDelivered ||
        isNotEligible ||
        isBeneficiaryRefused ||
        isBeneficiaryIneligible ||
        isBeneficiaryReferred;

    if (isErrorStatus) {
      return Align(
        alignment: Alignment.centerLeft,
        child: DigitIconButton(
          icon: Icons.info_rounded,
          iconSize: 20,
          iconText: localizations.translate(
            (isNotEligible || isBeneficiaryIneligible)
                ? _getNotEligibleLabel(interventionType)
                : isBeneficiaryReferred
                    ? _getBeneficiaryReferredLabel(interventionType)
                    : isBeneficiaryRefused
                        ? _getBeneficiaryRefusedLabel(interventionType)
                        : _getNotDeliveredLabel(interventionType),
          ),
          iconTextColor: theme.colorScheme.error,
          iconColor: theme.colorScheme.error,
        ),
      );
    } else if (isHead && interventionType == InterventionTypes.smc.toValue()) {
      return Align(
        alignment: Alignment.centerLeft,
        child: DigitIconButton(
          icon: Icons.info_rounded,
          iconSize: 20,
          iconText: localizations.translate(i18_local
              .householdOverView.householdOverViewHouseholderHeadLabelSMC),
          iconTextColor: theme.colorScheme.error,
          iconColor: theme.colorScheme.error,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: DigitIconButton(
          icon: Icons.check_circle,
          iconText: localizations.translate(
            _getDeliveredLabel(interventionType),
          ),
          iconSize: 20,
          iconTextColor: DigitTheme.instance.colorScheme.onSurfaceVariant,
          iconColor: DigitTheme.instance.colorScheme.onSurfaceVariant,
        ),
      );
    }
  }

  String _getDeliveredLabel(String interventionType) {
    return interventionType == InterventionTypes.oncho.toValue()
        ? i18_local.householdOverView.householdOverViewDeliveredIconLabelOncho
        : i18_local.householdOverView.householdOverViewDeliveredIconLabelSMC;
  }

  String _getNotDeliveredLabel(String interventionType) {
    return interventionType == InterventionTypes.oncho.toValue()
        ? i18_local
            .householdOverView.householdOverViewNotDeliveredIconLabelOncho
        : i18_local.householdOverView.householdOverViewNotDeliveredIconLabelSMC;
  }

  String _getNotEligibleLabel(String interventionType) {
    return interventionType == InterventionTypes.oncho.toValue()
        ? i18_local.householdOverView.householdOverViewNotEligibleIconLabelOncho
        : i18_local.householdOverView.householdOverViewNotEligibleIconLabelSMC;
  }

  String _getBeneficiaryReferredLabel(String interventionType) {
    return interventionType == InterventionTypes.oncho.toValue()
        ? i18_local
            .householdOverView.householdOverViewBeneficiaryReferredLabelOncho
        : i18_local
            .householdOverView.householdOverViewBeneficiaryReferredLabelSMC;
  }

  String _getBeneficiaryRefusedLabel(String interventionType) {
    return interventionType == InterventionTypes.oncho.toValue()
        ? i18_local
            .householdOverView.householdOverViewBeneficiaryRefusedLabelOncho
        : i18_local
            .householdOverView.householdOverViewBeneficiaryRefusedLabelSMC;
  }
}
