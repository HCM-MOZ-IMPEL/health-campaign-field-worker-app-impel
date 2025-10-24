import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';
import 'package:registration_delivery/utils/extensions/extensions.dart';

import 'package:registration_delivery/blocs/app_localization.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/models/entities/side_effect.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../models/entities/entities_smc/identifier_types.dart'
    as identifier_types;
import '../../utils/utils_smc/i18_key_constants.dart' as i18_local;
import 'package:registration_delivery/utils/utils.dart';
import '../../router/app_router.dart';
import '../action_card/action_card.dart';
import '../../utils/utils_smc/utils_smc.dart'
    show checkStatusSMC, isHeadBednetDelivered, isSMCDelivered;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final beneficiaryType = RegistrationDeliverySingleton().beneficiaryType;

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
                                individual.identifiers!
                                        .lastWhere(
                                          (e) =>
                                              e.identifierType ==
                                              IdentifierTypes
                                                  .uniqueBeneficiaryID
                                                  .toValue(),
                                        )
                                        .identifierId ??
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
              (tasks ?? [])
                          .where(
                            (element) =>
                                element.status ==
                                Status.administeredSuccess.toValue(),
                          )
                          .lastOrNull ==
                      null
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
            // child: Offstage(
            //   offstage: beneficiaryType != BeneficiaryType.individual,
            //   child: !isDelivered ||
            //           isNotEligible ||
            //           isBeneficiaryRefused ||
            //           isBeneficiaryIneligible ||
            //           isBeneficiaryReferred
            //       ? Align(
            //           alignment: Alignment.centerLeft,
            //           child: DigitIconButton(
            //             icon: Icons.info_rounded,
            //             iconSize: 20,
            //             iconText: localizations.translate(
            //               isHead
            //                   ? i18_local.householdOverView
            //                       .householdOverViewHouseholderHeadLabelSMC
            //                   : (isNotEligible || isBeneficiaryIneligible)
            //                       ? i18_local.householdOverView
            //                           .householdOverViewNotEligibleIconLabelSMC
            //                       : isBeneficiaryReferred
            //                           ? i18_local.householdOverView
            //                               .householdOverViewBeneficiaryReferredLabelSMC
            //                           : isBeneficiaryRefused
            //                               ? i18_local.householdOverView
            //                                   .householdOverViewBeneficiaryRefusedLabelSMC
            //                               : i18_local.householdOverView
            //                                   .householdOverViewNotDeliveredIconLabelSMC,
            //             ),
            //             iconTextColor: theme.colorScheme.error,
            //             iconColor: theme.colorScheme.error,
            //           ),
            //         )
            //       : Align(
            //           alignment: Alignment.centerLeft,
            //           child: DigitIconButton(
            //             icon: Icons.check_circle,
            //             iconText: localizations.translate(
            //               i18_local.householdOverView
            //                   .householdOverViewDeliveredIconLabelSMC,
            //             ),
            //             iconSize: 20,
            //             iconTextColor:
            //                 DigitTheme.instance.colorScheme.onSurfaceVariant,
            //             iconColor:
            //                 DigitTheme.instance.colorScheme.onSurfaceVariant,
            //           ),
            //         ),
            // ),
          ),
          Offstage(
            offstage: false,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  isHead
                      ? isHeadBednetDelivered(tasks)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: DigitIconButton(
                                icon: Icons.info_rounded,
                                iconText: localizations.translate(
                                  i18_local.householdOverView
                                      .headBednetDeliveredSuccess,
                                ),
                                iconSize: 20,
                                iconTextColor: DigitTheme
                                    .instance.colorScheme.onSurfaceVariant,
                                iconColor: DigitTheme
                                    .instance.colorScheme.onSurfaceVariant,
                              ),
                            )
                          : DigitElevatedButton(
                              onPressed: (projectBeneficiaries ?? []).isEmpty
                                  ? null
                                  : () {
                                      final bloc =
                                          context.read<HouseholdOverviewBloc>();

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

                                      if ((tasks ?? []).isEmpty ||
                                          isSMCDelivered(tasks)) {
                                        context.router.push(
                                            CustomDeliverInterventionHeadRoute());
                                      } else {
                                        context.router
                                            .push(BeneficiaryDetailsRoute());
                                      }
                                    },
                              child: Center(
                                child: Text(
                                  localizations.translate(
                                    i18_local.householdOverView
                                        .headBednetDeliveryAction,
                                  ),
                                ),
                              ),
                            )
                      : const Offstage(),
                  (isNotEligible ||
                              isBeneficiaryRefused ||
                              isBeneficiaryIneligible ||
                              isBeneficiaryReferred) &&
                          checkStatusSMC(tasks, context.selectedCycle)
                      ? isNotEligible
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: DigitIconButton(
                                icon: Icons.info_rounded,
                                iconText: localizations.translate(
                                  i18_local.householdOverView
                                      .tracomaDeliveredNotEligible,
                                ),
                                iconSize: 20,
                                iconTextColor:
                                    DigitTheme.instance.colorScheme.error,
                                iconColor:
                                    DigitTheme.instance.colorScheme.error,
                              ),
                            )
                          : Offstage()
                      : !isNotEligible
                          ? isSMCDelivered(tasks)
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: DigitIconButton(
                                    icon: Icons.info_rounded,
                                    iconText: localizations.translate(
                                      i18_local.householdOverView
                                          .tracomaDeliveredSuccess,
                                    ),
                                    iconSize: 20,
                                    iconTextColor: DigitTheme
                                        .instance.colorScheme.onSurfaceVariant,
                                    iconColor: DigitTheme
                                        .instance.colorScheme.onSurfaceVariant,
                                  ),
                                )
                              : DigitElevatedButton(
                                  onPressed: (projectBeneficiaries ?? [])
                                          .isEmpty
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

                                          if ((tasks ?? []).isEmpty ||
                                              isHeadBednetDelivered(tasks)) {
                                            context.router.push(
                                                EligibilityChecklistViewRoute(
                                              projectBeneficiaryClientReferenceId:
                                                  projectBeneficiaryClientReferenceId,
                                              individual: individual,
                                            ));
                                          } else {
                                            context.router.push(
                                                BeneficiaryDetailsRoute());
                                          }
                                        },
                                  child: Center(
                                    child: Text(
                                      localizations.translate(
                                        i18_local.householdOverView
                                            .tracomaDeliveryAction,
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
}
