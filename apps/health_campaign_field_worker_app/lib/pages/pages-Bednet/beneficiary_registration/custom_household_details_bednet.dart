import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_radio_button_list.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/atoms/selection_card.dart';
import 'package:digit_components/widgets/atoms/text_block.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_scanner/blocs/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/extensions/extensions.dart';

import 'package:registration_delivery/blocs/beneficiary_registration/beneficiary_registration.dart';
import 'package:registration_delivery/models/entities/household.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../blocs/project/project.dart';
import '../../../models/entities/project_types.dart';
import '../../../utils/constants.dart';
import '../../../utils/i18_key_constants.dart' as i18_local;
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import '../../../router/app_router.dart';
import '../../../widgets/localized.dart';
import 'package:registration_delivery/widgets/showcase/config/showcase_constants.dart';
import 'package:registration_delivery/widgets/showcase/showcase_button.dart';
import 'package:collection/collection.dart';

@RoutePage()
class CustomHouseHoldDetailsBednetPage extends LocalizedStatefulWidget {
  final bool isEligible;
  const CustomHouseHoldDetailsBednetPage({
    super.key,
    super.appLocalizations,
    required this.isEligible,
  });

  @override
  State<CustomHouseHoldDetailsBednetPage> createState() =>
      CustomHouseHoldDetailsBednetPageState();
}

class CustomHouseHoldDetailsBednetPageState
    extends LocalizedState<CustomHouseHoldDetailsBednetPage> {
  static const _dateOfRegistrationKey = 'dateOfRegistration';
  static const _memberCountKey = 'memberCount';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<BeneficiaryRegistrationBloc>();
    final router = context.router;

    return Scaffold(
      body: ReactiveFormBuilder(
        form: () => buildForm(bloc.state),
        builder: (context, form, child) {
          int memberCount = form.control(_memberCountKey).value;
          return BlocConsumer<BeneficiaryRegistrationBloc,
              BeneficiaryRegistrationState>(
            listener: (context, state) {
              if (state is BeneficiaryRegistrationPersistedState &&
                  state.isEdit) {
                final overviewBloc = context.read<HouseholdOverviewBloc>();

                HouseholdMemberWrapper memberWrapper =
                    overviewBloc.state.householdMemberWrapper;

                Future.delayed(
                  const Duration(
                    milliseconds: 300,
                  ),
                  () {
                    overviewBloc.add(
                      HouseholdOverviewReloadEvent(
                        projectId: RegistrationDeliverySingleton()
                            .projectId
                            .toString(),
                        projectBeneficiaryType:
                            RegistrationDeliverySingleton().beneficiaryType ??
                                BeneficiaryType.household,
                      ),
                    );
                    memberWrapper = overviewBloc.state.householdMemberWrapper;
                  },
                ).then((valueOne) {
                  if (!widget.isEligible) {
                    final projectBeneficiary = [
                      memberWrapper.projectBeneficiaries?.first
                    ];
                    final parent = context.router.parent() as StackRouter;
                    final previousWrapper = memberWrapper;

                    context.read<DeliverInterventionBloc>().add(
                          DeliverInterventionSubmitEvent(
                            navigateToSummary: true,
                            householdMemberWrapper: memberWrapper,
                            task: TaskModel(
                              projectBeneficiaryClientReferenceId:
                                  projectBeneficiary?.first
                                      ?.clientReferenceId, //TODO: need to check for individual based campaign
                              clientReferenceId: RegistrationDeliverySingleton()
                                          .beneficiaryType ==
                                      BeneficiaryType.household
                                  ? memberWrapper
                                          .tasks?.last.clientReferenceId ??
                                      IdGen.i.identifier
                                  : IdGen.i.identifier,
                              tenantId:
                                  RegistrationDeliverySingleton().tenantId,
                              rowVersion: 1,
                              auditDetails: AuditDetails(
                                createdBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid!,
                                createdTime: context.millisecondsSinceEpoch(),
                              ),
                              projectId:
                                  RegistrationDeliverySingleton().projectId,
                              status: Status.administeredFailed.toValue(),
                              clientAuditDetails: ClientAuditDetails(
                                createdBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid!,
                                createdTime: context.millisecondsSinceEpoch(),
                                lastModifiedBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid,
                                lastModifiedTime:
                                    context.millisecondsSinceEpoch(),
                              ),
                              additionalFields: TaskAdditionalFields(
                                version: 1,
                                fields: [
                                  AdditionalField(
                                    AdditionalFieldsType.reasonOfRefusal
                                        .toValue(),
                                    "INCOMPATIBLE",
                                  ),
                                ],
                              ),
                              address: memberWrapper.household?.address,
                            ),
                            isEditing: (memberWrapper.tasks ?? []).isNotEmpty &&
                                    RegistrationDeliverySingleton()
                                            .beneficiaryType ==
                                        BeneficiaryType.household
                                ? true
                                : false,
                            boundaryModel:
                                RegistrationDeliverySingleton().boundary!,
                          ),
                        );

                    parent.push(IneligibleSummaryRoute(
                        isEligible: widget.isEligible,
                        previousWrapper: previousWrapper));
                  } else {
                    final route = router.parent() as StackRouter;
                    route.popUntilRouteWithName(
                        CustomSearchBeneficiaryBednetRoute.name);
                    route.push(
                        CustomHouseholdWrapperRoute(wrapper: memberWrapper));
                  }
                });
              }
            },
            builder: (context, registrationState) {
              return ScrollableContent(
                header: const Column(children: [
                  BackNavigationHelpHeaderWidget(
                    showHelp: false,
                  ),
                ]),
                enableFixedButton: true,
                footer: DigitCard(
                  margin: const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
                  padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
                  child: DigitElevatedButton(
                    onPressed: () async {
                      form.markAllAsTouched();
                      if (!form.valid) return;

                      final memberCount =
                          form.control(_memberCountKey).value as int;

                      final dateOfRegistration = form
                          .control(_dateOfRegistrationKey)
                          .value as DateTime;

                      if (memberCount <= 0) {
                        DigitToast.show(
                          context,
                          options: DigitToastOptions(
                            localizations.translate(
                                i18_local.beneficiaryDetails.memberZeroError),
                            true,
                            Theme.of(context),
                          ),
                        );
                        return;
                      } else {
                        registrationState.maybeWhen(
                          orElse: () {
                            return;
                          },
                          create: (
                            addressModel,
                            householdModel,
                            individualModel,
                            projectBeneficiaryModel,
                            parentClientReferenceId,
                            relationshipType,
                            registrationDate,
                            searchQuery,
                            loading,
                            isHeadOfHousehold,
                            householdChecklists,
                            individualChecklists,
                          ) {
                            var household = householdModel;
                            household ??= HouseholdModel(
                              tenantId:
                                  RegistrationDeliverySingleton().tenantId,
                              clientReferenceId:
                                  householdModel?.clientReferenceId ??
                                      IdGen.i.identifier,
                              rowVersion: 1,
                              clientAuditDetails: ClientAuditDetails(
                                createdBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid!,
                                createdTime: context.millisecondsSinceEpoch(),
                                lastModifiedBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid,
                                lastModifiedTime:
                                    context.millisecondsSinceEpoch(),
                              ),
                              auditDetails: AuditDetails(
                                createdBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid!,
                                createdTime: context.millisecondsSinceEpoch(),
                                lastModifiedBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid,
                                lastModifiedTime:
                                    context.millisecondsSinceEpoch(),
                              ),
                            );

                            household = household.copyWith(
                              rowVersion: 1,
                              tenantId:
                                  RegistrationDeliverySingleton().tenantId,
                              clientReferenceId:
                                  householdModel?.clientReferenceId ??
                                      IdGen.i.identifier,
                              memberCount: memberCount,
                              clientAuditDetails: ClientAuditDetails(
                                createdBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid
                                    .toString(),
                                createdTime: context.millisecondsSinceEpoch(),
                                lastModifiedBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid
                                    .toString(),
                                lastModifiedTime:
                                    context.millisecondsSinceEpoch(),
                              ),
                              auditDetails: AuditDetails(
                                createdBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid
                                    .toString(),
                                createdTime: context.millisecondsSinceEpoch(),
                                lastModifiedBy: RegistrationDeliverySingleton()
                                    .loggedInUserUuid
                                    .toString(),
                                lastModifiedTime:
                                    context.millisecondsSinceEpoch(),
                              ),
                              address: addressModel,
                            );

                            bloc.add(
                              BeneficiaryRegistrationSaveHouseholdDetailsEvent(
                                household: household,
                                registrationDate: dateOfRegistration,
                              ),
                            );
                            final projectBloc = context.read<ProjectBloc>();
                            final projectState = projectBloc.state;
                            final projectTypeCode = projectState.selectedProject
                                ?.additionalDetails?.projectType?.code;

                            context.router.push(
                              CustomIndividualDetailsBednetRoute(
                                isHeadOfHousehold: true,
                                isEligible: widget.isEligible,
                              ),
                            );
                          },
                          editHousehold: (
                            addressModel,
                            householdModel,
                            individuals,
                            relationshipType,
                            registrationDate,
                            parentClientReferenceId,
                            projectBeneficiaryModel,
                            loading,
                            isHeadOfHousehold,
                            householdChecklists,
                            individualChecklists,
                          ) {
                            var household = householdModel.copyWith(
                              memberCount: memberCount,
                              address: addressModel,
                              clientAuditDetails: (householdModel
                                              .clientAuditDetails?.createdBy !=
                                          null &&
                                      householdModel.clientAuditDetails
                                              ?.createdTime !=
                                          null)
                                  ? ClientAuditDetails(
                                      createdBy: householdModel
                                          .clientAuditDetails!.createdBy,
                                      createdTime: householdModel
                                          .clientAuditDetails!.createdTime,
                                      lastModifiedBy:
                                          RegistrationDeliverySingleton()
                                              .loggedInUserUuid,
                                      lastModifiedTime:
                                          DateTime.now().millisecondsSinceEpoch,
                                    )
                                  : null,
                              rowVersion: householdModel.rowVersion,
                            );

                            bloc.add(
                              BeneficiaryRegistrationUpdateHouseholdDetailsEvent(
                                household: household.copyWith(
                                    clientAuditDetails: (addressModel
                                                    .clientAuditDetails
                                                    ?.createdBy !=
                                                null &&
                                            addressModel.clientAuditDetails
                                                    ?.createdTime !=
                                                null)
                                        ? ClientAuditDetails(
                                            createdBy: addressModel
                                                .clientAuditDetails!.createdBy,
                                            createdTime: addressModel
                                                .clientAuditDetails!
                                                .createdTime,
                                            lastModifiedBy:
                                                RegistrationDeliverySingleton()
                                                    .loggedInUserUuid,
                                            lastModifiedTime: context
                                                .millisecondsSinceEpoch(),
                                          )
                                        : null,
                                    additionalFields:
                                        household.additionalFields == null
                                            ? null
                                            : HouseholdAdditionalFields(
                                                version: household
                                                        .additionalFields
                                                        ?.version ??
                                                    1,
                                                fields: household
                                                    .additionalFields!.fields)),
                                addressModel: addressModel.copyWith(
                                  clientAuditDetails: (addressModel
                                                  .clientAuditDetails
                                                  ?.createdBy !=
                                              null &&
                                          addressModel.clientAuditDetails
                                                  ?.createdTime !=
                                              null)
                                      ? ClientAuditDetails(
                                          createdBy: addressModel
                                              .clientAuditDetails!.createdBy,
                                          createdTime: addressModel
                                              .clientAuditDetails!.createdTime,
                                          lastModifiedBy:
                                              RegistrationDeliverySingleton()
                                                  .loggedInUserUuid,
                                          lastModifiedTime:
                                              context.millisecondsSinceEpoch(),
                                        )
                                      : null,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        registrationState.mapOrNull(
                              editHousehold: (value) => localizations
                                  .translate(i18.common.coreCommonSave),
                            ) ??
                            localizations
                                .translate(i18.householdDetails.actionLabel),
                      ),
                    ),
                  ),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: DigitCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextBlock(
                            padding: const EdgeInsets.only(top: kPadding),
                            heading: localizations.translate(
                              i18.householdDetails.householdDetailsLabel,
                            ),
                            headingStyle: theme.textTheme.displayMedium,
                            body: localizations.translate(
                              i18.householdDetails.householdDetailsDescription,
                            ),
                          ),
                          Column(children: [
                            householdDetailsShowcaseData.dateOfRegistration
                                .buildWith(
                              child: DigitDateFormPicker(
                                isEnabled: false,
                                formControlName: _dateOfRegistrationKey,
                                label: localizations.translate(
                                  i18.householdDetails.dateOfRegistrationLabel,
                                ),
                                isRequired: false,
                                confirmText: localizations.translate(
                                  i18.common.coreCommonOk,
                                ),
                                cancelText: localizations.translate(
                                  i18.common.coreCommonCancel,
                                ),
                              ),
                            ),
                            householdDetailsShowcaseData
                                .numberOfMembersLivingInHousehold
                                .buildWith(
                              child: DigitIntegerFormPicker(
                                minimum: 1,
                                maximum: 20,
                                form: form,
                                formControlName: _memberCountKey,
                                label: localizations.translate(
                                  i18.householdDetails.noOfMembersCountLabel,
                                ),
                                incrementer: true,
                                // readOnly: widget.isEligible,
                              ),
                            ),
                          ]),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  getGenderOptions(String? gender) {
    final options = RegistrationDeliverySingleton().genderOptions;

    return options?.map((e) => e).firstWhereOrNull(
          (element) => element.toLowerCase() == gender,
        );
  }

  FormGroup buildForm(BeneficiaryRegistrationState state) {
    final household = state.mapOrNull(editHousehold: (value) {
      return value.householdModel;
    }, create: (value) {
      return value.householdModel;
    });

    final registrationDate = state.mapOrNull(
      editHousehold: (value) {
        return value.registrationDate;
      },
      create: (value) => DateTime.now(),
    );

    return fb.group(<String, Object>{
      _dateOfRegistrationKey:
          FormControl<DateTime>(value: registrationDate, validators: []),
      _memberCountKey: FormControl<int>(
        value: household?.memberCount ?? 1,
        validators: [Validators.max<int>(20)],
      ),
    });
  }
}
