// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AcknowledgementBednetRoute.name: (routeData) {
      final args = routeData.argsAs<AcknowledgementBednetRouteArgs>(
          orElse: () => const AcknowledgementBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AcknowledgementBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isDataRecordSuccess: args.isDataRecordSuccess,
          label: args.label,
          description: args.description,
          descriptionTableData: args.descriptionTableData,
        ),
      );
    },
    AcknowledgementRoute.name: (routeData) {
      final args = routeData.argsAs<AcknowledgementRouteArgs>(
          orElse: () => const AcknowledgementRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AcknowledgementPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isDataRecordSuccess: args.isDataRecordSuccess,
          label: args.label,
          description: args.description,
          descriptionTableData: args.descriptionTableData,
        ),
      );
    },
    AuthenticatedRouteWrapper.name: (routeData) {
      final args = routeData.argsAs<AuthenticatedRouteWrapperArgs>(
          orElse: () => const AuthenticatedRouteWrapperArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthenticatedPageWrapper(key: args.key),
      );
    },
    BednetWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BednetWrapperPage(),
      );
    },
    BeneficiariesReportRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BeneficiariesReportPage(),
      );
    },
    BoundarySelectionRoute.name: (routeData) {
      final args = routeData.argsAs<BoundarySelectionRouteArgs>(
          orElse: () => const BoundarySelectionRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BoundarySelectionPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    BoundarySelectionViewRoute.name: (routeData) {
      final args = routeData.argsAs<BoundarySelectionViewRouteArgs>(
          orElse: () => const BoundarySelectionViewRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BoundarySelectionViewPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    ComplaintsAcknowledgementRoute.name: (routeData) {
      final args = routeData.argsAs<ComplaintsAcknowledgementRouteArgs>(
          orElse: () => const ComplaintsAcknowledgementRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ComplaintsAcknowledgementPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    ConductMobilityControlAssessmentRoute.name: (routeData) {
      final args = routeData.argsAs<ConductMobilityControlAssessmentRouteArgs>(
          orElse: () => const ConductMobilityControlAssessmentRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConductMobilityControlAssessmentPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    ConsentHouseholdAcknowledgementBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<ConsentHouseholdAcknowledgementBednetRouteArgs>(
              orElse: () =>
                  const ConsentHouseholdAcknowledgementBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConsentHouseholdAcknowledgementBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          enableViewHousehold: args.enableViewHousehold,
        ),
      );
    },
    ConsentHouseholdAcknowledgementRoute.name: (routeData) {
      final args = routeData.argsAs<ConsentHouseholdAcknowledgementRouteArgs>(
          orElse: () => const ConsentHouseholdAcknowledgementRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConsentHouseholdAcknowledgementPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          enableViewHousehold: args.enableViewHousehold,
        ),
      );
    },
    CustomAcknowledgementRoute.name: (routeData) {
      final args = routeData.argsAs<CustomAcknowledgementRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomAcknowledgementPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          mrnNumber: args.mrnNumber,
          stockRecords: args.stockRecords,
          entryType: args.entryType,
        ),
      );
    },
    CustomAttendanceDateSessionSelectionBednetRoute.name: (routeData) {
      final args = routeData
          .argsAs<CustomAttendanceDateSessionSelectionBednetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomAttendanceDateSessionSelectionBednetPage(
          registers: args.registers,
          registerID: args.registerID,
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomAttendanceDateSessionSelectionRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomAttendanceDateSessionSelectionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomAttendanceDateSessionSelectionPage(
          registers: args.registers,
          registerID: args.registerID,
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomBednetSummaryRoute.name: (routeData) {
      final args = routeData.argsAs<CustomBednetSummaryRouteArgs>(
          orElse: () => const CustomBednetSummaryRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomBednetSummaryPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomBeneficiaryAcknowledgementBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomBeneficiaryAcknowledgementBednetRouteArgs>(
              orElse: () =>
                  const CustomBeneficiaryAcknowledgementBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomBeneficiaryAcknowledgementBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          enableViewHousehold: args.enableViewHousehold,
        ),
      );
    },
    CustomBeneficiaryAcknowledgementRoute.name: (routeData) {
      final args = routeData.argsAs<CustomBeneficiaryAcknowledgementRouteArgs>(
          orElse: () => const CustomBeneficiaryAcknowledgementRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomBeneficiaryAcknowledgementPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          enableViewHousehold: args.enableViewHousehold,
        ),
      );
    },
    CustomBeneficiaryAcknowledgementSMCRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomBeneficiaryAcknowledgementSMCRouteArgs>(
              orElse: () =>
                  const CustomBeneficiaryAcknowledgementSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomBeneficiaryAcknowledgementSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          enableViewHousehold: args.enableViewHousehold,
        ),
      );
    },
    CustomBeneficiaryChecklistBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomBeneficiaryChecklistBednetRouteArgs>(
          orElse: () => const CustomBeneficiaryChecklistBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomBeneficiaryChecklistBednetPage(
          key: args.key,
          beneficiaryClientRefId: args.beneficiaryClientRefId,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomBeneficiaryChecklistRoute.name: (routeData) {
      final args = routeData.argsAs<CustomBeneficiaryChecklistRouteArgs>(
          orElse: () => const CustomBeneficiaryChecklistRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomBeneficiaryChecklistPage(
          key: args.key,
          beneficiaryClientRefId: args.beneficiaryClientRefId,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomBeneficiaryDetailsBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomBeneficiaryDetailsBednetRouteArgs>(
          orElse: () => const CustomBeneficiaryDetailsBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomBeneficiaryDetailsBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomBeneficiaryDetailsSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomBeneficiaryDetailsSMCRouteArgs>(
          orElse: () => const CustomBeneficiaryDetailsSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomBeneficiaryDetailsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomClosedHouseholdDetailsBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomClosedHouseholdDetailsBednetRouteArgs>(
              orElse: () =>
                  const CustomClosedHouseholdDetailsBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomClosedHouseholdDetailsBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomClosedHouseholdDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CustomClosedHouseholdDetailsRouteArgs>(
          orElse: () => const CustomClosedHouseholdDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomClosedHouseholdDetailsPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomClosedHouseholdDetailsSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomClosedHouseholdDetailsSMCRouteArgs>(
          orElse: () => const CustomClosedHouseholdDetailsSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomClosedHouseholdDetailsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomClosedHouseholdSummaryBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomClosedHouseholdSummaryBednetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomClosedHouseholdSummaryBednetPage(
          reason: args.reason,
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomClosedHouseholdSummaryRoute.name: (routeData) {
      final args = routeData.argsAs<CustomClosedHouseholdSummaryRouteArgs>(
          orElse: () => const CustomClosedHouseholdSummaryRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomClosedHouseholdSummaryPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomClosedHouseholdSummarySMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomClosedHouseholdSummarySMCRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomClosedHouseholdSummarySMCPage(
          reason: args.reason,
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomDeliverInterventionBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomDeliverInterventionBednetRouteArgs>(
          orElse: () => const CustomDeliverInterventionBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomDeliverInterventionBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEditing: args.isEditing,
        ),
      );
    },
    CustomDeliverInterventionHeadRoute.name: (routeData) {
      final args = routeData.argsAs<CustomDeliverInterventionHeadRouteArgs>(
          orElse: () => const CustomDeliverInterventionHeadRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomDeliverInterventionHeadPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEditing: args.isEditing,
        ),
      );
    },
    CustomDeliverInterventionRoute.name: (routeData) {
      final args = routeData.argsAs<CustomDeliverInterventionRouteArgs>(
          orElse: () => const CustomDeliverInterventionRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomDeliverInterventionPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEditing: args.isEditing,
        ),
      );
    },
    CustomDeliverInterventionSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomDeliverInterventionSMCRouteArgs>(
          orElse: () => const CustomDeliverInterventionSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomDeliverInterventionSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEditing: args.isEditing,
        ),
      );
    },
    CustomDeliverySummaryBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomDeliverySummaryBednetRouteArgs>(
          orElse: () => const CustomDeliverySummaryBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomDeliverySummaryBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomDeliverySummaryRoute.name: (routeData) {
      final args = routeData.argsAs<CustomDeliverySummaryRouteArgs>(
          orElse: () => const CustomDeliverySummaryRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomDeliverySummaryPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomDeliverySummarySMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomDeliverySummarySMCRouteArgs>(
          orElse: () => const CustomDeliverySummarySMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomDeliverySummarySMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomDigitScannerRoute.name: (routeData) {
      final args = routeData.argsAs<CustomDigitScannerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomDigitScannerPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          quantity: args.quantity,
          isGS1code: args.isGS1code,
          singleValue: args.singleValue,
          isEditEnabled: args.isEditEnabled,
        ),
      );
    },
    CustomHouseDetailsBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseDetailsBednetRouteArgs>(
          orElse: () => const CustomHouseDetailsBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseDetailsBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomHouseDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseDetailsRouteArgs>(
          orElse: () => const CustomHouseDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseDetailsPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomHouseHoldDetailsBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseHoldDetailsBednetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseHoldDetailsBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEligible: args.isEligible,
        ),
      );
    },
    CustomHouseHoldDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseHoldDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseHoldDetailsPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEligible: args.isEligible,
        ),
      );
    },
    CustomHouseHoldDetailsSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseHoldDetailsSMCRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseHoldDetailsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEligible: args.isEligible,
        ),
      );
    },
    CustomHouseholdAcknowledgementBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomHouseholdAcknowledgementBednetRouteArgs>(
              orElse: () =>
                  const CustomHouseholdAcknowledgementBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdAcknowledgementBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          enableViewHousehold: args.enableViewHousehold,
        ),
      );
    },
    CustomHouseholdAcknowledgementRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdAcknowledgementRouteArgs>(
          orElse: () => const CustomHouseholdAcknowledgementRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdAcknowledgementPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          enableViewHousehold: args.enableViewHousehold,
        ),
      );
    },
    CustomHouseholdAcknowledgementSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdAcknowledgementSMCRouteArgs>(
          orElse: () => const CustomHouseholdAcknowledgementSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdAcknowledgementSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          enableViewHousehold: args.enableViewHousehold,
          isReferral: args.isReferral,
        ),
      );
    },
    CustomHouseholdLocationBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdLocationBednetRouteArgs>(
          orElse: () => const CustomHouseholdLocationBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdLocationBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomHouseholdLocationRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdLocationRouteArgs>(
          orElse: () => const CustomHouseholdLocationRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdLocationPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomHouseholdLocationSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdLocationSMCRouteArgs>(
          orElse: () => const CustomHouseholdLocationSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdLocationSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomHouseholdOverviewBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdOverviewBednetRouteArgs>(
          orElse: () => const CustomHouseholdOverviewBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdOverviewBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomHouseholdOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdOverviewRouteArgs>(
          orElse: () => const CustomHouseholdOverviewRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdOverviewPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomHouseholdOverviewSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdOverviewSMCRouteArgs>(
          orElse: () => const CustomHouseholdOverviewSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdOverviewSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomHouseholdWrapperBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdWrapperBednetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdWrapperBednetPage(
          key: args.key,
          wrapper: args.wrapper,
          isEditing: args.isEditing,
        ),
      );
    },
    CustomHouseholdWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<CustomHouseholdWrapperRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomHouseholdWrapperPage(
          key: args.key,
          wrapper: args.wrapper,
          isEditing: args.isEditing,
        ),
      );
    },
    CustomIndividualDetailsBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomIndividualDetailsBednetRouteArgs>(
          orElse: () => const CustomIndividualDetailsBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomIndividualDetailsBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isHeadOfHousehold: args.isHeadOfHousehold,
          isEligible: args.isEligible,
        ),
      );
    },
    CustomIndividualDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CustomIndividualDetailsRouteArgs>(
          orElse: () => const CustomIndividualDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomIndividualDetailsPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isHeadOfHousehold: args.isHeadOfHousehold,
          isEligible: args.isEligible,
        ),
      );
    },
    CustomIndividualDetailsSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomIndividualDetailsSMCRouteArgs>(
          orElse: () => const CustomIndividualDetailsSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomIndividualDetailsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isHeadOfHousehold: args.isHeadOfHousehold,
        ),
      );
    },
    CustomInventoryFacilitySelectionBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomInventoryFacilitySelectionBednetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryFacilitySelectionBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          facilities: args.facilities,
        ),
      );
    },
    CustomInventoryFacilitySelectionRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomInventoryFacilitySelectionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryFacilitySelectionPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          facilities: args.facilities,
        ),
      );
    },
    CustomInventoryFacilitySelectionSMCRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomInventoryFacilitySelectionSMCRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryFacilitySelectionSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          facilities: args.facilities,
        ),
      );
    },
    CustomInventoryReportDetailsBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomInventoryReportDetailsBednetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryReportDetailsBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          reportType: args.reportType,
        ),
      );
    },
    CustomInventoryReportDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CustomInventoryReportDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryReportDetailsPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          reportType: args.reportType,
        ),
      );
    },
    CustomInventoryReportDetailsSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomInventoryReportDetailsSMCRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryReportDetailsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          reportType: args.reportType,
        ),
      );
    },
    CustomInventoryReportSelectionBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomInventoryReportSelectionBednetRouteArgs>(
              orElse: () =>
                  const CustomInventoryReportSelectionBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryReportSelectionBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomInventoryReportSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<CustomInventoryReportSelectionRouteArgs>(
          orElse: () => const CustomInventoryReportSelectionRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryReportSelectionPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomInventoryReportSelectionSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomInventoryReportSelectionSMCRouteArgs>(
          orElse: () => const CustomInventoryReportSelectionSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomInventoryReportSelectionSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomManageAttendanceBednetRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CustomManageAttendanceBednetPage(),
      );
    },
    CustomManageAttendanceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CustomManageAttendancePage(),
      );
    },
    CustomManageStocksBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomManageStocksBednetRouteArgs>(
          orElse: () => const CustomManageStocksBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomManageStocksBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomManageStocksRoute.name: (routeData) {
      final args = routeData.argsAs<CustomManageStocksRouteArgs>(
          orElse: () => const CustomManageStocksRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomManageStocksPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomManageStocksSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomManageStocksSMCRouteArgs>(
          orElse: () => const CustomManageStocksSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomManageStocksSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomMarkAttendanceBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomMarkAttendanceBednetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomMarkAttendanceBednetPage(
          exitTime: args.exitTime,
          entryTime: args.entryTime,
          dateTime: args.dateTime,
          attendees: args.attendees,
          registerId: args.registerId,
          tenantId: args.tenantId,
          session: args.session,
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomMarkAttendanceRoute.name: (routeData) {
      final args = routeData.argsAs<CustomMarkAttendanceRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomMarkAttendancePage(
          exitTime: args.exitTime,
          entryTime: args.entryTime,
          dateTime: args.dateTime,
          attendees: args.attendees,
          registerId: args.registerId,
          tenantId: args.tenantId,
          session: args.session,
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomMinNumberRoute.name: (routeData) {
      final args = routeData.argsAs<CustomMinNumberRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomMinNumberPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          type: args.type,
        ),
      );
    },
    CustomRecordReferralDetailsSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomRecordReferralDetailsSMCRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomRecordReferralDetailsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEditing: args.isEditing,
          projectId: args.projectId,
          cycles: args.cycles,
        ),
      );
    },
    CustomReferBeneficiaryBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomReferBeneficiaryBednetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomReferBeneficiaryBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEditing: args.isEditing,
          projectBeneficiaryClientRefId: args.projectBeneficiaryClientRefId,
          individual: args.individual,
          isReadministrationUnSuccessful: args.isReadministrationUnSuccessful,
          quantityWasted: args.quantityWasted,
          productVariantId: args.productVariantId,
          referralReasons: args.referralReasons,
        ),
      );
    },
    CustomReferBeneficiarySMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomReferBeneficiarySMCRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomReferBeneficiarySMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEditing: args.isEditing,
          projectBeneficiaryClientRefId: args.projectBeneficiaryClientRefId,
          individual: args.individual,
          isReadministrationUnSuccessful: args.isReadministrationUnSuccessful,
          quantityWasted: args.quantityWasted,
          productVariantId: args.productVariantId,
          referralReasons: args.referralReasons,
        ),
      );
    },
    CustomReferralReasonChecklistSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomReferralReasonChecklistSMCRouteArgs>(
          orElse: () => const CustomReferralReasonChecklistSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomReferralReasonChecklistSMCPage(
          key: args.key,
          referralClientRefId: args.referralClientRefId,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomRefusedDeliveryBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomRefusedDeliveryBednetRouteArgs>(
          orElse: () => const CustomRefusedDeliveryBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomRefusedDeliveryBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomRefusedDeliveryRoute.name: (routeData) {
      final args = routeData.argsAs<CustomRefusedDeliveryRouteArgs>(
          orElse: () => const CustomRefusedDeliveryRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomRefusedDeliveryPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomSearchBeneficiaryBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomSearchBeneficiaryBednetRouteArgs>(
          orElse: () => const CustomSearchBeneficiaryBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomSearchBeneficiaryBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomSearchBeneficiaryRoute.name: (routeData) {
      final args = routeData.argsAs<CustomSearchBeneficiaryRouteArgs>(
          orElse: () => const CustomSearchBeneficiaryRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomSearchBeneficiaryPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomSearchBeneficiarySMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomSearchBeneficiarySMCRouteArgs>(
          orElse: () => const CustomSearchBeneficiarySMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomSearchBeneficiarySMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomSearchReferralReconciliationsSMCRoute.name: (routeData) {
      final args =
          routeData.argsAs<CustomSearchReferralReconciliationsSMCRouteArgs>(
              orElse: () =>
                  const CustomSearchReferralReconciliationsSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomSearchReferralReconciliationsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomStockDetailsBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomStockDetailsBednetRouteArgs>(
          orElse: () => const CustomStockDetailsBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomStockDetailsBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomStockDetailsSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomStockDetailsSMCRouteArgs>(
          orElse: () => const CustomStockDetailsSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomStockDetailsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomStockReconciliationBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomStockReconciliationBednetRouteArgs>(
          orElse: () => const CustomStockReconciliationBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomStockReconciliationBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomStockReconciliationRoute.name: (routeData) {
      final args = routeData.argsAs<CustomStockReconciliationRouteArgs>(
          orElse: () => const CustomStockReconciliationRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomStockReconciliationPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomStockReconciliationSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomStockReconciliationSMCRouteArgs>(
          orElse: () => const CustomStockReconciliationSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomStockReconciliationSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomWarehouseDetailsBednetRoute.name: (routeData) {
      final args = routeData.argsAs<CustomWarehouseDetailsBednetRouteArgs>(
          orElse: () => const CustomWarehouseDetailsBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomWarehouseDetailsBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    CustomWarehouseDetailsSMCRoute.name: (routeData) {
      final args = routeData.argsAs<CustomWarehouseDetailsSMCRouteArgs>(
          orElse: () => const CustomWarehouseDetailsSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CustomWarehouseDetailsSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    DigitScannerRoute.name: (routeData) {
      final args = routeData.argsAs<DigitScannerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DigitScannerPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          quantity: args.quantity,
          isGS1code: args.isGS1code,
          singleValue: args.singleValue,
          isEditEnabled: args.isEditEnabled,
        ),
      );
    },
    DoseAdministeredVerificationBednetRoute.name: (routeData) {
      final args =
          routeData.argsAs<DoseAdministeredVerificationBednetRouteArgs>(
              orElse: () =>
                  const DoseAdministeredVerificationBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DoseAdministeredVerificationBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    DoseAdministeredVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<DoseAdministeredVerificationRouteArgs>(
          orElse: () => const DoseAdministeredVerificationRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DoseAdministeredVerificationPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    EligibilityChecklistViewRoute.name: (routeData) {
      final args = routeData.argsAs<EligibilityChecklistViewRouteArgs>(
          orElse: () => const EligibilityChecklistViewRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EligibilityChecklistViewPage(
          key: args.key,
          referralClientRefId: args.referralClientRefId,
          individual: args.individual,
          projectBeneficiaryClientReferenceId:
              args.projectBeneficiaryClientReferenceId,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    HomeBednetRoute.name: (routeData) {
      final args = routeData.argsAs<HomeBednetRouteArgs>(
          orElse: () => const HomeBednetRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeBednetPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    HomeSMCRoute.name: (routeData) {
      final args = routeData.argsAs<HomeSMCRouteArgs>(
          orElse: () => const HomeSMCRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    IRSWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IRSWrapperPage(),
      );
    },
    IneligibleSummaryRoute.name: (routeData) {
      final args = routeData.argsAs<IneligibleSummaryRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: IneligibleSummaryPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          isEligible: args.isEligible,
          previousWrapper: args.previousWrapper,
        ),
      );
    },
    LanguageSelectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LanguageSelectionPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => const ProfileRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfilePage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    ProjectFacilitySelectionRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectFacilitySelectionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectFacilitySelectionPage(
          key: args.key,
          projectFacilities: args.projectFacilities,
        ),
      );
    },
    ProjectSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectSelectionRouteArgs>(
          orElse: () => const ProjectSelectionRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectSelectionPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    QRScannerRoute.name: (routeData) {
      final args = routeData.argsAs<QRScannerRouteArgs>(
          orElse: () => const QRScannerRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QRScannerPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    ReceiveStockRoute.name: (routeData) {
      final args = routeData.argsAs<ReceiveStockRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReceiveStockPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          mrnNumber: args.mrnNumber,
          stockRecords: args.stockRecords,
        ),
      );
    },
    ReferralReconProjectFacilitySelectionSMCRoute.name: (routeData) {
      final args =
          routeData.argsAs<ReferralReconProjectFacilitySelectionSMCRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReferralReconProjectFacilitySelectionSMCPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          projectFacilities: args.projectFacilities,
          facilityMap: args.facilityMap,
        ),
      );
    },
    SMCWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SMCWrapperPage(),
      );
    },
    UnauthenticatedRouteWrapper.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UnauthenticatedPageWrapper(),
      );
    },
    UserQRDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UserQRDetailsRouteArgs>(
          orElse: () => const UserQRDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserQRDetailsPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    VehicleAcknowledgementRoute.name: (routeData) {
      final args = routeData.argsAs<VehicleAcknowledgementRouteArgs>(
          orElse: () => const VehicleAcknowledgementRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VehicleAcknowledgementPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    VehicleOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<VehicleOverviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VehicleOverviewPage(
          key: args.key,
          vehicleNo: args.vehicleNo,
        ),
      );
    },
    VehicleSearchRoute.name: (routeData) {
      final args = routeData.argsAs<VehicleSearchRouteArgs>(
          orElse: () => const VehicleSearchRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VehicleSearchPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
        ),
      );
    },
    VehicleTrackingWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const VehicleTrackingWrapperPage(),
      );
    },
    VehicleTripBookRoute.name: (routeData) {
      final args = routeData.argsAs<VehicleTripBookRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VehicleTripBookPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          vehicleNo: args.vehicleNo,
        ),
      );
    },
    ViewAllTransactionsRoute.name: (routeData) {
      final args = routeData.argsAs<ViewAllTransactionsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewAllTransactionsScreen(
          key: args.key,
          warehouseId: args.warehouseId,
        ),
      );
    },
    ViewStockRecordsCDDRoute.name: (routeData) {
      final args = routeData.argsAs<ViewStockRecordsCDDRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewStockRecordsCDDPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          mrnNumber: args.mrnNumber,
          stockRecords: args.stockRecords,
        ),
      );
    },
    ViewStockRecordsRoute.name: (routeData) {
      final args = routeData.argsAs<ViewStockRecordsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewStockRecordsPage(
          key: args.key,
          appLocalizations: args.appLocalizations,
          mrnNumber: args.mrnNumber,
          stockRecords: args.stockRecords,
        ),
      );
    },
    ViewTransactionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ViewTransactionsScreen(),
      );
    },
    ...RegistrationDeliveryRoute().pagesMap,
    ...InventoryRoute().pagesMap,
    ...ClosedHouseholdPackageRoute().pagesMap,
    ...DashboardRoute().pagesMap,
    ...AttendanceRoute().pagesMap,
    ...ReferralReconciliationRoute().pagesMap,
    ...SurveyFormRoute().pagesMap,
  };
}

/// generated route for
/// [AcknowledgementBednetPage]
class AcknowledgementBednetRoute
    extends PageRouteInfo<AcknowledgementBednetRouteArgs> {
  AcknowledgementBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    bool isDataRecordSuccess = false,
    String? label,
    String? description,
    Map<String, dynamic>? descriptionTableData,
    List<PageRouteInfo>? children,
  }) : super(
          AcknowledgementBednetRoute.name,
          args: AcknowledgementBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isDataRecordSuccess: isDataRecordSuccess,
            label: label,
            description: description,
            descriptionTableData: descriptionTableData,
          ),
          initialChildren: children,
        );

  static const String name = 'AcknowledgementBednetRoute';

  static const PageInfo<AcknowledgementBednetRouteArgs> page =
      PageInfo<AcknowledgementBednetRouteArgs>(name);
}

class AcknowledgementBednetRouteArgs {
  const AcknowledgementBednetRouteArgs({
    this.key,
    this.appLocalizations,
    this.isDataRecordSuccess = false,
    this.label,
    this.description,
    this.descriptionTableData,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isDataRecordSuccess;

  final String? label;

  final String? description;

  final Map<String, dynamic>? descriptionTableData;

  @override
  String toString() {
    return 'AcknowledgementBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, isDataRecordSuccess: $isDataRecordSuccess, label: $label, description: $description, descriptionTableData: $descriptionTableData}';
  }
}

/// generated route for
/// [AcknowledgementPage]
class AcknowledgementRoute extends PageRouteInfo<AcknowledgementRouteArgs> {
  AcknowledgementRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    bool isDataRecordSuccess = false,
    String? label,
    String? description,
    Map<String, dynamic>? descriptionTableData,
    List<PageRouteInfo>? children,
  }) : super(
          AcknowledgementRoute.name,
          args: AcknowledgementRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isDataRecordSuccess: isDataRecordSuccess,
            label: label,
            description: description,
            descriptionTableData: descriptionTableData,
          ),
          initialChildren: children,
        );

  static const String name = 'AcknowledgementRoute';

  static const PageInfo<AcknowledgementRouteArgs> page =
      PageInfo<AcknowledgementRouteArgs>(name);
}

class AcknowledgementRouteArgs {
  const AcknowledgementRouteArgs({
    this.key,
    this.appLocalizations,
    this.isDataRecordSuccess = false,
    this.label,
    this.description,
    this.descriptionTableData,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isDataRecordSuccess;

  final String? label;

  final String? description;

  final Map<String, dynamic>? descriptionTableData;

  @override
  String toString() {
    return 'AcknowledgementRouteArgs{key: $key, appLocalizations: $appLocalizations, isDataRecordSuccess: $isDataRecordSuccess, label: $label, description: $description, descriptionTableData: $descriptionTableData}';
  }
}

/// generated route for
/// [AuthenticatedPageWrapper]
class AuthenticatedRouteWrapper
    extends PageRouteInfo<AuthenticatedRouteWrapperArgs> {
  AuthenticatedRouteWrapper({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthenticatedRouteWrapper.name,
          args: AuthenticatedRouteWrapperArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AuthenticatedRouteWrapper';

  static const PageInfo<AuthenticatedRouteWrapperArgs> page =
      PageInfo<AuthenticatedRouteWrapperArgs>(name);
}

class AuthenticatedRouteWrapperArgs {
  const AuthenticatedRouteWrapperArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AuthenticatedRouteWrapperArgs{key: $key}';
  }
}

/// generated route for
/// [BednetWrapperPage]
class BednetWrapperRoute extends PageRouteInfo<void> {
  const BednetWrapperRoute({List<PageRouteInfo>? children})
      : super(
          BednetWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'BednetWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BeneficiariesReportPage]
class BeneficiariesReportRoute extends PageRouteInfo<void> {
  const BeneficiariesReportRoute({List<PageRouteInfo>? children})
      : super(
          BeneficiariesReportRoute.name,
          initialChildren: children,
        );

  static const String name = 'BeneficiariesReportRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BoundarySelectionPage]
class BoundarySelectionRoute extends PageRouteInfo<BoundarySelectionRouteArgs> {
  BoundarySelectionRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          BoundarySelectionRoute.name,
          args: BoundarySelectionRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'BoundarySelectionRoute';

  static const PageInfo<BoundarySelectionRouteArgs> page =
      PageInfo<BoundarySelectionRouteArgs>(name);
}

class BoundarySelectionRouteArgs {
  const BoundarySelectionRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'BoundarySelectionRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [BoundarySelectionViewPage]
class BoundarySelectionViewRoute
    extends PageRouteInfo<BoundarySelectionViewRouteArgs> {
  BoundarySelectionViewRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          BoundarySelectionViewRoute.name,
          args: BoundarySelectionViewRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'BoundarySelectionViewRoute';

  static const PageInfo<BoundarySelectionViewRouteArgs> page =
      PageInfo<BoundarySelectionViewRouteArgs>(name);
}

class BoundarySelectionViewRouteArgs {
  const BoundarySelectionViewRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'BoundarySelectionViewRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [ComplaintsAcknowledgementPage]
class ComplaintsAcknowledgementRoute
    extends PageRouteInfo<ComplaintsAcknowledgementRouteArgs> {
  ComplaintsAcknowledgementRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          ComplaintsAcknowledgementRoute.name,
          args: ComplaintsAcknowledgementRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'ComplaintsAcknowledgementRoute';

  static const PageInfo<ComplaintsAcknowledgementRouteArgs> page =
      PageInfo<ComplaintsAcknowledgementRouteArgs>(name);
}

class ComplaintsAcknowledgementRouteArgs {
  const ComplaintsAcknowledgementRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'ComplaintsAcknowledgementRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [ConductMobilityControlAssessmentPage]
class ConductMobilityControlAssessmentRoute
    extends PageRouteInfo<ConductMobilityControlAssessmentRouteArgs> {
  ConductMobilityControlAssessmentRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          ConductMobilityControlAssessmentRoute.name,
          args: ConductMobilityControlAssessmentRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'ConductMobilityControlAssessmentRoute';

  static const PageInfo<ConductMobilityControlAssessmentRouteArgs> page =
      PageInfo<ConductMobilityControlAssessmentRouteArgs>(name);
}

class ConductMobilityControlAssessmentRouteArgs {
  const ConductMobilityControlAssessmentRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'ConductMobilityControlAssessmentRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [ConsentHouseholdAcknowledgementBednetPage]
class ConsentHouseholdAcknowledgementBednetRoute
    extends PageRouteInfo<ConsentHouseholdAcknowledgementBednetRouteArgs> {
  ConsentHouseholdAcknowledgementBednetRoute({
    Key? key,
    AttendanceLocalization? appLocalizations,
    bool? enableViewHousehold,
    List<PageRouteInfo>? children,
  }) : super(
          ConsentHouseholdAcknowledgementBednetRoute.name,
          args: ConsentHouseholdAcknowledgementBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            enableViewHousehold: enableViewHousehold,
          ),
          initialChildren: children,
        );

  static const String name = 'ConsentHouseholdAcknowledgementBednetRoute';

  static const PageInfo<ConsentHouseholdAcknowledgementBednetRouteArgs> page =
      PageInfo<ConsentHouseholdAcknowledgementBednetRouteArgs>(name);
}

class ConsentHouseholdAcknowledgementBednetRouteArgs {
  const ConsentHouseholdAcknowledgementBednetRouteArgs({
    this.key,
    this.appLocalizations,
    this.enableViewHousehold,
  });

  final Key? key;

  final AttendanceLocalization? appLocalizations;

  final bool? enableViewHousehold;

  @override
  String toString() {
    return 'ConsentHouseholdAcknowledgementBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, enableViewHousehold: $enableViewHousehold}';
  }
}

/// generated route for
/// [ConsentHouseholdAcknowledgementPage]
class ConsentHouseholdAcknowledgementRoute
    extends PageRouteInfo<ConsentHouseholdAcknowledgementRouteArgs> {
  ConsentHouseholdAcknowledgementRoute({
    Key? key,
    AttendanceLocalization? appLocalizations,
    bool? enableViewHousehold,
    List<PageRouteInfo>? children,
  }) : super(
          ConsentHouseholdAcknowledgementRoute.name,
          args: ConsentHouseholdAcknowledgementRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            enableViewHousehold: enableViewHousehold,
          ),
          initialChildren: children,
        );

  static const String name = 'ConsentHouseholdAcknowledgementRoute';

  static const PageInfo<ConsentHouseholdAcknowledgementRouteArgs> page =
      PageInfo<ConsentHouseholdAcknowledgementRouteArgs>(name);
}

class ConsentHouseholdAcknowledgementRouteArgs {
  const ConsentHouseholdAcknowledgementRouteArgs({
    this.key,
    this.appLocalizations,
    this.enableViewHousehold,
  });

  final Key? key;

  final AttendanceLocalization? appLocalizations;

  final bool? enableViewHousehold;

  @override
  String toString() {
    return 'ConsentHouseholdAcknowledgementRouteArgs{key: $key, appLocalizations: $appLocalizations, enableViewHousehold: $enableViewHousehold}';
  }
}

/// generated route for
/// [CustomAcknowledgementPage]
class CustomAcknowledgementRoute
    extends PageRouteInfo<CustomAcknowledgementRouteArgs> {
  CustomAcknowledgementRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    required String mrnNumber,
    required List<StockModel> stockRecords,
    required StockRecordEntryType entryType,
    List<PageRouteInfo>? children,
  }) : super(
          CustomAcknowledgementRoute.name,
          args: CustomAcknowledgementRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            mrnNumber: mrnNumber,
            stockRecords: stockRecords,
            entryType: entryType,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomAcknowledgementRoute';

  static const PageInfo<CustomAcknowledgementRouteArgs> page =
      PageInfo<CustomAcknowledgementRouteArgs>(name);
}

class CustomAcknowledgementRouteArgs {
  const CustomAcknowledgementRouteArgs({
    this.key,
    this.appLocalizations,
    required this.mrnNumber,
    required this.stockRecords,
    required this.entryType,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final String mrnNumber;

  final List<StockModel> stockRecords;

  final StockRecordEntryType entryType;

  @override
  String toString() {
    return 'CustomAcknowledgementRouteArgs{key: $key, appLocalizations: $appLocalizations, mrnNumber: $mrnNumber, stockRecords: $stockRecords, entryType: $entryType}';
  }
}

/// generated route for
/// [CustomAttendanceDateSessionSelectionBednetPage]
class CustomAttendanceDateSessionSelectionBednetRoute
    extends PageRouteInfo<CustomAttendanceDateSessionSelectionBednetRouteArgs> {
  CustomAttendanceDateSessionSelectionBednetRoute({
    required List<AttendanceRegisterModel> registers,
    required String registerID,
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomAttendanceDateSessionSelectionBednetRoute.name,
          args: CustomAttendanceDateSessionSelectionBednetRouteArgs(
            registers: registers,
            registerID: registerID,
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomAttendanceDateSessionSelectionBednetRoute';

  static const PageInfo<CustomAttendanceDateSessionSelectionBednetRouteArgs>
      page =
      PageInfo<CustomAttendanceDateSessionSelectionBednetRouteArgs>(name);
}

class CustomAttendanceDateSessionSelectionBednetRouteArgs {
  const CustomAttendanceDateSessionSelectionBednetRouteArgs({
    required this.registers,
    required this.registerID,
    this.key,
    this.appLocalizations,
  });

  final List<AttendanceRegisterModel> registers;

  final String registerID;

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomAttendanceDateSessionSelectionBednetRouteArgs{registers: $registers, registerID: $registerID, key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomAttendanceDateSessionSelectionPage]
class CustomAttendanceDateSessionSelectionRoute
    extends PageRouteInfo<CustomAttendanceDateSessionSelectionRouteArgs> {
  CustomAttendanceDateSessionSelectionRoute({
    required List<AttendanceRegisterModel> registers,
    required String registerID,
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomAttendanceDateSessionSelectionRoute.name,
          args: CustomAttendanceDateSessionSelectionRouteArgs(
            registers: registers,
            registerID: registerID,
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomAttendanceDateSessionSelectionRoute';

  static const PageInfo<CustomAttendanceDateSessionSelectionRouteArgs> page =
      PageInfo<CustomAttendanceDateSessionSelectionRouteArgs>(name);
}

class CustomAttendanceDateSessionSelectionRouteArgs {
  const CustomAttendanceDateSessionSelectionRouteArgs({
    required this.registers,
    required this.registerID,
    this.key,
    this.appLocalizations,
  });

  final List<AttendanceRegisterModel> registers;

  final String registerID;

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomAttendanceDateSessionSelectionRouteArgs{registers: $registers, registerID: $registerID, key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomBednetSummaryPage]
class CustomBednetSummaryRoute
    extends PageRouteInfo<CustomBednetSummaryRouteArgs> {
  CustomBednetSummaryRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomBednetSummaryRoute.name,
          args: CustomBednetSummaryRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBednetSummaryRoute';

  static const PageInfo<CustomBednetSummaryRouteArgs> page =
      PageInfo<CustomBednetSummaryRouteArgs>(name);
}

class CustomBednetSummaryRouteArgs {
  const CustomBednetSummaryRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomBednetSummaryRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomBeneficiaryAcknowledgementBednetPage]
class CustomBeneficiaryAcknowledgementBednetRoute
    extends PageRouteInfo<CustomBeneficiaryAcknowledgementBednetRouteArgs> {
  CustomBeneficiaryAcknowledgementBednetRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool? enableViewHousehold,
    List<PageRouteInfo>? children,
  }) : super(
          CustomBeneficiaryAcknowledgementBednetRoute.name,
          args: CustomBeneficiaryAcknowledgementBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            enableViewHousehold: enableViewHousehold,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBeneficiaryAcknowledgementBednetRoute';

  static const PageInfo<CustomBeneficiaryAcknowledgementBednetRouteArgs> page =
      PageInfo<CustomBeneficiaryAcknowledgementBednetRouteArgs>(name);
}

class CustomBeneficiaryAcknowledgementBednetRouteArgs {
  const CustomBeneficiaryAcknowledgementBednetRouteArgs({
    this.key,
    this.appLocalizations,
    this.enableViewHousehold,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool? enableViewHousehold;

  @override
  String toString() {
    return 'CustomBeneficiaryAcknowledgementBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, enableViewHousehold: $enableViewHousehold}';
  }
}

/// generated route for
/// [CustomBeneficiaryAcknowledgementPage]
class CustomBeneficiaryAcknowledgementRoute
    extends PageRouteInfo<CustomBeneficiaryAcknowledgementRouteArgs> {
  CustomBeneficiaryAcknowledgementRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool? enableViewHousehold,
    List<PageRouteInfo>? children,
  }) : super(
          CustomBeneficiaryAcknowledgementRoute.name,
          args: CustomBeneficiaryAcknowledgementRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            enableViewHousehold: enableViewHousehold,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBeneficiaryAcknowledgementRoute';

  static const PageInfo<CustomBeneficiaryAcknowledgementRouteArgs> page =
      PageInfo<CustomBeneficiaryAcknowledgementRouteArgs>(name);
}

class CustomBeneficiaryAcknowledgementRouteArgs {
  const CustomBeneficiaryAcknowledgementRouteArgs({
    this.key,
    this.appLocalizations,
    this.enableViewHousehold,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool? enableViewHousehold;

  @override
  String toString() {
    return 'CustomBeneficiaryAcknowledgementRouteArgs{key: $key, appLocalizations: $appLocalizations, enableViewHousehold: $enableViewHousehold}';
  }
}

/// generated route for
/// [CustomBeneficiaryAcknowledgementSMCPage]
class CustomBeneficiaryAcknowledgementSMCRoute
    extends PageRouteInfo<CustomBeneficiaryAcknowledgementSMCRouteArgs> {
  CustomBeneficiaryAcknowledgementSMCRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool? enableViewHousehold,
    List<PageRouteInfo>? children,
  }) : super(
          CustomBeneficiaryAcknowledgementSMCRoute.name,
          args: CustomBeneficiaryAcknowledgementSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            enableViewHousehold: enableViewHousehold,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBeneficiaryAcknowledgementSMCRoute';

  static const PageInfo<CustomBeneficiaryAcknowledgementSMCRouteArgs> page =
      PageInfo<CustomBeneficiaryAcknowledgementSMCRouteArgs>(name);
}

class CustomBeneficiaryAcknowledgementSMCRouteArgs {
  const CustomBeneficiaryAcknowledgementSMCRouteArgs({
    this.key,
    this.appLocalizations,
    this.enableViewHousehold,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool? enableViewHousehold;

  @override
  String toString() {
    return 'CustomBeneficiaryAcknowledgementSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, enableViewHousehold: $enableViewHousehold}';
  }
}

/// generated route for
/// [CustomBeneficiaryChecklistBednetPage]
class CustomBeneficiaryChecklistBednetRoute
    extends PageRouteInfo<CustomBeneficiaryChecklistBednetRouteArgs> {
  CustomBeneficiaryChecklistBednetRoute({
    Key? key,
    String? beneficiaryClientRefId,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomBeneficiaryChecklistBednetRoute.name,
          args: CustomBeneficiaryChecklistBednetRouteArgs(
            key: key,
            beneficiaryClientRefId: beneficiaryClientRefId,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBeneficiaryChecklistBednetRoute';

  static const PageInfo<CustomBeneficiaryChecklistBednetRouteArgs> page =
      PageInfo<CustomBeneficiaryChecklistBednetRouteArgs>(name);
}

class CustomBeneficiaryChecklistBednetRouteArgs {
  const CustomBeneficiaryChecklistBednetRouteArgs({
    this.key,
    this.beneficiaryClientRefId,
    this.appLocalizations,
  });

  final Key? key;

  final String? beneficiaryClientRefId;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomBeneficiaryChecklistBednetRouteArgs{key: $key, beneficiaryClientRefId: $beneficiaryClientRefId, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomBeneficiaryChecklistPage]
class CustomBeneficiaryChecklistRoute
    extends PageRouteInfo<CustomBeneficiaryChecklistRouteArgs> {
  CustomBeneficiaryChecklistRoute({
    Key? key,
    String? beneficiaryClientRefId,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomBeneficiaryChecklistRoute.name,
          args: CustomBeneficiaryChecklistRouteArgs(
            key: key,
            beneficiaryClientRefId: beneficiaryClientRefId,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBeneficiaryChecklistRoute';

  static const PageInfo<CustomBeneficiaryChecklistRouteArgs> page =
      PageInfo<CustomBeneficiaryChecklistRouteArgs>(name);
}

class CustomBeneficiaryChecklistRouteArgs {
  const CustomBeneficiaryChecklistRouteArgs({
    this.key,
    this.beneficiaryClientRefId,
    this.appLocalizations,
  });

  final Key? key;

  final String? beneficiaryClientRefId;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomBeneficiaryChecklistRouteArgs{key: $key, beneficiaryClientRefId: $beneficiaryClientRefId, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomBeneficiaryDetailsBednetPage]
class CustomBeneficiaryDetailsBednetRoute
    extends PageRouteInfo<CustomBeneficiaryDetailsBednetRouteArgs> {
  CustomBeneficiaryDetailsBednetRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomBeneficiaryDetailsBednetRoute.name,
          args: CustomBeneficiaryDetailsBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBeneficiaryDetailsBednetRoute';

  static const PageInfo<CustomBeneficiaryDetailsBednetRouteArgs> page =
      PageInfo<CustomBeneficiaryDetailsBednetRouteArgs>(name);
}

class CustomBeneficiaryDetailsBednetRouteArgs {
  const CustomBeneficiaryDetailsBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomBeneficiaryDetailsBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomBeneficiaryDetailsSMCPage]
class CustomBeneficiaryDetailsSMCRoute
    extends PageRouteInfo<CustomBeneficiaryDetailsSMCRouteArgs> {
  CustomBeneficiaryDetailsSMCRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomBeneficiaryDetailsSMCRoute.name,
          args: CustomBeneficiaryDetailsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomBeneficiaryDetailsSMCRoute';

  static const PageInfo<CustomBeneficiaryDetailsSMCRouteArgs> page =
      PageInfo<CustomBeneficiaryDetailsSMCRouteArgs>(name);
}

class CustomBeneficiaryDetailsSMCRouteArgs {
  const CustomBeneficiaryDetailsSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomBeneficiaryDetailsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomClosedHouseholdDetailsBednetPage]
class CustomClosedHouseholdDetailsBednetRoute
    extends PageRouteInfo<CustomClosedHouseholdDetailsBednetRouteArgs> {
  CustomClosedHouseholdDetailsBednetRoute({
    Key? key,
    ClosedHouseholdLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomClosedHouseholdDetailsBednetRoute.name,
          args: CustomClosedHouseholdDetailsBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomClosedHouseholdDetailsBednetRoute';

  static const PageInfo<CustomClosedHouseholdDetailsBednetRouteArgs> page =
      PageInfo<CustomClosedHouseholdDetailsBednetRouteArgs>(name);
}

class CustomClosedHouseholdDetailsBednetRouteArgs {
  const CustomClosedHouseholdDetailsBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final ClosedHouseholdLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomClosedHouseholdDetailsBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomClosedHouseholdDetailsPage]
class CustomClosedHouseholdDetailsRoute
    extends PageRouteInfo<CustomClosedHouseholdDetailsRouteArgs> {
  CustomClosedHouseholdDetailsRoute({
    Key? key,
    ClosedHouseholdLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomClosedHouseholdDetailsRoute.name,
          args: CustomClosedHouseholdDetailsRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomClosedHouseholdDetailsRoute';

  static const PageInfo<CustomClosedHouseholdDetailsRouteArgs> page =
      PageInfo<CustomClosedHouseholdDetailsRouteArgs>(name);
}

class CustomClosedHouseholdDetailsRouteArgs {
  const CustomClosedHouseholdDetailsRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final ClosedHouseholdLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomClosedHouseholdDetailsRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomClosedHouseholdDetailsSMCPage]
class CustomClosedHouseholdDetailsSMCRoute
    extends PageRouteInfo<CustomClosedHouseholdDetailsSMCRouteArgs> {
  CustomClosedHouseholdDetailsSMCRoute({
    Key? key,
    ClosedHouseholdLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomClosedHouseholdDetailsSMCRoute.name,
          args: CustomClosedHouseholdDetailsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomClosedHouseholdDetailsSMCRoute';

  static const PageInfo<CustomClosedHouseholdDetailsSMCRouteArgs> page =
      PageInfo<CustomClosedHouseholdDetailsSMCRouteArgs>(name);
}

class CustomClosedHouseholdDetailsSMCRouteArgs {
  const CustomClosedHouseholdDetailsSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final ClosedHouseholdLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomClosedHouseholdDetailsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomClosedHouseholdSummaryBednetPage]
class CustomClosedHouseholdSummaryBednetRoute
    extends PageRouteInfo<CustomClosedHouseholdSummaryBednetRouteArgs> {
  CustomClosedHouseholdSummaryBednetRoute({
    required dynamic reason,
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomClosedHouseholdSummaryBednetRoute.name,
          args: CustomClosedHouseholdSummaryBednetRouteArgs(
            reason: reason,
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomClosedHouseholdSummaryBednetRoute';

  static const PageInfo<CustomClosedHouseholdSummaryBednetRouteArgs> page =
      PageInfo<CustomClosedHouseholdSummaryBednetRouteArgs>(name);
}

class CustomClosedHouseholdSummaryBednetRouteArgs {
  const CustomClosedHouseholdSummaryBednetRouteArgs({
    required this.reason,
    this.key,
    this.appLocalizations,
  });

  final dynamic reason;

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomClosedHouseholdSummaryBednetRouteArgs{reason: $reason, key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomClosedHouseholdSummaryPage]
class CustomClosedHouseholdSummaryRoute
    extends PageRouteInfo<CustomClosedHouseholdSummaryRouteArgs> {
  CustomClosedHouseholdSummaryRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomClosedHouseholdSummaryRoute.name,
          args: CustomClosedHouseholdSummaryRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomClosedHouseholdSummaryRoute';

  static const PageInfo<CustomClosedHouseholdSummaryRouteArgs> page =
      PageInfo<CustomClosedHouseholdSummaryRouteArgs>(name);
}

class CustomClosedHouseholdSummaryRouteArgs {
  const CustomClosedHouseholdSummaryRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomClosedHouseholdSummaryRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomClosedHouseholdSummarySMCPage]
class CustomClosedHouseholdSummarySMCRoute
    extends PageRouteInfo<CustomClosedHouseholdSummarySMCRouteArgs> {
  CustomClosedHouseholdSummarySMCRoute({
    required dynamic reason,
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomClosedHouseholdSummarySMCRoute.name,
          args: CustomClosedHouseholdSummarySMCRouteArgs(
            reason: reason,
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomClosedHouseholdSummarySMCRoute';

  static const PageInfo<CustomClosedHouseholdSummarySMCRouteArgs> page =
      PageInfo<CustomClosedHouseholdSummarySMCRouteArgs>(name);
}

class CustomClosedHouseholdSummarySMCRouteArgs {
  const CustomClosedHouseholdSummarySMCRouteArgs({
    required this.reason,
    this.key,
    this.appLocalizations,
  });

  final dynamic reason;

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomClosedHouseholdSummarySMCRouteArgs{reason: $reason, key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomDeliverInterventionBednetPage]
class CustomDeliverInterventionBednetRoute
    extends PageRouteInfo<CustomDeliverInterventionBednetRouteArgs> {
  CustomDeliverInterventionBednetRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CustomDeliverInterventionBednetRoute.name,
          args: CustomDeliverInterventionBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomDeliverInterventionBednetRoute';

  static const PageInfo<CustomDeliverInterventionBednetRouteArgs> page =
      PageInfo<CustomDeliverInterventionBednetRouteArgs>(name);
}

class CustomDeliverInterventionBednetRouteArgs {
  const CustomDeliverInterventionBednetRouteArgs({
    this.key,
    this.appLocalizations,
    this.isEditing = false,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool isEditing;

  @override
  String toString() {
    return 'CustomDeliverInterventionBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, isEditing: $isEditing}';
  }
}

/// generated route for
/// [CustomDeliverInterventionHeadPage]
class CustomDeliverInterventionHeadRoute
    extends PageRouteInfo<CustomDeliverInterventionHeadRouteArgs> {
  CustomDeliverInterventionHeadRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CustomDeliverInterventionHeadRoute.name,
          args: CustomDeliverInterventionHeadRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomDeliverInterventionHeadRoute';

  static const PageInfo<CustomDeliverInterventionHeadRouteArgs> page =
      PageInfo<CustomDeliverInterventionHeadRouteArgs>(name);
}

class CustomDeliverInterventionHeadRouteArgs {
  const CustomDeliverInterventionHeadRouteArgs({
    this.key,
    this.appLocalizations,
    this.isEditing = false,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool isEditing;

  @override
  String toString() {
    return 'CustomDeliverInterventionHeadRouteArgs{key: $key, appLocalizations: $appLocalizations, isEditing: $isEditing}';
  }
}

/// generated route for
/// [CustomDeliverInterventionPage]
class CustomDeliverInterventionRoute
    extends PageRouteInfo<CustomDeliverInterventionRouteArgs> {
  CustomDeliverInterventionRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CustomDeliverInterventionRoute.name,
          args: CustomDeliverInterventionRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomDeliverInterventionRoute';

  static const PageInfo<CustomDeliverInterventionRouteArgs> page =
      PageInfo<CustomDeliverInterventionRouteArgs>(name);
}

class CustomDeliverInterventionRouteArgs {
  const CustomDeliverInterventionRouteArgs({
    this.key,
    this.appLocalizations,
    this.isEditing = false,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool isEditing;

  @override
  String toString() {
    return 'CustomDeliverInterventionRouteArgs{key: $key, appLocalizations: $appLocalizations, isEditing: $isEditing}';
  }
}

/// generated route for
/// [CustomDeliverInterventionSMCPage]
class CustomDeliverInterventionSMCRoute
    extends PageRouteInfo<CustomDeliverInterventionSMCRouteArgs> {
  CustomDeliverInterventionSMCRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CustomDeliverInterventionSMCRoute.name,
          args: CustomDeliverInterventionSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomDeliverInterventionSMCRoute';

  static const PageInfo<CustomDeliverInterventionSMCRouteArgs> page =
      PageInfo<CustomDeliverInterventionSMCRouteArgs>(name);
}

class CustomDeliverInterventionSMCRouteArgs {
  const CustomDeliverInterventionSMCRouteArgs({
    this.key,
    this.appLocalizations,
    this.isEditing = false,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool isEditing;

  @override
  String toString() {
    return 'CustomDeliverInterventionSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, isEditing: $isEditing}';
  }
}

/// generated route for
/// [CustomDeliverySummaryBednetPage]
class CustomDeliverySummaryBednetRoute
    extends PageRouteInfo<CustomDeliverySummaryBednetRouteArgs> {
  CustomDeliverySummaryBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomDeliverySummaryBednetRoute.name,
          args: CustomDeliverySummaryBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomDeliverySummaryBednetRoute';

  static const PageInfo<CustomDeliverySummaryBednetRouteArgs> page =
      PageInfo<CustomDeliverySummaryBednetRouteArgs>(name);
}

class CustomDeliverySummaryBednetRouteArgs {
  const CustomDeliverySummaryBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomDeliverySummaryBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomDeliverySummaryPage]
class CustomDeliverySummaryRoute
    extends PageRouteInfo<CustomDeliverySummaryRouteArgs> {
  CustomDeliverySummaryRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomDeliverySummaryRoute.name,
          args: CustomDeliverySummaryRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomDeliverySummaryRoute';

  static const PageInfo<CustomDeliverySummaryRouteArgs> page =
      PageInfo<CustomDeliverySummaryRouteArgs>(name);
}

class CustomDeliverySummaryRouteArgs {
  const CustomDeliverySummaryRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomDeliverySummaryRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomDeliverySummarySMCPage]
class CustomDeliverySummarySMCRoute
    extends PageRouteInfo<CustomDeliverySummarySMCRouteArgs> {
  CustomDeliverySummarySMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomDeliverySummarySMCRoute.name,
          args: CustomDeliverySummarySMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomDeliverySummarySMCRoute';

  static const PageInfo<CustomDeliverySummarySMCRouteArgs> page =
      PageInfo<CustomDeliverySummarySMCRouteArgs>(name);
}

class CustomDeliverySummarySMCRouteArgs {
  const CustomDeliverySummarySMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomDeliverySummarySMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomDigitScannerPage]
class CustomDigitScannerRoute
    extends PageRouteInfo<CustomDigitScannerRouteArgs> {
  CustomDigitScannerRoute({
    Key? key,
    ScannerLocalization? appLocalizations,
    required int quantity,
    required bool isGS1code,
    bool singleValue = false,
    bool isEditEnabled = false,
    List<PageRouteInfo>? children,
  }) : super(
          CustomDigitScannerRoute.name,
          args: CustomDigitScannerRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            quantity: quantity,
            isGS1code: isGS1code,
            singleValue: singleValue,
            isEditEnabled: isEditEnabled,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomDigitScannerRoute';

  static const PageInfo<CustomDigitScannerRouteArgs> page =
      PageInfo<CustomDigitScannerRouteArgs>(name);
}

class CustomDigitScannerRouteArgs {
  const CustomDigitScannerRouteArgs({
    this.key,
    this.appLocalizations,
    required this.quantity,
    required this.isGS1code,
    this.singleValue = false,
    this.isEditEnabled = false,
  });

  final Key? key;

  final ScannerLocalization? appLocalizations;

  final int quantity;

  final bool isGS1code;

  final bool singleValue;

  final bool isEditEnabled;

  @override
  String toString() {
    return 'CustomDigitScannerRouteArgs{key: $key, appLocalizations: $appLocalizations, quantity: $quantity, isGS1code: $isGS1code, singleValue: $singleValue, isEditEnabled: $isEditEnabled}';
  }
}

/// generated route for
/// [CustomHouseDetailsBednetPage]
class CustomHouseDetailsBednetRoute
    extends PageRouteInfo<CustomHouseDetailsBednetRouteArgs> {
  CustomHouseDetailsBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseDetailsBednetRoute.name,
          args: CustomHouseDetailsBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseDetailsBednetRoute';

  static const PageInfo<CustomHouseDetailsBednetRouteArgs> page =
      PageInfo<CustomHouseDetailsBednetRouteArgs>(name);
}

class CustomHouseDetailsBednetRouteArgs {
  const CustomHouseDetailsBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomHouseDetailsBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomHouseDetailsPage]
class CustomHouseDetailsRoute
    extends PageRouteInfo<CustomHouseDetailsRouteArgs> {
  CustomHouseDetailsRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseDetailsRoute.name,
          args: CustomHouseDetailsRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseDetailsRoute';

  static const PageInfo<CustomHouseDetailsRouteArgs> page =
      PageInfo<CustomHouseDetailsRouteArgs>(name);
}

class CustomHouseDetailsRouteArgs {
  const CustomHouseDetailsRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomHouseDetailsRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomHouseHoldDetailsBednetPage]
class CustomHouseHoldDetailsBednetRoute
    extends PageRouteInfo<CustomHouseHoldDetailsBednetRouteArgs> {
  CustomHouseHoldDetailsBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    required bool isEligible,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseHoldDetailsBednetRoute.name,
          args: CustomHouseHoldDetailsBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEligible: isEligible,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseHoldDetailsBednetRoute';

  static const PageInfo<CustomHouseHoldDetailsBednetRouteArgs> page =
      PageInfo<CustomHouseHoldDetailsBednetRouteArgs>(name);
}

class CustomHouseHoldDetailsBednetRouteArgs {
  const CustomHouseHoldDetailsBednetRouteArgs({
    this.key,
    this.appLocalizations,
    required this.isEligible,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isEligible;

  @override
  String toString() {
    return 'CustomHouseHoldDetailsBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, isEligible: $isEligible}';
  }
}

/// generated route for
/// [CustomHouseHoldDetailsPage]
class CustomHouseHoldDetailsRoute
    extends PageRouteInfo<CustomHouseHoldDetailsRouteArgs> {
  CustomHouseHoldDetailsRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    required bool isEligible,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseHoldDetailsRoute.name,
          args: CustomHouseHoldDetailsRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEligible: isEligible,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseHoldDetailsRoute';

  static const PageInfo<CustomHouseHoldDetailsRouteArgs> page =
      PageInfo<CustomHouseHoldDetailsRouteArgs>(name);
}

class CustomHouseHoldDetailsRouteArgs {
  const CustomHouseHoldDetailsRouteArgs({
    this.key,
    this.appLocalizations,
    required this.isEligible,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isEligible;

  @override
  String toString() {
    return 'CustomHouseHoldDetailsRouteArgs{key: $key, appLocalizations: $appLocalizations, isEligible: $isEligible}';
  }
}

/// generated route for
/// [CustomHouseHoldDetailsSMCPage]
class CustomHouseHoldDetailsSMCRoute
    extends PageRouteInfo<CustomHouseHoldDetailsSMCRouteArgs> {
  CustomHouseHoldDetailsSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    required bool isEligible,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseHoldDetailsSMCRoute.name,
          args: CustomHouseHoldDetailsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEligible: isEligible,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseHoldDetailsSMCRoute';

  static const PageInfo<CustomHouseHoldDetailsSMCRouteArgs> page =
      PageInfo<CustomHouseHoldDetailsSMCRouteArgs>(name);
}

class CustomHouseHoldDetailsSMCRouteArgs {
  const CustomHouseHoldDetailsSMCRouteArgs({
    this.key,
    this.appLocalizations,
    required this.isEligible,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isEligible;

  @override
  String toString() {
    return 'CustomHouseHoldDetailsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, isEligible: $isEligible}';
  }
}

/// generated route for
/// [CustomHouseholdAcknowledgementBednetPage]
class CustomHouseholdAcknowledgementBednetRoute
    extends PageRouteInfo<CustomHouseholdAcknowledgementBednetRouteArgs> {
  CustomHouseholdAcknowledgementBednetRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool? enableViewHousehold,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdAcknowledgementBednetRoute.name,
          args: CustomHouseholdAcknowledgementBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            enableViewHousehold: enableViewHousehold,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdAcknowledgementBednetRoute';

  static const PageInfo<CustomHouseholdAcknowledgementBednetRouteArgs> page =
      PageInfo<CustomHouseholdAcknowledgementBednetRouteArgs>(name);
}

class CustomHouseholdAcknowledgementBednetRouteArgs {
  const CustomHouseholdAcknowledgementBednetRouteArgs({
    this.key,
    this.appLocalizations,
    this.enableViewHousehold,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool? enableViewHousehold;

  @override
  String toString() {
    return 'CustomHouseholdAcknowledgementBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, enableViewHousehold: $enableViewHousehold}';
  }
}

/// generated route for
/// [CustomHouseholdAcknowledgementPage]
class CustomHouseholdAcknowledgementRoute
    extends PageRouteInfo<CustomHouseholdAcknowledgementRouteArgs> {
  CustomHouseholdAcknowledgementRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    bool? enableViewHousehold,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdAcknowledgementRoute.name,
          args: CustomHouseholdAcknowledgementRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            enableViewHousehold: enableViewHousehold,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdAcknowledgementRoute';

  static const PageInfo<CustomHouseholdAcknowledgementRouteArgs> page =
      PageInfo<CustomHouseholdAcknowledgementRouteArgs>(name);
}

class CustomHouseholdAcknowledgementRouteArgs {
  const CustomHouseholdAcknowledgementRouteArgs({
    this.key,
    this.appLocalizations,
    this.enableViewHousehold,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool? enableViewHousehold;

  @override
  String toString() {
    return 'CustomHouseholdAcknowledgementRouteArgs{key: $key, appLocalizations: $appLocalizations, enableViewHousehold: $enableViewHousehold}';
  }
}

/// generated route for
/// [CustomHouseholdAcknowledgementSMCPage]
class CustomHouseholdAcknowledgementSMCRoute
    extends PageRouteInfo<CustomHouseholdAcknowledgementSMCRouteArgs> {
  CustomHouseholdAcknowledgementSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    bool? enableViewHousehold,
    bool? isReferral,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdAcknowledgementSMCRoute.name,
          args: CustomHouseholdAcknowledgementSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            enableViewHousehold: enableViewHousehold,
            isReferral: isReferral,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdAcknowledgementSMCRoute';

  static const PageInfo<CustomHouseholdAcknowledgementSMCRouteArgs> page =
      PageInfo<CustomHouseholdAcknowledgementSMCRouteArgs>(name);
}

class CustomHouseholdAcknowledgementSMCRouteArgs {
  const CustomHouseholdAcknowledgementSMCRouteArgs({
    this.key,
    this.appLocalizations,
    this.enableViewHousehold,
    this.isReferral,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool? enableViewHousehold;

  final bool? isReferral;

  @override
  String toString() {
    return 'CustomHouseholdAcknowledgementSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, enableViewHousehold: $enableViewHousehold, isReferral: $isReferral}';
  }
}

/// generated route for
/// [CustomHouseholdLocationBednetPage]
class CustomHouseholdLocationBednetRoute
    extends PageRouteInfo<CustomHouseholdLocationBednetRouteArgs> {
  CustomHouseholdLocationBednetRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdLocationBednetRoute.name,
          args: CustomHouseholdLocationBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdLocationBednetRoute';

  static const PageInfo<CustomHouseholdLocationBednetRouteArgs> page =
      PageInfo<CustomHouseholdLocationBednetRouteArgs>(name);
}

class CustomHouseholdLocationBednetRouteArgs {
  const CustomHouseholdLocationBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomHouseholdLocationBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomHouseholdLocationPage]
class CustomHouseholdLocationRoute
    extends PageRouteInfo<CustomHouseholdLocationRouteArgs> {
  CustomHouseholdLocationRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdLocationRoute.name,
          args: CustomHouseholdLocationRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdLocationRoute';

  static const PageInfo<CustomHouseholdLocationRouteArgs> page =
      PageInfo<CustomHouseholdLocationRouteArgs>(name);
}

class CustomHouseholdLocationRouteArgs {
  const CustomHouseholdLocationRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomHouseholdLocationRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomHouseholdLocationSMCPage]
class CustomHouseholdLocationSMCRoute
    extends PageRouteInfo<CustomHouseholdLocationSMCRouteArgs> {
  CustomHouseholdLocationSMCRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdLocationSMCRoute.name,
          args: CustomHouseholdLocationSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdLocationSMCRoute';

  static const PageInfo<CustomHouseholdLocationSMCRouteArgs> page =
      PageInfo<CustomHouseholdLocationSMCRouteArgs>(name);
}

class CustomHouseholdLocationSMCRouteArgs {
  const CustomHouseholdLocationSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomHouseholdLocationSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomHouseholdOverviewBednetPage]
class CustomHouseholdOverviewBednetRoute
    extends PageRouteInfo<CustomHouseholdOverviewBednetRouteArgs> {
  CustomHouseholdOverviewBednetRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdOverviewBednetRoute.name,
          args: CustomHouseholdOverviewBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdOverviewBednetRoute';

  static const PageInfo<CustomHouseholdOverviewBednetRouteArgs> page =
      PageInfo<CustomHouseholdOverviewBednetRouteArgs>(name);
}

class CustomHouseholdOverviewBednetRouteArgs {
  const CustomHouseholdOverviewBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomHouseholdOverviewBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomHouseholdOverviewPage]
class CustomHouseholdOverviewRoute
    extends PageRouteInfo<CustomHouseholdOverviewRouteArgs> {
  CustomHouseholdOverviewRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdOverviewRoute.name,
          args: CustomHouseholdOverviewRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdOverviewRoute';

  static const PageInfo<CustomHouseholdOverviewRouteArgs> page =
      PageInfo<CustomHouseholdOverviewRouteArgs>(name);
}

class CustomHouseholdOverviewRouteArgs {
  const CustomHouseholdOverviewRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomHouseholdOverviewRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomHouseholdOverviewSMCPage]
class CustomHouseholdOverviewSMCRoute
    extends PageRouteInfo<CustomHouseholdOverviewSMCRouteArgs> {
  CustomHouseholdOverviewSMCRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdOverviewSMCRoute.name,
          args: CustomHouseholdOverviewSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdOverviewSMCRoute';

  static const PageInfo<CustomHouseholdOverviewSMCRouteArgs> page =
      PageInfo<CustomHouseholdOverviewSMCRouteArgs>(name);
}

class CustomHouseholdOverviewSMCRouteArgs {
  const CustomHouseholdOverviewSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomHouseholdOverviewSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomHouseholdWrapperBednetPage]
class CustomHouseholdWrapperBednetRoute
    extends PageRouteInfo<CustomHouseholdWrapperBednetRouteArgs> {
  CustomHouseholdWrapperBednetRoute({
    Key? key,
    required HouseholdMemberWrapper wrapper,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdWrapperBednetRoute.name,
          args: CustomHouseholdWrapperBednetRouteArgs(
            key: key,
            wrapper: wrapper,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdWrapperBednetRoute';

  static const PageInfo<CustomHouseholdWrapperBednetRouteArgs> page =
      PageInfo<CustomHouseholdWrapperBednetRouteArgs>(name);
}

class CustomHouseholdWrapperBednetRouteArgs {
  const CustomHouseholdWrapperBednetRouteArgs({
    this.key,
    required this.wrapper,
    this.isEditing = false,
  });

  final Key? key;

  final HouseholdMemberWrapper wrapper;

  final bool isEditing;

  @override
  String toString() {
    return 'CustomHouseholdWrapperBednetRouteArgs{key: $key, wrapper: $wrapper, isEditing: $isEditing}';
  }
}

/// generated route for
/// [CustomHouseholdWrapperPage]
class CustomHouseholdWrapperRoute
    extends PageRouteInfo<CustomHouseholdWrapperRouteArgs> {
  CustomHouseholdWrapperRoute({
    Key? key,
    required HouseholdMemberWrapper wrapper,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CustomHouseholdWrapperRoute.name,
          args: CustomHouseholdWrapperRouteArgs(
            key: key,
            wrapper: wrapper,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomHouseholdWrapperRoute';

  static const PageInfo<CustomHouseholdWrapperRouteArgs> page =
      PageInfo<CustomHouseholdWrapperRouteArgs>(name);
}

class CustomHouseholdWrapperRouteArgs {
  const CustomHouseholdWrapperRouteArgs({
    this.key,
    required this.wrapper,
    this.isEditing = false,
  });

  final Key? key;

  final HouseholdMemberWrapper wrapper;

  final bool isEditing;

  @override
  String toString() {
    return 'CustomHouseholdWrapperRouteArgs{key: $key, wrapper: $wrapper, isEditing: $isEditing}';
  }
}

/// generated route for
/// [CustomIndividualDetailsBednetPage]
class CustomIndividualDetailsBednetRoute
    extends PageRouteInfo<CustomIndividualDetailsBednetRouteArgs> {
  CustomIndividualDetailsBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    bool isHeadOfHousehold = true,
    bool isEligible = true,
    List<PageRouteInfo>? children,
  }) : super(
          CustomIndividualDetailsBednetRoute.name,
          args: CustomIndividualDetailsBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isHeadOfHousehold: isHeadOfHousehold,
            isEligible: isEligible,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomIndividualDetailsBednetRoute';

  static const PageInfo<CustomIndividualDetailsBednetRouteArgs> page =
      PageInfo<CustomIndividualDetailsBednetRouteArgs>(name);
}

class CustomIndividualDetailsBednetRouteArgs {
  const CustomIndividualDetailsBednetRouteArgs({
    this.key,
    this.appLocalizations,
    this.isHeadOfHousehold = true,
    this.isEligible = true,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isHeadOfHousehold;

  final bool isEligible;

  @override
  String toString() {
    return 'CustomIndividualDetailsBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, isHeadOfHousehold: $isHeadOfHousehold, isEligible: $isEligible}';
  }
}

/// generated route for
/// [CustomIndividualDetailsPage]
class CustomIndividualDetailsRoute
    extends PageRouteInfo<CustomIndividualDetailsRouteArgs> {
  CustomIndividualDetailsRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    bool isHeadOfHousehold = true,
    bool isEligible = true,
    List<PageRouteInfo>? children,
  }) : super(
          CustomIndividualDetailsRoute.name,
          args: CustomIndividualDetailsRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isHeadOfHousehold: isHeadOfHousehold,
            isEligible: isEligible,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomIndividualDetailsRoute';

  static const PageInfo<CustomIndividualDetailsRouteArgs> page =
      PageInfo<CustomIndividualDetailsRouteArgs>(name);
}

class CustomIndividualDetailsRouteArgs {
  const CustomIndividualDetailsRouteArgs({
    this.key,
    this.appLocalizations,
    this.isHeadOfHousehold = true,
    this.isEligible = true,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isHeadOfHousehold;

  final bool isEligible;

  @override
  String toString() {
    return 'CustomIndividualDetailsRouteArgs{key: $key, appLocalizations: $appLocalizations, isHeadOfHousehold: $isHeadOfHousehold, isEligible: $isEligible}';
  }
}

/// generated route for
/// [CustomIndividualDetailsSMCPage]
class CustomIndividualDetailsSMCRoute
    extends PageRouteInfo<CustomIndividualDetailsSMCRouteArgs> {
  CustomIndividualDetailsSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    bool isHeadOfHousehold = true,
    List<PageRouteInfo>? children,
  }) : super(
          CustomIndividualDetailsSMCRoute.name,
          args: CustomIndividualDetailsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isHeadOfHousehold: isHeadOfHousehold,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomIndividualDetailsSMCRoute';

  static const PageInfo<CustomIndividualDetailsSMCRouteArgs> page =
      PageInfo<CustomIndividualDetailsSMCRouteArgs>(name);
}

class CustomIndividualDetailsSMCRouteArgs {
  const CustomIndividualDetailsSMCRouteArgs({
    this.key,
    this.appLocalizations,
    this.isHeadOfHousehold = true,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isHeadOfHousehold;

  @override
  String toString() {
    return 'CustomIndividualDetailsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, isHeadOfHousehold: $isHeadOfHousehold}';
  }
}

/// generated route for
/// [CustomInventoryFacilitySelectionBednetPage]
class CustomInventoryFacilitySelectionBednetRoute
    extends PageRouteInfo<CustomInventoryFacilitySelectionBednetRouteArgs> {
  CustomInventoryFacilitySelectionBednetRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    required List<FacilityModel> facilities,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryFacilitySelectionBednetRoute.name,
          args: CustomInventoryFacilitySelectionBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            facilities: facilities,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryFacilitySelectionBednetRoute';

  static const PageInfo<CustomInventoryFacilitySelectionBednetRouteArgs> page =
      PageInfo<CustomInventoryFacilitySelectionBednetRouteArgs>(name);
}

class CustomInventoryFacilitySelectionBednetRouteArgs {
  const CustomInventoryFacilitySelectionBednetRouteArgs({
    this.key,
    this.appLocalizations,
    required this.facilities,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  final List<FacilityModel> facilities;

  @override
  String toString() {
    return 'CustomInventoryFacilitySelectionBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, facilities: $facilities}';
  }
}

/// generated route for
/// [CustomInventoryFacilitySelectionPage]
class CustomInventoryFacilitySelectionRoute
    extends PageRouteInfo<CustomInventoryFacilitySelectionRouteArgs> {
  CustomInventoryFacilitySelectionRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    required List<FacilityModel> facilities,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryFacilitySelectionRoute.name,
          args: CustomInventoryFacilitySelectionRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            facilities: facilities,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryFacilitySelectionRoute';

  static const PageInfo<CustomInventoryFacilitySelectionRouteArgs> page =
      PageInfo<CustomInventoryFacilitySelectionRouteArgs>(name);
}

class CustomInventoryFacilitySelectionRouteArgs {
  const CustomInventoryFacilitySelectionRouteArgs({
    this.key,
    this.appLocalizations,
    required this.facilities,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  final List<FacilityModel> facilities;

  @override
  String toString() {
    return 'CustomInventoryFacilitySelectionRouteArgs{key: $key, appLocalizations: $appLocalizations, facilities: $facilities}';
  }
}

/// generated route for
/// [CustomInventoryFacilitySelectionSMCPage]
class CustomInventoryFacilitySelectionSMCRoute
    extends PageRouteInfo<CustomInventoryFacilitySelectionSMCRouteArgs> {
  CustomInventoryFacilitySelectionSMCRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    required List<FacilityModel> facilities,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryFacilitySelectionSMCRoute.name,
          args: CustomInventoryFacilitySelectionSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            facilities: facilities,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryFacilitySelectionSMCRoute';

  static const PageInfo<CustomInventoryFacilitySelectionSMCRouteArgs> page =
      PageInfo<CustomInventoryFacilitySelectionSMCRouteArgs>(name);
}

class CustomInventoryFacilitySelectionSMCRouteArgs {
  const CustomInventoryFacilitySelectionSMCRouteArgs({
    this.key,
    this.appLocalizations,
    required this.facilities,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  final List<FacilityModel> facilities;

  @override
  String toString() {
    return 'CustomInventoryFacilitySelectionSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, facilities: $facilities}';
  }
}

/// generated route for
/// [CustomInventoryReportDetailsBednetPage]
class CustomInventoryReportDetailsBednetRoute
    extends PageRouteInfo<CustomInventoryReportDetailsBednetRouteArgs> {
  CustomInventoryReportDetailsBednetRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    required InventoryReportType reportType,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryReportDetailsBednetRoute.name,
          args: CustomInventoryReportDetailsBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            reportType: reportType,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryReportDetailsBednetRoute';

  static const PageInfo<CustomInventoryReportDetailsBednetRouteArgs> page =
      PageInfo<CustomInventoryReportDetailsBednetRouteArgs>(name);
}

class CustomInventoryReportDetailsBednetRouteArgs {
  const CustomInventoryReportDetailsBednetRouteArgs({
    this.key,
    this.appLocalizations,
    required this.reportType,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  final InventoryReportType reportType;

  @override
  String toString() {
    return 'CustomInventoryReportDetailsBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, reportType: $reportType}';
  }
}

/// generated route for
/// [CustomInventoryReportDetailsPage]
class CustomInventoryReportDetailsRoute
    extends PageRouteInfo<CustomInventoryReportDetailsRouteArgs> {
  CustomInventoryReportDetailsRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    required InventoryReportType reportType,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryReportDetailsRoute.name,
          args: CustomInventoryReportDetailsRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            reportType: reportType,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryReportDetailsRoute';

  static const PageInfo<CustomInventoryReportDetailsRouteArgs> page =
      PageInfo<CustomInventoryReportDetailsRouteArgs>(name);
}

class CustomInventoryReportDetailsRouteArgs {
  const CustomInventoryReportDetailsRouteArgs({
    this.key,
    this.appLocalizations,
    required this.reportType,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  final InventoryReportType reportType;

  @override
  String toString() {
    return 'CustomInventoryReportDetailsRouteArgs{key: $key, appLocalizations: $appLocalizations, reportType: $reportType}';
  }
}

/// generated route for
/// [CustomInventoryReportDetailsSMCPage]
class CustomInventoryReportDetailsSMCRoute
    extends PageRouteInfo<CustomInventoryReportDetailsSMCRouteArgs> {
  CustomInventoryReportDetailsSMCRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    required InventoryReportType reportType,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryReportDetailsSMCRoute.name,
          args: CustomInventoryReportDetailsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            reportType: reportType,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryReportDetailsSMCRoute';

  static const PageInfo<CustomInventoryReportDetailsSMCRouteArgs> page =
      PageInfo<CustomInventoryReportDetailsSMCRouteArgs>(name);
}

class CustomInventoryReportDetailsSMCRouteArgs {
  const CustomInventoryReportDetailsSMCRouteArgs({
    this.key,
    this.appLocalizations,
    required this.reportType,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  final InventoryReportType reportType;

  @override
  String toString() {
    return 'CustomInventoryReportDetailsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, reportType: $reportType}';
  }
}

/// generated route for
/// [CustomInventoryReportSelectionBednetPage]
class CustomInventoryReportSelectionBednetRoute
    extends PageRouteInfo<CustomInventoryReportSelectionBednetRouteArgs> {
  CustomInventoryReportSelectionBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryReportSelectionBednetRoute.name,
          args: CustomInventoryReportSelectionBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryReportSelectionBednetRoute';

  static const PageInfo<CustomInventoryReportSelectionBednetRouteArgs> page =
      PageInfo<CustomInventoryReportSelectionBednetRouteArgs>(name);
}

class CustomInventoryReportSelectionBednetRouteArgs {
  const CustomInventoryReportSelectionBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomInventoryReportSelectionBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomInventoryReportSelectionPage]
class CustomInventoryReportSelectionRoute
    extends PageRouteInfo<CustomInventoryReportSelectionRouteArgs> {
  CustomInventoryReportSelectionRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryReportSelectionRoute.name,
          args: CustomInventoryReportSelectionRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryReportSelectionRoute';

  static const PageInfo<CustomInventoryReportSelectionRouteArgs> page =
      PageInfo<CustomInventoryReportSelectionRouteArgs>(name);
}

class CustomInventoryReportSelectionRouteArgs {
  const CustomInventoryReportSelectionRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomInventoryReportSelectionRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomInventoryReportSelectionSMCPage]
class CustomInventoryReportSelectionSMCRoute
    extends PageRouteInfo<CustomInventoryReportSelectionSMCRouteArgs> {
  CustomInventoryReportSelectionSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomInventoryReportSelectionSMCRoute.name,
          args: CustomInventoryReportSelectionSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomInventoryReportSelectionSMCRoute';

  static const PageInfo<CustomInventoryReportSelectionSMCRouteArgs> page =
      PageInfo<CustomInventoryReportSelectionSMCRouteArgs>(name);
}

class CustomInventoryReportSelectionSMCRouteArgs {
  const CustomInventoryReportSelectionSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomInventoryReportSelectionSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomManageAttendanceBednetPage]
class CustomManageAttendanceBednetRoute extends PageRouteInfo<void> {
  const CustomManageAttendanceBednetRoute({List<PageRouteInfo>? children})
      : super(
          CustomManageAttendanceBednetRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomManageAttendanceBednetRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CustomManageAttendancePage]
class CustomManageAttendanceRoute extends PageRouteInfo<void> {
  const CustomManageAttendanceRoute({List<PageRouteInfo>? children})
      : super(
          CustomManageAttendanceRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomManageAttendanceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CustomManageStocksBednetPage]
class CustomManageStocksBednetRoute
    extends PageRouteInfo<CustomManageStocksBednetRouteArgs> {
  CustomManageStocksBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomManageStocksBednetRoute.name,
          args: CustomManageStocksBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomManageStocksBednetRoute';

  static const PageInfo<CustomManageStocksBednetRouteArgs> page =
      PageInfo<CustomManageStocksBednetRouteArgs>(name);
}

class CustomManageStocksBednetRouteArgs {
  const CustomManageStocksBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomManageStocksBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomManageStocksPage]
class CustomManageStocksRoute
    extends PageRouteInfo<CustomManageStocksRouteArgs> {
  CustomManageStocksRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomManageStocksRoute.name,
          args: CustomManageStocksRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomManageStocksRoute';

  static const PageInfo<CustomManageStocksRouteArgs> page =
      PageInfo<CustomManageStocksRouteArgs>(name);
}

class CustomManageStocksRouteArgs {
  const CustomManageStocksRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomManageStocksRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomManageStocksSMCPage]
class CustomManageStocksSMCRoute
    extends PageRouteInfo<CustomManageStocksSMCRouteArgs> {
  CustomManageStocksSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomManageStocksSMCRoute.name,
          args: CustomManageStocksSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomManageStocksSMCRoute';

  static const PageInfo<CustomManageStocksSMCRouteArgs> page =
      PageInfo<CustomManageStocksSMCRouteArgs>(name);
}

class CustomManageStocksSMCRouteArgs {
  const CustomManageStocksSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomManageStocksSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomMarkAttendanceBednetPage]
class CustomMarkAttendanceBednetRoute
    extends PageRouteInfo<CustomMarkAttendanceBednetRouteArgs> {
  CustomMarkAttendanceBednetRoute({
    required int exitTime,
    required int entryTime,
    required DateTime dateTime,
    required List<AttendeeModel> attendees,
    required String registerId,
    required String tenantId,
    int? session,
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomMarkAttendanceBednetRoute.name,
          args: CustomMarkAttendanceBednetRouteArgs(
            exitTime: exitTime,
            entryTime: entryTime,
            dateTime: dateTime,
            attendees: attendees,
            registerId: registerId,
            tenantId: tenantId,
            session: session,
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomMarkAttendanceBednetRoute';

  static const PageInfo<CustomMarkAttendanceBednetRouteArgs> page =
      PageInfo<CustomMarkAttendanceBednetRouteArgs>(name);
}

class CustomMarkAttendanceBednetRouteArgs {
  const CustomMarkAttendanceBednetRouteArgs({
    required this.exitTime,
    required this.entryTime,
    required this.dateTime,
    required this.attendees,
    required this.registerId,
    required this.tenantId,
    this.session,
    this.key,
    this.appLocalizations,
  });

  final int exitTime;

  final int entryTime;

  final DateTime dateTime;

  final List<AttendeeModel> attendees;

  final String registerId;

  final String tenantId;

  final int? session;

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomMarkAttendanceBednetRouteArgs{exitTime: $exitTime, entryTime: $entryTime, dateTime: $dateTime, attendees: $attendees, registerId: $registerId, tenantId: $tenantId, session: $session, key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomMarkAttendancePage]
class CustomMarkAttendanceRoute
    extends PageRouteInfo<CustomMarkAttendanceRouteArgs> {
  CustomMarkAttendanceRoute({
    required int exitTime,
    required int entryTime,
    required DateTime dateTime,
    required List<AttendeeModel> attendees,
    required String registerId,
    required String tenantId,
    int? session,
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomMarkAttendanceRoute.name,
          args: CustomMarkAttendanceRouteArgs(
            exitTime: exitTime,
            entryTime: entryTime,
            dateTime: dateTime,
            attendees: attendees,
            registerId: registerId,
            tenantId: tenantId,
            session: session,
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomMarkAttendanceRoute';

  static const PageInfo<CustomMarkAttendanceRouteArgs> page =
      PageInfo<CustomMarkAttendanceRouteArgs>(name);
}

class CustomMarkAttendanceRouteArgs {
  const CustomMarkAttendanceRouteArgs({
    required this.exitTime,
    required this.entryTime,
    required this.dateTime,
    required this.attendees,
    required this.registerId,
    required this.tenantId,
    this.session,
    this.key,
    this.appLocalizations,
  });

  final int exitTime;

  final int entryTime;

  final DateTime dateTime;

  final List<AttendeeModel> attendees;

  final String registerId;

  final String tenantId;

  final int? session;

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomMarkAttendanceRouteArgs{exitTime: $exitTime, entryTime: $entryTime, dateTime: $dateTime, attendees: $attendees, registerId: $registerId, tenantId: $tenantId, session: $session, key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomMinNumberPage]
class CustomMinNumberRoute extends PageRouteInfo<CustomMinNumberRouteArgs> {
  CustomMinNumberRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    required dynamic type,
    List<PageRouteInfo>? children,
  }) : super(
          CustomMinNumberRoute.name,
          args: CustomMinNumberRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomMinNumberRoute';

  static const PageInfo<CustomMinNumberRouteArgs> page =
      PageInfo<CustomMinNumberRouteArgs>(name);
}

class CustomMinNumberRouteArgs {
  const CustomMinNumberRouteArgs({
    this.key,
    this.appLocalizations,
    required this.type,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  final dynamic type;

  @override
  String toString() {
    return 'CustomMinNumberRouteArgs{key: $key, appLocalizations: $appLocalizations, type: $type}';
  }
}

/// generated route for
/// [CustomRecordReferralDetailsSMCPage]
class CustomRecordReferralDetailsSMCRoute
    extends PageRouteInfo<CustomRecordReferralDetailsSMCRouteArgs> {
  CustomRecordReferralDetailsSMCRoute({
    Key? key,
    ReferralReconLocalization? appLocalizations,
    bool isEditing = false,
    required String projectId,
    required List<String> cycles,
    List<PageRouteInfo>? children,
  }) : super(
          CustomRecordReferralDetailsSMCRoute.name,
          args: CustomRecordReferralDetailsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEditing: isEditing,
            projectId: projectId,
            cycles: cycles,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomRecordReferralDetailsSMCRoute';

  static const PageInfo<CustomRecordReferralDetailsSMCRouteArgs> page =
      PageInfo<CustomRecordReferralDetailsSMCRouteArgs>(name);
}

class CustomRecordReferralDetailsSMCRouteArgs {
  const CustomRecordReferralDetailsSMCRouteArgs({
    this.key,
    this.appLocalizations,
    this.isEditing = false,
    required this.projectId,
    required this.cycles,
  });

  final Key? key;

  final ReferralReconLocalization? appLocalizations;

  final bool isEditing;

  final String projectId;

  final List<String> cycles;

  @override
  String toString() {
    return 'CustomRecordReferralDetailsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, isEditing: $isEditing, projectId: $projectId, cycles: $cycles}';
  }
}

/// generated route for
/// [CustomReferBeneficiaryBednetPage]
class CustomReferBeneficiaryBednetRoute
    extends PageRouteInfo<CustomReferBeneficiaryBednetRouteArgs> {
  CustomReferBeneficiaryBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    bool isEditing = false,
    required String projectBeneficiaryClientRefId,
    required IndividualModel individual,
    bool isReadministrationUnSuccessful = false,
    String quantityWasted = "00",
    String? productVariantId,
    List<String>? referralReasons,
    List<PageRouteInfo>? children,
  }) : super(
          CustomReferBeneficiaryBednetRoute.name,
          args: CustomReferBeneficiaryBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEditing: isEditing,
            projectBeneficiaryClientRefId: projectBeneficiaryClientRefId,
            individual: individual,
            isReadministrationUnSuccessful: isReadministrationUnSuccessful,
            quantityWasted: quantityWasted,
            productVariantId: productVariantId,
            referralReasons: referralReasons,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomReferBeneficiaryBednetRoute';

  static const PageInfo<CustomReferBeneficiaryBednetRouteArgs> page =
      PageInfo<CustomReferBeneficiaryBednetRouteArgs>(name);
}

class CustomReferBeneficiaryBednetRouteArgs {
  const CustomReferBeneficiaryBednetRouteArgs({
    this.key,
    this.appLocalizations,
    this.isEditing = false,
    required this.projectBeneficiaryClientRefId,
    required this.individual,
    this.isReadministrationUnSuccessful = false,
    this.quantityWasted = "00",
    this.productVariantId,
    this.referralReasons,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isEditing;

  final String projectBeneficiaryClientRefId;

  final IndividualModel individual;

  final bool isReadministrationUnSuccessful;

  final String quantityWasted;

  final String? productVariantId;

  final List<String>? referralReasons;

  @override
  String toString() {
    return 'CustomReferBeneficiaryBednetRouteArgs{key: $key, appLocalizations: $appLocalizations, isEditing: $isEditing, projectBeneficiaryClientRefId: $projectBeneficiaryClientRefId, individual: $individual, isReadministrationUnSuccessful: $isReadministrationUnSuccessful, quantityWasted: $quantityWasted, productVariantId: $productVariantId, referralReasons: $referralReasons}';
  }
}

/// generated route for
/// [CustomReferBeneficiarySMCPage]
class CustomReferBeneficiarySMCRoute
    extends PageRouteInfo<CustomReferBeneficiarySMCRouteArgs> {
  CustomReferBeneficiarySMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    bool isEditing = false,
    required String projectBeneficiaryClientRefId,
    required IndividualModel individual,
    bool isReadministrationUnSuccessful = false,
    String quantityWasted = "00",
    String? productVariantId,
    List<String>? referralReasons,
    List<PageRouteInfo>? children,
  }) : super(
          CustomReferBeneficiarySMCRoute.name,
          args: CustomReferBeneficiarySMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEditing: isEditing,
            projectBeneficiaryClientRefId: projectBeneficiaryClientRefId,
            individual: individual,
            isReadministrationUnSuccessful: isReadministrationUnSuccessful,
            quantityWasted: quantityWasted,
            productVariantId: productVariantId,
            referralReasons: referralReasons,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomReferBeneficiarySMCRoute';

  static const PageInfo<CustomReferBeneficiarySMCRouteArgs> page =
      PageInfo<CustomReferBeneficiarySMCRouteArgs>(name);
}

class CustomReferBeneficiarySMCRouteArgs {
  const CustomReferBeneficiarySMCRouteArgs({
    this.key,
    this.appLocalizations,
    this.isEditing = false,
    required this.projectBeneficiaryClientRefId,
    required this.individual,
    this.isReadministrationUnSuccessful = false,
    this.quantityWasted = "00",
    this.productVariantId,
    this.referralReasons,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  final bool isEditing;

  final String projectBeneficiaryClientRefId;

  final IndividualModel individual;

  final bool isReadministrationUnSuccessful;

  final String quantityWasted;

  final String? productVariantId;

  final List<String>? referralReasons;

  @override
  String toString() {
    return 'CustomReferBeneficiarySMCRouteArgs{key: $key, appLocalizations: $appLocalizations, isEditing: $isEditing, projectBeneficiaryClientRefId: $projectBeneficiaryClientRefId, individual: $individual, isReadministrationUnSuccessful: $isReadministrationUnSuccessful, quantityWasted: $quantityWasted, productVariantId: $productVariantId, referralReasons: $referralReasons}';
  }
}

/// generated route for
/// [CustomReferralReasonChecklistSMCPage]
class CustomReferralReasonChecklistSMCRoute
    extends PageRouteInfo<CustomReferralReasonChecklistSMCRouteArgs> {
  CustomReferralReasonChecklistSMCRoute({
    Key? key,
    String? referralClientRefId,
    ReferralReconLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomReferralReasonChecklistSMCRoute.name,
          args: CustomReferralReasonChecklistSMCRouteArgs(
            key: key,
            referralClientRefId: referralClientRefId,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomReferralReasonChecklistSMCRoute';

  static const PageInfo<CustomReferralReasonChecklistSMCRouteArgs> page =
      PageInfo<CustomReferralReasonChecklistSMCRouteArgs>(name);
}

class CustomReferralReasonChecklistSMCRouteArgs {
  const CustomReferralReasonChecklistSMCRouteArgs({
    this.key,
    this.referralClientRefId,
    this.appLocalizations,
  });

  final Key? key;

  final String? referralClientRefId;

  final ReferralReconLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomReferralReasonChecklistSMCRouteArgs{key: $key, referralClientRefId: $referralClientRefId, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomRefusedDeliveryBednetPage]
class CustomRefusedDeliveryBednetRoute
    extends PageRouteInfo<CustomRefusedDeliveryBednetRouteArgs> {
  CustomRefusedDeliveryBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomRefusedDeliveryBednetRoute.name,
          args: CustomRefusedDeliveryBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomRefusedDeliveryBednetRoute';

  static const PageInfo<CustomRefusedDeliveryBednetRouteArgs> page =
      PageInfo<CustomRefusedDeliveryBednetRouteArgs>(name);
}

class CustomRefusedDeliveryBednetRouteArgs {
  const CustomRefusedDeliveryBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomRefusedDeliveryBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomRefusedDeliveryPage]
class CustomRefusedDeliveryRoute
    extends PageRouteInfo<CustomRefusedDeliveryRouteArgs> {
  CustomRefusedDeliveryRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomRefusedDeliveryRoute.name,
          args: CustomRefusedDeliveryRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomRefusedDeliveryRoute';

  static const PageInfo<CustomRefusedDeliveryRouteArgs> page =
      PageInfo<CustomRefusedDeliveryRouteArgs>(name);
}

class CustomRefusedDeliveryRouteArgs {
  const CustomRefusedDeliveryRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomRefusedDeliveryRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomSearchBeneficiaryBednetPage]
class CustomSearchBeneficiaryBednetRoute
    extends PageRouteInfo<CustomSearchBeneficiaryBednetRouteArgs> {
  CustomSearchBeneficiaryBednetRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomSearchBeneficiaryBednetRoute.name,
          args: CustomSearchBeneficiaryBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomSearchBeneficiaryBednetRoute';

  static const PageInfo<CustomSearchBeneficiaryBednetRouteArgs> page =
      PageInfo<CustomSearchBeneficiaryBednetRouteArgs>(name);
}

class CustomSearchBeneficiaryBednetRouteArgs {
  const CustomSearchBeneficiaryBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomSearchBeneficiaryBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomSearchBeneficiaryPage]
class CustomSearchBeneficiaryRoute
    extends PageRouteInfo<CustomSearchBeneficiaryRouteArgs> {
  CustomSearchBeneficiaryRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomSearchBeneficiaryRoute.name,
          args: CustomSearchBeneficiaryRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomSearchBeneficiaryRoute';

  static const PageInfo<CustomSearchBeneficiaryRouteArgs> page =
      PageInfo<CustomSearchBeneficiaryRouteArgs>(name);
}

class CustomSearchBeneficiaryRouteArgs {
  const CustomSearchBeneficiaryRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomSearchBeneficiaryRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomSearchBeneficiarySMCPage]
class CustomSearchBeneficiarySMCRoute
    extends PageRouteInfo<CustomSearchBeneficiarySMCRouteArgs> {
  CustomSearchBeneficiarySMCRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomSearchBeneficiarySMCRoute.name,
          args: CustomSearchBeneficiarySMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomSearchBeneficiarySMCRoute';

  static const PageInfo<CustomSearchBeneficiarySMCRouteArgs> page =
      PageInfo<CustomSearchBeneficiarySMCRouteArgs>(name);
}

class CustomSearchBeneficiarySMCRouteArgs {
  const CustomSearchBeneficiarySMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomSearchBeneficiarySMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomSearchReferralReconciliationsSMCPage]
class CustomSearchReferralReconciliationsSMCRoute
    extends PageRouteInfo<CustomSearchReferralReconciliationsSMCRouteArgs> {
  CustomSearchReferralReconciliationsSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomSearchReferralReconciliationsSMCRoute.name,
          args: CustomSearchReferralReconciliationsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomSearchReferralReconciliationsSMCRoute';

  static const PageInfo<CustomSearchReferralReconciliationsSMCRouteArgs> page =
      PageInfo<CustomSearchReferralReconciliationsSMCRouteArgs>(name);
}

class CustomSearchReferralReconciliationsSMCRouteArgs {
  const CustomSearchReferralReconciliationsSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomSearchReferralReconciliationsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomStockDetailsBednetPage]
class CustomStockDetailsBednetRoute
    extends PageRouteInfo<CustomStockDetailsBednetRouteArgs> {
  CustomStockDetailsBednetRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomStockDetailsBednetRoute.name,
          args: CustomStockDetailsBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomStockDetailsBednetRoute';

  static const PageInfo<CustomStockDetailsBednetRouteArgs> page =
      PageInfo<CustomStockDetailsBednetRouteArgs>(name);
}

class CustomStockDetailsBednetRouteArgs {
  const CustomStockDetailsBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomStockDetailsBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomStockDetailsSMCPage]
class CustomStockDetailsSMCRoute
    extends PageRouteInfo<CustomStockDetailsSMCRouteArgs> {
  CustomStockDetailsSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomStockDetailsSMCRoute.name,
          args: CustomStockDetailsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomStockDetailsSMCRoute';

  static const PageInfo<CustomStockDetailsSMCRouteArgs> page =
      PageInfo<CustomStockDetailsSMCRouteArgs>(name);
}

class CustomStockDetailsSMCRouteArgs {
  const CustomStockDetailsSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomStockDetailsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomStockReconciliationBednetPage]
class CustomStockReconciliationBednetRoute
    extends PageRouteInfo<CustomStockReconciliationBednetRouteArgs> {
  CustomStockReconciliationBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomStockReconciliationBednetRoute.name,
          args: CustomStockReconciliationBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomStockReconciliationBednetRoute';

  static const PageInfo<CustomStockReconciliationBednetRouteArgs> page =
      PageInfo<CustomStockReconciliationBednetRouteArgs>(name);
}

class CustomStockReconciliationBednetRouteArgs {
  const CustomStockReconciliationBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomStockReconciliationBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomStockReconciliationPage]
class CustomStockReconciliationRoute
    extends PageRouteInfo<CustomStockReconciliationRouteArgs> {
  CustomStockReconciliationRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomStockReconciliationRoute.name,
          args: CustomStockReconciliationRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomStockReconciliationRoute';

  static const PageInfo<CustomStockReconciliationRouteArgs> page =
      PageInfo<CustomStockReconciliationRouteArgs>(name);
}

class CustomStockReconciliationRouteArgs {
  const CustomStockReconciliationRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomStockReconciliationRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomStockReconciliationSMCPage]
class CustomStockReconciliationSMCRoute
    extends PageRouteInfo<CustomStockReconciliationSMCRouteArgs> {
  CustomStockReconciliationSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomStockReconciliationSMCRoute.name,
          args: CustomStockReconciliationSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomStockReconciliationSMCRoute';

  static const PageInfo<CustomStockReconciliationSMCRouteArgs> page =
      PageInfo<CustomStockReconciliationSMCRouteArgs>(name);
}

class CustomStockReconciliationSMCRouteArgs {
  const CustomStockReconciliationSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'CustomStockReconciliationSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomWarehouseDetailsBednetPage]
class CustomWarehouseDetailsBednetRoute
    extends PageRouteInfo<CustomWarehouseDetailsBednetRouteArgs> {
  CustomWarehouseDetailsBednetRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomWarehouseDetailsBednetRoute.name,
          args: CustomWarehouseDetailsBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomWarehouseDetailsBednetRoute';

  static const PageInfo<CustomWarehouseDetailsBednetRouteArgs> page =
      PageInfo<CustomWarehouseDetailsBednetRouteArgs>(name);
}

class CustomWarehouseDetailsBednetRouteArgs {
  const CustomWarehouseDetailsBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomWarehouseDetailsBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [CustomWarehouseDetailsSMCPage]
class CustomWarehouseDetailsSMCRoute
    extends PageRouteInfo<CustomWarehouseDetailsSMCRouteArgs> {
  CustomWarehouseDetailsSMCRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          CustomWarehouseDetailsSMCRoute.name,
          args: CustomWarehouseDetailsSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomWarehouseDetailsSMCRoute';

  static const PageInfo<CustomWarehouseDetailsSMCRouteArgs> page =
      PageInfo<CustomWarehouseDetailsSMCRouteArgs>(name);
}

class CustomWarehouseDetailsSMCRouteArgs {
  const CustomWarehouseDetailsSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  @override
  String toString() {
    return 'CustomWarehouseDetailsSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [DigitScannerPage]
class DigitScannerRoute extends PageRouteInfo<DigitScannerRouteArgs> {
  DigitScannerRoute({
    Key? key,
    ScannerLocalization? appLocalizations,
    required int quantity,
    required bool isGS1code,
    bool singleValue = false,
    bool isEditEnabled = false,
    List<PageRouteInfo>? children,
  }) : super(
          DigitScannerRoute.name,
          args: DigitScannerRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            quantity: quantity,
            isGS1code: isGS1code,
            singleValue: singleValue,
            isEditEnabled: isEditEnabled,
          ),
          initialChildren: children,
        );

  static const String name = 'DigitScannerRoute';

  static const PageInfo<DigitScannerRouteArgs> page =
      PageInfo<DigitScannerRouteArgs>(name);
}

class DigitScannerRouteArgs {
  const DigitScannerRouteArgs({
    this.key,
    this.appLocalizations,
    required this.quantity,
    required this.isGS1code,
    this.singleValue = false,
    this.isEditEnabled = false,
  });

  final Key? key;

  final ScannerLocalization? appLocalizations;

  final int quantity;

  final bool isGS1code;

  final bool singleValue;

  final bool isEditEnabled;

  @override
  String toString() {
    return 'DigitScannerRouteArgs{key: $key, appLocalizations: $appLocalizations, quantity: $quantity, isGS1code: $isGS1code, singleValue: $singleValue, isEditEnabled: $isEditEnabled}';
  }
}

/// generated route for
/// [DoseAdministeredVerificationBednetPage]
class DoseAdministeredVerificationBednetRoute
    extends PageRouteInfo<DoseAdministeredVerificationBednetRouteArgs> {
  DoseAdministeredVerificationBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          DoseAdministeredVerificationBednetRoute.name,
          args: DoseAdministeredVerificationBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'DoseAdministeredVerificationBednetRoute';

  static const PageInfo<DoseAdministeredVerificationBednetRouteArgs> page =
      PageInfo<DoseAdministeredVerificationBednetRouteArgs>(name);
}

class DoseAdministeredVerificationBednetRouteArgs {
  const DoseAdministeredVerificationBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'DoseAdministeredVerificationBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [DoseAdministeredVerificationPage]
class DoseAdministeredVerificationRoute
    extends PageRouteInfo<DoseAdministeredVerificationRouteArgs> {
  DoseAdministeredVerificationRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          DoseAdministeredVerificationRoute.name,
          args: DoseAdministeredVerificationRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'DoseAdministeredVerificationRoute';

  static const PageInfo<DoseAdministeredVerificationRouteArgs> page =
      PageInfo<DoseAdministeredVerificationRouteArgs>(name);
}

class DoseAdministeredVerificationRouteArgs {
  const DoseAdministeredVerificationRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'DoseAdministeredVerificationRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [EligibilityChecklistViewPage]
class EligibilityChecklistViewRoute
    extends PageRouteInfo<EligibilityChecklistViewRouteArgs> {
  EligibilityChecklistViewRoute({
    Key? key,
    String? referralClientRefId,
    IndividualModel? individual,
    String? projectBeneficiaryClientReferenceId,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          EligibilityChecklistViewRoute.name,
          args: EligibilityChecklistViewRouteArgs(
            key: key,
            referralClientRefId: referralClientRefId,
            individual: individual,
            projectBeneficiaryClientReferenceId:
                projectBeneficiaryClientReferenceId,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'EligibilityChecklistViewRoute';

  static const PageInfo<EligibilityChecklistViewRouteArgs> page =
      PageInfo<EligibilityChecklistViewRouteArgs>(name);
}

class EligibilityChecklistViewRouteArgs {
  const EligibilityChecklistViewRouteArgs({
    this.key,
    this.referralClientRefId,
    this.individual,
    this.projectBeneficiaryClientReferenceId,
    this.appLocalizations,
  });

  final Key? key;

  final String? referralClientRefId;

  final IndividualModel? individual;

  final String? projectBeneficiaryClientReferenceId;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'EligibilityChecklistViewRouteArgs{key: $key, referralClientRefId: $referralClientRefId, individual: $individual, projectBeneficiaryClientReferenceId: $projectBeneficiaryClientReferenceId, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [HomeBednetPage]
class HomeBednetRoute extends PageRouteInfo<HomeBednetRouteArgs> {
  HomeBednetRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          HomeBednetRoute.name,
          args: HomeBednetRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeBednetRoute';

  static const PageInfo<HomeBednetRouteArgs> page =
      PageInfo<HomeBednetRouteArgs>(name);
}

class HomeBednetRouteArgs {
  const HomeBednetRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'HomeBednetRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [HomeSMCPage]
class HomeSMCRoute extends PageRouteInfo<HomeSMCRouteArgs> {
  HomeSMCRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          HomeSMCRoute.name,
          args: HomeSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeSMCRoute';

  static const PageInfo<HomeSMCRouteArgs> page =
      PageInfo<HomeSMCRouteArgs>(name);
}

class HomeSMCRouteArgs {
  const HomeSMCRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'HomeSMCRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [IRSWrapperPage]
class IRSWrapperRoute extends PageRouteInfo<void> {
  const IRSWrapperRoute({List<PageRouteInfo>? children})
      : super(
          IRSWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'IRSWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IneligibleSummaryPage]
class IneligibleSummaryRoute extends PageRouteInfo<IneligibleSummaryRouteArgs> {
  IneligibleSummaryRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    required bool isEligible,
    HouseholdMemberWrapper? previousWrapper,
    List<PageRouteInfo>? children,
  }) : super(
          IneligibleSummaryRoute.name,
          args: IneligibleSummaryRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            isEligible: isEligible,
            previousWrapper: previousWrapper,
          ),
          initialChildren: children,
        );

  static const String name = 'IneligibleSummaryRoute';

  static const PageInfo<IneligibleSummaryRouteArgs> page =
      PageInfo<IneligibleSummaryRouteArgs>(name);
}

class IneligibleSummaryRouteArgs {
  const IneligibleSummaryRouteArgs({
    this.key,
    this.appLocalizations,
    required this.isEligible,
    this.previousWrapper,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final bool isEligible;

  final HouseholdMemberWrapper? previousWrapper;

  @override
  String toString() {
    return 'IneligibleSummaryRouteArgs{key: $key, appLocalizations: $appLocalizations, isEligible: $isEligible, previousWrapper: $previousWrapper}';
  }
}

/// generated route for
/// [LanguageSelectionPage]
class LanguageSelectionRoute extends PageRouteInfo<void> {
  const LanguageSelectionRoute({List<PageRouteInfo>? children})
      : super(
          LanguageSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageSelectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<ProfileRouteArgs> page =
      PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [ProjectFacilitySelectionPage]
class ProjectFacilitySelectionRoute
    extends PageRouteInfo<ProjectFacilitySelectionRouteArgs> {
  ProjectFacilitySelectionRoute({
    Key? key,
    required List<ProjectFacilityModel> projectFacilities,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectFacilitySelectionRoute.name,
          args: ProjectFacilitySelectionRouteArgs(
            key: key,
            projectFacilities: projectFacilities,
          ),
          initialChildren: children,
        );

  static const String name = 'ProjectFacilitySelectionRoute';

  static const PageInfo<ProjectFacilitySelectionRouteArgs> page =
      PageInfo<ProjectFacilitySelectionRouteArgs>(name);
}

class ProjectFacilitySelectionRouteArgs {
  const ProjectFacilitySelectionRouteArgs({
    this.key,
    required this.projectFacilities,
  });

  final Key? key;

  final List<ProjectFacilityModel> projectFacilities;

  @override
  String toString() {
    return 'ProjectFacilitySelectionRouteArgs{key: $key, projectFacilities: $projectFacilities}';
  }
}

/// generated route for
/// [ProjectSelectionPage]
class ProjectSelectionRoute extends PageRouteInfo<ProjectSelectionRouteArgs> {
  ProjectSelectionRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectSelectionRoute.name,
          args: ProjectSelectionRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'ProjectSelectionRoute';

  static const PageInfo<ProjectSelectionRouteArgs> page =
      PageInfo<ProjectSelectionRouteArgs>(name);
}

class ProjectSelectionRouteArgs {
  const ProjectSelectionRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'ProjectSelectionRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [QRScannerPage]
class QRScannerRoute extends PageRouteInfo<QRScannerRouteArgs> {
  QRScannerRoute({
    Key? key,
    InventoryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          QRScannerRoute.name,
          args: QRScannerRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'QRScannerRoute';

  static const PageInfo<QRScannerRouteArgs> page =
      PageInfo<QRScannerRouteArgs>(name);
}

class QRScannerRouteArgs {
  const QRScannerRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final InventoryLocalization? appLocalizations;

  @override
  String toString() {
    return 'QRScannerRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [ReceiveStockPage]
class ReceiveStockRoute extends PageRouteInfo<ReceiveStockRouteArgs> {
  ReceiveStockRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    required String mrnNumber,
    required List<StockModel> stockRecords,
    List<PageRouteInfo>? children,
  }) : super(
          ReceiveStockRoute.name,
          args: ReceiveStockRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            mrnNumber: mrnNumber,
            stockRecords: stockRecords,
          ),
          initialChildren: children,
        );

  static const String name = 'ReceiveStockRoute';

  static const PageInfo<ReceiveStockRouteArgs> page =
      PageInfo<ReceiveStockRouteArgs>(name);
}

class ReceiveStockRouteArgs {
  const ReceiveStockRouteArgs({
    this.key,
    this.appLocalizations,
    required this.mrnNumber,
    required this.stockRecords,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final String mrnNumber;

  final List<StockModel> stockRecords;

  @override
  String toString() {
    return 'ReceiveStockRouteArgs{key: $key, appLocalizations: $appLocalizations, mrnNumber: $mrnNumber, stockRecords: $stockRecords}';
  }
}

/// generated route for
/// [ReferralReconProjectFacilitySelectionSMCPage]
class ReferralReconProjectFacilitySelectionSMCRoute
    extends PageRouteInfo<ReferralReconProjectFacilitySelectionSMCRouteArgs> {
  ReferralReconProjectFacilitySelectionSMCRoute({
    Key? key,
    ReferralReconLocalization? appLocalizations,
    required List<ProjectFacilityModel> projectFacilities,
    required Map<String, String> facilityMap,
    List<PageRouteInfo>? children,
  }) : super(
          ReferralReconProjectFacilitySelectionSMCRoute.name,
          args: ReferralReconProjectFacilitySelectionSMCRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            projectFacilities: projectFacilities,
            facilityMap: facilityMap,
          ),
          initialChildren: children,
        );

  static const String name = 'ReferralReconProjectFacilitySelectionSMCRoute';

  static const PageInfo<ReferralReconProjectFacilitySelectionSMCRouteArgs>
      page = PageInfo<ReferralReconProjectFacilitySelectionSMCRouteArgs>(name);
}

class ReferralReconProjectFacilitySelectionSMCRouteArgs {
  const ReferralReconProjectFacilitySelectionSMCRouteArgs({
    this.key,
    this.appLocalizations,
    required this.projectFacilities,
    required this.facilityMap,
  });

  final Key? key;

  final ReferralReconLocalization? appLocalizations;

  final List<ProjectFacilityModel> projectFacilities;

  final Map<String, String> facilityMap;

  @override
  String toString() {
    return 'ReferralReconProjectFacilitySelectionSMCRouteArgs{key: $key, appLocalizations: $appLocalizations, projectFacilities: $projectFacilities, facilityMap: $facilityMap}';
  }
}

/// generated route for
/// [SMCWrapperPage]
class SMCWrapperRoute extends PageRouteInfo<void> {
  const SMCWrapperRoute({List<PageRouteInfo>? children})
      : super(
          SMCWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'SMCWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UnauthenticatedPageWrapper]
class UnauthenticatedRouteWrapper extends PageRouteInfo<void> {
  const UnauthenticatedRouteWrapper({List<PageRouteInfo>? children})
      : super(
          UnauthenticatedRouteWrapper.name,
          initialChildren: children,
        );

  static const String name = 'UnauthenticatedRouteWrapper';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserQRDetailsPage]
class UserQRDetailsRoute extends PageRouteInfo<UserQRDetailsRouteArgs> {
  UserQRDetailsRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          UserQRDetailsRoute.name,
          args: UserQRDetailsRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'UserQRDetailsRoute';

  static const PageInfo<UserQRDetailsRouteArgs> page =
      PageInfo<UserQRDetailsRouteArgs>(name);
}

class UserQRDetailsRouteArgs {
  const UserQRDetailsRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'UserQRDetailsRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [VehicleAcknowledgementPage]
class VehicleAcknowledgementRoute
    extends PageRouteInfo<VehicleAcknowledgementRouteArgs> {
  VehicleAcknowledgementRoute({
    Key? key,
    AppLocalizations? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          VehicleAcknowledgementRoute.name,
          args: VehicleAcknowledgementRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'VehicleAcknowledgementRoute';

  static const PageInfo<VehicleAcknowledgementRouteArgs> page =
      PageInfo<VehicleAcknowledgementRouteArgs>(name);
}

class VehicleAcknowledgementRouteArgs {
  const VehicleAcknowledgementRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final AppLocalizations? appLocalizations;

  @override
  String toString() {
    return 'VehicleAcknowledgementRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [VehicleOverviewPage]
class VehicleOverviewRoute extends PageRouteInfo<VehicleOverviewRouteArgs> {
  VehicleOverviewRoute({
    Key? key,
    required String vehicleNo,
    List<PageRouteInfo>? children,
  }) : super(
          VehicleOverviewRoute.name,
          args: VehicleOverviewRouteArgs(
            key: key,
            vehicleNo: vehicleNo,
          ),
          initialChildren: children,
        );

  static const String name = 'VehicleOverviewRoute';

  static const PageInfo<VehicleOverviewRouteArgs> page =
      PageInfo<VehicleOverviewRouteArgs>(name);
}

class VehicleOverviewRouteArgs {
  const VehicleOverviewRouteArgs({
    this.key,
    required this.vehicleNo,
  });

  final Key? key;

  final String vehicleNo;

  @override
  String toString() {
    return 'VehicleOverviewRouteArgs{key: $key, vehicleNo: $vehicleNo}';
  }
}

/// generated route for
/// [VehicleSearchPage]
class VehicleSearchRoute extends PageRouteInfo<VehicleSearchRouteArgs> {
  VehicleSearchRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    List<PageRouteInfo>? children,
  }) : super(
          VehicleSearchRoute.name,
          args: VehicleSearchRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
          ),
          initialChildren: children,
        );

  static const String name = 'VehicleSearchRoute';

  static const PageInfo<VehicleSearchRouteArgs> page =
      PageInfo<VehicleSearchRouteArgs>(name);
}

class VehicleSearchRouteArgs {
  const VehicleSearchRouteArgs({
    this.key,
    this.appLocalizations,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  @override
  String toString() {
    return 'VehicleSearchRouteArgs{key: $key, appLocalizations: $appLocalizations}';
  }
}

/// generated route for
/// [VehicleTrackingWrapperPage]
class VehicleTrackingWrapperRoute extends PageRouteInfo<void> {
  const VehicleTrackingWrapperRoute({List<PageRouteInfo>? children})
      : super(
          VehicleTrackingWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'VehicleTrackingWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VehicleTripBookPage]
class VehicleTripBookRoute extends PageRouteInfo<VehicleTripBookRouteArgs> {
  VehicleTripBookRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    required String vehicleNo,
    List<PageRouteInfo>? children,
  }) : super(
          VehicleTripBookRoute.name,
          args: VehicleTripBookRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            vehicleNo: vehicleNo,
          ),
          initialChildren: children,
        );

  static const String name = 'VehicleTripBookRoute';

  static const PageInfo<VehicleTripBookRouteArgs> page =
      PageInfo<VehicleTripBookRouteArgs>(name);
}

class VehicleTripBookRouteArgs {
  const VehicleTripBookRouteArgs({
    this.key,
    this.appLocalizations,
    required this.vehicleNo,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final String vehicleNo;

  @override
  String toString() {
    return 'VehicleTripBookRouteArgs{key: $key, appLocalizations: $appLocalizations, vehicleNo: $vehicleNo}';
  }
}

/// generated route for
/// [ViewAllTransactionsScreen]
class ViewAllTransactionsRoute
    extends PageRouteInfo<ViewAllTransactionsRouteArgs> {
  ViewAllTransactionsRoute({
    Key? key,
    required String? warehouseId,
    List<PageRouteInfo>? children,
  }) : super(
          ViewAllTransactionsRoute.name,
          args: ViewAllTransactionsRouteArgs(
            key: key,
            warehouseId: warehouseId,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewAllTransactionsRoute';

  static const PageInfo<ViewAllTransactionsRouteArgs> page =
      PageInfo<ViewAllTransactionsRouteArgs>(name);
}

class ViewAllTransactionsRouteArgs {
  const ViewAllTransactionsRouteArgs({
    this.key,
    required this.warehouseId,
  });

  final Key? key;

  final String? warehouseId;

  @override
  String toString() {
    return 'ViewAllTransactionsRouteArgs{key: $key, warehouseId: $warehouseId}';
  }
}

/// generated route for
/// [ViewStockRecordsCDDPage]
class ViewStockRecordsCDDRoute
    extends PageRouteInfo<ViewStockRecordsCDDRouteArgs> {
  ViewStockRecordsCDDRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    required String mrnNumber,
    required List<StockModel> stockRecords,
    List<PageRouteInfo>? children,
  }) : super(
          ViewStockRecordsCDDRoute.name,
          args: ViewStockRecordsCDDRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            mrnNumber: mrnNumber,
            stockRecords: stockRecords,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewStockRecordsCDDRoute';

  static const PageInfo<ViewStockRecordsCDDRouteArgs> page =
      PageInfo<ViewStockRecordsCDDRouteArgs>(name);
}

class ViewStockRecordsCDDRouteArgs {
  const ViewStockRecordsCDDRouteArgs({
    this.key,
    this.appLocalizations,
    required this.mrnNumber,
    required this.stockRecords,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final String mrnNumber;

  final List<StockModel> stockRecords;

  @override
  String toString() {
    return 'ViewStockRecordsCDDRouteArgs{key: $key, appLocalizations: $appLocalizations, mrnNumber: $mrnNumber, stockRecords: $stockRecords}';
  }
}

/// generated route for
/// [ViewStockRecordsPage]
class ViewStockRecordsRoute extends PageRouteInfo<ViewStockRecordsRouteArgs> {
  ViewStockRecordsRoute({
    Key? key,
    RegistrationDeliveryLocalization? appLocalizations,
    required String mrnNumber,
    required List<StockModel> stockRecords,
    List<PageRouteInfo>? children,
  }) : super(
          ViewStockRecordsRoute.name,
          args: ViewStockRecordsRouteArgs(
            key: key,
            appLocalizations: appLocalizations,
            mrnNumber: mrnNumber,
            stockRecords: stockRecords,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewStockRecordsRoute';

  static const PageInfo<ViewStockRecordsRouteArgs> page =
      PageInfo<ViewStockRecordsRouteArgs>(name);
}

class ViewStockRecordsRouteArgs {
  const ViewStockRecordsRouteArgs({
    this.key,
    this.appLocalizations,
    required this.mrnNumber,
    required this.stockRecords,
  });

  final Key? key;

  final RegistrationDeliveryLocalization? appLocalizations;

  final String mrnNumber;

  final List<StockModel> stockRecords;

  @override
  String toString() {
    return 'ViewStockRecordsRouteArgs{key: $key, appLocalizations: $appLocalizations, mrnNumber: $mrnNumber, stockRecords: $stockRecords}';
  }
}

/// generated route for
/// [ViewTransactionsScreen]
class ViewTransactionsRoute extends PageRouteInfo<void> {
  const ViewTransactionsRoute({List<PageRouteInfo>? children})
      : super(
          ViewTransactionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewTransactionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
