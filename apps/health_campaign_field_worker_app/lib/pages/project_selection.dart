import 'package:attendance_management/attendance_management.dart';
import 'package:closed_household/closed_household.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_project_cell.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_dss/digit_dss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:health_campaign_field_worker_app/blocs/app_initialization/app_initialization.dart';
import 'package:health_campaign_field_worker_app/data/local_store/no_sql/schema/app_configuration.dart';
import 'package:health_campaign_field_worker_app/data/local_store/no_sql/schema/service_registry.dart';
import 'package:health_campaign_field_worker_app/models/entities/roles_type.dart';
import 'package:health_campaign_field_worker_app/pages/home.dart';
import 'package:health_campaign_field_worker_app/utils/environment_config.dart';
import 'package:inventory_management/inventory_management.dart';
import 'package:inventory_management/models/entities/inventory_transport_type.dart';
import 'package:registration_delivery/registration_delivery.dart';

import '../blocs/auth/auth.dart';
import '../blocs/project/project.dart';
import '../models/entities/project_types.dart';
import '../router/app_router.dart';
import '../utils/i18_key_constants.dart' as i18;
import '../utils/utils.dart';
import '../widgets/header/back_navigation_help_header.dart';
import '../widgets/localized.dart';

@RoutePage()
class ProjectSelectionPage extends LocalizedStatefulWidget {
  const ProjectSelectionPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<ProjectSelectionPage> createState() => _ProjectSelectionPageState();
}

class _ProjectSelectionPageState extends LocalizedState<ProjectSelectionPage> {
  /// [_selectedProject] is to keep track of the project the user selected.
  /// Primary intention is to use this project during the retry mechanism of a
  /// failing down-sync. At this point, the [ProjectState] has not persisted the
  /// selected project yet
  ProjectModel? _selectedProject;
  DialogRoute? syncDialogRoute;

  @override
  void initState() {
    context.read<ProjectBloc>().add(const ProjectInitializeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ScrollableContent(
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackNavigationHelpHeaderWidget(
              showBackNavigation: false,
              showLogoutCTA: true,
              showHelp: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Text(
                localizations.translate(
                  i18.projectSelection.projectDetailsLabelText,
                ),
                style: theme.textTheme.displayMedium,
              ),
            ),
          ],
        ),
        children: [
          BlocConsumer<ProjectBloc, ProjectState>(
            listener: (context, state) {
              final error = state.syncError;

              if (syncDialogRoute?.isActive ?? false) {
                Navigator.of(context).removeRoute(syncDialogRoute!);
              }

              if (error != null) {
                syncDialogRoute = DialogRoute(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => DigitDialog(
                    options: DigitSyncDialog.getDigitDialog(
                      type: DigitSyncDialogType.failed,
                      label: localizations.translate(
                        i18.projectSelection.syncFailedTitleText,
                      ),
                      primaryAction: DigitDialogActions(
                        label: localizations.translate(
                          i18.projectSelection.retryButtonText,
                        ),
                        action: _selectedProject == null
                            ? null
                            : (context) {
                                if (syncDialogRoute?.isActive ?? false) {
                                  Navigator.of(context)
                                      .removeRoute(syncDialogRoute!);
                                }
                                context.read<ProjectBloc>().add(
                                      ProjectSelectProjectEvent(
                                        _selectedProject!,
                                      ),
                                    );
                              },
                      ),
                      secondaryAction: DigitDialogActions(
                        label: localizations.translate(
                          i18.projectSelection.dismissButtonText,
                        ),
                        action: (context) {
                          if (syncDialogRoute?.isActive ?? false) {
                            Navigator.of(context).removeRoute(syncDialogRoute!);
                          }
                        },
                      ),
                    ),
                  ),
                );

                Navigator.of(context).push(syncDialogRoute!);

                return;
              } else if (state.loading) {
                syncDialogRoute = DialogRoute(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => DigitDialog(
                    options: DigitSyncDialog.getDigitDialog(
                      type: DigitSyncDialogType.inProgress,
                      label: localizations.translate(
                        i18.projectSelection.syncInProgressTitleText,
                      ),
                    ),
                  ),
                );

                Navigator.of(context).push(syncDialogRoute!);
              }

              final selectedProject = state.selectedProject;
              if (selectedProject != null) {
                final boundary = selectedProject.address?.boundary;
                //// Function to set initial Data required for the packages to run

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                setPackagesSingleton(context);

                if (boundary != null) {
                  navigateToBoundary(boundary, context);
                } else {
                  DigitToast.show(
                    context,
                    options: DigitToastOptions(
                      'No boundary data associated with this project.',
                      true,
                      theme,
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state.loading) {
                return const Expanded(
                  child: Center(child: Offstage()),
                );
              }

              final projects = state.projects;

              if (projects.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        Text(localizations.translate(
                          i18.projectSelection.noProjectsAssigned,
                        )),
                        Text(localizations.translate(
                          i18.projectSelection.contactSysAdmin,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: SizedBox(
                            width: 300,
                            child: DigitElevatedButton(
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(const AuthLogoutEvent());
                              },
                              child: Center(
                                child: Text(
                                  localizations.translate(
                                    i18.common.coreCommonOk,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: projects
                    .map(
                      (element) => DigitProjectCell(
                        projectText: element.name,
                        onTap: () {
                          _selectedProject = element;

                          context.read<ProjectBloc>().add(
                                ProjectSelectProjectEvent(element),
                              );
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  void navigateToBoundary(String boundary, BuildContext context) async {
    BoundaryBloc boundaryBloc = context.read<BoundaryBloc>();
    boundaryBloc.add(BoundaryFindEvent(code: boundary));
    try {
      await boundaryBloc.stream
          .firstWhere((element) => element.boundaryList.isNotEmpty);
      DigitComponentsUtils().hideDialog(context);
      context.router.replaceAll([
        context.selectedProject.additionalDetails?.projectType?.code ==
                ProjectTypes.smc.toValue()
            ? SMCWrapperRoute()
            : IRSWrapperRoute(),
        BoundarySelectionRoute(),
      ]);
    } catch (e) {
      debugPrint('error $e');
    }
  }
}

void setPackagesSingleton(BuildContext context) {
  context.read<AppInitializationBloc>().state.maybeWhen(
      orElse: () {},
      initialized: (
        AppConfiguration appConfiguration,
        List<ServiceRegistry> serviceRegistry,
        DashboardConfigSchema? dashboardConfigSchema,
      ) {
        // INFO : Need to add singleton of package Here
        AttendanceSingleton().setInitialData(
            projectId: context.projectId,
            loggedInIndividualId: context.loggedInIndividualId ?? '',
            loggedInUserUuid: context.loggedInUserUuid,
            appVersion: Constants().version);

        InventorySingleton().setInitialData(
          isWareHouseMgr: context.loggedInUserRoles
              .where(
                  (role) => role.code == RolesType.warehouseManager.toValue())
              .toList()
              .isNotEmpty,
          isDistributor: context.loggedInUserRoles
              .where(
                (role) => role.code == RolesType.distributor.toValue(),
              )
              .toList()
              .isNotEmpty,
          loggedInUser: context.loggedInUserModel,
          projectId: context.projectId,
          loggedInUserUuid: context.loggedInUserUuid,
          transportTypes: appConfiguration.transportTypes
              ?.map((e) => InventoryTransportTypes()
                ..name = e.code
                ..code = e.code)
              .toList(),
        );
        DashboardSingleton().setInitialData(
            projectId: context.projectId,
            tenantId: envConfig.variables.tenantId,
            dashboardConfig: dashboardConfigSchema,
            appVersion: Constants().version,
            selectedProject: context.selectedProject,
            actionPath: Constants.getEndPoint(
              serviceRegistry: serviceRegistry,
              service: DashboardResponseModel.schemaName.toUpperCase(),
              action: ApiOperation.search.toValue(),
              entityName: DashboardResponseModel.schemaName,
            ));

        RegistrationDeliverySingleton().setInitialData(
          loggedInUser: context.loggedInUserModel,
          loggedInUserUuid: context.loggedInUserUuid,
          maxRadius: appConfiguration.maxRadius!,
          projectId: context.projectId,
          selectedBeneficiaryType: context.beneficiaryType,
          projectType: context.selectedProjectType,
          selectedProject: context.selectedProject,
          genderOptions:
              appConfiguration.genderOptions!.map((e) => e.code).toList(),
          idTypeOptions:
              appConfiguration.idTypeOptions!.map((e) => e.code).toList(),
          householdDeletionReasonOptions: appConfiguration
              .householdDeletionReasonOptions!
              .map((e) => e.code)
              .toList(),
          householdMemberDeletionReasonOptions: appConfiguration
              .householdMemberDeletionReasonOptions!
              .map((e) => e.code)
              .toList(),
          deliveryCommentOptions: appConfiguration.deliveryCommentOptions!
              .map((e) => e.code)
              .toList(),
          symptomsTypes:
              appConfiguration.symptomsTypes?.map((e) => e.code).toList(),
          searchHouseHoldFilter: appConfiguration.searchHouseHoldFilters != null
              ? appConfiguration.searchHouseHoldFilters!
                  .map((e) => e.code)
                  .toList()
              : [],
          referralReasons:
              appConfiguration.referralReasons?.map((e) => e.code).toList(),
          houseStructureTypes:
              appConfiguration.houseStructureTypes?.map((e) => e.code).toList(),
          refusalReasons:
              appConfiguration.refusalReasons?.map((e) => e.code).toList(),
        );
        ClosedHouseholdSingleton().setInitialData(
          loggedInUserUuid: context.loggedInUserUuid,
          projectId: context.projectId,
          beneficiaryType: context.beneficiaryType,
        );
      });
}
