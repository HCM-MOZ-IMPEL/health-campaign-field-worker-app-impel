import 'package:complaints/router/complaints_router.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:health_campaign_field_worker_app/blocs/inventory_management/custom_inventory_report.dart';
import 'package:survey_form/router/survey_form_router.gm.dart';
import 'package:survey_form/router/survey_form_router.dart';
import 'package:complaints/router/complaints_router.gm.dart';
import 'package:digit_scanner/blocs/app_localization.dart';
import 'package:inventory_management/blocs/record_stock.dart';
import 'package:inventory_management/models/entities/stock.dart';
import 'package:referral_reconciliation/router/referral_reconciliation_router.gm.dart';
import 'package:referral_reconciliation/router/referral_reconciliation_router.dart';
import 'package:attendance_management/router/attendance_router.gm.dart';
import 'package:closed_household/router/closed_household_router.dart';
import 'package:closed_household/router/closed_household_router.gm.dart';
import 'package:inventory_management/router/inventory_router.dart';
import 'package:inventory_management/router/inventory_router.gm.dart';
import 'package:registration_delivery/router/registration_delivery_router.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:digit_dss/router/dashboard_router.dart';
import 'package:digit_dss/router/dashboard_router.gm.dart';

import 'package:auto_route/auto_route.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:survey_form/router/survey_form_router.gm.dart';

import '../blocs/localization/app_localization.dart';
import '../pages/acknowledgement.dart';
import '../pages/authenticated.dart';
import '../pages/custom_digit_scanner.dart';
import '../pages/inventory_management/custom_inventory_report_details.dart';
import '../pages/inventory_management/custom_inventory_report_selection.dart';
import '../pages/inventory_management/custom_manage_stock.dart';
import '../pages/inventory_management/custom_stock_reconciliation.dart';
import '../pages/inventory_management/view_transactions_page.dart';
import '../pages/irswrapper.dart';
import '../pages/pages-Bednet/acknowledgement_bednet.dart';
import '../pages/pages-Bednet/bednetwrapper.dart';
import '../pages/pages-Bednet/custom_qr_scanner.dart';
import '../pages/pages-Bednet/home_bednet.dart';
import '../pages/pages-Bednet/beneficiary/custom_beneficiary_checklist_bednet.dart';
import '../pages/pages-Bednet/beneficiary/custom_beneficiary_details_bednet.dart';
import '../pages/pages-Bednet/beneficiary/custom_deliver_intervention_bednet.dart';
import '../pages/pages-Bednet/beneficiary/custom_delivery_summary_bednet.dart';
import '../pages/pages-Bednet/beneficiary/custom_facility_selection_bednet.dart';
import '../pages/pages-Bednet/beneficiary/custom_refer_beneficiary_bednet.dart';
import '../pages/pages-Bednet/beneficiary/custom_refused_delivery_bednet.dart';
import '../pages/pages-Bednet/beneficiary/dose_administered_verification_bednet.dart';
import '../pages/pages-Bednet/beneficiary/widgets/consent_household_acknowledgement_bednet.dart';
import '../pages/pages-Bednet/beneficiary/widgets/past_delivery_smc.dart';
import '../pages/pages-SMC/checklist/checklist_eligibility_assessment.dart';

import '../pages/pages-Bednet/beneficiary_registration/custom_beneficiary_acknowledgement_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_house_details_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_household_acknowledgement_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_household_details_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_household_location_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_household_overview_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_household_wrapper_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_individual_details_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_search_beneficiary_bednet.dart';
import '../pages/pages-Bednet/beneficiary_registration/custom_summary_page_bednet.dart';

import '../pages/pages-Bednet/closed/custom_closed_household_details_bednet.dart';
import '../pages/pages-Bednet/closed/custom_closed_household_summary_bednet.dart';

import '../pages/pages-Bednet/attendance/custom_manage_attendance_bednet.dart';
import '../pages/pages-Bednet/attendance/custom_mark_attendance_bednet.dart';
import '../pages/pages-Bednet/attendance/custom_session_select_bednet.dart';

import '../pages/inventory_management/custom_acknowledgement.dart';
import '../pages/inventory_management/custom_inventory_facility_selection.dart';
import '../pages/inventory_management/custom_min_number.dart';
import '../pages/inventory_management/custom_stock_details.dart';
import '../pages/inventory_management/custom_warehouse_details.dart';
import '../pages/inventory_management/qr_scanner.dart';
import '../pages/inventory_management/qrscanner.dart';
import '../pages/inventory_management/view_all_transactions_page.dart';
import '../pages/inventory_management/view_record_cdd.dart';
import '../pages/inventory_management/receive_stock.dart';
import '../pages/inventory_management/view_stock_records.dart';
import '../pages/pages-SMC/beneficiary/widgets/consent_household_acknowledgement.dart';
import '../pages/pages-SMC/beneficiary_registration/custom_household_acknowledgement_smc.dart';
import '../pages/pages-SMC/smcwrapper.dart';
import '../pages/boundary_selection.dart';

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
import '../pages/beneficiary_registration/custom_individual_details.dart';
import '../pages/pages-SMC/beneficiary_registration/custom_individual_details_smc.dart';
import '../pages/beneficiary_registration/custom_household_location.dart';
import 'package:registration_delivery/blocs/app_localization.dart';
import '../pages/pages-SMC/closed/custom_closed_household_details_smc.dart';
import '../pages/pages-SMC/closed/custom_closed_household_summary_smc.dart';
import '../pages/beneficiary_registration/custom_household_overview.dart';
import '../pages/beneficiary_registration/custom_search_beneficiary.dart';
import '../pages/beneficiary/custom_deliver_intervention.dart';
import '../pages/beneficiary/custom_refused_delivery.dart';
import 'package:closed_household/blocs/app_localization.dart';
import '../pages/closed/custom_closed_household_summary.dart';
import '../pages/closed/custom_closed_household_details.dart';
import '../pages/beneficiary_registration/custom_household_wrapper.dart';
import '../pages/beneficiary_registration/custom_beneficiary_acknowledgement.dart';
import '../pages/beneficiary_registration/custom_household_acknowledgement.dart';
import '../pages/beneficiary/custom_beneficiary_checklist.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import '../pages/beneficiary_registration/custom_house_details.dart';
import '../pages/beneficiary_registration/custom_household_details.dart';
import '../pages/ineligible_summary_page.dart';
import 'package:inventory_management/blocs/app_localization.dart';
import '../pages/beneficiary/custom_delivery_summary_page.dart';
// import 'package:inventory_management/blocs/inventory_report.dart';
import '../pages/attendance/custom_manage_attendance.dart';
import '../pages/attendance/custom_mark_attendance.dart';
import '../pages/attendance/custom_session_select.dart';
import 'package:attendance_management/attendance_management.dart';
import '../pages/pages-SMC/beneficiary/custom_refer_beneficiary_smc.dart';

import '../pages/pages-SMC/beneficiary_registration/custom_household_overview_smc.dart';
import '../pages/pages-SMC/beneficiary_registration/custom_search_beneficiary_smc.dart';
import '../pages/pages-SMC/beneficiary_registration/custom_beneficiary_acknowledgement_smc.dart';
import '../pages/pages-SMC/beneficiary_registration/custom_household_location_smc.dart';
import '../pages/pages-SMC/beneficiary_registration/custom_household_details_smc.dart';
import '../pages/pages-SMC/beneficiary/custom_deliver_intervention_smc.dart';
import '../pages/pages-SMC/home_smc.dart';
import '../pages/pages-SMC/beneficiary/custom_delivery_summary_smc.dart';
import '../pages/pages-SMC/beneficiary/dose_administered_verification.dart';
import '../pages/boundary_selection_view.dart';
import '../pages/pages-SMC/beneficiary/custom_beneficiary_details_smc.dart';
import '../pages/pages-SMC/beneficiary/custom_facility_selection_smc.dart';
import 'package:referral_reconciliation/blocs/app_localization.dart';

import '../pages/vehicle_tracking/vehicle_acknowledgement.dart';
import '../pages/vehicle_tracking/vehicle_overview.dart';
import '../pages/vehicle_tracking/vehicle_search.dart';
import '../pages/vehicle_tracking/vehicle_tracking_wrapper.dart';
import '../pages/vehicle_tracking/vehicle_trip_book.dart';
import '../pages/vehicle_tracking/vehicle_tracking_feedback.dart';
import '../pages/pages-SMC/referral_reconcillation/custom_hf_referral_wrapper_page.dart';
import '../pages/pages-SMC/referral_reconcillation/custom_record_facility_page.dart';
import '../pages/pages-SMC/referral_reconcillation/custom_record_referral_details.dart';
import '../pages/pages-SMC/referral_reconcillation/custom_referral_facility_selection_page.dart';
import '../pages/pages-SMC/referral_reconcillation/custom_referral_reason_checklist_page.dart';
import '../pages/pages-SMC/referral_reconcillation/custom_referral_reason_checklist_preview_page.dart';

import '../pages/pages-SMC/checklist/custom_survey_form.dart';
import '../pages/pages-SMC/checklist/custom_survey_form_acknowledgement.dart';
import '../pages/pages-SMC/checklist/custom_survey_form_boundary_view.dart';
import '../pages/pages-SMC/checklist/custom_survey_form_preview.dart';
import '../pages/pages-SMC/checklist/custom_survey_form_view.dart';
import '../pages/pages-SMC/checklist/custom_survey_form_wrapper.dart';

import 'package:referral_reconciliation/models/entities/hf_referral.dart';
import 'package:complaints/blocs/localization/app_localization.dart';
import 'package:survey_form/blocs/app_localization.dart';
import '../pages/pages-SMC/referral_reconcillation/custom_search_referral_page.dart';
import '../pages/pages-SMC/complaint/custom_complaint_type.dart';
import '../pages/pages-SMC/complaint/custom_complaints_details.dart';
import '../pages/pages-SMC/custom_dashboard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  // INFO : Need to add the router modules here
  modules: [
    RegistrationDeliveryRoute,
    InventoryRoute,
    ClosedHouseholdPackageRoute,
    DashboardRoute,
    AttendanceRoute,
    ReferralReconciliationRoute,
    SurveyFormRoute,
    ComplaintsRoute,
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

        AutoRoute(
            page: IRSWrapperRoute.page,
            path: 'irs',
            // initial: true,
            children: [
              AutoRoute(
                page: HomeRoute.page,
                path: 'home',
                initial: true,
              ),
              AutoRoute(
                  page: BoundarySelectionViewRoute.page,
                  path: 'boundary-selection-view'),
              AutoRoute(page: ProfileRoute.page, path: 'profile'),
              AutoRoute(page: UserQRDetailsRoute.page, path: 'user-qr-code'),
              AutoRoute(
                page: BeneficiariesReportRoute.page,
                path: 'beneficiary-downsync-report',
              ),

              // INFO : Need to add Router of package Here

              // Attendance Route
              AutoRoute(
                page: ManageAttendanceRoute.page,
                path: 'manage-attendance',
              ),
              AutoRoute(
                page: CustomManageAttendanceRoute.page,
                path: 'custom-manage-attendance',
              ),
              AutoRoute(
                page: AttendanceDateSessionSelectionRoute.page,
                path: 'attendance-date-session-selection',
              ),
              AutoRoute(
                page: CustomAttendanceDateSessionSelectionRoute.page,
                path: 'custom-attendance-date-session-selection',
              ),
              AutoRoute(
                page: MarkAttendanceRoute.page,
                path: 'mark-attendance',
              ),
              AutoRoute(
                page: CustomMarkAttendanceRoute.page,
                path: 'custom-mark-attendance',
              ),
              AutoRoute(
                page: AttendanceAcknowledgementRoute.page,
                path: 'attendance-acknowledgement',
              ),

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
                  page: CustomAcknowledgementRoute.page,
                  path: 'custom-acknowledgement-stock'),
              AutoRoute(
                page: ViewStockRecordsRoute.page,
                path: 'custom-stock-record-view',
              ),
              AutoRoute(
                page: RecordStockWrapperRoute.page,
                path: 'record-stock',
                children: [
                  // AutoRoute(
                  //   page: WarehouseDetailsRoute.page,
                  //   path: 'warehouse-details',
                  //   // initial: true,
                  // ),
                  AutoRoute(
                    page: CustomWarehouseDetailsRoute.page,
                    path: 'custom-warehouse-details',
                    initial: true,
                  ),
                  AutoRoute(
                    page: StockDetailsRoute.page,
                    path: 'details',
                  ),
                  AutoRoute(
                    page: CustomStockDetailsRoute.page,
                    path: 'custom-details',
                  ),
                  RedirectRoute(
                    path: 'details',
                    redirectTo: 'custom-details',
                  ),
                  AutoRoute(
                    page: ViewAllTransactionsRoute.page,
                    path: 'custom-all-transactions',
                  ),
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
                page: CustomInventoryReportDetailsRoute.page,
                path: 'custom-inventory-report-details',
              ),
              RedirectRoute(
                path: 'inventory-report-details',
                redirectTo: 'custom-inventory-report-details',
              ),
              AutoRoute(
                page: InventoryAcknowledgementRoute.page,
                path: 'inventory-acknowledgement',
              ),

              // DSS Dashboard Routes
              AutoRoute(
                page: UserDashboardRoute.page,
                path: 'dashboard',
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
                          path: 'household-details',
                        ),
                        AutoRoute(
                          page: CustomHouseHoldDetailsRoute.page,
                          path: 'custom-household-details',
                        ),
                        RedirectRoute(
                          path: 'household-details',
                          redirectTo: 'custom-household-details',
                        ),
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
                          page: CustomBeneficiaryAcknowledgementRoute.page,
                          path: 'custom-beneficiary-acknowledgement',
                        ),
                        RedirectRoute(
                          path: 'beneficiary-acknowledgement',
                          redirectTo: 'custom-beneficiary-acknowledgement',
                        ),
                        AutoRoute(
                          page: HouseDetailsRoute.page,
                          path: 'house-details',
                        ),
                        AutoRoute(
                          page: CustomHouseDetailsRoute.page,
                          path: 'custom-house-details',
                        ),
                        RedirectRoute(
                          path: 'house-details',
                          redirectTo: 'custom-house-details',
                        ),
                        AutoRoute(
                          page: SummaryRoute.page,
                          path: 'beneficiary-summary',
                        ),
                        AutoRoute(
                          page: BeneficiaryChecklistRoute.page,
                          path: 'beneficiary-checklist',
                        ),
                        AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
                        AutoRoute(
                          page: IneligibleSummaryRoute.page,
                          path: 'ineligible-beneficiary-summary',
                        ),
                        RedirectRoute(
                          path: 'beneficiary-summary',
                          redirectTo: 'ineligible-beneficiary-summary',
                        )
                      ],
                    ),
                    AutoRoute(
                      page: CustomHouseholdWrapperRoute.page,
                      path: 'household',
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
                      ],
                    ),
                    AutoRoute(
                      page: BeneficiaryWrapperRoute.page,
                      path: 'beneficiary',
                      children: [
                        AutoRoute(
                          page: BeneficiaryChecklistRoute.page,
                          path: 'beneficiary-checklist',
                        ),
                        AutoRoute(
                          page: CustomBeneficiaryChecklistRoute.page,
                          path: 'custom-beneficiary-checklist',
                          initial: true,
                        ),
                        RedirectRoute(
                          path: 'beneficiary-checklist',
                          redirectTo: 'custom-beneficiary-checklist',
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
                          page: CustomRefusedDeliveryRoute.page,
                          path: 'custom-refused-delivery',
                        ),
                        RedirectRoute(
                          path: 'refused-delivery',
                          redirectTo: 'custom-refused-delivery',
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
                        AutoRoute(
                          page: CustomHouseholdAcknowledgementRoute.page,
                          path: 'custom-household-acknowledgement',
                        ),
                        RedirectRoute(
                          path: 'household-acknowledgement',
                          redirectTo: 'custom-household-acknowledgement',
                        ),
                        AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
                        AutoRoute(
                          page: DeliverySummaryRoute.page,
                          path: 'delivery-summary',
                        ),
                        AutoRoute(
                          page: CustomDeliverySummaryRoute.page,
                          path: 'custom-delivery-summary',
                        ),
                        RedirectRoute(
                          path: 'delivery-summary',
                          redirectTo: 'custom-delivery-summary',
                        ),
                      ],
                    ),
                  ]),

              /// close household
              AutoRoute(
                  page: ClosedHouseholdWrapperRoute.page,
                  path: 'closed-household-wrapper',
                  children: [
                    AutoRoute(
                      page: ClosedHouseholdDetailsRoute.page,
                      path: 'closed-household-details',
                    ),
                    AutoRoute(
                      page: CustomClosedHouseholdDetailsRoute.page,
                      path: 'custom-closed-household-details',
                      initial: true,
                    ),
                    RedirectRoute(
                      path: 'closed-household-details',
                      redirectTo: 'custom-closed-household-details',
                    ),
                    AutoRoute(
                      page: ClosedHouseholdSummaryRoute.page,
                      path: 'closed-household-summary',
                    ),
                    AutoRoute(
                      page: CustomClosedHouseholdSummaryRoute.page,
                      path: 'custom-closed-household-summary',
                    ),
                    RedirectRoute(
                      path: 'closed-household-summary',
                      redirectTo: 'custom-closed-household-summary',
                    ),
                    AutoRoute(
                        page: ClosedHouseholdAcknowledgementRoute.page,
                        path: 'closed-household-acknowledgement'),
                  ]),

              // SurveyForm Route
              AutoRoute(
                  page: SurveyFormWrapperRoute.page,
                  path: 'surveyForm',
                  children: [
                    AutoRoute(
                      page: SurveyformRoute.page,
                      path: '',
                    ),
                    AutoRoute(
                        page: SurveyFormBoundaryViewRoute.page,
                        path: 'view-boundary'),
                    AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
                    AutoRoute(
                        page: SurveyFormPreviewRoute.page, path: 'preview'),
                    AutoRoute(
                        page: SurveyFormAcknowledgementRoute.page,
                        path: 'surveyForm-acknowledgement'),
                  ]),
              AutoRoute(
                  page: AcknowledgementRoute.page, path: 'acknowledgement'),
              AutoRoute(
                page: ComplaintsAcknowledgementRoute.page,
                path: 'complaints-acknowledgement',
              ),
              AutoRoute(
                page: ProjectFacilitySelectionRoute.page,
                path: 'select-project-facilities',
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
            ]),

        // SMC routes
        AutoRoute(page: SMCWrapperRoute.page, path: 'smc', children: [
          AutoRoute(page: HomeRoute.page, path: 'home'),
          AutoRoute(page: HomeSMCRoute.page, path: 'home-smc', initial: true),
          RedirectRoute(
            path: 'home',
            redirectTo: 'home-smc',
          ),
          AutoRoute(page: ProfileRoute.page, path: 'profile'),
          AutoRoute(page: UserQRDetailsRoute.page, path: 'user-qr-code'),
          // Inventory Routes
          AutoRoute(
            page: CustomManageStocksRoute.page,
            path: 'custom-manage-stocks',
          ),
          AutoRoute(
            page: QRScannerRoute.page,
            path: 'qr-scanner',
          ),
          AutoRoute(
            page: ReceiveStockRoute.page,
            path: 'custom-stock-view-lga',
          ),
          AutoRoute(
            page: ViewStockRecordsCDDRoute.page,
            path: 'custom-stock-view-lga',
          ),

          AutoRoute(
            page: CustomMinNumberRoute.page,
            path: 'custom-min-number',
          ),
          AutoRoute(
            page: BeneficiariesReportRoute.page,
            path: 'beneficiary-downsync-report',
          ),
          AutoRoute(
            page: ViewTransactionsRoute.page,
            path: 'beneficiary-downsync-report',
          ),

          AutoRoute(
            page: BeneficiariesReportRoute.page,
            path: 'beneficiary-downsync-report',
          ),
          AutoRoute(
              page: BoundarySelectionViewRoute.page,
              path: 'boundary-selection-view'),
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
                  page: CustomSearchBeneficiarySMCRoute.page,
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
                      path: 'individual-details',
                    ),
                    AutoRoute(
                      page: CustomIndividualDetailsSMCRoute.page,
                      path: 'custom-individual-details-smc',
                    ),
                    RedirectRoute(
                      path: 'individual-details',
                      redirectTo: 'custom-individual-details-smc',
                    ),
                    AutoRoute(
                      page: HouseHoldDetailsRoute.page,
                      path: 'household-details',
                    ),
                    AutoRoute(
                      page: CustomHouseHoldDetailsSMCRoute.page,
                      path: 'custom-household-details-smc',
                    ),
                    RedirectRoute(
                      path: 'household-details',
                      redirectTo: 'custom-household-details-smc',
                    ),
                    AutoRoute(
                      page: HouseholdLocationRoute.page,
                      path: 'household-location',
                    ),
                    AutoRoute(
                      page: CustomHouseholdLocationSMCRoute.page,
                      path: 'custom-household-location-smc',
                      initial: true,
                    ),
                    RedirectRoute(
                      path: 'household-location',
                      redirectTo: 'custom-household-location-smc',
                    ),
                    AutoRoute(
                      page: BeneficiaryAcknowledgementRoute.page,
                      path: 'beneficiary-acknowledgement',
                    ),
                    AutoRoute(
                      page: CustomBeneficiaryAcknowledgementSMCRoute.page,
                      path: 'custom-beneficiary-acknowledgement-smc',
                    ),
                    RedirectRoute(
                      path: 'beneficiary-acknowledgement',
                      redirectTo: 'custom-beneficiary-acknowledgement-smc',
                    ),
                    AutoRoute(
                      page: HouseDetailsRoute.page,
                      path: 'house-details',
                    ),
                    AutoRoute(
                      page: CustomHouseDetailsRoute.page,
                      path: 'custom-house-details',
                    ),
                    RedirectRoute(
                      path: 'house-details',
                      redirectTo: 'custom-house-details',
                    ),
                    AutoRoute(
                      page: SummaryRoute.page,
                      path: 'beneficiary-summary',
                    ),
                    AutoRoute(
                      page: BeneficiaryChecklistRoute.page,
                      path: 'beneficiary-checklist',
                    ),
                    AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
                    AutoRoute(
                      page: IneligibleSummaryRoute.page,
                      path: 'ineligible-beneficiary-summary',
                    ),
                    RedirectRoute(
                      path: 'beneficiary-summary',
                      redirectTo: 'ineligible-beneficiary-summary',
                    )
                  ],
                ),
                AutoRoute(
                  page: BeneficiaryWrapperRoute.page,
                  path: 'beneficiary',
                  children: [
                    AutoRoute(
                      page: BeneficiaryChecklistRoute.page,
                      path: 'beneficiary-checklist',
                    ),
                    AutoRoute(
                      page: HouseholdOverviewRoute.page,
                      path: 'overview',
                    ),
                    AutoRoute(
                      page: CustomHouseholdOverviewSMCRoute.page,
                      path: 'custom-overview-smc',
                      initial: true,
                    ),
                    RedirectRoute(
                      path: 'overview',
                      redirectTo: 'custom-overview',
                    ),
                    AutoRoute(
                      page: BeneficiaryDetailsRoute.page,
                      path: 'beneficiary-details',
                    ),
                    AutoRoute(
                      page: CustomBeneficiaryDetailsSMCRoute.page,
                      path: 'custom-beneficiary-details-smc',
                    ),
                    RedirectRoute(
                      path: 'beneficiary-details',
                      redirectTo: 'custom-beneficiary-details-smc',
                    ),
                    AutoRoute(
                      page: DeliverInterventionRoute.page,
                      path: 'deliver-intervention-head',
                    ),
                    AutoRoute(
                      page: DeliverInterventionRoute.page,
                      path: 'deliver-intervention',
                    ),
                    AutoRoute(
                      page: CustomDeliverInterventionSMCRoute.page,
                      path: 'custom-deliver-intervention-smc',
                    ),
                    RedirectRoute(
                      path: 'deliver-intervention',
                      redirectTo: 'custom-deliver-intervention-smc',
                    ),
                    AutoRoute(
                      page: EligibilityChecklistViewRoute.page,
                      path: 'eligibility-checklist',
                    ),
                    AutoRoute(
                      page: RefusedDeliveryRoute.page,
                      path: 'refused-delivery',
                    ),
                    AutoRoute(
                      page: CustomRefusedDeliveryRoute.page,
                      path: 'custom-refused-delivery',
                    ),
                    RedirectRoute(
                      path: 'refused-delivery',
                      redirectTo: 'custom-refused-delivery',
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
                      page: CustomReferBeneficiarySMCRoute.page,
                      path: 'refer-beneficiary-smc',
                    ),
                    AutoRoute(
                      page: CustomInventoryFacilitySelectionSMCRoute.page,
                      path: 'custom-inventory-select-facilities-smc',
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
                    AutoRoute(
                      page: CustomHouseholdAcknowledgementSMCRoute.page,
                      path: 'custom-household-acknowledgement-smc',
                    ),
                    RedirectRoute(
                      path: 'household-acknowledgement',
                      redirectTo: 'custom-household-acknowledgement-smc',
                    ),
                    AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
                    AutoRoute(
                      page: DeliverySummaryRoute.page,
                      path: 'delivery-summary',
                    ),
                    AutoRoute(
                      page: CustomDeliverySummarySMCRoute.page,
                      path: 'custom-delivery-summary-smc',
                    ),
                    RedirectRoute(
                      path: 'delivery-summary',
                      redirectTo: 'custom-delivery-summary-smc',
                    ),
                    AutoRoute(
                      page: DoseAdministeredVerificationRoute.page,
                      path: 'dose-administered-verification',
                    ),
                  ],
                ),
              ]),

          // vehicle Tracking module
          AutoRoute(
              page: VehicleTrackingWrapperRoute.page,
              path: 'vehicle-tracking',
              children: [
                AutoRoute(
                  page: VehicleSearchRoute.page,
                  path: 'vehicle-search',
                  initial: true,
                ),
                AutoRoute(
                  page: VehicleOverviewRoute.page,
                  path: 'vehicle-overview',
                ),
                AutoRoute(
                  page: VehicleTripBookRoute.page,
                  path: 'vehicle-trip-book',
                ),
                AutoRoute(
                  page: VehicleTripFeedbackRoute.page,
                  path: 'vehicle-trip-feedback',
                ),
                AutoRoute(
                  page: VehicleAcknowledgementRoute.page,
                  path: 'vehicle-acknowledgement',
                )
              ]),

          // Attendance Route
          AutoRoute(
            page: ManageAttendanceRoute.page,
            path: 'manage-attendance',
          ),
          AutoRoute(
            page: CustomManageAttendanceRoute.page,
            path: 'custom-manage-attendance',
          ),
          AutoRoute(
            page: AttendanceDateSessionSelectionRoute.page,
            path: 'attendance-date-session-selection',
          ),
          AutoRoute(
            page: CustomAttendanceDateSessionSelectionRoute.page,
            path: 'custom-attendance-date-session-selection',
          ),
          AutoRoute(
            page: MarkAttendanceRoute.page,
            path: 'mark-attendance',
          ),
          AutoRoute(
            page: CustomMarkAttendanceRoute.page,
            path: 'custom-mark-attendance',
          ),
          AutoRoute(
            page: AttendanceAcknowledgementRoute.page,
            path: 'attendance-acknowledgement',
          ),

          // Inventory Route
          AutoRoute(
            page: ManageStocksRoute.page,
            path: 'manage-stocks',
          ),
          RedirectRoute(
            path: 'manage-stocks',
            redirectTo: 'custom-manage-stocks',
          ),
          AutoRoute(
              page: CustomAcknowledgementRoute.page,
              path: 'custom-acknowledgement-stock'),
          AutoRoute(
            page: ViewStockRecordsRoute.page,
            path: 'custom-stock-record-view',
          ),
          AutoRoute(
            page: RecordStockWrapperRoute.page,
            path: 'record-stock',
            children: [
              AutoRoute(
                page: CustomWarehouseDetailsRoute.page,
                path: 'warehouse-details',
                initial: true,
              ),
              AutoRoute(
                page: StockDetailsRoute.page,
                path: 'details',
              ),
              AutoRoute(
                page: CustomStockDetailsRoute.page,
                path: 'custom-details-bednet',
              ),
              RedirectRoute(
                path: 'details',
                redirectTo: 'custom-details',
              ),
              AutoRoute(
                page: ViewAllTransactionsRoute.page,
                path: 'custom-all-transactions',
              ),
            ],
          ),
          AutoRoute(
            page: InventoryFacilitySelectionRoute.page,
            path: 'inventory-select-facilities',
          ),
          AutoRoute(
            page: CustomInventoryFacilitySelectionRoute.page,
            path: 'custom-inventory-select-facilities',
          ),
          RedirectRoute(
            path: 'inventory-select-facilities',
            redirectTo: 'custom-inventory-select-facilities',
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
            page: CustomInventoryReportDetailsRoute.page,
            path: 'custom-inventory-report-details',
          ),
          RedirectRoute(
            path: 'inventory-report-details',
            redirectTo: 'custom-inventory-report-details',
          ),
          AutoRoute(
            page: InventoryAcknowledgementRoute.page,
            path: 'inventory-acknowledgement',
          ),

          /// close household
          AutoRoute(
              page: ClosedHouseholdWrapperRoute.page,
              path: 'closed-household-wrapper',
              children: [
                AutoRoute(
                  page: ClosedHouseholdDetailsRoute.page,
                  path: 'closed-household-details',
                ),
                AutoRoute(
                  page: CustomClosedHouseholdDetailsSMCRoute.page,
                  path: 'custom-closed-household-details-smc',
                  initial: true,
                ),
                RedirectRoute(
                  path: 'closed-household-details',
                  redirectTo: 'custom-closed-household-details-smc',
                ),
                AutoRoute(
                  page: CustomClosedHouseholdSummarySMCRoute.page,
                  path: 'custom-closed-household-summary-smc',
                ),
                AutoRoute(
                    page: ClosedHouseholdAcknowledgementRoute.page,
                    path: 'closed-household-acknowledgement'),
              ]),

          // DSS Dashboard Routes
          AutoRoute(
            page: UserDashboardRoute.page,
            path: 'dashboard',
          ),
          AutoRoute(
            page: CustomUserDashboardRoute.page,
            path: 'custom-dashboard',
          ),
          RedirectRoute(
            path: 'dashboard',
            redirectTo: 'custom-dashboard',
          ),

          // SurveyForm Route
          AutoRoute(
              page: CustomSurveyFormWrapperRoute.page,
              path: 'custom-surveyForm',
              children: [
                AutoRoute(
                  page: CustomSurveyformRoute.page,
                  path: '',
                ),
                AutoRoute(
                    page: CustomSurveyFormBoundaryViewRoute.page,
                    path: 'custom-view-boundary'),
                AutoRoute(
                    page: CustomSurveyFormViewRoute.page, path: 'custom-view'),
                AutoRoute(
                    page: CustomSurveyFormPreviewRoute.page,
                    path: 'custom-preview'),
                AutoRoute(
                    page: CustomSurveyFormAcknowledgementRoute.page,
                    path: 'custom-surveyForm-acknowledgement'),
              ]),
          // AutoRoute(
          //     page: SurveyFormWrapperRoute.page,
          //     path: 'surveyForm',
          //     children: [
          //       AutoRoute(
          //         page: SurveyformRoute.page,
          //         path: '',
          //       ),
          //       AutoRoute(
          //           page: SurveyFormBoundaryViewRoute.page,
          //           path: 'view-boundary'),
          //       AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
          //       AutoRoute(page: SurveyFormPreviewRoute.page, path: 'preview'),
          //       AutoRoute(
          //           page: SurveyFormAcknowledgementRoute.page,
          //           path: 'surveyForm-acknowledgement'),
          //     ]),
          AutoRoute(page: AcknowledgementRoute.page, path: 'acknowledgement'),
          AutoRoute(
            page: ComplaintsAcknowledgementRoute.page,
            path: 'complaints-acknowledgement',
          ),
          AutoRoute(
            page: ProjectFacilitySelectionRoute.page,
            path: 'select-project-facilities',
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
              // AutoRoute(
              //   page: ComplaintTypeRoute.page,
              //   path: 'complaints-type',
              //   initial: true,
              // ),
              AutoRoute(
                page: CustomComplaintTypeRoute.page,
                path: 'custom-complaints-type',
                initial: true,
              ),
              // RedirectRoute(
              //   path: 'complaints-type',
              //   redirectTo: 'custom-complaints-type',
              // ),
              AutoRoute(
                page: ComplaintsLocationRoute.page,
                path: 'complaints-location',
              ),
              AutoRoute(
                page: ComplaintsDetailsRoute.page,
                path: 'complaints-details',
              ),
              AutoRoute(
                page: CustomComplaintsDetailsRoute.page,
                path: 'custom-complaints-details',
              ),
              RedirectRoute(
                path: 'complaints-details',
                redirectTo: 'custom-complaints-details',
              ),
            ],
          ),

          // Referral Reconciliation Route

          AutoRoute(
              page: CustomSearchReferralReconciliationsRoute.page,
              path: 'custom-search-referrals'),
          // Referral Reconciliation Route
          AutoRoute(
              page: CustomHFCreateReferralWrapperRoute.page,
              path: 'hf-referral',
              children: [
                AutoRoute(
                    page: ReferralFacilityRoute.page, path: 'facility-details'),
                AutoRoute(
                    page: CustomReferralFacilityRoute.page,
                    path: 'custom-facility-details',
                    initial: true),
                RedirectRoute(
                    path: 'facility-details',
                    redirectTo: 'custom-facility-details'),
                AutoRoute(
                    page: RecordReferralDetailsRoute.page,
                    path: 'referral-details'),
                AutoRoute(
                    page: CustomRecordReferralDetailsRoute.page,
                    path: 'custom-referral-details'),
                RedirectRoute(
                    path: 'referral-details',
                    redirectTo: 'custom-referral-details'),
                AutoRoute(
                  page: ReferralReasonChecklistRoute.page,
                  path: 'referral-checklist-create',
                ),
                AutoRoute(
                  page: CustomReferralReasonChecklistRoute.page,
                  path: 'custom-referral-checklist-create',
                ),
                RedirectRoute(
                    path: 'referral-checklist-create',
                    redirectTo: 'custom-referral-checklist-create'),
                AutoRoute(
                  page: ReferralReasonChecklistPreviewRoute.page,
                  path: 'referral-checklist-view',
                ),
                AutoRoute(
                  page: CustomReferralReasonChecklistPreviewRoute.page,
                  path: 'custom-referral-checklist-view',
                ),
                RedirectRoute(
                    path: 'referral-checklist-view',
                    redirectTo: 'custom-referral-checklist-view'),
              ]),
          AutoRoute(
            page: ReferralReconAcknowledgementRoute.page,
            path: 'referral-acknowledgement',
          ),
          AutoRoute(
            page: ReferralReconProjectFacilitySelectionRoute.page,
            path: 'referral-project-facility',
          ),
          AutoRoute(
            page: SearchReferralReconciliationsRoute.page,
            path: 'search-referrals',
          ),
          //   AutoRoute(
          //       page: HFCreateReferralWrapperRoute.page,
          //       path: 'hf-referral',
          //       children: [
          //         AutoRoute(
          //           page: ReferralFacilityRoute.page,
          //           path: 'facility-details',
          //           initial: true,
          //         ),
          //         AutoRoute(
          //           page: CustomReferralFacilitySMCRoute.page,
          //           path: 'custom-facility-details-smc',
          //           initial: true,
          //         ),
          //         RedirectRoute(
          //           path: 'facility-details',
          //           redirectTo: 'custom-facility-details-smc',
          //         ),
          //         AutoRoute(
          //             page: RecordReferralDetailsRoute.page,
          //             path: 'referral-details'),
          //         AutoRoute(
          //           page: CustomRecordReferralDetailsSMCRoute.page,
          //           path: 'custom-referral-details-smc',
          //         ),
          //         RedirectRoute(
          //           path: 'referral-details',
          //           redirectTo: 'custom-referral-details-smc',
          //         ),
          //         AutoRoute(
          //           page: ReferralReasonChecklistRoute.page,
          //           path: 'referral-checklist-create',
          //         ),
          //         AutoRoute(
          //           page: CustomReferralReasonChecklistSMCRoute.page,
          //           path: 'custom-referral-checklist-create-smc',
          //         ),
          //         RedirectRoute(
          //           path: 'referral-checklist-create',
          //           redirectTo: 'custom-referral-checklist-create-smc',
          //         ),
          //         AutoRoute(
          //           page: ReferralReasonChecklistPreviewRoute.page,
          //           path: 'referral-checklist-view',
          //         ),
          //       ]),
          //   AutoRoute(
          //     page: ReferralReconAcknowledgementRoute.page,
          //     path: 'referral-acknowledgement',
          //   ),
          //   AutoRoute(
          //     page: ReferralReconProjectFacilitySelectionRoute.page,
          //     path: 'referral-project-facility',
          //   ),
          //   AutoRoute(
          //     page: ReferralReconProjectFacilitySelectionSMCRoute.page,
          //     path: 'referral-project-facility-smc',
          //   ),
          //   AutoRoute(
          //     page: SearchReferralReconciliationsRoute.page,
          //     path: 'search-referrals',
          //   ),
          //   AutoRoute(
          //       page: CustomSearchReferralReconciliationsSMCRoute.page,
          //       path: 'custom-search-referrals'),
          //   RedirectRoute(
          //       path: 'search-referrals', redirectTo: 'custom-search-referrals')
        ]),

        // Bednet routes
        AutoRoute(page: BednetWrapperRoute.page, path: 'bednet', children: [
          AutoRoute(page: HomeRoute.page, path: 'home'),
          AutoRoute(
              page: HomeBednetRoute.page, path: 'home-bednet', initial: true),
          RedirectRoute(
            path: 'home',
            redirectTo: 'home-bednet',
          ),
          AutoRoute(
              page: BoundarySelectionViewRoute.page,
              path: 'boundary-selection-view'),
          AutoRoute(page: ProfileRoute.page, path: 'profile'),
          AutoRoute(page: UserQRDetailsRoute.page, path: 'user-qr-code'),
          // Inventory Routes
          AutoRoute(
            page: CustomManageStocksRoute.page,
            path: 'custom-manage-stocks',
          ),
          AutoRoute(
            page: QRScannerRoute.page,
            path: 'qr-scanner',
          ),
          AutoRoute(
            page: ReceiveStockRoute.page,
            path: 'custom-stock-view-lga',
          ),
          AutoRoute(
            page: ViewStockRecordsCDDRoute.page,
            path: 'custom-stock-view-lga',
          ),

          AutoRoute(
            page: CustomMinNumberRoute.page,
            path: 'custom-min-number',
          ),
          AutoRoute(
            page: BeneficiariesReportRoute.page,
            path: 'beneficiary-downsync-report',
          ),
          AutoRoute(
            page: ViewTransactionsRoute.page,
            path: 'beneficiary-downsync-report',
          ),

          AutoRoute(
            page: BeneficiariesReportRoute.page,
            path: 'beneficiary-downsync-report',
          ),

          // vehicle Tracking module
          AutoRoute(
              page: VehicleTrackingWrapperRoute.page,
              path: 'vehicle-tracking',
              children: [
                AutoRoute(
                  page: VehicleSearchRoute.page,
                  path: 'vehicle-search',
                  initial: true,
                ),
                AutoRoute(
                  page: VehicleOverviewRoute.page,
                  path: 'vehicle-overview',
                ),
                AutoRoute(
                  page: VehicleTripBookRoute.page,
                  path: 'vehicle-trip-book',
                ),
                AutoRoute(
                  page: VehicleTripFeedbackRoute.page,
                  path: 'vehicle-trip-feedback',
                ),
                AutoRoute(
                  page: VehicleAcknowledgementRoute.page,
                  path: 'vehicle-acknowledgement',
                )
              ]),

          // registration delivery
          AutoRoute(
            page: CustomInventoryFacilitySelectionRoute.page,
            path: 'custom-inventory-select-facilities',
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
                  page: CustomSearchBeneficiaryBednetRoute.page,
                  path: 'custom-search-beneficiary-bednet',
                ),
                RedirectRoute(
                  path: 'search-beneficiary',
                  redirectTo: 'custom-search-beneficiary-bednet',
                ),

                AutoRoute(
                  page: FacilitySelectionRoute.page,
                  path: 'select-facilities',
                ),

                // Attendance Route
                AutoRoute(
                  page: ManageAttendanceRoute.page,
                  path: 'manage-attendance',
                ),
                AutoRoute(
                  page: CustomManageAttendanceBednetRoute.page,
                  path: 'custom-manage-attendance-bednet',
                ),
                RedirectRoute(
                    path: 'manage-attendance',
                    redirectTo: 'custom-manage-attendance-bednet'),
                AutoRoute(
                  page: AttendanceDateSessionSelectionRoute.page,
                  path: 'attendance-date-session-selection',
                ),
                AutoRoute(
                  page: CustomAttendanceDateSessionSelectionRoute.page,
                  path: 'custom-attendance-date-session-selection',
                ),
                AutoRoute(
                  page: CustomAttendanceDateSessionSelectionBednetRoute.page,
                  path: 'custom-attendance-date-session-selection-bednet',
                ),
                AutoRoute(
                  page: MarkAttendanceRoute.page,
                  path: 'mark-attendance',
                ),
                AutoRoute(
                  page: CustomMarkAttendanceBednetRoute.page,
                  path: 'custom-mark-attendance-bednet',
                ),
                AutoRoute(
                  page: AttendanceAcknowledgementRoute.page,
                  path: 'attendance-acknowledgement',
                ),

                //       /// Beneficiary Registration
                AutoRoute(
                  page: BeneficiaryRegistrationWrapperRoute.page,
                  path: 'beneficiary-registration',
                  children: [
                    AutoRoute(
                      page: IndividualDetailsRoute.page,
                      path: 'individual-details',
                    ),
                    AutoRoute(
                      page: CustomIndividualDetailsBednetRoute.page,
                      path: 'custom-individual-details-bednet',
                    ),
                    RedirectRoute(
                      path: 'individual-details',
                      redirectTo: 'custom-individual-details-bednet',
                    ),
                    AutoRoute(
                      page: CustomHouseHoldDetailsRoute.page,
                      path: 'custom-household-details',
                    ),
                    AutoRoute(
                      page: CustomHouseHoldDetailsBednetRoute.page,
                      path: 'custom-household-details-bednet',
                    ),
                    RedirectRoute(
                      path: 'custom-household-details',
                      redirectTo: 'custom-household-details-bednet',
                    ),
                    AutoRoute(
                      page: HouseholdLocationRoute.page,
                      path: 'household-location',
                    ),
                    AutoRoute(
                      page: CustomHouseholdLocationBednetRoute.page,
                      path: 'custom-household-location-bednet',
                      initial: true,
                    ),
                    RedirectRoute(
                      path: 'household-location',
                      redirectTo: 'custom-household-location-bednet',
                    ),
                    AutoRoute(
                      page: BeneficiaryAcknowledgementRoute.page,
                      path: 'beneficiary-acknowledgement',
                    ),
                    AutoRoute(
                      page: CustomBeneficiaryAcknowledgementBednetRoute.page,
                      path: 'custom-beneficiary-acknowledgement-bednet',
                    ),
                    RedirectRoute(
                      path: 'beneficiary-acknowledgement',
                      redirectTo: 'custom-beneficiary-acknowledgement-bednet',
                    ),
                    AutoRoute(
                      page: HouseDetailsRoute.page,
                      path: 'house-details',
                    ),
                    AutoRoute(
                      page: CustomHouseDetailsBednetRoute.page,
                      path: 'custom-house-details-bednet',
                    ),
                    RedirectRoute(
                      path: 'house-details',
                      redirectTo: 'custom-house-details-bednet',
                    ),
                    AutoRoute(
                      page: SummaryRoute.page,
                      path: 'beneficiary-summary',
                    ),
                    AutoRoute(
                      page: CustomBednetSummaryRoute.page,
                      path: 'custom-bednet-beneficiary-summary',
                    ),
                    RedirectRoute(
                      path: 'beneficiary-summary',
                      redirectTo: 'custom-bednet-beneficiary-summary',
                    ),
                    AutoRoute(
                      page: BeneficiaryChecklistRoute.page,
                      path: 'beneficiary-checklist',
                    ),
                    AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
                    AutoRoute(
                      page: IneligibleSummaryRoute.page,
                      path: 'ineligible-beneficiary-summary',
                    ),
                    RedirectRoute(
                      path: 'beneficiary-summary',
                      redirectTo: 'ineligible-beneficiary-summary',
                    )
                  ],
                ),
                AutoRoute(
                  page: CustomHouseholdWrapperRoute.page,
                  path: 'household',
                  children: [
                    AutoRoute(
                      page: HouseholdOverviewRoute.page,
                      path: 'overview',
                    ),
                    AutoRoute(
                      page: CustomHouseholdOverviewBednetRoute.page,
                      path: 'custom-overview-bednet',
                      initial: true,
                    ),
                    RedirectRoute(
                      path: 'overview',
                      redirectTo: 'custom-overview-bednet',
                    ),
                  ],
                ),
                AutoRoute(
                  page: BeneficiaryWrapperRoute.page,
                  path: 'beneficiary',
                  children: [
                    AutoRoute(
                      page: BeneficiaryDetailsRoute.page,
                      path: 'beneficiary-details',
                    ),
                    AutoRoute(
                      page: CustomBeneficiaryDetailsBednetRoute.page,
                      path: 'custom-beneficiary-details-bednet',
                      // initial: true,
                    ),
                    RedirectRoute(
                      path: 'beneficiary-details',
                      redirectTo: 'custom-beneficiary-details-bednet',
                    ),
                    AutoRoute(
                      page: DeliverInterventionRoute.page,
                      path: 'deliver-intervention',
                    ),
                    AutoRoute(
                      page: CustomDeliverInterventionBednetRoute.page,
                      path: 'custom-deliver-intervention-bednet',
                      initial: true,
                    ),
                    RedirectRoute(
                      path: 'deliver-intervention',
                      redirectTo: 'custom-deliver-intervention-bednet',
                    ),
                    // AutoRoute(
                    //   page: EligibilityChecklistViewRoute.page,
                    //   path: 'eligibility-checklist',
                    // ),
                    AutoRoute(
                      page: RefusedDeliveryRoute.page,
                      path: 'refused-delivery',
                    ),
                    AutoRoute(
                      page: CustomRefusedDeliveryBednetRoute.page,
                      path: 'custom-refused-delivery-bednet',
                    ),
                    RedirectRoute(
                      path: 'refused-delivery',
                      redirectTo: 'custom-refused-delivery-bednet',
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
                      page: CustomReferBeneficiaryBednetRoute.page,
                      path: 'refer-beneficiary-bednet',
                    ),
                    AutoRoute(
                      page: CustomInventoryFacilitySelectionBednetRoute.page,
                      path: 'custom-inventory-select-facilities-bednet',
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
                    AutoRoute(
                      page: CustomHouseholdAcknowledgementBednetRoute.page,
                      path: 'custom-household-acknowledgement-bednet',
                    ),
                    RedirectRoute(
                      path: 'household-acknowledgement',
                      redirectTo: 'custom-household-acknowledgement-bednet',
                    ),
                    AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
                    AutoRoute(
                      page: DeliverySummaryRoute.page,
                      path: 'delivery-summary',
                    ),
                    AutoRoute(
                      page: CustomDeliverySummaryBednetRoute.page,
                      path: 'custom-delivery-summary-bednet',
                    ),
                    RedirectRoute(
                      path: 'delivery-summary',
                      redirectTo: 'custom-delivery-summary-bednet',
                    ),
                    AutoRoute(
                      page: DoseAdministeredVerificationRoute.page,
                      path: 'dose-administered-verification',
                    ),
                  ],
                ),
              ]),

          /// close household
          AutoRoute(
              page: ClosedHouseholdWrapperRoute.page,
              path: 'closed-household-wrapper',
              children: [
                AutoRoute(
                  page: ClosedHouseholdDetailsRoute.page,
                  path: 'closed-household-details',
                ),
                AutoRoute(
                  page: CustomClosedHouseholdDetailsBednetRoute.page,
                  path: 'custom-closed-household-details-bednet',
                  initial: true,
                ),
                RedirectRoute(
                  path: 'closed-household-details',
                  redirectTo: 'custom-closed-household-details-bednet',
                ),
                AutoRoute(
                  page: CustomClosedHouseholdSummaryBednetRoute.page,
                  path: 'custom-closed-household-summary-bednet',
                ),
                AutoRoute(
                    page: ClosedHouseholdAcknowledgementRoute.page,
                    path: 'closed-household-acknowledgement'),
              ]),
          // Inventory Route
          AutoRoute(
            page: ManageStocksRoute.page,
            path: 'manage-stocks',
          ),
          RedirectRoute(
            path: 'manage-stocks',
            redirectTo: 'custom-manage-stocks-bednet',
          ),
          AutoRoute(
              page: CustomAcknowledgementRoute.page,
              path: 'custom-acknowledgement-stock'),
          AutoRoute(
            page: ViewStockRecordsRoute.page,
            path: 'custom-stock-record-view',
          ),
          AutoRoute(
            page: RecordStockWrapperRoute.page,
            path: 'record-stock',
            children: [
              AutoRoute(
                page: CustomWarehouseDetailsRoute.page,
                path: 'custom-warehouse-details-bednet',
                initial: true,
              ),
              AutoRoute(
                page: StockDetailsRoute.page,
                path: 'details',
              ),
              AutoRoute(
                page: CustomStockDetailsRoute.page,
                path: 'custom-details-bednet',
              ),
              RedirectRoute(
                path: 'details',
                redirectTo: 'custom-details-bednet',
              ),
              AutoRoute(
                page: ViewAllTransactionsRoute.page,
                path: 'custom-all-transactions',
              ),
            ],
          ),
          AutoRoute(
            page: InventoryFacilitySelectionRoute.page,
            path: 'inventory-select-facilities',
          ),
          AutoRoute(
            page: CustomInventoryFacilitySelectionBednetRoute.page,
            path: 'custom-inventory-select-facilities-bednet',
          ),
          AutoRoute(
            page: StockReconciliationRoute.page,
            path: 'stock-reconciliation',
          ),
          AutoRoute(
            page: CustomStockReconciliationRoute.page,
            path: 'custom-stock-reconciliation-bednet',
          ),
          RedirectRoute(
            path: 'stock-reconciliation',
            redirectTo: 'custom-stock-reconciliation-bednet',
          ),
          AutoRoute(
            page: InventoryReportSelectionRoute.page,
            path: 'inventory-report-selection',
          ),
          AutoRoute(
            page: CustomInventoryReportSelectionRoute.page,
            path: 'custom-inventory-report-selection-bednet',
          ),
          RedirectRoute(
            path: 'inventory-report-selection',
            redirectTo: 'custom-inventory-report-selection-bednet',
          ),
          AutoRoute(
            page: InventoryReportDetailsRoute.page,
            path: 'inventory-report-details',
          ),
          AutoRoute(
            page: CustomInventoryReportDetailsRoute.page,
            path: 'custom-inventory-report-details-bednet',
          ),
          RedirectRoute(
            path: 'inventory-report-details',
            redirectTo: 'custom-inventory-report-details-bednet',
          ),
          AutoRoute(
            page: InventoryAcknowledgementRoute.page,
            path: 'inventory-acknowledgement',
          ),

          // SurveyForm Route
          AutoRoute(
              page: SurveyFormWrapperRoute.page,
              path: 'surveyForm',
              children: [
                AutoRoute(
                  page: SurveyformRoute.page,
                  path: '',
                ),
                AutoRoute(
                    page: SurveyFormBoundaryViewRoute.page,
                    path: 'view-boundary'),
                AutoRoute(page: SurveyFormViewRoute.page, path: 'view'),
                AutoRoute(page: SurveyFormPreviewRoute.page, path: 'preview'),
                AutoRoute(
                    page: SurveyFormAcknowledgementRoute.page,
                    path: 'surveyForm-acknowledgement'),
              ]),

          AutoRoute(page: AcknowledgementRoute.page, path: 'acknowledgement'),
          AutoRoute(
            page: ComplaintsAcknowledgementRoute.page,
            path: 'complaints-acknowledgement',
          ),

          // DSS Dashboard Routes
          AutoRoute(
            page: UserDashboardRoute.page,
            path: 'dashboard',
          ),
          // AutoRoute(
          //   page: CustomUserDashboardBednetRoute.page,
          //   path: 'custom-dashboard-bedent',
          // ),
          RedirectRoute(
            path: 'dashboard',
            redirectTo: 'custom-dashboard-bedent',
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
        ]),
      ],
    ),
  ];
}
