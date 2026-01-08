import 'package:complaints/complaints.dart';
import 'package:complaints/router/complaints_router.gm.dart';
import 'package:digit_data_model/models/entities/household_type.dart';
import 'package:digit_data_model/models/entities/user_action.dart';
import 'package:digit_ui_components/theme/spacers.dart';
import 'package:recase/recase.dart';
import 'package:referral_reconciliation/referral_reconciliation.dart';
import 'package:referral_reconciliation/router/referral_reconciliation_router.gm.dart';

import 'package:attendance_management/attendance_management.dart';
import 'package:attendance_management/router/attendance_router.gm.dart';

import 'package:closed_household/router/closed_household_router.gm.dart';
import 'package:closed_household/utils/utils.dart';
import 'package:health_campaign_field_worker_app/utils/environment_config.dart';
import 'package:inventory_management/inventory_management.dart';
import 'package:inventory_management/router/inventory_router.gm.dart';

import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:survey_form/router/survey_form_router.gm.dart';
import 'package:survey_form/survey_form.dart';
import 'package:sync_service/blocs/sync/sync.dart';
import 'package:transit_post/utils/utils.dart';
import '../../blocs/localization/localization.dart';
import '../../data/local_store/app_shared_preferences.dart';
import '../../blocs/localization/localization.dart';
import '../../data/local_store/app_shared_preferences.dart';

import 'dart:async';
import 'package:digit_dss/data/local_store/no_sql/schema/dashboard_config_schema.dart';
import 'package:digit_dss/models/entities/dashboard_response_model.dart';
import 'package:digit_dss/router/dashboard_router.gm.dart';
import 'package:digit_dss/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:health_campaign_field_worker_app/data/local_store/no_sql/schema/service_registry.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../blocs/app_initialization/app_initialization.dart';
import '../../blocs/auth/auth.dart';
import '../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../data/local_store/secure_store/secure_store.dart';
import '../../models/entities/project_types.dart';
import '../../models/entities/roles_type.dart';
import '../../router/app_router.dart';
import '../../utils/debound.dart';
import '../../utils/least_level_boundary_singleton.dart';
import '../../utils/utils_smc/i18_key_constants.dart' as i18;
import '../../utils/utils.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/home/home_item_card.dart';
import '../../widgets/localized.dart';
import '../../widgets/progress_bar/custom_beneficiary_progress.dart';
import '../../widgets/showcase/config/showcase_constants.dart';
import '../../widgets/widgets_smc/progress_bar/custom_beneficiary_progress_smc.dart';
import '../../widgets/widgets_smc/progress_bar/custom_beneficiary_progress_bednet.dart';
import 'package:referral_reconciliation/blocs/search_referral_reconciliations.dart';

@RoutePage()
class HomeSMCPage extends LocalizedStatefulWidget {
  const HomeSMCPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<HomeSMCPage> createState() => HomeSMCPageState();
}

class HomeSMCPageState extends LocalizedState<HomeSMCPage> {
  bool skipProgressBar = false;
  bool _isCardExpanded = false;
  final storage = const FlutterSecureStorage();
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool isTriggerLocalisation = true;
  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (result.firstOrNull == ConnectivityResult.none) {
        if (context.mounted) {
          context.syncRefresh();
        }
      }
    });
    //// Function to set initial Data required for the packages to run
    setPackagesSingleton(context);
  }

  //  Be sure to cancel subscription after you are done
  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.read<AuthBloc>().state;
    final localSecureStore = LocalSecureStore.instance;
    if (state is! AuthAuthenticatedState) {
      return Container();
    }
    final roles = state.userModel.roles.map((e) {
      return e.code;
    });

    //[TODO: Add below roles to enum]
    if (!(roles.contains(RolesType.distributor.toValue()) ||
        roles.contains(RolesType.registrar.toValue()) ||
        roles.contains(RolesType.communityDistributor.toValue()))) {
      skipProgressBar = true;
    }

    final mappedItems = _getItems(context);

    final homeItems = mappedItems?.homeItems ?? [];
    final showcaseKeys = <GlobalKey>[
      if (!skipProgressBar) homeShowcaseData.distributorProgressBar.showcaseKey,
      ...(mappedItems?.showcaseKeys ?? []),
    ];

    return Scaffold(
      backgroundColor: DigitTheme.instance.colorScheme.background,
      body: BlocListener<SyncBloc, SyncState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            pendingSync: (count) {
              final debouncer = Debouncer(seconds: 5);
              debouncer.run(() async {
                if (count != 0) {
                  if (context.mounted) {
                    await performBackgroundService(
                      isBackground: false,
                      stopService: false,
                      context: context,
                    );
                  }
                }
              });
            },
          );
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ScrollableContent(
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return homeItems.elementAt(index);
                  },
                  childCount: homeItems.length,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 145,
                  childAspectRatio: 104 / 128,
                ),
              ),
            ],
            header: Column(
              children: [
                const BackNavigationHelpHeaderWidget(
                  showBackNavigation: false,
                  showHelp: false,
                  showcaseButton: null,
                ),
                skipProgressBar
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: spacer2,
                        ),
                        child: Column(
                          children: [
                            CustomBeneficiaryProgressBarSMC(
                              label: localizations.translate(
                                i18.home.progressIndicatorTitle,
                              ),
                              prefixLabel: localizations.translate(
                                i18.home.progressIndicatorPrefixLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            footer: PoweredByDigit(
              version: Constants().version,
            ),
            children: [
              const SizedBox(height: kPadding * 2),
              BlocConsumer<SyncBloc, SyncState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () => null,
                    syncInProgress: () async {
                      await localSecureStore.setManualSyncTrigger(true);
                      if (context.mounted) {
                        DigitSyncDialog.show(
                          context,
                          type: DigitSyncDialogType.inProgress,
                          label: localizations.translate(
                            i18.syncDialog.syncInProgressTitle,
                          ),
                          barrierDismissible: false,
                        );
                      }
                    },
                    completedSync: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      await localSecureStore.setManualSyncTrigger(false);
                      if (context.mounted) {
                        DigitSyncDialog.show(
                          context,
                          type: DigitSyncDialogType.complete,
                          label: localizations.translate(
                            i18.syncDialog.dataSyncedTitle,
                          ),
                          primaryAction: DigitDialogActions(
                            label: localizations.translate(
                              i18.syncDialog.closeButtonLabel,
                            ),
                            action: (ctx) {
                              Navigator.pop(ctx);
                            },
                          ),
                        );
                      }
                    },
                    failedSync: () async {
                      await localSecureStore.setManualSyncTrigger(false);
                      if (context.mounted) {
                        _showSyncFailedDialog(
                          context,
                          message: localizations.translate(
                            i18.syncDialog.syncFailedTitle,
                          ),
                        );
                      }
                    },
                    failedDownSync: () async {
                      await localSecureStore.setManualSyncTrigger(false);
                      if (context.mounted) {
                        _showSyncFailedDialog(
                          context,
                          message: localizations.translate(
                            i18.syncDialog.downSyncFailedTitle,
                          ),
                        );
                      }
                    },
                    failedUpSync: () async {
                      await localSecureStore.setManualSyncTrigger(false);
                      if (context.mounted) {
                        _showSyncFailedDialog(
                          context,
                          message: localizations.translate(
                            i18.syncDialog.upSyncFailedTitle,
                          ),
                        );
                      }
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const Offstage(),
                    pendingSync: (count) {
                      return count == 0
                          ? const Offstage()
                          : DigitInfoCard(
                              icon: Icons.info,
                              backgroundColor:
                                  theme.colorScheme.tertiaryContainer,
                              iconColor: theme.colorScheme.surfaceTint,
                              description: localizations
                                  .translate(i18.home.dataSyncInfoContent)
                                  .replaceAll('{}', count.toString()),
                              title: localizations.translate(
                                i18.home.dataSyncInfoLabel,
                              ),
                            );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSyncFailedDialog(
    BuildContext context, {
    required String message,
  }) {
    Navigator.of(context, rootNavigator: true).pop();

    DigitDialog.show(
      context,
      options: DigitDialogOptions(
        titleIcon: Icon(
          Icons.warning,
          color: DigitTheme.instance.colorScheme.error,
        ),
        titleText: message,
        contentText: localizations.translate(
          i18.syncDialog.syncFailedDescriptionText,
        ),
        primaryAction: DigitDialogActions(
          label: localizations.translate(
            i18.syncDialog.closeButtonFailedLabel,
          ),
          action: (ctx) => Navigator.pop(ctx),
        ),
        secondaryAction: DigitDialogActions(
          label: localizations.translate(
            i18.syncDialog.retryButtonLabel,
          ),
          action: (ctx) {
            Navigator.pop(ctx);
            // Sync Failed Manual Sync is Enabled
            _attemptSyncUp(context);
          },
        ),
      ),
    );
  }

  _HomeItemDataModel? _getItems(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    if (state is! AuthAuthenticatedState) {
      return null;
    }

    final Map<String, Widget> homeItemsMap = {
      i18.home.dashboard: homeShowcaseData.dashBoard.buildWith(
        child: HomeItemCard(
          icon: Icons.bar_chart_sharp,
          label: i18.home.dashboard,
          onPressed: () {
            context.router.push(const CustomUserDashboardRoute());
          },
        ),
      ),
      // INFO : Need to add home items of package Here
      i18.home.manageAttendanceLabel:
          homeShowcaseData.manageAttendance.buildWith(
        child: HomeItemCard(
          icon: Icons.fingerprint_outlined,
          label: i18.home.manageAttendanceLabel,
          onPressed: () {
            context.router.push(const CustomManageAttendanceSMCRoute());
          },
        ),
      ),

      i18.home.closedHouseHoldLabel: homeShowcaseData.closedHouseHold.buildWith(
        child: HomeItemCard(
          icon: Icons.home,
          enableCustomIcon: true,
          customIcon: Constants.closedHouseholdSvg,
          customIconSize: 48,
          label: i18.home.closedHouseHoldLabelSMC,
          onPressed: () async {
            RegistrationDeliverySingleton()
                .setHouseholdType(HouseholdType.family);
            await context.router.push(const ClosedHouseholdWrapperRoute());
          },
        ),
      ),

      i18.home.manageStockLabel:
          homeShowcaseData.warehouseManagerManageStock.buildWith(
        child: HomeItemCard(
          icon: Icons.store_mall_directory,
          label: i18.home.manageStockLabel,
          onPressed: () {
            context.read<AppInitializationBloc>().state.maybeWhen(
                  orElse: () {},
                  initialized: (
                    AppConfiguration appConfiguration,
                    _,
                    __,
                  ) {
                    context.router.push(CustomManageStocksRoute());
                  },
                );
          },
        ),
      ),
      i18.home.stockReconciliationLabel:
          homeShowcaseData.wareHouseManagerStockReconciliation.buildWith(
        child: HomeItemCard(
          icon: Icons.menu_book,
          label: i18.home.stockReconciliationLabel,
          onPressed: () {
            context.router.push(StockReconciliationRoute());
          },
        ),
      ),
      i18.home.viewReportsLabel: homeShowcaseData.inventoryReport.buildWith(
        child: HomeItemCard(
          icon: Icons.announcement,
          label: i18.home.viewReportsLabel,
          onPressed: () {
            context.router.push(InventoryReportSelectionRoute());
          },
        ),
      ),

      i18.home.beneficiaryLabel:
          homeShowcaseData.distributorBeneficiaries.buildWith(
        child: HomeItemCard(
          icon: Icons.all_inbox,
          label: i18.home.beneficiaryLabel,
          onPressed: () async {
            RegistrationDeliverySingleton()
                .setHouseholdType(HouseholdType.family);
            await context.router.push(const RegistrationDeliveryWrapperRoute());
          },
        ),
      ),

      i18.home.myCheckList: homeShowcaseData.supervisorMySurveyForm.buildWith(
        child: HomeItemCard(
          enableCustomIcon: true,
          customIcon: myChecklistSvg,
          icon: Icons.checklist,
          label: i18.home.myCheckList,
          onPressed: () => context.router.push(CustomSurveyFormWrapperRoute()),
        ),
      ),
      i18.home.fileComplaint:
          homeShowcaseData.distributorFileComplaint.buildWith(
        child: HomeItemCard(
          icon: Icons.announcement,
          label: i18.home.fileComplaint,
          onPressed: () =>
              context.router.push(const ComplaintsInboxWrapperRoute()),
        ),
      ),
      i18.home.syncDataLabel: homeShowcaseData.distributorSyncData.buildWith(
        child: StreamBuilder<Map<String, dynamic>?>(
          stream: FlutterBackgroundService().on('serviceRunning'),
          builder: (context, snapshot) {
            return HomeItemCard(
              icon: Icons.sync_alt,
              label: i18.home.syncDataLabel,
              onPressed: () async {
                if (snapshot.data == null ||
                    snapshot.data?['enablesManualSync'] == true) {
                  if (context.mounted) _attemptSyncUp(context);
                } else {
                  if (context.mounted) {
                    DigitToast.show(
                      context,
                      options: DigitToastOptions(
                        localizations
                            .translate(i18.common.coreCommonSyncInProgress),
                        false,
                        Theme.of(context),
                      ),
                    );
                  }
                }
              },
            );
          },
        ),
      ),
      i18.home.db: homeShowcaseData.db.buildWith(
        child: HomeItemCard(
          icon: Icons.table_chart,
          label: i18.home.db,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DriftDbViewer(
                  context.read<LocalSqlDataStore>(),
                ),
              ),
            );
          },
        ),
      ),
      i18.home.beneficiaryReferralLabel: HomeItemCard(
        icon: Icons.supervised_user_circle_rounded,
        label: i18.home.beneficiaryReferralLabel,
        onPressed: () async {
          await context.router.push(CustomSearchReferralReconciliationsRoute());
        },
      ),
      i18.home.vehicleTrackingLabel: homeShowcaseData.vehicleTracking.buildWith(
        child: HomeItemCard(
          icon: Icons.local_taxi_rounded,
          label: i18.home.vehicleTrackingLabel,
          onPressed: () => {
            // context.router.push(VehicleTripBookRoute())
            context.router.push(const VehicleTrackingWrapperRoute()),
          },
        ),
      ),
      // i18.home.dataShare: homeShowcaseData.dataShare.buildWith(
      //   child: HomeItemCard(
      //     icon: Icons.send,
      //     label: i18.home.dataShare,
      //     onPressed: () {
      //       // if (isTriggerLocalisation) {
      //       //   triggerLocalization(context);
      //       //   isTriggerLocalisation = false;
      //       // }
      //       context.router.push(const DataShareHomeRoute());
      //     },
      //   ),
      // )
    };

    final Map<String, GlobalKey> homeItemsShowcaseMap = {
      i18.home.dashboard: homeShowcaseData.dashBoard.showcaseKey,

      i18.home.dashboard: homeShowcaseData.dashBoard.showcaseKey,

      i18.home.dashboard: homeShowcaseData.dashBoard.showcaseKey,

      i18.home.dashboard: homeShowcaseData.dashBoard.showcaseKey,

      i18.home.dashboard: homeShowcaseData.dashBoard.showcaseKey,

      i18.home.dashboard: homeShowcaseData.dashBoard.showcaseKey,

      i18.home.dashboard: homeShowcaseData.dashBoard.showcaseKey,
      // i18.home.dataShare: homeShowcaseData.dataShare.showcaseKey,
      // INFO : Need to add showcase keys of package Here
      i18.home.manageAttendanceLabel:
          homeShowcaseData.manageAttendance.showcaseKey,
      i18.home.vehicleTrackingLabel:
          homeShowcaseData.vehicleTracking.showcaseKey,

      i18.home.manageStockLabel:
          homeShowcaseData.warehouseManagerManageStock.showcaseKey,
      i18.home.stockReconciliationLabel:
          homeShowcaseData.wareHouseManagerStockReconciliation.showcaseKey,
      i18.home.viewReportsLabel: homeShowcaseData.inventoryReport.showcaseKey,

      i18.home.beneficiaryLabel:
          homeShowcaseData.distributorBeneficiaries.showcaseKey,

      i18.home.myCheckList: homeShowcaseData.supervisorMySurveyForm.showcaseKey,
      i18.home.fileComplaint:
          homeShowcaseData.distributorFileComplaint.showcaseKey,
      i18.home.syncDataLabel: homeShowcaseData.distributorSyncData.showcaseKey,
      i18.home.db: homeShowcaseData.db.showcaseKey,
      i18.home.closedHouseHoldLabel:
          homeShowcaseData.closedHouseHold.showcaseKey,
      i18.home.dashboard: homeShowcaseData.dashBoard.showcaseKey,
      i18.home.beneficiaryReferralLabel:
          homeShowcaseData.hfBeneficiaryReferral.showcaseKey,
    };

    final homeItemsLabel = <String>[
      // INFO: Need to add items label of package Here
      i18.home.beneficiaryReferralLabel,
      i18.home.beneficiaryLabel,
      i18.home.closedHouseHoldLabel,
      i18.home.manageStockLabel,
      i18.home.stockReconciliationLabel,
      i18.home.viewReportsLabel,
      i18.home.vehicleTrackingLabel,
      // i18.home.dataShare,

      i18.home.mySurveyForm,
      i18.home.fileComplaint,
      i18.home.syncDataLabel,
      i18.home.manageAttendanceLabel,
      i18.home.dashboard,
      i18.home.db,
    ];

    final List<String> filteredLabels = homeItemsLabel
        .where((element) =>
            state.actionsWrapper.actions
                .map((e) => e.displayName)
                .toList()
                .contains(element) ||
            element ==
                i18.home.db) // TODO: need to add close household inside mdms
        .toList();

    final showcaseKeys = filteredLabels
        .where((f) =>
            f != i18.home.db) // TODO: need to add close household inside mdms
        .map((label) => homeItemsShowcaseMap[label]!)
        .toList();

    final List<Widget> widgetList =
        filteredLabels.map((label) => homeItemsMap[label]!).toList();

    return _HomeItemDataModel(
      widgetList,
      showcaseKeys,
    );
  }

  void _attemptSyncUp(BuildContext context) async {
    // await LocalSecureStore.instance.setManualSyncTrigger(true);

    if (context.mounted) {
      context.read<SyncBloc>().add(
            SyncSyncUpEvent(
              userId: context.loggedInUserUuid,
              localRepositories: [
                // INFO : Need to add local repo of package Here
                context.read<
                    LocalRepository<HFReferralModel, HFReferralSearchModel>>(),
                context.read<
                    LocalRepository<AttendanceLogModel,
                        AttendanceLogSearchModel>>(),

                context.read<LocalRepository<StockModel, StockSearchModel>>(),
                context.read<
                    LocalRepository<StockReconciliationModel,
                        StockReconciliationSearchModel>>(),

                context.read<
                    LocalRepository<HouseholdModel, HouseholdSearchModel>>(),
                context.read<
                    LocalRepository<ProjectBeneficiaryModel,
                        ProjectBeneficiarySearchModel>>(),
                context.read<
                    LocalRepository<HouseholdMemberModel,
                        HouseholdMemberSearchModel>>(),
                context.read<LocalRepository<TaskModel, TaskSearchModel>>(),
                context.read<
                    LocalRepository<SideEffectModel, SideEffectSearchModel>>(),
                context.read<
                    LocalRepository<ReferralModel, ReferralSearchModel>>(),

                context.read<
                    LocalRepository<IndividualModel, IndividualSearchModel>>(),
                context
                    .read<LocalRepository<ServiceModel, ServiceSearchModel>>(),
                context.read<
                    LocalRepository<PgrServiceModel, PgrServiceSearchModel>>(),
                context.read<
                    LocalRepository<UserActionModel, UserActionSearchModel>>(),
              ],
              remoteRepositories: [
                // INFO : Need to add repo repo of package Here
                context.read<
                    RemoteRepository<HFReferralModel, HFReferralSearchModel>>(),
                context.read<
                    RemoteRepository<AttendanceLogModel,
                        AttendanceLogSearchModel>>(),

                context.read<RemoteRepository<StockModel, StockSearchModel>>(),
                context.read<
                    RemoteRepository<StockReconciliationModel,
                        StockReconciliationSearchModel>>(),

                context.read<
                    RemoteRepository<HouseholdModel, HouseholdSearchModel>>(),
                context.read<
                    RemoteRepository<ProjectBeneficiaryModel,
                        ProjectBeneficiarySearchModel>>(),
                context.read<
                    RemoteRepository<HouseholdMemberModel,
                        HouseholdMemberSearchModel>>(),
                context.read<RemoteRepository<TaskModel, TaskSearchModel>>(),
                context.read<
                    RemoteRepository<SideEffectModel, SideEffectSearchModel>>(),
                context.read<
                    RemoteRepository<ReferralModel, ReferralSearchModel>>(),

                context.read<
                    RemoteRepository<IndividualModel, IndividualSearchModel>>(),
                context
                    .read<RemoteRepository<ServiceModel, ServiceSearchModel>>(),
                context.read<
                    RemoteRepository<PgrServiceModel, PgrServiceSearchModel>>(),
                context.read<
                    RemoteRepository<UserActionModel, UserActionSearchModel>>(),
              ],
            ),
          );
    }
  }
}

// Function to set initial Data required for the packages to run
void setPackagesSingleton(BuildContext context) {
  context.read<AppInitializationBloc>().state.maybeWhen(
      orElse: () {},
      initialized: (
        AppConfiguration appConfiguration,
        List<ServiceRegistry> serviceRegistry,
        List<DashboardConfigSchema?>? dashboardConfigSchema,
      ) {
        loadLocalization(context, appConfiguration);
        final filter = appConfiguration.searchHouseHoldFiltersSMC;

        // info filter dashboardschema based on projectTypeCode
        final projectTypeCode =
            context.projectTypeCode ?? ProjectTypes.irs.toValue();
        final filteredDashboardConfig = context.filterDashboardConfig(
            dashboardConfigSchema ?? [], projectTypeCode);

        // INFO : Need to add singleton of package Here
        AttendanceSingleton().setInitialData(
            projectId: context.projectId,
            loggedInIndividualId: context.loggedInIndividualId ?? '',
            loggedInUserUuid: context.loggedInUserUuid,
            appVersion: Constants().version);

        SurveyFormSingleton().setInitialData(
          projectId: context.projectId,
          projectName: context.selectedProject.name,
          loggedInIndividualId: context.loggedInIndividualId ?? '',
          loggedInUserUuid: context.loggedInUserUuid,
          appVersion: Constants().version,
          roles: context.read<AuthBloc>().state.maybeMap(
              orElse: () => const Offstage(),
              authenticated: (res) {
                return res.userModel.roles
                    .map((e) => e.code.snakeCase.toUpperCase())
                    .toList();
              }),
        );
        ComplaintsSingleton().setInitialData(
          tenantId: envConfig.variables.tenantId,
          loggedInUserUuid: context.loggedInUserUuid,
          userMobileNumber: context.loggedInUser.mobileNumber,
          loggedInUserName: context.loggedInUser.name,
          complaintTypes:
              appConfiguration.complaintTypes!.map((e) => e.code).toList(),
          userName: context.loggedInUser.name ?? '',
        );

        InventorySingleton().setInitialData(
          isWareHouseMgr: context.loggedInUserRoles
              .where((role) =>
                  role.code == RolesType.warehouseManager.toValue() ||
                  role.code == RolesType.spaqManager.toValue())
              .toList()
              .isNotEmpty,
          isDistributor: context.loggedInUserRoles
              .where(
                (role) =>
                    role.code == RolesType.distributor.toValue() ||
                    role.code == RolesType.communityDistributor.toValue(),
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
            dashboardConfig: filteredDashboardConfig.firstOrNull,
            appVersion: Constants().version,
            selectedProject: context.selectedProject,
            actionPath: Constants.getEndPoint(
              serviceRegistry: serviceRegistry,
              service: DashboardResponseModel.schemaName.toUpperCase(),
              action: ApiOperation.search.toValue(),
              entityName: DashboardResponseModel.schemaName,
            ));

        RegistrationDeliverySingleton().setInitialData(
          beneficiaryIdMinCount:
              appConfiguration.beneficiaryIdConfig?.first.minCount.toInt(),
          beneficiaryIdBatchSize:
              appConfiguration.beneficiaryIdConfig?.first.batchSize.toInt(),
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
          searchHouseHoldFilter:
              appConfiguration.searchHouseHoldFiltersSMC != null
                  ? appConfiguration.searchHouseHoldFiltersSMC!
                      .map((e) => e.code)
                      .toList()
                  : [],
          referralReasons:
              appConfiguration.referralReasons?.map((e) => e.code).toList(),
          houseStructureTypes:
              appConfiguration.houseStructureTypes?.map((e) => e.code).toList(),
          refusalReasons:
              appConfiguration.refusalReasons?.map((e) => e.code).toList(),
          searchCLFFilters: [],
        );
        ClosedHouseholdSingleton().setInitialData(
          loggedInUserUuid: context.loggedInUserUuid,
          projectId: context.projectId,
          beneficiaryType: context.beneficiaryType,
        );
        ReferralReconSingleton().setInitialData(
          userName: context.loggedInUser.name ?? '',
          userUUid: context.loggedInUserUuid,
          projectId: context.selectedProject.id,
          projectName: context.selectedProject.name,
          roleCode: RolesType.healthFacilitySupervisor.toValue(),
          appVersion: Constants().version,
          tenantId: envConfig.variables.tenantId,
          validIndividualAgeForCampaign: ValidIndividualAgeForCampaign(
            validMinAge: context.selectedProjectType?.validMinAge ?? 3,
            validMaxAge: context.selectedProjectType?.validMaxAge ?? 64,
          ),
          genderOptions:
              appConfiguration.genderOptions?.map((e) => e.code).toList() ?? [],
          cycles: context.cycles,
          referralReasons:
              appConfiguration.referralReasons?.map((e) => e.code).toList() ??
                  [],
          checklistTypes:
              appConfiguration.checklistTypes?.map((e) => e.code).toList() ??
                  [],
        );

        TransitPostSingleton().setInitialData(
          resources: context.selectedProjectType?.resources,
          transitPostType: [],
          loggedInUserUuid: context.loggedInUserUuid,
          projectId: context.selectedProject.id,
          minAge: context.selectedProjectType?.validMinAge,
          maxAge: context.selectedProjectType?.validMaxAge,
        );
      });
}

void triggerLocalization(BuildContext context) {
  context.read<AppInitializationBloc>().state.maybeWhen(
        orElse: () {},
        initialized: (
          AppConfiguration appConfiguration,
          _,
          __,
        ) {
          final appConfig = appConfiguration;
          final localizationModulesList = appConfiguration.backendInterface;
          final selectedLocale = AppSharedPreferences().getSelectedLocale;
          LocalizationParams().setCode(LeastLevelBoundarySingleton().boundary);
          context
              .read<LocalizationBloc>()
              .add(LocalizationEvent.onLoadLocalization(
                module:
                    "${localizationModulesList?.interfaces.where((element) => element.type == Modules.localizationModule).map((e) => e.name.toString()).join(',')}",
                tenantId: appConfig.tenantId ?? "default",
                locale: selectedLocale!,
                path: Constants.localizationApiPath,
              ));
        },
      );
}

void loadLocalization(
    BuildContext context, AppConfiguration appConfiguration) async {
  context.read<LocalizationBloc>().add(
      LocalizationEvent.onUpdateLocalizationIndex(
          index: appConfiguration.languages!.indexWhere((element) =>
              element.value == AppSharedPreferences().getSelectedLocale),
          code: "pt_MZ"));
}

class _HomeItemDataModel {
  final List<Widget> homeItems;
  final List<GlobalKey> showcaseKeys;

  const _HomeItemDataModel(this.homeItems, this.showcaseKeys);
}
