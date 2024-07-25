import 'package:auto_route/auto_route.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/utils/utils.dart';

import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/blocs/referral_management/referral_management.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/blocs/side_effects/side_effects.dart';
import 'package:registration_delivery/models/entities/household.dart';
import 'package:registration_delivery/models/entities/household_member.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';
import 'package:registration_delivery/models/entities/referral.dart';
import 'package:registration_delivery/models/entities/side_effect.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/extensions/extensions.dart';

@RoutePage()
class CustomHouseholdWrapperPage extends StatelessWidget {
  final HouseholdMemberWrapper wrapper;
  final bool isEditing;

  const CustomHouseholdWrapperPage({
    super.key,
    required this.wrapper,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    final task = context.repository<TaskModel, TaskSearchModel>(context);
    final individual =
        context.repository<IndividualModel, IndividualSearchModel>(context);

    final household =
        context.repository<HouseholdModel, HouseholdSearchModel>(context);

    final householdMember = context
        .repository<HouseholdMemberModel, HouseholdMemberSearchModel>(context);

    final projectBeneficiary = context.repository<ProjectBeneficiaryModel,
        ProjectBeneficiarySearchModel>(context);
    final serviceDefinition = context.repository<ServiceDefinitionModel,
        ServiceDefinitionSearchModel>(context);
    final service =
        context.repository<ServiceModel, ServiceSearchModel>(context);
    final sideEffect =
        context.repository<SideEffectModel, SideEffectSearchModel>(context);
    final facilityRepository =
        context.read<LocalRepository<FacilityModel, FacilitySearchModel>>();

    final projectFacilityRepository = context.read<
        LocalRepository<ProjectFacilityModel, ProjectFacilitySearchModel>>();
    final referral =
        context.repository<ReferralModel, ReferralSearchModel>(context);

    final serviceDefinationRepo = context.repository<ServiceDefinitionModel,
        ServiceDefinitionSearchModel>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ServiceBloc(
            const ServiceEmptyState(),
            serviceDataRepository: service,
          ),
        ),
        BlocProvider(
          create: (_) => ServiceDefinitionBloc(
            const ServiceDefinitionEmptyState(),
            serviceDefinitionDataRepository: serviceDefinition,
          )..add(const ServiceDefinitionFetchEvent()),
        ),
        BlocProvider(
          create: (_) => FacilityBloc(
              facilityDataRepository: facilityRepository,
              projectFacilityDataRepository: projectFacilityRepository)
            ..add(
              FacilityLoadForProjectEvent(
                projectId: RegistrationDeliverySingleton().projectId!,
              ),
            ),
        ),
        BlocProvider(
          create: (_) => ServiceDefinitionBloc(
            const ServiceDefinitionEmptyState(),
            serviceDefinitionDataRepository: serviceDefinition,
          )..add(const ServiceDefinitionFetchEvent()),
        ),
        BlocProvider(
          create: (_) => HouseholdOverviewBloc(
              HouseholdOverviewState(
                householdMemberWrapper: wrapper,
              ),
              individualRepository: individual,
              householdRepository: household,
              householdMemberRepository: householdMember,
              projectBeneficiaryRepository: projectBeneficiary,
              taskDataRepository: task,
              sideEffectDataRepository: sideEffect,
              referralDataRepository: referral,
              beneficiaryType:
                  RegistrationDeliverySingleton().beneficiaryType!),
        ),
        BlocProvider(
          create: (_) => DeliverInterventionBloc(
            DeliverInterventionState(
              isEditing: isEditing,
            ),
            taskRepository: task,
          ),
        ),
        BlocProvider(
          create: (_) => ReferralBloc(
            ReferralState(
              isEditing: isEditing,
            ),
            referralRepository: referral,
          ),
        ),
        BlocProvider(
          create: (_) => SideEffectsBloc(
            SideEffectsState(
              isEditing: isEditing,
            ),
            sideEffectRepository: sideEffect,
          ),
        ),
      ],
      child: BlocBuilder<HouseholdOverviewBloc, HouseholdOverviewState>(
        builder: (context, houseHoldOverviewState) {
          return BlocProvider(
            lazy: false,
            create: (_) => DeliverInterventionBloc(
              DeliverInterventionState(
                isEditing: isEditing,
              ),
              taskRepository: task,
            )..add(DeliverInterventionSearchEvent(
                  taskSearch: TaskSearchModel(
                projectBeneficiaryClientReferenceId: houseHoldOverviewState
                    .householdMemberWrapper.projectBeneficiaries
                    ?.map((e) => e.clientReferenceId)
                    .toList(),
              ))),
            child: BlocProvider(
              lazy: false,
              create: (_) => ReferralBloc(
                ReferralState(
                  isEditing: isEditing,
                ),
                referralRepository: referral,
              )..add(ReferralSearchEvent(ReferralSearchModel(
                  projectBeneficiaryClientReferenceId: houseHoldOverviewState
                      .householdMemberWrapper.projectBeneficiaries
                      ?.map((e) => e.clientReferenceId)
                      .toList(),
                ))),
              child: BlocProvider(
                lazy: false,
                create: (_) => SideEffectsBloc(
                  SideEffectsState(
                    isEditing: isEditing,
                  ),
                  sideEffectRepository: sideEffect,
                )..add(SideEffectsSearchEvent(SideEffectSearchModel(
                    taskClientReferenceId: houseHoldOverviewState
                        .householdMemberWrapper.tasks
                        ?.map((e) => e.clientReferenceId)
                        .toList(),
                  ))),
                child: const AutoRouter(),
              ),
            ),
          );
        },
      ),
    );
  }
}
