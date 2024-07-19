import 'package:inventory_management/router/inventory_router.dart';
import 'package:inventory_management/router/inventory_router.gm.dart';
import 'package:registration_delivery/router/registration_delivery_router.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';

import 'package:auto_route/auto_route.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';

import '../blocs/localization/app_localization.dart';
import '../pages/acknowledgement.dart';
import '../pages/authenticated.dart';
import '../pages/boundary_selection.dart';
import '../pages/checklist/checklist.dart';
import '../pages/checklist/checklist_boundary_view.dart';
import '../pages/checklist/checklist_preview.dart';
import '../pages/checklist/checklist_view.dart';
import '../pages/checklist/checklist_wrapper.dart';
import '../pages/complaints/inbox/complaints_details_view.dart';
import '../pages/complaints/inbox/complaints_inbox.dart';
import '../pages/complaints/inbox/complaints_inbox_filter.dart';
import '../pages/complaints/inbox/complaints_inbox_search.dart';
import '../pages/complaints/inbox/complaints_inbox_sort.dart';
import '../pages/complaints/inbox/complaints_inbox_wrapper.dart';
import '../pages/complaints/registration/complaint_type.dart';
import '../pages/complaints/registration/complaints_details.dart';
import '../pages/complaints/registration/complaints_location.dart';
import '../pages/complaints/registration/complaints_registration_wrapper.dart';
import '../pages/complaints_acknowledgement.dart';
import '../pages/home.dart';
import '../pages/language_selection.dart';
import '../pages/login.dart';
import '../pages/profile.dart';
import '../pages/project_facility_selection.dart';
import '../pages/project_selection.dart';
import '../pages/qr_details_page.dart';
import '../pages/reports/beneficiary/beneficaries_report.dart';
import '../pages/unauthenticated.dart';
export 'package:auto_route/auto_route.dart';
import '../pages/inventory/custom_manage_stocks.dart';
import '../pages/inventory/custom_stock_reconciliation.dart';
import '../pages/reports/inventory/custom_report_selection.dart';
import '../pages/beneficiary_registration/custom_individual_details.dart';
import '../pages/beneficiary_registration/custom_household_location.dart';
import 'package:registration_delivery/blocs/app_localization.dart';

import '../pages/beneficiary_registration/custom_household_overview.dart';
import '../pages/beneficiary_registration/custom_search_beneficiary.dart';
import '../pages/beneficiary/custom_deliver_intervention.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  // INFO : Need to add the router modules here
  modules: [
    RegistrationDeliveryRoute,
    InventoryRoute,
  ],
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> routes = [
    AutoRoute(
      page: UnauthenticatedRouteWrapper.page,
      path: '/',
      children: [
        AutoRoute(
          page: LoginRoute.page,
          path: 'login',
          initial: true,
        ),
      ],
    ),
    AutoRoute(
      page: AuthenticatedRouteWrapper.page,
      path: '/',
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(page: UserQRDetailsRoute.page, path: 'user-qr-code'),
        AutoRoute(
          page: BeneficiariesReportRoute.page,
          path: 'beneficiary-downsync-report',
        ),

        // INFO : Need to add Router of package Here
        // Inventory Route
        AutoRoute(
          page: ManageStocksRoute.page,
          path: 'manage-stocks',
        ),
        AutoRoute(
          page: CustomManageStocksRoute.page,
          path: 'custom-manage-stocks',
        ),
        RedirectRoute(
          path: 'manage-stocks',
          redirectTo: 'custom-manage-stocks',
        ),
        AutoRoute(
          page: RecordStockWrapperRoute.page,
          path: 'record-stock',
          children: [
            AutoRoute(
              page: WarehouseDetailsRoute.page,
              path: 'warehouse-details',
              initial: true,
            ),
            AutoRoute(page: StockDetailsRoute.page, path: 'details'),
          ],
        ),
        AutoRoute(
          page: InventoryFacilitySelectionRoute.page,
          path: 'inventory-select-facilities',
        ),
        AutoRoute(
          page: StockReconciliationRoute.page,
          path: 'stock-reconciliation',
        ),
        AutoRoute(
          page: CustomStockReconciliationRoute.page,
          path: 'custom-stock-reconciliation',
        ),
        RedirectRoute(
          path: 'stock-reconciliation',
          redirectTo: 'custom-stock-reconciliation',
        ),
        AutoRoute(
          page: InventoryReportSelectionRoute.page,
          path: 'inventory-report-selection',
        ),
        AutoRoute(
          page: CustomInventoryReportSelectionRoute.page,
          path: 'custom-inventory-report-selection',
        ),
        RedirectRoute(
          path: 'inventory-report-selection',
          redirectTo: 'custom-inventory-report-selection',
        ),
        AutoRoute(
          page: InventoryReportDetailsRoute.page,
          path: 'inventory-report-details',
        ),
        AutoRoute(
          page: InventoryAcknowledgementRoute.page,
          path: 'inventory-acknowledgement',
        ),

        AutoRoute(
            page: RegistrationDeliveryWrapperRoute.page,
            path: 'registration-delivery-wrapper',
            children: [
              AutoRoute(
                page: SearchBeneficiaryRoute.page,
                path: 'search-beneficiary',
              ),
              AutoRoute(
                initial: true,
                page: CustomSearchBeneficiaryRoute.page,
                path: 'custom-search-beneficiary',
              ),
              RedirectRoute(
                path: 'search-beneficiary',
                redirectTo: 'custom-search-beneficiary',
              ),

              AutoRoute(
                page: FacilitySelectionRoute.page,
                path: 'select-facilities',
              ),

              /// Beneficiary Registration
              AutoRoute(
                page: BeneficiaryRegistrationWrapperRoute.page,
                path: 'beneficiary-registration',
                children: [
                  AutoRoute(
                      page: IndividualDetailsRoute.page,
                      path: 'individual-details'),
                  AutoRoute(
                    page: CustomIndividualDetailsRoute.page,
                    path: 'custom-individual-details',
                  ),
                  RedirectRoute(
                    path: 'individual-details',
                    redirectTo: 'custom-individual-details',
                  ),
                  AutoRoute(
                      page: HouseHoldDetailsRoute.page,
                      path: 'household-details'),
                  AutoRoute(
                    page: HouseholdLocationRoute.page,
                    path: 'household-location',
                  ),
                  AutoRoute(
                    page: CustomHouseholdLocationRoute.page,
                    path: 'custom-household-location',
                    initial: true,
                  ),
                  RedirectRoute(
                    path: 'household-location',
                    redirectTo: 'custom-household-location',
                  ),
                  AutoRoute(
                    page: BeneficiaryAcknowledgementRoute.page,
                    path: 'beneficiary-acknowledgement',
                  ),
                  AutoRoute(
                      page: HouseDetailsRoute.page, path: 'house-details'),
                  AutoRoute(
                    page: SummaryRoute.page,
                    path: 'beneficiary-summary',
                  ),
                ],
              ),
              AutoRoute(
                page: BeneficiaryWrapperRoute.page,
                path: 'beneficiary',
                children: [
                  AutoRoute(
                    page: HouseholdOverviewRoute.page,
                    path: 'overview',
                  ),
                  AutoRoute(
                    page: CustomHouseholdOverviewRoute.page,
                    path: 'custom-overview',
                    initial: true,
                  ),
                  RedirectRoute(
                    path: 'overview',
                    redirectTo: 'custom-overview',
                  ),
                  AutoRoute(
                    page: BeneficiaryChecklistRoute.page,
                    path: 'beneficiary-checklist',
                  ),
                  AutoRoute(
                    page: BeneficiaryDetailsRoute.page,
                    path: 'beneficiary-details',
                  ),
                  AutoRoute(
                    page: DeliverInterventionRoute.page,
                    path: 'deliver-intervention',
                  ),
                  AutoRoute(
                    page: CustomDeliverInterventionRoute.page,
                    path: 'custom-deliver-intervention',
                  ),
                  RedirectRoute(
                    path: 'deliver-intervention',
                    redirectTo: 'custom-deliver-intervention',
                  ),
                  AutoRoute(
                    page: RefusedDeliveryRoute.page,
                    path: 'refused-delivery',
                  ),
                  AutoRoute(
                    page: SideEffectsRoute.page,
                    path: 'side-effects',
                  ),
                  AutoRoute(
                    page: ReferBeneficiaryRoute.page,
                    path: 'refer-beneficiary',
                  ),
                  AutoRoute(
                    page: DoseAdministeredRoute.page,
                    path: 'dose-administered',
                  ),
                  AutoRoute(
                    page: SplashAcknowledgementRoute.page,
                    path: 'splash-acknowledgement',
                  ),
                  AutoRoute(
                    page: ReasonForDeletionRoute.page,
                    path: 'reason-for-deletion',
                  ),
                  AutoRoute(
                    page: RecordPastDeliveryDetailsRoute.page,
                    path: 'record-past-delivery-details',
                  ),
                  AutoRoute(
                    page: HouseholdAcknowledgementRoute.page,
                    path: 'household-acknowledgement',
                  ),
                  AutoRoute(page: ChecklistViewRoute.page, path: 'view'),
                ],
              ),
            ]),

        AutoRoute(
            page: ChecklistWrapperRoute.page,
            path: 'checklist',
            children: [
              AutoRoute(
                page: ChecklistRoute.page,
                path: '',
              ),
              AutoRoute(
                  page: ChecklistBoundaryViewRoute.page, path: 'view-boundary'),
              AutoRoute(page: ChecklistViewRoute.page, path: 'view'),
              AutoRoute(page: ChecklistPreviewRoute.page, path: 'preview'),
            ]),
        AutoRoute(page: AcknowledgementRoute.page, path: 'acknowledgement'),
        AutoRoute(
          page: ComplaintsAcknowledgementRoute.page,
          path: 'complaints-acknowledgement',
        ),
        AutoRoute(
          page: ProjectFacilitySelectionRoute.page,
          path: 'select-project-facilities',
        ),

        /// Project Selection
        AutoRoute(
          page: ProjectSelectionRoute.page,
          path: 'select-project',
          initial: true,
        ),

        /// Boundary Selection
        AutoRoute(
          page: BoundarySelectionRoute.page,
          path: 'select-boundary',
        ),

        /// Complaints Inbox
        AutoRoute(
          page: ComplaintsInboxWrapperRoute.page,
          path: 'complaints-inbox',
          children: [
            AutoRoute(
              page: ComplaintsInboxRoute.page,
              path: 'complaints-inbox-items',
              initial: true,
            ),
            AutoRoute(
              page: ComplaintsInboxFilterRoute.page,
              path: 'complaints-inbox-filter',
            ),
            AutoRoute(
              page: ComplaintsInboxSearchRoute.page,
              path: 'complaints-inbox-search',
            ),
            AutoRoute(
              page: ComplaintsInboxSortRoute.page,
              path: 'complaints-inbox-sort',
            ),
            AutoRoute(
              page: ComplaintsDetailsViewRoute.page,
              path: 'complaints-inbox-view-details',
            ),
          ],
        ),

        /// Complaints registration
        AutoRoute(
          page: ComplaintsRegistrationWrapperRoute.page,
          path: 'complaints-registration',
          children: [
            AutoRoute(
              page: ComplaintTypeRoute.page,
              path: 'complaints-type',
              initial: true,
            ),
            AutoRoute(
              page: ComplaintsLocationRoute.page,
              path: 'complaints-location',
            ),
            AutoRoute(
              page: ComplaintsDetailsRoute.page,
              path: 'complaints-details',
            ),
          ],
        ),
      ],
    )
  ];
}
