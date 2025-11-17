library i18;

import 'package:referral_reconciliation/utils/i18_key_constants.dart';

const common = Common();
const householdDetails = HouseholdDetails();
const login = Login();
const forgotPassword = ForgotPassword();
const home = Home();
const dataShare = DataShare();
const acknowledgementSuccess = AcknowledgementSuccess();
const adverseEvents = AdverseEvents();
const projectSelection = ProjectSelection();
const checklist = Checklist();
const complaints = Complaints();
const syncDialog = SyncDialog();
const homeShowcase = HomeShowcase();
const privacyPolicy = PrivacyPolicy();
const dashBoard = Dashboard();
const deliverIntervention = DeliverIntervention();

const vehicleTracking = VehicleTracking();

const householdLocationShowcase = HouseholdLocationShowcase();
const householdLocation = HouseholdLocation();
const searchBeneficiary = SearchBeneficiary();
const individualDetails = IndividualDetails();
const beneficiaryDetails = BeneficiaryDetails();
const stockDetails = StockDetails();
const stockReconciliationDetails = StockReconciliationDetails();
const inventoryReportDetails = InventoryReportDetails();

const selectStockShowcase = SelectStockShowcase();
const warehouseDetailsShowcase = WarehouseDetailsShowcase();
const stockDetailsReceiptShowcase = StockDetailsReceiptShowcase();
const stockDetailsIssuedShowcase = StockDetailsIssuedShowcase();
const selectChecklistShowcase = SelectChecklistShowcase();
const selectSurveyFormShowcase = SelectSurveyFormShowcase();
const stockDetailsReturnedShowcase = StockDetailsReturnedShowcase();
const stockReconciliationShowcase = StockReconciliationShowcase();

const surveyFormDataShowcase = SurveyFormDataShowcase();
const surveyFormListShowcase = SurveyFormListShowcase();
const checklistDataShowcase = ChecklistDataShowcase();
const checklistListShowcase = ChecklistListShowcase();
const complaintTypeShowcase = ComplaintTypeShowcase();
const complaintsDetailsShowcase = ComplaintsDetailsShowcase();
const complaintsDetailsViewShowcase = ComplaintsDetailsViewShowcase();
const complaintsInboxShowcase = ComplaintsInboxShowcase();

const attendance = Attendance();

const referralReconciliation = ReferralReconciliation();

class Common {
  const Common();
  String get coreCommonGoHome => 'CORE_COMMON_GO_HOME';

  String get coreCommonAttention => 'CORE_COMMON_ATTENTION';
  String get coreCommonComment => 'CORE_COMMON_COMMENT';

  String get coreCommonContinue => 'CORE_COMMON_CONTINUE';
  String get coreCommonWarning => 'CORE_COMMON_WARNING';

  String get dataDownloadInProgress => 'DATA_DOWNLOAD_IN_PROGRESS';
  String get unableToCheckDataInServer => 'FAILED_TO_CHECK_DATA_IN_SERVER';

  String get coreCommonAge => 'CORE_COMMON_AGE';

  String get coreCommonName => 'CORE_COMMON_NAME';

  String get coreCommonEmailId => 'CORE_COMMON_EMAIL_ID';

  String get coreCommonGender => 'CORE_COMMON_GENDER';

  String get coreCommonMobileNumber => 'CORE_COMMON_MOBILE_NUMBER';

  String get coreCommonSubmit => 'CORE_COMMON_SUBMIT';

  String get coreCommonSave => 'CORE_COMMON_SAVE';

  String get coreCommonCancel => 'CORE_COMMON_CANCEL';

  String get corecommonRequired => 'CORE_COMMON_REQUIRED';

  String get coreCommonOthersRequired => 'CORE_COMMON_OTHERS_REQUIRED';

  String get coreCommonReasonRequired => 'CORE_COMMON_REASON_REQUIRED';

  String get corecommonclose => 'CORE_COMMON_CLOSE';

  String get coreCommonOk => 'CORE_COMMON_OK';

  String get coreCommonNA => 'CORE_COMMON_NA';

  String get coreCommonProfile => 'CORE_COMMON_PROFILE';

  String get coreCommonLogout => 'CORE_COMMON_LOGOUT';

  String get coreCommonBack => 'CORE_COMMON_BACK';

  String get coreCommonHelp => 'CORE_COMMON_HELP';

  String get coreCommonHome => 'CORE_COMMON_HOME';

  String get coreCommonViewDownloadedData => 'CORE_COMMON_VIEW_DOWNLOADED_DATA';

  String get coreCommonlanguage => 'CORE_COMMON_LANGUAGE';

  String get coreCommonSyncProgress => 'CORE_COMMON_SYNC_PROGRESS';

  String get coreCommonDataSynced => 'CORE_COMMON_DATA_SYNCED';

  String get coreCommonDataSyncFailed => 'CORE_COMMON_DATA_SYNC_FAILED';

  String get coreCommonDataSyncRetry => 'CORE_COMMON_DATA_SYNC_RETRY';

  String get connectionLabel => 'CORE_COMMON_CONNECTION_LABEL';

  String get connectionContent => 'CORE_COMMON_CONNECTION_CONTENT';

  String get coreCommonSkip => 'CORE_COMMON_SKIP';

  String get coreCommonNext => 'CORE_COMMON_NEXT';

  String get coreCommonYes => 'CORE_COMMON_YES';

  String get coreCommonNo => 'CORE_COMMON_NO';
  String get coreCommonGoback => 'CORE_COMMON_GO_BACK';

  String get coreCommonRequiredItems => 'CORE_COMMON_REQUIRED_ITEMS';

  String get min2CharsRequired => 'MIN_2_CHARS_REQUIRED';

  String get min3CharsRequired => 'MIN_3_CHARS_REQUIRED';

  String get maxCharsRequired => 'MAX_CHARS_ALLOWED';
  String get maxCharsRequiredValidation => 'MAX_CHARS_ALLOWED_VALIDATION';
  String get minCharsRequiredValidation => 'MIN_CHARS_ALLOWED_VALIDATION';

  String get maxValue => 'MAX_VALUE_ALLOWED';
  String get minValue => 'MIN_VALUE_ALLOWED';

  String get noResultsFound => 'NO_RESULTS_FOUND';

  String get coreCommonSyncInProgress => 'CORE_COMMON_SYNC_IN_PROGRESS';

  String get facilitySearchHeaderLabel => 'FACILITY_SEARCH_HEADER_LABEL';
  String get projectFacilitySearchHeaderLabel =>
      'PROJECT_FACILITY_SEARCH_HEADER_LABEL';

  String get coreCommonDownload => 'CORE_COMMON_DOWNLOAD';

  String get coreCommonDownloadFailed => 'CORE_COMMON_DOWNLOAD_FAILED';

  String get noMatchFound => 'CORE_COMMON_NO_MATCH_FOUND';

  String get scanBales => 'CORE_COMMON_SCAN_BALES';
  String get ageInMonths => 'AGE_IN_MONTHS_LABEL';
  String get metersLabel => 'CORE_COMMON_METERS';

  String get locationCapturing => 'CAPTURING_LOCATION';
}

class HomeShowcase {
  const HomeShowcase();

  String get distributorProgressBar {
    return 'DISTRIBUTOR_HOME_SHOWCASE_PROGRESS_BAR';
  }

  String get distributorBeneficiaries {
    return 'DISTRIBUTOR_HOME_SHOWCASE_BENEFICIARIES';
  }

  String get distributorFileComplaint {
    return 'DISTRIBUTOR_HOME_SHOWCASE_FILE_COMPLAINT';
  }

  String get beneficiaryReferral {
    return 'HF_HOME_SHOWCASE_BENEFICIARY_LABEL';
  }

  String get manageAttendance {
    return 'HF_HOME_SHOWCASE_MANAGE_ATTENDANCE';
  }

  String get distributorSyncData {
    return 'DISTRIBUTOR_HOME_SHOWCASE_SYNC_DATA';
  }

  String get warehouseManagerManageStock {
    return 'WAREHOUSE_MANAGER_HOME_SHOWCASE_MANAGE_STOCK';
  }

  String get wareHouseManagerStockReconciliation {
    return 'WAREHOUSE_MANAGER_HOME_SHOWCASE_STOCK_RECONCILIATION';
  }

  String get warehouseManagerFileComplaint {
    return 'WAREHOUSE_MANAGER_HOME_SHOWCASE_FILE_COMPLAINT';
  }

  String get warehouseManagerSyncData {
    return 'WAREHOUSE_MANAGER_HOME_SHOWCASE_SYNC_DATA';
  }

  String get supervisorProgressBar {
    return 'SUPERVISOR_HOME_SHOWCASE_PROGRESS_BAR';
  }

  String get supervisorMyChecklist {
    return 'SUPERVISOR_HOME_SHOWCASE_MY_CHECKLIST';
  }

  String get supervisorComplaints {
    return 'SUPERVISOR_HOME_SHOWCASE_COMPLAINTS';
  }

  String get supervisorSyncData {
    return 'SUPERVISOR_HOME_SHOWCASE_SYNC_DATA';
  }

  String get wareHouseManagerChecklist {
    return 'WAREHOUSE_MANAGER_HOME_SHOWCASE_CHECKLIST';
  }

  String get inventoryReport {
    return 'WAREHOUSE_MANAGER_HOME_SHOWCASE_INVENTORY_REPORT';
  }

  String get deleteAll {
    return 'WAREHOUSE_MANAGER_HOME_SHOWCASE_DELETE_ALL';
  }

  String get supervisorMySurveyForm {
    return 'SUPERVISOR_HOME_SHOWCASE_MY_CHECKLIST';
  }

  String get vehicleTracking {
    return 'VEHICLE_TRACKING';
  }
}

class VehicleTracking {
  const VehicleTracking();
  String get vehicleOverviewLabel => 'VEHICLE_TRACKING_VEHICLE_OVERVIEW_LABEL';
  String get mapLabel => 'VEHICLE_TRACKING_MAP_LABEL';
  String get endTripButtonLabel => 'VEHICLE_TRACKING_END_TRIP';
  String get startTripButtonLabel => 'VEHICLE_TRACKING_START_TRIP';
  String get searchVehicle => "SEARCH_VEHICLE_LABEL";
  String get mileageLabel => 'VEHICLE_TRACKING_MILEAGE_LABEL';
  String get mileageLabelRequired => 'VEHICLE_TRACKING_MILEAGE_REQUIRED_LABEL';
  String get originLabel => 'VEHICLE_TRACKING_ORIGIN_LABEL';
  String get originLabelRequired => 'VEHICLE_TRACKING_ORIGIN_REQUIRED_LABEL';

  String get endMileageLabel => 'VEHICLE_TRACKING_END_MILEAGE_LABEL';
  String get destinationLabel => 'VEHICLE_TRACKING_DESTINATION_LABEL';
  String get destinationLabelRequired =>
      'VEHICLE_TRACKING_DESTINATION_REQUIRED_LABEL';

  String get startTripTitle => 'VEHICLE_TRACKING_START_TRIP_TITLE';
  String get startTripContent => 'VEHICLE_TRACKING_START_TRIP_CONTENT';

  String get endTripTitle => 'VEHICLE_TRACKING_END_TRIP_TITLE';
  String get endTripContent => 'VEHICLE_TRACKING_END_TRIP_CONTENT';

  String get tripBookLabel => "TRIP_BOOK_LABEL";
  String get tripBookReasonLabel => "TRIP_BOOK_REASON_LABEL";
  String get bookTripButtonActionLabel => "BOOK_TRIP_BUTTON_ACTION_LABEL";
  String get othersReasonTextLabel => "BOOK_TRIP_OTHERS_REASON_TEXT_LABEL";
  String get feedbackLabel => "VEHICLE_TRACKING_FEEDBACK_LABEL";

  String get tripComment => "VEHICLE_TRACKING_TRIP_COMMENT";
  String get tipSubmitted => "VEHICLE_TRACKING_TIP_SUBMITTED";

  String get commentRequired => "VEHICLE_TRACKING_COMMENT_REQUIRED";

  String get acknowledgementLabel => "VEHICLE_TRACKING_ACKNOWLEDGEMENT_LABEL";
  String get acknowledgementDescription =>
      "VEHICLE_TRACKING_ACKNOWLEDGEMENT_DESCRIPTION";
  String get acknowledgementSubLabel =>
      "VEHICLE_TRACKING_ACKNOWLEDGEMENT_SUB_LABEL";

  String get startDate => 'VEHICLE_TRACKING_START_DATE';
  String get endDate => 'VEHICLE_TRACKING_END_DATE';
  String get vehicleType => 'VEHICLE_TRACKING_VEHICLE_TYPE';
  String get brand => 'VEHICLE_BRAND';
  String get color => 'VEHICLE_COLOR';
  String get model => 'VEHICLE_MODEL';
  String get driverName => 'VEHICLE_DRIVER_NAME';
}

class SelectStockShowcase {
  const SelectStockShowcase();

  String get recordStockReceipt {
    return 'SELECT_STOCK_SHOWCASE_RECORD_STOCK_RECEIPT';
  }

  String get recordStockIssued {
    return 'SELECT_STOCK_SHOWCASE_RECORD_STOCK_ISSUED';
  }

  String get recordStockReturned {
    return 'SELECT_STOCK_SHOWCASE_RECORD_STOCK_RETURNED';
  }
}

class WarehouseDetailsShowcase {
  const WarehouseDetailsShowcase();

  String get dateOfReturn {
    return 'WAREHOUSE_DETAILS_SHOWCASE_DATE_OF_RETURN';
  }

  String get dateOfReceipt {
    return 'WAREHOUSE_DETAILS_SHOWCASE_DATE_OF_RECEIPT';
  }

  String get administrativeUnit {
    return 'WAREHOUSE_DETAILS_SHOWCASE_ADMINISTRATIVE_UNIT';
  }

  String get warehouseName {
    return 'WAREHOUSE_DETAILS_SHOWCASE_WAREHOUSE_NAME';
  }
}

class HouseholdDetails {
  const HouseholdDetails();

  String get householdDetailsLabel => 'HOUSEHOLD_DETAILS_LABEL';

  String get actionLabel => 'HOUSEHOLD_ACTION_LABEL';

  String get dateOfRegistrationLabel =>
      'HOUSEHOLD_DETAILS_DATE_OF_REGISTRATION_LABEL';

  String get dateOfAdministrationLabel =>
      'HOUSEHOLD_DETAILS_DATE_OF_ADMINISTRATION_LABEL';

  String get noOfMembersCountLabel => 'NO_OF_MEMBERS_COUNT_LABEL';
  String get viewHouseHoldDetailsAction =>
      'VIEW_HOUSEHOLD_DETAILS_ACTION_LABEL';
  String get bednetHouseholdOverViewActionText =>
      'BEDNET_HOUSEHOLD_OVERVIEW_ACTION_LABEL';
}

class StockDetailsReceiptShowcase {
  const StockDetailsReceiptShowcase();

  String get receivedFrom {
    return 'STOCK_DETAILS_RECEIPT_SHOWCASE_RECEIVED_FROM';
  }

  String get numberOfBednetsReceived {
    return 'STOCK_DETAILS_RECEIPT_SHOWCASE_NUMBER_OF_BEDNETS_RECEIVED';
  }

  String get packingSlipId {
    return 'STOCK_DETAILS_RECEIPT_SHOWCASE_PACKING_SLIP_ID';
  }

  String get numberOfNetsIndicatedOnPackingSlip {
    return 'STOCK_DETAILS_RECEIPT_SHOWCASE_NUMBER_OF_NETS_INDICATED_ON_PACKING_SLIP';
  }

  String get typeOfTransport {
    return 'STOCK_DETAILS_RECEIPT_SHOWCASE_TYPE_OF_TRANSPORT';
  }

  String get vehicleNumber {
    return 'STOCK_DETAILS_RECEIPT_SHOWCASE_VEHICLE_NUMBER';
  }

  String get driverName {
    return 'STOCK_DETAILS_RECEIPT_SHOWCASE_DRIVER_NAME';
  }

  String get driverNameMinMaxLengthValidation =>
      'DRIVER_NAME_MIN_MAX_VALIDATION';
  String get driverNameValidation => 'STOCK_DETAILS_DRIVER_NAME_VALIDATION';

  String get comments {
    return 'STOCK_DETAILS_RECEIPT_SHOWCASE_COMMENTS';
  }
}

class StockDetailsIssuedShowcase {
  const StockDetailsIssuedShowcase();

  String get issuedTo {
    return 'STOCK_DETAILS_ISSUED_SHOWCASE_ISSUED_TO';
  }

  String get numberOfBednetsIssued {
    return 'STOCK_DETAILS_ISSUED_SHOWCASE_NUMBER_OF_BEDNETS_ISSUED';
  }

  String get packingSlipId {
    return 'STOCK_DETAILS_ISSUED_SHOWCASE_PACKING_SLIP_ID';
  }

  String get numberOfNetsIndicatedOnPackingSlip {
    return 'STOCK_DETAILS_ISSUED_SHOWCASE_NUMBER_OF_NETS_INDICATED_ON_PACKING_SLIP';
  }

  String get typeOfTransport {
    return 'STOCK_DETAILS_ISSUED_SHOWCASE_TYPE_OF_TRANSPORT';
  }

  String get vehicleNumber {
    return 'STOCK_DETAILS_ISSUED_SHOWCASE_VEHICLE_NUMBER';
  }

  String get driverName {
    return 'STOCK_DETAILS_ISSUED_SHOWCASE_DRIVER_NAME';
  }

  String get comments {
    return 'STOCK_DETAILS_ISSUED_SHOWCASE_COMMENTS';
  }

  String get facilitySearchHeaderLabel => 'FACILITY_SEARCH_HEADER_LABEL';

  String get coreCommonDownload => 'CORE_COMMON_DOWNLOAD';
  String get coreCommonDownloadFailed => 'CORE_COMMON_DOWNLOAD_FAILED';
}

class AdverseEvents {
  const AdverseEvents();

  String get adverseEventsLabel => 'ADVERSE_EVENTS_LABEL';

  String get sideEffectsLabel => 'SIDE_EFFECTS_LABEL';

  String get selectSymptomsLabel => 'SELECT_SYMPTOMS_LABEL';

  String get resourceHeaderLabel => 'RESOURCE_HEADER_LABEL';

  String get resourceCountHeaderLabel => 'RESOURCE_COUNT_HEADER_LABEL';

  String get resourcesAdministeredLabel => 'RESOURCES_ADMINISTERED_LABEL';

  String get didYouReAdministerLabel => 'DID_YOU_RE_ADMINISTER';

  String get noOfTimesReAdministered => 'NO_OF_TIMES_RE_ADMINISTERED';
}

class Login {
  const Login();

  String get labelText => 'LOGIN_LABEL_TEXT';
  String get logOutWarningMsg => 'LOG_OUT_WARNING_MESSAGE';

  String get userIdPlaceholder => 'USER_ID_PLACEHOLDER';
  String get unableToLoginText => 'UNABLE_TO_LOGIN';

  String get passwordPlaceholder => 'PASSWORD_PLACEHOLDER';

  String get actionLabel => 'LOGIN_ACTION_LABEL';
  String get noInternetError => 'ERR_NOT_CONNECTED_TO_INTERNET';
}

class SelectSurveyFormShowcase {
  const SelectSurveyFormShowcase();

  String get selectSurveyForm {
    return 'SELECT_CHECKLIST_SHOWCASE_SELECT_CHECKLIST';
  }
}

class SurveyFormDataShowcase {
  const SurveyFormDataShowcase();

  String get date {
    return 'CHECKLIST_DATA_SHOWCASE_DATE';
  }

  String get administrativeUnit {
    return 'CHECKLIST_DATA_SHOWCASE_ADMINISTRATIVE_UNIT';
  }
}

class SurveyFormListShowcase {
  const SurveyFormListShowcase();

  String get open {
    return 'CHECKLIST_LIST_SHOWCASE_OPEN';
  }
}

class SelectChecklistShowcase {
  const SelectChecklistShowcase();

  String get selectChecklist {
    return 'SELECT_CHECKLIST_SHOWCASE_SELECT_CHECKLIST';
  }
}

class ChecklistDataShowcase {
  const ChecklistDataShowcase();

  String get date {
    return 'CHECKLIST_DATA_SHOWCASE_DATE';
  }

  String get administrativeUnit {
    return 'CHECKLIST_DATA_SHOWCASE_ADMINISTRATIVE_UNIT';
  }
}

class ChecklistListShowcase {
  const ChecklistListShowcase();

  String get open {
    return 'CHECKLIST_LIST_SHOWCASE_OPEN';
  }
}

class ComplaintTypeShowcase {
  const ComplaintTypeShowcase();

  String get complaintType {
    return 'COMPLAINT_TYPE_SHOWCASE_COMPLAINT_TYPE';
  }

  String get complaintTypeNext {
    return 'COMPLAINT_TYPE_SHOWCASE_COMPLAINT_TYPE_NEXT';
  }
}

class ComplaintsDetailsShowcase {
  const ComplaintsDetailsShowcase();

  String get complaintDate {
    return 'COMPLAINT_DETAILS_SHOWCASE_DATE';
  }

  String get complaintOrganizationUnit {
    return 'COMPLAINT_DETAILS_SHOWCASE_ORGANIZATION_UNIT';
  }

  String get complaintSelfOrOther {
    return 'COMPLAINT_DETAILS_SHOWCASE_SELF_OR_OTHER';
  }

  String get complaintName {
    return 'COMPLAINT_DETAILS_SHOWCASE_NAME';
  }

  String get complaintContact {
    return 'COMPLAINT_DETAILS_SHOWCASE_CONTACT';
  }

  String get complaintSupervisorName {
    return 'COMPLAINT_DETAILS_SHOWCASE_SUPERVISOR_NAME';
  }

  String get complaintSupervisorContact {
    return 'COMPLAINT_DETAILS_SHOWCASE_SUPERVISOR_CONTACT';
  }

  String get complaintDescription {
    return 'COMPLAINT_DETAILS_SHOWCASE_DESCRIPTION';
  }

  String get complaintSubmit {
    return 'COMPLAINT_DETAILS_SHOWCASE_SUBMIT';
  }
}

class ComplaintsDetailsViewShowcase {
  const ComplaintsDetailsViewShowcase();

  String get complaintNumber {
    return 'COMPLAINT_DETAILS_VIEW_SHOWCASE_NUMBER';
  }

  String get complaintType {
    return 'COMPLAINT_DETAILS_VIEW_SHOWCASE_TYPE';
  }

  String get complaintDate {
    return 'COMPLAINT_DETAILS_VIEW_SHOWCASE_DATE';
  }

  String get complaintName {
    return 'COMPLAINT_DETAILS_VIEW_SHOWCASE_NAME';
  }

  String get complaintArea {
    return 'COMPLAINT_DETAILS_VIEW_SHOWCASE_AREA';
  }

  String get complaintContact {
    return 'COMPLAINT_DETAILS_VIEW_CONTACT';
  }

  String get complaintStatus {
    return 'COMPLAINT_DETAILS_VIEW_SHOWCASE_STATUS';
  }

  String get complaintDescription {
    return 'COMPLAINT_DETAILS_VIEW_SHOWCASE_DESCRIPTION';
  }

  String get complaintClose {
    return 'COMPLAINT_DETAILS_VIEW_SHOWCASE_CLOSE';
  }
}

class ComplaintsInboxShowcase {
  const ComplaintsInboxShowcase();

  String get complaintSearch {
    return 'COMPLAINT_INBOX_SHOWCASE_SEARCH';
  }

  String get complaintFilter {
    return 'COMPLAINT_INBOX_SHOWCASE_FILTER';
  }

  String get complaintSort {
    return 'COMPLAINT_INBOX_SHOWCASE_SORT';
  }

  String get complaintNumber {
    return 'COMPLAINT_INBOX_SHOWCASE_NUMBER';
  }

  String get complaintType {
    return 'COMPLAINT_INBOX_SHOWCASE_TYPE';
  }

  String get complaintDate {
    return 'COMPLAINT_INBOX_SHOWCASE_DATE';
  }

  String get complaintArea {
    return 'COMPLAINT_INBOX_SHOWCASE_AREA';
  }

  String get complaintStatus {
    return 'COMPLAINT_INBOX_SHOWCASE_STATUS';
  }

  String get complaintOpen {
    return 'COMPLAINT_INBOX_SHOWCASE_OPEN';
  }

  String get complaintCreate {
    return 'COMPLAINT_INBOX_SHOWCASE_CREATE';
  }
}

class Checklist {
  const Checklist();

  String get checklist => 'CHECKLIST';

  String get checklistlabel => 'CHECKLIST_LABEL';

  String get checklistCreateActionLabel => 'CHECKLIST_CREATE_ACTION_LABEL';

  String get checklistViewActionLabel => 'CHECKLIST_VIEW_ACTION_LABEL';

  String get checklistDetailLabel => 'CHECKLIST_DETAILS_LABEL';

  String get checklistDialogLabel => 'CHECKLIST_DIALOG_LABEL';

  String get checklistDialogDescription => 'CHECKLIST_DIALOG_DESCRITPTION';

  String get checklistDialogPrimaryAction => 'CHECKLIST_DIALOG_PRIMARY_ACTION';

  String get checklistDialogSecondaryAction =>
      'CHECKLIST_DIALOG_SECONDARY_ACTION';

  String get checklistdate => 'CHECKLIST_DATE';

  String get checklistReasonRequiredError => 'CHECKLIST_REASON_REQUIRED_ERROR';

  String get notSelectedKey => 'NOT_SELECTED';

  String get checklistBackDialogLabel => 'CHECKLIST_BACK_DIALOG_LABEL';

  String get checklistBackDialogDescription =>
      'CHECKLIST_BACK_DIALOG_DESCRITPTION';

  String get checklistBackDialogPrimaryAction =>
      'CHECKLIST_BACK_DIALOG_PRIMARY_ACTION';

  String get checklistBackDialogSecondaryAction =>
      'CHECKLIST_BACK_DIALOG_SECONDARY_ACTION';

  String get noChecklistFound => 'NO_CHECKLISTS_FOUND';
}

class ForgotPassword {
  const ForgotPassword();

  String get labelText => 'FORGOT_PASSWORD_LABEL_TEXT';

  String get contentText => 'FORGOT_PASSWORD_CONTENT_TEXT';

  String get primaryActionLabel => 'PRIMARY_ACTION_LABEL';

  String get actionLabel => 'FORGOT_PASSWORD_ACTION_LABEL';
}

class Home {
  const Home();

  String get beneficiaryLabel => 'HOME_BENEFICIARY_LABEL';
  String get mySurveyForm => 'MY_CHECK_LIST_LABEL';
  String get vehicleTrackingLabel => 'VEHICLE_TRACKING_LABEL';

  String get manageStockLabel => 'HOME_MANAGE_STOCK_LABEL';

  String get stockReconciliationLabel => 'HOME_STOCK_RECONCILIATION_LABEL';

  String get viewReportsLabel => 'HOME_VIEW_REPORTS_LABEL';

  String get syncDataLabel => 'HOME_SYNC_DATA_LABEL';

  String get callbackLabel => 'HOME_CALL_BACK_LABEL';
  String get dataShare => 'HOME_DATA_SHARE_LABEL';

  String get fileComplaint => 'HOME_FILE_COMPLAINT';

  String get progressIndicatorTitle => 'PROGRESS_INDICATOR_TITLE';

  String get progressIndicatorHelp => 'PROGRESS_INDICATOR_HELP';

  String get progressIndicatorPrefixLabel => 'PROGRESS_INDICATOR_PREFIX_LABEL';

  String get dataSyncInfoLabel => 'DATA_SYNC_INFO_LABEL';

  String get dataSyncInfoContent => 'DATA_SYNC_INFO_CONTENT';

  String get myCheckList => 'MY_CHECK_LIST_LABEL';

  String get mobilizerChecklist => 'MOBILIZER_CHECK_LIST_LABEL';

  String get specialCaseCheckList => 'SPECIAL_CASE_CHECK_LIST_LABEL';

  String get warehouseManagerCheckList => 'WAREHOUSE_MANAGER_CHECK_LIST_LABEL';

  String get deleteAllLabel => 'HOME_DELETE_ALL_LABEL';
  String get db => 'HOME_DB_LABEL';
  String get dashboard => 'HOME_DASHBOARD_LABEL';

  String get beneficiaryReferralLabel => 'HOME_BENEFICIARY_REFERRAL_LABEL';
  String get manageAttendanceLabel => 'HOME_MANAGE_ATTENDANCE_LABEL';
  String get closedHouseHoldLabel => 'HOME_CLOSE_HOUSEHOLD_LABEL';
}

class AcknowledgementSuccess {
  const AcknowledgementSuccess();

  String get materialIssueHeading => "MATERIAL_ISSUE_HEADING";
  String get materialReceiveHeading => "MATERIAL_RECEIVE_HEADING";
  String get materialReturnHeading => "MATERIAL_RETURN_HEADING";

  String get materialIssueDescription => "MATERIAL_ISSUE_DESCRIPTION";
  String get materialReceiveDescription => "MATERIAL_RECEIVE_DESCRIPTION";
  String get materialReturnDescription => "MATERIAL_RETURN_DESCRIPTION";

  String get mrnNumberLabel => 'MRN_NUMBER_LABEL';
  String get mrrnNumberDescription => "MRRN_NUMBER_DESCRIPTION";
  String get mrrnNumberHeading => "MRRN_NUMBER_HEADING";
  String get minNumberLabel => 'MIN_NUMBER_LABEL';
  String get minNumberDescription => "MIN_NUMBER_DESCRIPTION";
  String get minNumberHeading => "MIN_NUMBER_HEADING";
  String get mrnNumberDescription => "MRN_NUMBER_DESCRIPTION";
  String get mrnNumberHeading => "MRN_NUMBER_HEADING";
  String get viewtransactions => 'VIEW_TRANSACTIONS';
  String get createNewTransactions => 'CREATE_NEW_TRANSACTION';

  String get actionLabelText => 'ACKNOWLEDGEMENT_SUCCESS_ACTION_LABEL_TEXT';

  String get acknowledgementDescriptionText =>
      'ACKNOWLEDGEMENT_SUCCESS_DESCRIPTION_TEXT';

  String get acknowledgementLabelText => 'ACKNOWLEDGEMENT_SUCCESS_LABEL_TEXT';

  String get goToHome => 'GO_TO_HOME_SCREEN';
  String get downloadmoredata => 'DOWNLOAD_MORE_DATA';
  String get dataDownloadedSuccessLabel => 'DATA_DOWNLOADED_SUCCESS_LABEL';
}

class ProjectSelection {
  const ProjectSelection();

  String get projectDetailsLabelText => 'PROJECT_DETAILS_LABEL';

  String get syncInProgressTitleText => 'SYNC_IN_PROGRESS';

  String get syncCompleteTitleText => 'SYNC_COMPLETE';

  String get syncCompleteButtonText => 'CLOSE';

  String get syncFailedTitleText => 'SYNC_FAILED';

  String get retryButtonText => 'RETRY';

  String get dismissButtonText => 'DISMISS';

  String get noProjectsAssigned => 'NO_PROJECTS_ASSIGNED';

  String get contactSysAdmin => 'CONTACT_SYS_ADMIN';

  String get onProjectMapped => 'NO_PROJECT_MAPPED';
}

class Complaints {
  const Complaints();

  String get complaintsTypeHeading => 'COMPLAINTS_TYPE_HEADING';

  String get complaintsTypeLabel => 'COMPLAINTS_TYPE_LABEL';

  String get actionLabel => 'HOUSEHOLD_LOCATION_ACTION_LABEL';

  String get complaintsLocationLabel => 'COMPLAINTS_LOCATION_LABEL';

  String get complaintsDetailsLabel => 'COMPLAINTS_DETAILS_LABEL';

  String get dateOfComplaint => 'COMPLAINTS_DATE';

  String get complainantTypeQuestion => 'COMPLAINTS_COMPLAINANT_TYPE_QUESTION';

  String get complainantName => 'COMPLAINTS_COMPLAINANT_NAME';

  String get complainantContactNumber =>
      'COMPLAINTS_COMPLAINANT_CONTACT_NUMBER';

  String get supervisorName => 'COMPLAINTS_SUPERVISOR_NAME';

  String get supervisorContactNumber => 'COMPLAINTS_SUPERVISOR_CONTACT_NUMBER';

  String get complaintDescription => 'COMPLAINTS_DESCRIPTION';

  String get dialogTitle => 'COMPLAINTS_DIALOG_TITLE';

  String get dialogContent => 'COMPLAINTS_DIALOG_MESSAGE';

  String get fileComplaintAction => 'COMPLAINTS_FILE_COMPLAINT_ACTION';

  String get inboxHeading => 'COMPLAINTS_INBOX_HEADING';

  String get searchCTA => 'COMPLAINTS_INBOX_SEARCH_CTA';

  String get filterCTA => 'COMPLAINTS_INBOX_FILTER_CTA';

  String get sortCTA => 'COMPLAINTS_INBOX_SORT_CTA';

  String get complaintInboxFilterHeading => 'COMPLAINTS_INBOX_FILTER_HEADING';

  String get complaintsFilterClearAll => 'COMPLAINTS_FILTER_CLEAR_ALL';

  String get complaintInboxSearchHeading => 'COMPLAINTS_INBOX_SEARCH_HEADING';

  String get complaintInboxSortHeading => 'COMPLAINTS_INBOX_SORT_HEADING';

  String get complaintsSortDateAsc => 'COMPLAINT_SORT_DATE_ASC';

  String get complaintsSortDateDesc => 'COMPLAINT_SORT_DATE_DESC';

  String get assignedToAll => 'COMPLAINTS_ASSIGNED_TO_ALL';

  String get assignedToSelf => 'COMPLAINTS_ASSIGNED_TO_SELF';

  String get noComplaintsExist => 'COMPLAINTS_NO_COMPLAINTS_EXIST';

  String get validationRequiredError => 'COMPLAINTS_VALIDATION_REQUIRED_ERROR';

  String get inboxDateLabel => 'COMPLAINTS_INBOX_DATE_LABEL';

  String get inboxNumberLabel => 'COMPLAINTS_INBOX_NUMBER_LABEL';

  String get inboxTypeLabel => 'COMPLAINTS_INBOX_TYPE_LABEL';

  String get inboxAreaLabel => 'COMPLAINTS_INBOX_AREA_LABEL';

  String get inboxStatusLabel => 'COMPLAINTS_INBOX_STATUS_LABEL';

  String get inboxNotGeneratedLabel => 'COMPLAINTS_INBOX_NOT_GENERATED_LABEL';

  String get inboxSyncRequiredLabel => 'COMPLAINTS_INBOX_SYNC_REQUIRED_LABEL';

  String get raisedForMyself => 'COMPLAINTS_RAISED_FOR_MYSELF';
  String get validationMinLengthError =>
      'COMPLAINTS_VALIDATION_MINLENGTH_ERROR';
  String get mobilenumberValidationMaxLengthError =>
      'COMPLAINTS_VALIDATION_MINLENGTH_ERROR';

  String get raisedForAnotherUser => 'COMPLAINTS_RAISED_FOR_ANOTHER_USER';

  String get locality => 'COMPLAINTS_LOCALITY';

  String get backToInbox => 'COMPLAINTS_BACK_TO_INBOX';

  String get acknowledgementAction => 'COMPLAINTS_ACKNOWLEDGEMENT_ACTION';

  String get acknowledgementDescription =>
      'COMPLAINTS_ACKNOWLEDGEMENT_DESCRIPTION';

  String get acknowledgementLabel => 'COMPLAINTS_ACKNOWLEDGEMENT_LABEL';

  String get acknowledgementSubLabelMain =>
      'COMPLAINTS_ACKNOWLEDGEMENT_SUB_LABEL_MAIN';

  String get acknowledgementSubLabelSub =>
      'COMPLAINTS_ACKNOWLEDGEMENT_SUB_LABEL_SUB';

  String get complaintsError => 'COMPLAINTS_VALIDATION_REQUIRED_ERROR';

  String get validationRadioRequiredError =>
      'COMPLAINTS_VALIDATION_RADIO_REQUIRED_ERROR';
}

class DataShare {
  const DataShare();

  String get sendAction => 'SEND_ACTION';

  String get dataUnSyncedDesc => 'DATA_UN_SYNCED_DESCRIPTION';

  String get sendActionDescription => 'SEND_ACTION_DESCRIPTION';

  String get receiveAction => 'RECEIVE_ACTION';

  String get receiveActionDescription => 'RECEIVE_ACTION_DESCRIPTION';

  String get selectRecipients => 'SELECT_RECIPIENTS';

  String get noRecipientsSelected => 'NO_RECIPIENTS_SELECTED';

  String get noDevicesConnected => 'NO_DEVICES_CONNECTED';

  String get sendActionMessage => 'SEND_ACTION_MESSAGE';

  String get sendingActionMessage => 'SENDING_ACTION_MESSAGE';

  String get dataTransferCompleted => 'DATA_TRANSFER_COMPLETED';

  String get receiveActionMessage => 'RECEIVE_ACTION_MESSAGE';

  String get receivingActionMessage => 'RECEIVING_ACTION_MESSAGE';

  String get receivedSuccessMessage => 'RECEIVED_SUCCESS_MESSAGE';

  String get receiverDialogTitle => 'RECEIVER_DIALOG_TITLE';

  String get receiverDialogDescription => 'RECEIVER_DIALOG_DESCRIPTION';

  String get senderDialogTitle => 'SENDER_DIALOG_TITLE';

  String get senderDialogDescription => 'SENDER_DIALOG_DESCRIPTION';

  String get dataSharingLabel => 'DATA_SHARING_LABEL';

  String get projectMisMatchError => 'PROJECT_MISMATCH_ERROR';

  String get invalidFileError => 'INVALID_FILE_FORMAT_ERROR';

  String get fileNotFoundError => 'FILE_NOT_FOUND_ERROR';

  String get failedToTransfer => 'FAILED_TO_TRANSFER';

  String get failedToTransferDesc => 'FAILED_TO_TRANSFER_DESCRIPTION';

  String get dateReceivedForBoundaries => 'DATA_RECEIVED_FOR_BOUNDARIES';

  String get noBoundariesMatchedTitle => 'NO_BOUNDARIES_MATCHED_ERROR_TITLE';

  String get noBoundariesMatchedDesc =>
      'NO_BOUNDARIES_MATCHED_ERROR_DESCRIPTION';

  String get failedToTransferDescription => 'FAILED_TO_TRANSFER_DESCRIPTION';

  String get failedToReceive => 'FAILED_TO_RECEIVE';

  String get failedToReceiveDescription => 'FAILED_TO_RECEIVE_DESCRIPTION';
}

class SyncDialog {
  const SyncDialog();

  String get syncFailedTitle => 'SYNC_DIALOG_SYNC_FAILED_TITLE';

  String get downSyncFailedTitle => 'SYNC_DIALOG_DOWN_SYNC_FAILED_TITLE';

  String get upSyncFailedTitle => 'SYNC_DIALOG_UP_SYNC_FAILED_TITLE';

  String get syncInProgressTitle => 'SYNC_DIALOG_SYNC_IN_PROGRESS_TITLE';

  String get dataSyncedTitle => 'SYNC_DIALOG_DATA_SYNCED_TITLE';

  String get closeButtonLabel => 'SYNC_DIALOG_CLOSE_BUTTON_LABEL';

  String get retryButtonLabel => 'SYNC_DIALOG_RETRY_BUTTON_LABEL';
  String get pendingSyncLabel => 'PENDING_SYNC_LABEL';
  String get pendingSyncContent => 'PENDING_SYNC_CONTENT';
}

class StockReconciliationShowcase {
  const StockReconciliationShowcase();

  String get warehouseName {
    return 'STOCK_RECONCILIATION_SHOWCASE_WAREHOUSE_NAME';
  }

  String get dateOfReconciliation {
    return 'STOCK_RECONCILIATION_SHOWCASE_DATE_OF_RECONCILIATION';
  }

  String get stockReceived {
    return 'STOCK_RECONCILIATION_SHOWCASE_STOCK_RECEIVED';
  }

  String get stockIssued {
    return 'STOCK_RECONCILIATION_SHOWCASE_STOCK_ISSUED';
  }

  String get stockReturned {
    return 'STOCK_RECONCILIATION_SHOWCASE_STOCK_RETURNED';
  }

  String get stockOnHand {
    return 'STOCK_RECONCILIATION_SHOWCASE_STOCK_ON_HAND';
  }

  String get manualStockCount {
    return 'STOCK_RECONCILIATION_SHOWCASE_MANUAL_STOCK_COUNT';
  }

  String get comments {
    return 'STOCK_RECONCILIATION_SHOWCASE_COMMENTS';
  }
}

class StockDetailsReturnedShowcase {
  const StockDetailsReturnedShowcase();

  String get returnedFrom {
    return 'STOCK_DETAILS_RETURNED_SHOWCASE_RETURNED_FROM';
  }

  String get numberOfBednetsReturned {
    return 'STOCK_DETAILS_RETURNED_SHOWCASE_NUMBER_OF_BEDNETS_RETURNED';
  }

  String get packingSlipId {
    return 'STOCK_DETAILS_RETURNED_SHOWCASE_PACKING_SLIP_ID';
  }

  String get numberOfNetsIndicatedOnPackingSlip {
    return 'STOCK_DETAILS_RETURNED_SHOWCASE_NUMBER_OF_NETS_INDICATED_ON_PACKING_SLIP';
  }

  String get typeOfTransport {
    return 'STOCK_DETAILS_RETURNED_SHOWCASE_TYPE_OF_TRANSPORT';
  }

  String get vehicleNumber {
    return 'STOCK_DETAILS_RETURNED_SHOWCASE_VEHICLE_NUMBER';
  }

  String get driverName {
    return 'STOCK_DETAILS_RETURNED_SHOWCASE_DRIVER_NAME';
  }

  String get comments {
    return 'STOCK_DETAILS_RETURNED_SHOWCASE_COMMENT';
  }
}

class HouseholdLocationShowcase {
  const HouseholdLocationShowcase();

  String get administrativeArea {
    return 'HOUSEHOLD_LOCATION_SHOWCASE_ADMINISTRATIVE_AREA';
  }

  String get landmark {
    return 'HOUSEHOLD_LOCATION_SHOWCASE_LANDMARK';
  }

  String get address {
    return 'HOUSEHOLD_LOCATION_SHOWCASE_ADDRESS';
  }

  String get postalCode {
    return 'HOUSEHOLD_LOCATION_SHOWCASE_POSTAL_CODE';
  }
}

class HouseholdLocation {
  const HouseholdLocation();

  String get householdLocationLabelText => 'HOUSEHOLD_LOCATION_LABEL_TEXT';

  String get householdLocationAccuracyText =>
      'HOUSEHOLD_LOCATION_ACCURACY_LABEL_TEXT';

  String get householdLocationDescriptionText =>
      'HOUSEHOLD_LOCATION_DESCRIPTION_TEXT';

  String get administrationAreaFormLabel => 'ADMINISTRATION_AREA_FORM_LABEL';

  String get administrationAreaRequiredValidation =>
      'HOUSEHOLD_LOCATION_ADMINISTRATION_AREA_REQUIRED_VALIDATION';

  String get householdAddressLine1LabelText =>
      'HOUSEHOLD_ADDRESS_LINE_1_FORM_LABEL';

  String get landmarkFormLabel => 'LANDMARK_FORM_LABEL';

  String get householdAddressLine2LabelText =>
      'HOUSEHOLD_ADDRESS_LINE_2_FORM_LABEL';

  String get postalCodeFormLabel => 'POSTAL_CODE_FORM_LABEL';

  String get actionLabel => 'HOUSEHOLD_LOCATION_ACTION_LABEL';
  String get refreshLocation => 'HOUSEHOLD_REFRESH_LOCATION';
}

class SearchBeneficiary {
  const SearchBeneficiary();

  String get statisticsLabelText => 'BENEFICIARY_STATISTICS_LABEL_TEXT';

  String get searchIndividualLabelText =>
      'BENEFICIARY_STATISTICS_SEARCH_INDIVIDUAL_LABEL';

  String get noOfHouseholdsRegistered => 'NO_OF_HOUSEHOLDS_REGISTERED';

  String get noOfResourcesDelivered => 'NO_OF_RESOURCES_DELIVERED';
  String get beneficiaryIdbednet => 'BENEFICIARY_ID_BEDNET';

  String get beneficiarySearchHintText => 'BENEFICIARY_SEARCH_HINT_TEXT';

  String get beneficiaryIndividualSearchHintText =>
      'BENEFICIARY_INDIVIDUAL_SEARCH_HINT_TEXT';

  String get beneficiaryInfoDescription => 'BENEFICIARY_INFO_DESCRIPTION';

  String get beneficiaryInfoTitle => 'BENEFICIARY_INFO_TITLE';

  String get beneficiaryAddActionLabel => 'BENEFICIARY_ADD_ACTION_LABEL';

  String get iconLabel => 'ICON_LABEL';

  String get yearsAbbr => 'YEARS_ABBR';

  String get monthsAbbr => 'MONTHS_ABBR';

  String get proximityLabel => 'PROXIMITY_LABEL';
}

class IndividualDetails {
  const IndividualDetails();

  String get individualsDetailsLabelText => 'INDIVIDUAL_LABEL_TEXT';

  String get individualsDetailsLabelTextSMC => 'INDIVIDUAL_LABEL_TEXT_SMC';
  String get individualsChildDetailsLabelTextSMC =>
      'INDIVIDUAL_CHILD_LABEL_TEXT_SMC';

  String get nameLabelText => 'INDIVIDUAL_NAME_LABEL_TEXT';

  String get checkboxLabelText => 'HEAD_OF_HOUSEHOLD_LABEL_TEXT';

  String get idTypeLabelText => 'ID_TYPE_LABEL_TEXT';

  String get idNumberLabelText => 'ID_NUMBER_LABEL_TEXT';

  String get idNumberSuggestionText => 'ID_NUMBER_SUGGESTION_TEXT';

  String get dobLabelText => 'DOB_LABEL_TEXT';

  String get ageLabelText => 'AGE_LABEL_TEXT';

  String get separatorLabelText => 'SEPARATOR_LABEL_TEXT';

  String get genderLabelText => 'GENDER_LABEL_TEXT';

  String get dobErrorText => 'DOB_ERROR_MESSAGE';

  String get mobileNumberLabelText => 'MOBILE_NUMBER_LABEL_TEXT';

  String get heightLabelText => 'HEIGHT_LABEL_TEXT';

  String get submitButtonLabelText => 'INDIVIDUAL_DETAILS_SUBMIT';

  String get mobileNumberInvalidFormatValidationMessage =>
      'INDIVIDUAL_DETAILS_INVALID_MOBILE_NUMBER';

  String get yearsHintText => 'YEARS_HINT_TEXT';
  String get monthsHintText => 'MONTHS_HINT_TEXT';

  String get yearsErrorText => 'ERR_YEARS';

  String get monthsErrorText => 'ERR_MONTHS';

  String get yearsAndMonthsErrorText => 'ERR_YEARS_AND_MONTHS';

  String get linkVoucherToIndividual => 'LINK_VOUCHER_TO_INDIVIDUAL';

  String get headAgeValidError => 'HEAD_VALID_AGE_ERROR_MESSAGE';
  String get voucherCodeBednet => 'BEDNET_VOUCHER_CODE_INDIVIDUAL';

  String get lastNameLabelText => 'INDIVIDUAL_LAST_NAME_LABEL_TEXT';

  String get lastNameHeadLabelText => 'HEAD_HOUSEHOLD_LAST_NAME_LABEL_TEXT';

  String get childFirstNameLabelTextSMC =>
      'CHILD_INDIVIDUAL_FIRST_NAME_LABEL_TEXT_SMC';
  String get lastNameIsRequiredError => 'LAST_NAME_REQUIRED_ERROR_MESSAGE';
  String get lastNameLengthError => 'LAST_NAME_LENGTH_ERROR_MESSAGE';
  String get firstNameHeadLabelTextSMC => 'FIRST_NAME_HEAD_LABEL_TEXT_SMC';
  String get childLastNameLabelText => 'CHILD_INDIVIDUAL_LAST_NAME_LABEL_TEXT';
  String get mobileMinLengthValidationMessageSMC =>
      'MOBILE_MIN_LENGTH_VALIDATION_SMC';
  String get scanVoucherAndLinkToIndividual => 'VOUCHER_LINK_ERROR';
  String get bednetCountSummaryText => 'BEDNET_SUMMARY_COUNT_TEXT';
}

class BeneficiaryDetails {
  const BeneficiaryDetails();

  String get validationForExcessStockReturn =>
      "ERROR_VALIDATION_FOR_EXCESS_STOCK_RETURN";
  String get validationForExcessStockDispatch =>
      "ERROR_VALIDATION_FOR_EXCESS_STOCK_DISPATCH";

  String get beneficiarysDetailsLabelText => 'BENEFICIARY_DETAILS_LABEL_TEXT';
  String get beneficiarysDetailsEditIconLabelText =>
      'BENEFICIARY_DETAILS_EDIT_ICON_LABEL_TEXT';
  String get beneficiarysDetailsEditIconLabel =>
      'BENEFICIARY_DETAILS_EDIT_ICON_LABEL';
  String get beneficiarysDetailsDeleteIconLabel =>
      'BENEFICIARY_DETAILS_DELETE_ICON_LABEL';
  String get resourcesTobeDelivered => 'RESOURCES_TO_BE_DELIVERED';
  String get resourcesTobeProvided => 'RESOURCES_TO_BE_PROVIDED';

  String get beneficiaryAge => 'BENEFICIARY_AGE';
  String get ctaProceed => 'PROCEED';
  String get beneficiaryDoseNo => 'BENEFICIARY_DETAILS_DOSE_NO';
  String get beneficiaryDose => 'BENEFICIARY_DETAILS_DOSE';
  String get beneficiaryStatus => 'BENEFICIARY_DETAILS_STATUS';
  String get beneficiaryResources => 'BENEFICIARY_DETAILS_RESOURCES';
  String get beneficiaryQuantity => 'BENEFICIARY_DETAILS_QUANTITY';
  String get beneficiaryCompletedOn => 'BENEFICIARY_DETAILS_COMPLETED_ON';
  String get beneficiaryDeliveryStrategy =>
      'BENEFICIARY_DETAILS_DELIVERY_STRATEGY';
  String get beneficiaryCycle => 'BENEFICIARY_DETAILS_CYCLE';
  String get currentCycleLabel => 'BENEFICIARY_DETAILS_CURRENT_CYCLE_LABEL';
  String get fromCurrentLocation => 'FROM_CURRENT_LOCATION';
  String get unableToScan => 'UNABLE_TO_SCAN';

  String get scanValidResource => 'SCAN_VALID_RESOURCE';

  String get scannedResourceCountMisMatch => 'SCANNED_RESOURCE_COUNT_MISMATCH';

  String get resourceAlreadyScanned => 'RESOURCE_ALREADY_SCANNED';

  String get scannerLabel => 'SCANNER_LABEL';

  String get noOfResourceScanned => 'NO_OF_RESOURCE_SCANNED';

  String get resourcesScanned => 'RESOURCES_SCANNED';

  String get saveScannedResource => 'SAVE_SCANNED_RESOURCE';

  String get flashOn => 'FLASH_ON';

  String get flashOff => 'FLASH_OFF';

  String get scannerDialogTitle => 'SCANNER_DIALOG_TITLE';

  String get scannerDialogContent => 'SCANNER_DIALOG_CONTENT';

  String get scannerDialogPrimaryAction => 'SCANNER_DIALOG_PRIMARY_ACTION';

  String get scannerDialogSecondaryAction => 'SCANNER_DIALOG_SECONDARY_ACTION';
  String get beneficiaryHeader => 'BENEFICIARY_HEADER';
  String get deliveryHeader => 'DELIVERY_TABLE_HEADER';
  String get typeOfInsecticideUsed =>
      'DELIVER_INTERVENTION_TYPE_OF_INSECTICIDE_USED';

  String get pregnantWomenLabel => 'PREGNANT_WOMEN_LABEL';
  String get roomsLabel => 'ROOMS_LABEL';
  String get childrenLabel => 'CHILDREN_LABEL';
  String get womenLabel => 'WOMEN_LABEL';
  String get menLabel => 'MEN_LABEL';

  String get noOfRoomsSprayed => 'DELIVERY_ROOMS_SPRAYED';
  String get roomsVsSprayedValidation =>
      'SPRAYED_ROOMS_CANNOT_EXCEED_TOTAL_ROOMS';

  String get typeOfResourceUsedHeading => 'TYPE_OF_RESOURCE_USED';

  String get proceedWithoutDownloading => 'PROCEED_WITHOUT_DOWNLOADING';
  String get unableToCheckDataInServer => 'FAILED_TO_CHECK_DATA_IN_SERVER';
  String get dataFound => 'DATA_FOUND';
  String get noDataFound => 'NO_DATA_FOUND';
  String get dataFoundContent => 'DATA_FOUND_CONTENT';
  String get noDataFoundContent => 'NO_DATA_FOUND_CONTENT';
  String get dataDownloadInProgress => 'DATA_DOWNLOAD_IN_PROGRESS';
  String get insufficientStorage => 'INSUFFICIENT_STORAGE_WARNING';
  String get downloadreport => 'DOWNLOAD_REPORT';
  String get boundary => 'BOUNDARY';
  String get status => 'STATUS';
  String get downloadedon => 'DOWNLOADED_ON';
  String get recordsdownload => 'RECORDS_DOWNLOAD';
  String get downloadcompleted => 'DOWNLOAD_COMPLETED';
  String get datadownloadreport => 'DATA_DOWNLOAD_REPORT';
  String get download => 'DOWNLOAD';
  String get partialdownloaded => 'PARTIAL_DOWNLOAD';
  String get downloadtime => 'DOWNLOAD_TIME';
  String get totalrecorddownload => 'TOTAL_RECORD_DOWNLOAD';
  String get insufficientStorageContent =>
      'INSUFFICIENT_STORAGE_WARNING_CONTENT';
  String get recordCycle => 'BENEFICIARY_DETAILS_RECORD_CYCLE';
  String get noOfRoomsValidation => 'ROOMS_VALIDATION';
  String get memberZeroError => 'MEMBER_ZERO_ERROR';

  String get noOfRoomsAlertTitle => 'ROOMS_ALERT_TITLE';
  String get noOfRoomsAlertContent => 'ROOMS_ALERT_CONTENT';
  String get noOfRoomsAlertYes => 'ROOMS_ALERT_YES';
  String get noOfRoomsAlertNo => 'ROOMS_ALERT_NO';

  String get noOfMembersAlertTitle => 'MEMBERS_ALERT_TITLE';
  String get noOfMembersAlertContent => 'MEMBERS_ALERT_CONTENT';
  String get noOfMembersAlertYes => 'MEMBERS_ALERT_YES';
  String get noOfMembersAlertNo => 'MEMBERS_ALERT_NO';

  String get noOfWomenCountLabel => 'NO_OF_WOMEN_LABEL';
  String get noOfMenCountLabel => 'NO_OF_MEN_LABEL';

  String get commentsLabel => 'REFUSAL_COMMENTS_LABEL';
  String get refusalCommentsRequried => 'REFUSAL_COMMENTS_REQUIRED';
  String get genderOfInterviewee => 'GENDER_OF_INTERVIEWEE';

  String get invalidChildPregnantWomenCount =>
      'INVALID_CHILD_PREGNANT_WOMEN_COUNT';
}

class StockDetails {
  const StockDetails();

  String get stockDetailsLabel => 'STOCK_DETAILS_LABEL';
  String get stockReceivedIssuedQuantityLabel =>
      'STOCK_DETAILS_RECEIVED_ISSUES_QUANTITY_LABEL';

  String get stockScanResourcesLabel => 'STOCK_SCAN_RESOURCE_LABEL';

  String get minNumberLabel => 'MIN_NUMBER_LABEL';
  String get mrnNumberLabel => 'MRN_NUMBER_LABEL';
  String get selectMINNumber => 'STOCK_DETAILS_SELECT_MIN_NUMBER';
  String get selectMRNNumber => 'STOCK_DETAILS_SELECT_MRN_NUMBER';
  String get noTransactionsFound => 'STOCK_DETAILS_NO_TRANSACTIONS_FOUND';
  String get resource => 'STOCK_DETAILS_RESOURCE';
  String get stockReceiptDetails => 'STOCK_DETAILS_STOCK_RECEIPT_DETAILS';
  String get stockIssueDetails => 'STOCK_DETAILS_STOCK_ISSUE_DETAILS';
  String get stockReturnDetails => 'STOCK_DETAILS_STOCK_RETURN_DETAILS';
  String get waybill => 'STOCK_DETAILS_WAYBILL';
  String get waybillNumber => 'STOCK_DETAILS_WAYBILL_NUMBER';
  String get damageStockLabel => 'STOCK_DETAILS_DAMAGE_QUANTITY';
  String get emptyVialsLabel => 'STOCK_DETAILS_EMPTY_OPENED_VIALS_LABEL';
  String get unusableVvmFirst => 'UNUSABLE_VVM_THREE_FOURTH_VIALS_LABEL';
  String get unusableVvmSecond => 'UNUSABLE_VVM_FIRST_SECOND_VIALS_LABEL';
  String get blisters => 'STOCK_DETAILS_BLISTERS';
  String get capsules => 'STOCK_DETAILS_CAPSULES';

  String get reconciliationCommentRequired => 'RECONCILIATION_COMMENT_REQUIRED';

  String get cddCodeLabel => 'CDD_CODE_LABEL';

  String get quantityCapsuleReceivedLabel =>
      'STOCK_DETAILS_CAPSULE_QUANTITY_RECEIVED';

  String get quantityCapsuleSentLabel => 'STOCK_DETAILS_CAPSULE_QUANTITY_SENT';

  String get quantityCapsuleReturnedLabel =>
      'STOCK_DETAILS_CAPSULE_QUANTITY_RETURNED';

  String get quantityCapsulePartialReturnedLabel =>
      'STOCK_DETAILS_CAPSULE_PARTIAL_QUANTITY_RETURNED';
  String get selectTransactingPartyReturnedFrom =>
      'STOCK_DETAILS_RETURNED_FROM';
  String get quantityCapsulePartialWastedLabel =>
      'STOCK_DETAILS_CAPSULE_PARTIAL_QUANTITY_WASTED';
  String get returnedTo => 'STOCK_DETAILS_RETURNED_TO';
  String get resourceLabel => 'RESOURCE';
  String get batchNumberLabel {
    return 'STOCK_DETAILS_BATCH_NUMBER';
  }

  String get transportTypeLabel => 'STOCK_DETAILS_TYPE_OF_TRANSPORT_LABEL';
  String get statusVvmLabel => 'STOCK_DETAILS_STATUS_OF_VVM';
  String get statusIvmLabel => 'STOCK_DETAILS_STATUS_OF_IVM';
  String get manufacturerLabel => 'STOCK_DETAILS_STATUS_OF_MANUFACTURER_LABEL';
  String get expireDateLabel => 'STOCK_DETAILS_EXPIRE_DATE_LABEL';

  String get quantityUnusedReturnedLabel =>
      'STOCK_DETAILS_UNUSED_QUANTITY_RETURNED';

  String get quantityPartialReturnedLabel =>
      'STOCK_DETAILS_PARTIAL_QUANTITY_RETURNED';

  String get quantityDamageReturnedLabel =>
      'STOCK_DETAILS_DAMAGE_QUANTITY_RETURNED';

  String get quantityReturnedMaxError =>
      'STOCK_DETAILS_RETURNED_MAX_QUANTITY_ERROR';
  String get quantityWastedReturnedLabel =>
      'STOCK_DETAILS_WASTED_QUANTITY_RETURNED';
  String get productRequired => 'STOCK_DETAILS_PRODUCT_IS_REQUIRED';

  String get manageStockLabel => 'STOCK_DETAILS_MANAGE_STOCK_LABEL';

  String get recordStockReturnedDescription =>
      'STOCK_DETAILS_RECORD_STOCK_RETURNED_DESCRIPTION';

  String get driverNameLabel => 'STOCK_DETAILS_DRIVER_NAME';

  String get createNewTransactions => "STOCK_DETAILS_CREATE_NEW_TRANSACTION";
  String get viewCreatedTransactions =>
      "STOCK_DETAILS_VIEW_CREATED_TRANSACTIONS";
  String get stockReceiptDetailsLabel => 'STOCK_RECEIPT_DETAILS_LABEL';

  String get supervisorCodeRequired =>
      'STOCK_DETAILS_SUPERVISOR_CODE_IS_REQUIRED';
  String get supervisorCodeLabel => 'STOCK_SUPERVISOR_CODE_LABEL';

  String get monitorCodeLabel => 'STOCK_MONITOR_CODE_LABEL';

  String get stockMismatchCommentRequried => 'STOCK_MISMATCH_COMMENT_REQURIED';

  String get countDialogTitle => 'STOCK_DETAILS_COUNT_DIALOG_TITLE';

  String get countContent => 'STOCK_DETAILS_COUNT_DIALOG_CONTENT';

  String get countDialogSuccess =>
      'STOCK_DETAILS_COUNT_DIALOG_SUCCESS_ACTION_LABEL';

  String get countDialogCancel =>
      'STOCK_DETAILS_COUNT_DIALOG_CANCEL_ACTION_LABEL';

  String get selectProductBednetLabel => 'SELECT_PRODUCT_BEDNET_LABEL';
  String get stockIssuedBednetDetailsLabel => 'ISSUED_STOCK_BEDNET_DETAILS';
}

class StockReconciliationDetails {
  const StockReconciliationDetails();
  String get insecticideLabel => 'STOCK_RECONCILIATION_INDECTICIDE_LABEL';
  String get commentsRequired => 'STOCK_RECONCILIATION_COMMENT_IS_REQUIRED';
}

class InventoryReportDetails {
  const InventoryReportDetails();
  String get dateLabel {
    return 'INVENTORY_REPORT_DETAILS_DATE_LABEL';
  }

  String get returnedTOTransactingPartyLabel {
    return 'INVENTORY_REPORT_DETAILS_RETURNED_TO_TRANSACTING_PARTY_LABEL';
  }

  String get backToHomeButtonLabel =>
      "INVENTORY_REPORT_DETAILS_BACK_TO_HOME_BUTTON_LABEL";
  String get partialReturnedQuantityLabel =>
      "INVENTORY_REPORT_DETAILS_PARTIAL_RETURNED_QUANTITY_LABEL";

  String get commentIsRequiredText => "COMMENT_IS_REQUIRED_TEXT";

  String get checkTheQuantityReceivedText =>
      'CHECK_THE_QUANTITY_RECEIEVED_TEXT';

  String get stockReceiptDetailsText => 'STOCK_RECEIPT_DETAILS_TEXT';

  String get receivedFromText => 'RECEIVED_FROM_TEXT';

  String get quantityReceivedByWarehouse => 'QUANTITY_RECEIVED_BY_WAREHOUSE';

  String get actualQuantityReceived => 'ACTUAL_QUANTITY_RECEIVED';
  String get actualQuantityReceivedRequired =>
      'ACTUAL_QUANTITY_RECEIVED_REQUIRED';

  String get commentsText => 'COMMENTS_TEXT';

  String get waybillNumberText => 'WAYBILL_NUMBER_TEXT';
  String get summaryReport => 'INVENTORY_REPORT_DETAILS_SUMMARY_REPORT_LABEL';

  String get batchNumberText => 'BATCH_NUMBER_TEXT';
  String get houseHoldRegistered =>
      'SUMMARY_REPORT_COLUMN_HOUSEHOLD_REGISTERED';
  String get childrenTreated => 'SUMMARY_REPORT_COLUMN_CHILDREN_TREATED';
  String get childrenTreatedPercentage =>
      'SUMMARY_REPORT_COLUMN_CHILDREN_TREATED_PERCENTAGE';
  String get drugsReceived => 'SUMMARY_REPORT_COLUMN_DRUGS_RECEIVED';
  String get drugsUsed => 'SUMMARY_REPORT_COLUMN_DRUGS_USED';
  String get drugsBalance => 'SUMMARY_REPORT_COLUMN_DRUGS_BALANCE';

  String get aztReceived => 'SUMMARY_REPORT_COLUMN_AZT_RECEIVED';
  String get aztConsumed => 'SUMMARY_REPORT_COLUMN_AZT_CONSUMED';
}

class PrivacyPolicy {
  const PrivacyPolicy();

  String get acceptText {
    return 'PRIVACY_POLICY_ACCEPT_TEXT';
  }

  String get declineText {
    return 'PRIVACY_POLICY_DECLINE_TEXT';
  }

  String get privacyNoticeText => 'PRIVACY_POLICY_TEXT';
  String get privacyPolicyLinkText => 'PRIVACY_POLICY_LINK_TEXT';
  String get privacyPolicyValidationText => 'PRIVACY_POLICY_VALIDATION_TEXT';
}

class Dashboard {
  const Dashboard();

  String get dashboardHeaderLabel => 'DASHBOARD_HEADER';
  String get noteDescriptionBednet => 'DSS_NOTE_DESCRIPTION_BEDNET';
}

class Attendance {
  const Attendance();

  String get comments => 'ATTENDANCE_COMMENTS_FIELD';
  String get attendanceOfficerBednet => 'ATTENDANCE_OFFICER_BEDNET';
  String get locationBednet => 'ATTENDANCE_LOCATION_BEDNET';
}

class DeliverIntervention {
  const DeliverIntervention();

  String get memberCountText => "MEMBER_COUNT_TEXT";
  String get bednetCountText => "BEDNET_COUNT_TEXT";

  String get doseGivenCareGiver => 'DELIVER_INTERVENTION_DOSE_GIVEN_CARE_GIVER';
  String get infoWrittenInChildCard =>
      'DELIVER_INTERVENTION_DOSE_INFO_IN_CHILD_CARD_ADDED';
  String get healthTalkGivenOnSPAQ =>
      'DELIVER_INTERVENTION_DOSE_HEALTH_TALK_GIVEN_SPAQ';
  String get wasTheDoseAdministered => 'WAS_THE_DOSE_ADMINISTERED_LABEL';
  String get bednetScanLessThanCount => 'NET_SCANNED_LESS_THAN_COUNT_LABEL';
  String get bednetScanMoreThanCount => 'NET_SCANNED_MORE_THAN_COUNT_LABEL';
  String get informationBulletOne => 'INFORMATION_BULLET_ONE';
  String get informationBulletTwo => 'INFORMATION_BULLET_TWO';
  String get informationBulletThree => 'INFORMATION_BULLET_THREE';
  String get informationBulletFour => 'INFORMATION_BULLET_FOUR';
  String get scanValidResource => 'SCAN_VALID_RESOURCE';
  String get notDelivered => 'NOT_DELIVERED';
  String get delivered => 'DELIVERED';
  String get resourceDelivered => 'RESOURCE_DELIVERED';
  String get numberOfResourceDelivered => 'NUMBER_OF_RESOURCE_DELIVERED_LABEL';
  String get scanBednet => 'SCAN_THE_BEDNET';
  String get deliveryCommentError => 'BEDNET_DELIVERY_COMMENT_ERROR';
  String get deliveryCommentRequired => 'DELIVERY_COMMENT_REQUIRED';
}
