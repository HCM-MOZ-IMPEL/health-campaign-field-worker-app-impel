import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/models/digit_table_model.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_ui_components/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:health_campaign_field_worker_app/utils/utils.dart'
    as utilsLocal;
import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;
import 'package:registration_delivery/models/entities/household.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';

import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/models/entities/referral.dart';
import 'package:registration_delivery/models/entities/side_effect.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/utils/constants.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18Local;
import '../../../utils/utils_smc/utils_smc.dart'
    show
        checkEligibilityForAgeAndSideEffectOncho,
        checkIfBeneficiaryIneligibleBednet,
        checkIfBeneficiaryIneligibleOncho,
        checkIfBeneficiaryReferredBednet,
        checkIfBeneficiaryReferredOncho,
        checkIfBeneficiaryRefusedBednet,
        checkIfBeneficiaryRefusedOncho,
        checkStatusBednet,
        checkStatusOncho,
        checkStatusSMC,
        fetchProductVariantForProjectType,
        isSmcAndBednetFlow,
        isSmcAndOnchoFlow;
import '../../../models/entities/entities_smc/intervention_types.dart';
import 'package:registration_delivery/utils/utils.dart';

import '../../localized.dart';
import 'custom_beneficiary_card.dart';

class CustomViewBeneficiaryCardSMC extends LocalizedStatefulWidget {
  final HouseholdMemberWrapper householdMember;
  final VoidCallback? onOpenPressed;
  final double? distance;

  const CustomViewBeneficiaryCardSMC({
    super.key,
    super.appLocalizations,
    required this.householdMember,
    this.onOpenPressed,
    this.distance,
  });

  @override
  State<CustomViewBeneficiaryCardSMC> createState() =>
      _CustomViewBeneficiaryCardSMCState();
}

class _CustomViewBeneficiaryCardSMCState
    extends LocalizedState<CustomViewBeneficiaryCardSMC> {
  late HouseholdMemberWrapper householdMember;
  static const _menCountKey = 'menCount';
  static const _womenCountKey = 'womenCount';

  @override
  void initState() {
    householdMember = widget.householdMember;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomViewBeneficiaryCardSMC oldWidget) {
    householdMember = widget.householdMember;
    super.didUpdateWidget(oldWidget);
  }

  bool _isCardExpanded = false;

  bool get isCardExpanded => _isCardExpanded;

  set isCardExpanded(bool value) => setState(() => _isCardExpanded = value);

  // Flow detection getters
  bool get _isSmcAndOnchoFlow => isSmcAndOnchoFlow(context);

  bool get _isSmcAndBednetFlow => isSmcAndBednetFlow(context);

  // Get intervention type for current flow
  String _getInterventionType() {
    if (_isSmcAndOnchoFlow) {
      return InterventionTypes.oncho.toValue();
    } else if (_isSmcAndBednetFlow) {
      return InterventionTypes.bednet.toValue();
    } else {
      return InterventionTypes.smc.toValue();
    }
  }

  // Get task data filtered by intervention type for current flow
  List<TaskModel>? _getTaskDataForCurrentFlow(
    List<TaskModel>? allTaskData,
    String interventionType,
  ) {
    if (allTaskData == null || allTaskData.isEmpty) {
      return allTaskData;
    }

    if (interventionType == InterventionTypes.oncho.toValue()) {
      return allTaskData
          .where((e) =>
              e.additionalFields?.fields.firstWhereOrNull(
                (element) =>
                    element.key ==
                        additional_fields_local
                            .AdditionalFieldsType.interventionType
                            .toValue() &&
                    element.value == InterventionTypes.oncho.toValue(),
              ) !=
              null)
          .toList();
    } else if (interventionType == InterventionTypes.bednet.toValue()) {
      return allTaskData
          .where((e) =>
              e.additionalFields?.fields.firstWhereOrNull(
                (element) =>
                    element.key ==
                        additional_fields_local
                            .AdditionalFieldsType.interventionType
                            .toValue() &&
                    element.value == InterventionTypes.bednet.toValue(),
              ) !=
              null)
          .toList();
    } else {
      // SMC tasks - default

      return allTaskData?.where((e) {
        final interventionField = e.additionalFields?.fields.firstWhereOrNull(
          (element) =>
              element.key ==
              additional_fields_local.AdditionalFieldsType.interventionType
                  .toValue(),
        );

        // If field is missing → assume SMC
        if (interventionField == null) {
          return true;
        }

        // If field exists → must be SMC
        return interventionField.value == InterventionTypes.smc.toValue();
      }).toList();
    }
  }

  // Status check wrapper methods - dynamically call intervention-specific methods
  bool _checkIfBeneficiaryRefused(
    List<TaskModel>? taskData,
    String interventionType,
  ) {
    if (interventionType == InterventionTypes.oncho.toValue()) {
      return checkIfBeneficiaryRefusedOncho(taskData);
    } else if (interventionType == InterventionTypes.bednet.toValue()) {
      // Bednet uses SMC logic
      return checkIfBeneficiaryRefusedBednet(taskData);
    } else {
      return checkIfBeneficiaryRefused(taskData);
    }
  }

  bool _checkIfBeneficiaryIneligible(
    List<TaskModel>? taskData,
    String interventionType,
  ) {
    if (interventionType == InterventionTypes.oncho.toValue()) {
      return checkIfBeneficiaryIneligibleOncho(taskData);
    } else if (interventionType == InterventionTypes.bednet.toValue()) {
      return checkIfBeneficiaryIneligibleBednet(taskData);
    } else {
      return utilsLocal.checkIfBeneficiaryIneligible(taskData);
    }
  }

  bool _checkIfBeneficiaryReferred(
    List<ReferralModel>? referralData,
    List<TaskModel>? taskData,
    ProjectCycle? currentCycle,
    String interventionType,
  ) {
    if (interventionType == InterventionTypes.oncho.toValue()) {
      return checkIfBeneficiaryReferredOncho(taskData);
    } else if (interventionType == InterventionTypes.bednet.toValue()) {
      // Bednet uses SMC logic
      return checkIfBeneficiaryReferredBednet(taskData);
    } else {
      return checkIfBeneficiaryReferred(referralData, currentCycle);
    }
  }

  bool _checkStatus(
    List<TaskModel>? taskData,
    ProjectCycle? currentCycle,
    String interventionType,
  ) {
    if (interventionType == InterventionTypes.oncho.toValue()) {
      return checkStatusOncho(taskData, currentCycle);
    } else if (interventionType == InterventionTypes.bednet.toValue()) {
      // Bednet uses SMC logic
      return checkStatusBednet(taskData, currentCycle);
    } else {
      return checkStatusSMC(taskData, currentCycle);
    }
  }

  bool _checkEligibilityForAgeAndSideEffect(
    DigitDOBAgeConvertor age,
    TaskModel? lastTask,
    List<SideEffectModel>? sideEffects,
    String interventionType,
  ) {
    if (interventionType == InterventionTypes.oncho.toValue()) {
      return checkEligibilityForAgeAndSideEffectOncho(
        age,
        RegistrationDeliverySingleton()
            .selectedProject
            ?.additionalDetails
            ?.additionalProjectType,
        lastTask,
        sideEffects,
      );
    } else if (interventionType == InterventionTypes.bednet.toValue()) {
      return true;
    } else {
      return checkEligibilityForAgeAndSideEffect(
        age,
        RegistrationDeliverySingleton().projectType,
        lastTask,
        sideEffects,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final headerList = [
      TableHeader(
        localizations.translate(i18.beneficiaryDetails.beneficiaryHeader),
        cellKey: 'beneficiary',
      ),
      TableHeader(
        localizations.translate(i18.beneficiaryDetails.deliveryHeader),
        cellKey: 'delivery',
      ),
      TableHeader(
        localizations.translate(i18.individualDetails.ageLabelText),
        cellKey: 'age',
      ),
      TableHeader(
        localizations.translate(i18.common.coreCommonGender),
        cellKey: 'gender',
      ),
    ];
    final filteredHeaderList = RegistrationDeliverySingleton()
                .beneficiaryType !=
            BeneficiaryType.individual
        ? headerList.where((element) => element.cellKey != 'delivery').toList()
        : headerList;
    final currentCycle =
        RegistrationDeliverySingleton().projectType?.cycles?.firstWhereOrNull(
              (e) =>
                  (e.startDate) < DateTime.now().millisecondsSinceEpoch &&
                  (e.endDate) > DateTime.now().millisecondsSinceEpoch,
              // Return null when no matching cycle is found
            );
    final household = householdMember.household;
    bool isHeadOfHousehold =
        householdMember.headOfHousehold?.clientReferenceId ==
            householdMember.members?.first.clientReferenceId;
    final childCount =
        getValueForTheKey(AdditionalFieldsType.children.toValue(), household);
    final pregnantWomenCount = getValueForTheKey(
        AdditionalFieldsType.pregnantWomen.toValue(), household);
    final menCount = getValueForTheKey(_menCountKey, household);
    final womenCount = getValueForTheKey(_womenCountKey, household);
    final noOfRooms =
        getValueForTheKey(AdditionalFieldsType.noOfRooms.toValue(), household);

    final interventionType = _getInterventionType();

    // Determine which intervention type has delivery cards (important for SMC+ONCHO flow)
    ProjectTypeModel? smcProjectType = RegistrationDeliverySingleton()
        .selectedProject
        ?.additionalDetails
        ?.projectType;

    ProjectTypeModel? onchoAdditionalProjectType =
        RegistrationDeliverySingleton()
            .selectedProject
            ?.additionalDetails
            ?.additionalProjectType;

    bool isSmcDeliveryCards = fetchProductVariantForProjectType(
            smcProjectType, householdMember.headOfHousehold, null, null) !=
        null;
    bool isOnchoDeliveryCards = fetchProductVariantForProjectType(
            onchoAdditionalProjectType,
            householdMember.headOfHousehold,
            null,
            null) !=
        null;
    bool isBednetDeliveryCards = _isSmcAndBednetFlow
        ? fetchProductVariantForProjectType(onchoAdditionalProjectType,
                    householdMember.headOfHousehold, null, null) !=
                null ||
            isHeadOfHousehold
        : false;

    // For SMC+ONCHO flow, determine which one to show based on delivery cards availability
    // Priority: If individual is valid for both, show SMC (primary intervention)
    // If only ONCHO, show ONCHO. If neither, default to SMC.
    final effectiveInterventionType = _isSmcAndOnchoFlow
        ? (isSmcDeliveryCards
            ? InterventionTypes.smc.toValue()
            : isOnchoDeliveryCards
                ? InterventionTypes.oncho.toValue()
                : InterventionTypes.smc.toValue())
        : _isSmcAndBednetFlow
            ? (isSmcDeliveryCards
                ? InterventionTypes.smc.toValue()
                : isBednetDeliveryCards
                    ? InterventionTypes.bednet.toValue()
                    : InterventionTypes.smc.toValue())
            : InterventionTypes.smc.toValue();

    final tableData = householdMember.members?.map(
      (e) {
        // Determine which intervention type has delivery cards (important for SMC+ONCHO flow)
        ProjectTypeModel? smcProjectType = RegistrationDeliverySingleton()
            .selectedProject
            ?.additionalDetails
            ?.projectType;

        ProjectTypeModel? onchoAdditionalProjectType =
            RegistrationDeliverySingleton()
                .selectedProject
                ?.additionalDetails
                ?.additionalProjectType;
        ProjectTypeModel? bednetAdditionalProjectType =
            RegistrationDeliverySingleton()
                .selectedProject
                ?.additionalDetails
                ?.additionalProjectType;

        bool isSmcDeliveryCards =
            fetchProductVariantForProjectType(smcProjectType, e, null, null) !=
                null;
        bool isOnchoDeliveryCards = fetchProductVariantForProjectType(
                onchoAdditionalProjectType, e, null, null) !=
            null;
        bool isBednetDeliveryCards = _isSmcAndBednetFlow
            ? fetchProductVariantForProjectType(
                        bednetAdditionalProjectType, e, null, null) !=
                    null ||
                e.clientReferenceId ==
                    householdMember.headOfHousehold?.clientReferenceId
            : false;

        // For SMC+ONCHO flow, determine which one to show based on delivery cards availability
        // Priority: If individual is valid for both, show SMC (primary intervention)
        // If only ONCHO, show ONCHO. If neither, default to SMC.
        final effectiveInterventionType = _isSmcAndOnchoFlow
            ? (isSmcDeliveryCards
                ? InterventionTypes.smc.toValue()
                : isOnchoDeliveryCards
                    ? InterventionTypes.oncho.toValue()
                    : InterventionTypes.smc.toValue())
            : _isSmcAndBednetFlow
                ? (isSmcDeliveryCards
                    ? InterventionTypes.smc.toValue()
                    : isBednetDeliveryCards
                        ? InterventionTypes.bednet.toValue()
                        : InterventionTypes.smc.toValue())
                : InterventionTypes.smc.toValue();

        final projectBeneficiary =
            householdMember.projectBeneficiaries?.where((element) {
          if (RegistrationDeliverySingleton().beneficiaryType ==
              BeneficiaryType.individual) {
            return element.beneficiaryClientReferenceId == e.clientReferenceId;
          } else {
            return element.beneficiaryClientReferenceId ==
                householdMember.household!.clientReferenceId;
          }
        }).toList();

        final taskData = (projectBeneficiary ?? []).isNotEmpty
            ? householdMember.tasks
                ?.where((element) =>
                    element.projectBeneficiaryClientReferenceId ==
                    projectBeneficiary?.first.clientReferenceId)
                .toList()
            : null;

        // Filter tasks by intervention type for current flow
        final filteredTaskData =
            _getTaskDataForCurrentFlow(taskData, effectiveInterventionType);
        final referralData = (projectBeneficiary ?? []).isNotEmpty
            ? householdMember.referrals
                ?.where((element) =>
                    element.projectBeneficiaryClientReferenceId ==
                    projectBeneficiary?.first.clientReferenceId)
                .toList()
            : null;
        final sideEffects =
            filteredTaskData != null && filteredTaskData.isNotEmpty
                ? householdMember.sideEffects
                    ?.where((element) =>
                        element.taskClientReferenceId ==
                        filteredTaskData.last.clientReferenceId)
                    .toList()
                : null;

        final ageInYears = DigitDateUtils.calculateAge(
          e.dateOfBirth != null
              ? DigitDateUtils.getFormattedDateToDateTime(
                    e.dateOfBirth!,
                  ) ??
                  DateTime.now()
              : DateTime.now(),
        ).years;
        final ageInMonths = DigitDateUtils.calculateAge(
          e.dateOfBirth != null
              ? DigitDateUtils.getFormattedDateToDateTime(
                    e.dateOfBirth!,
                  ) ??
                  DateTime.now()
              : DateTime.now(),
        ).months;

        final isNotEligible = !_checkEligibilityForAgeAndSideEffect(
          DigitDOBAgeConvertor(
            years: ageInYears,
            months: ageInMonths,
          ),
          (filteredTaskData ?? []).isNotEmpty ? filteredTaskData?.last : null,
          sideEffects,
          effectiveInterventionType,
        );
        final isHead = e.clientReferenceId ==
            householdMember.headOfHousehold!.clientReferenceId;

        final isSideEffectRecorded = recordedSideEffect(
          currentCycle,
          (filteredTaskData ?? []).isNotEmpty ? filteredTaskData?.last : null,
          sideEffects,
        );
        final isBeneficiaryRefused = _checkIfBeneficiaryRefused(
            filteredTaskData, effectiveInterventionType);
        final isBeneficiaryReferred = _checkIfBeneficiaryReferred(
          referralData,
          filteredTaskData,
          currentCycle,
          effectiveInterventionType,
        );
        final isBeneficiaryIneligible = _checkIfBeneficiaryIneligible(
          filteredTaskData,
          effectiveInterventionType,
        );

        final isStatusReset = _checkStatus(
            filteredTaskData, currentCycle, effectiveInterventionType);

        final rowTableData = [
          TableData(
            [
              e.name?.givenName,
              e.name?.familyName,
            ].whereNotNull().join(' '),
            cellKey: 'beneficiary',
          ),
          TableData(
            isHead &&
                    effectiveInterventionType == InterventionTypes.smc.toValue()
                ? localizations.translate(
                    i18Local.householdOverView
                        .householdOverViewHouseholderHeadLabelSMC,
                  )
                : effectiveInterventionType ==
                        InterventionTypes.bednet.toValue()
                    ? getTableCellTextBednet(
                        StatusKeys(
                          isNotEligible,
                          isBeneficiaryRefused,
                          isBeneficiaryReferred,
                          isStatusReset,
                        ),
                        filteredTaskData,
                        isBeneficiaryIneligible,
                        effectiveInterventionType)
                    : getTableCellText(
                        StatusKeys(
                          isNotEligible,
                          isBeneficiaryRefused,
                          isBeneficiaryReferred,
                          isStatusReset,
                        ),
                        filteredTaskData,
                        isBeneficiaryIneligible,
                        effectiveInterventionType,
                      ),
            cellKey: 'delivery',
            style: TextStyle(
              color: getTableCellTextColor(
                isNotEligible: isNotEligible,
                taskdata: filteredTaskData,
                isBeneficiaryRefused:
                    isBeneficiaryRefused || isBeneficiaryReferred,
                isStatusReset: isStatusReset,
                theme: theme,
                isBeneficiaryIneligible: isBeneficiaryIneligible,
              ),
            ),
          ),
          TableData(
            e.dateOfBirth == null
                ? ''
                : '${DigitDateUtils.calculateAge(
                    DigitDateUtils.getFormattedDateToDateTime(
                          e.dateOfBirth!,
                        ) ??
                        DateTime.now(),
                  ).years} ${localizations.translate(i18.searchBeneficiary.yearsAbbr)} ${DigitDateUtils.calculateAge(
                    DigitDateUtils.getFormattedDateToDateTime(
                          e.dateOfBirth!,
                        ) ??
                        DateTime.now(),
                  ).months} ${localizations.translate(i18.searchBeneficiary.monthsAbbr)}',
            cellKey: 'age',
          ),
          TableData(
            e.gender?.name != null
                ? localizations
                    .translate('CORE_COMMON_${e.gender?.name.toUpperCase()}')
                : ' -- ',
            cellKey: 'gender',
          ),
        ];

        return TableDataRow(
          RegistrationDeliverySingleton().beneficiaryType !=
                  BeneficiaryType.individual
              ? rowTableData
                  .where((element) => element.cellKey != 'delivery')
                  .toList()
              : rowTableData,
        );
        // rowTableData
      },
    ).toList();

    final ageInYears = DigitDateUtils.calculateAge(
      householdMember.headOfHousehold?.dateOfBirth != null
          ? DigitDateUtils.getFormattedDateToDateTime(
                householdMember.headOfHousehold!.dateOfBirth!,
              ) ??
              DateTime.now()
          : DateTime.now(),
    ).years;
    final ageInMonths = DigitDateUtils.calculateAge(
      householdMember.headOfHousehold?.dateOfBirth != null
          ? DigitDateUtils.getFormattedDateToDateTime(
                householdMember.headOfHousehold!.dateOfBirth!,
              ) ??
              DateTime.now()
          : DateTime.now(),
    ).months;

    final projectBeneficiary = householdMember.projectBeneficiaries?.where((p) {
      if (RegistrationDeliverySingleton().beneficiaryType ==
          BeneficiaryType.individual) {
        return p.beneficiaryClientReferenceId ==
            householdMember.headOfHousehold?.clientReferenceId;
      } else {
        return p.beneficiaryClientReferenceId ==
            householdMember.household?.clientReferenceId;
      }
    }).firstOrNull;

    final allFilteredByBeneficiary = householdMember.tasks
        ?.where((t) =>
            t.projectBeneficiaryClientReferenceId ==
            projectBeneficiary?.clientReferenceId)
        .toList();

    final tasks = _getTaskDataForCurrentFlow(
      allFilteredByBeneficiary,
      effectiveInterventionType,
    );

    final isNotEligible = !_checkEligibilityForAgeAndSideEffect(
      DigitDOBAgeConvertor(
        years: ageInYears,
        months: ageInMonths,
      ),
      (tasks ?? []).isNotEmpty ? tasks?.last : null,
      householdMember.sideEffects,
      effectiveInterventionType,
    );

    final isBeneficiaryRefused =
        _checkIfBeneficiaryRefused(tasks, effectiveInterventionType);

    return DigitCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.7,
                child: CustomBeneficiaryCard(
                  description: [
                    householdMember.household?.address?.doorNo,
                    householdMember.household?.address?.addressLine1,
                    householdMember.household?.address?.addressLine2,
                    householdMember.household?.address?.landmark,
                    householdMember.household?.address?.city,
                    householdMember.household?.address?.pincode,
                  ].whereNotNull().take(2).join(' '),
                  subtitle:
                      '${householdMember.household?.memberCount ?? 1} ${householdMember.members?.length == 1 ? localizations.translate(i18Local.beneficiaryDetails.householdMemberSingularSMC) : localizations.translate(i18Local.beneficiaryDetails.householdMemberPluralSMC)}'
                      '${childCount != null ? ' | $childCount ${localizations.translate(i18Local.beneficiaryDetails.childrenLabel)}' : ''}'
                      '${pregnantWomenCount != null ? ' | $pregnantWomenCount ${localizations.translate(i18Local.beneficiaryDetails.pregnantWomenLabel)}' : ''}'
                      '${menCount != null ? ' | $menCount ${localizations.translate(i18Local.beneficiaryDetails.menLabel)}' : ''}'
                      '${womenCount != null ? ' | $womenCount ${localizations.translate(i18Local.beneficiaryDetails.womenLabel)}' : ''}'
                      '${noOfRooms != null ? ' | $noOfRooms ${localizations.translate(i18Local.beneficiaryDetails.roomsLabel)}' : ''}'
                      '${widget.distance != null ? '\n${((widget.distance!) * 1000).round() > 999 ? '(${((widget.distance!).round())} km)' : '(${((widget.distance!) * 1000).round()} m) ${localizations.translate(i18.beneficiaryDetails.fromCurrentLocation)}'}' : ''}',
                  status: getStatus(
                      tasks ?? [],
                      householdMember.projectBeneficiaries ?? [],
                      RegistrationDeliverySingleton().beneficiaryType ==
                              BeneficiaryType.individual
                          ? isNotEligible
                          : false,
                      isBeneficiaryRefused),
                  title: [
                    householdMember.headOfHousehold?.name?.givenName ??
                        localizations.translate(i18.common.coreCommonNA),
                    householdMember.headOfHousehold?.name?.familyName,
                  ].whereNotNull().join(' '),
                ),
              ),
              Flexible(
                child: DigitOutLineButton(
                  buttonStyle: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  label:
                      localizations.translate(i18.searchBeneficiary.iconLabel),
                  onPressed: widget.onOpenPressed,
                ),
              ),
            ],
          ),
          Offstage(
            offstage: !isCardExpanded,
            child: DigitTable(
              headerList: filteredHeaderList,
              tableData: tableData ?? [],
              columnWidth: 130,
              columnRowFixedHeight: 65,
              height: householdMember.members?.length == 1
                  ? 65 * 2
                  : (householdMember.members?.length ?? 0) <= 4
                      ? ((householdMember.members?.length ?? 0) + 1) * 65
                      : 5 * 68,
              scrollPhysics: (householdMember.members?.length ?? 0) <= 4
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
            ),
          ),
          Container(
            height: 24,
            margin: const EdgeInsets.all(4),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                isCardExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 24,
              ),
              onPressed: () => isCardExpanded = !isCardExpanded,
            ),
          ),
        ],
      ),
    );
  }

  String getTableCellTextBednet(
    StatusKeys statusKeys,
    List<TaskModel>? taskData,
    bool isBeneficiaryIneligible,
    String interventionType,
  ) {
    if (statusKeys.isNotEligible || isBeneficiaryIneligible) {
      return localizations.translate(
        interventionType == InterventionTypes.bednet.toValue()
            ? i18Local
                .householdOverView.householdOverViewNotEligibleIconLabelBednet
            : i18Local
                .householdOverView.householdOverViewNotEligibleIconLabelSMC,
      );
    } else if (statusKeys.isBeneficiaryReferred) {
      return localizations.translate(
        interventionType == InterventionTypes.bednet.toValue()
            ? i18Local.householdOverView
                .householdOverViewBeneficiaryReferredLabelBednet
            : i18Local
                .householdOverView.householdOverViewBeneficiaryReferredLabelSMC,
      );
    } else if (taskData != null) {
      if (taskData.isEmpty) {
        return localizations.translate(
          interventionType == InterventionTypes.bednet.toValue()
              ? i18Local.householdOverView
                  .householdOverViewNotDeliveredIconLabelBednet
              : i18Local
                  .householdOverView.householdOverViewNotDeliveredIconLabelSMC,
        );
      } else if (statusKeys.isBeneficiaryRefused && !statusKeys.isStatusReset) {
        return localizations.translate(
          interventionType == InterventionTypes.bednet.toValue()
              ? i18Local.householdOverView
                  .householdOverViewBeneficiaryRefusedLabelBednet
              : i18Local.householdOverView
                  .householdOverViewBeneficiaryRefusedLabelSMC,
        );
      } else if (statusKeys.isStatusReset) {
        return localizations.translate(
          interventionType == InterventionTypes.bednet.toValue()
              ? i18Local.householdOverView
                  .householdOverViewNotDeliveredIconLabelBednet
              : i18Local
                  .householdOverView.householdOverViewNotDeliveredIconLabelSMC,
        );
      } else {
        return localizations.translate(
          interventionType == InterventionTypes.bednet.toValue()
              ? i18Local
                  .householdOverView.householdOverViewDeliveredIconLabelBednet
              : i18Local
                  .householdOverView.householdOverViewDeliveredIconLabelSMC,
        );
      }
    } else {
      return localizations.translate(
        interventionType == InterventionTypes.bednet.toValue()
            ? i18Local
                .householdOverView.householdOverViewNotDeliveredIconLabelBednet
            : i18Local
                .householdOverView.householdOverViewNotDeliveredIconLabelSMC,
      );
    }
  }

  String getTableCellText(
    StatusKeys statusKeys,
    List<TaskModel>? taskData,
    bool isBeneficiaryIneligible,
    String interventionType,
  ) {
    if (statusKeys.isNotEligible || isBeneficiaryIneligible) {
      return localizations.translate(
        interventionType == InterventionTypes.oncho.toValue()
            ? i18Local
                .householdOverView.householdOverViewNotEligibleIconLabelOncho
            : i18Local
                .householdOverView.householdOverViewNotEligibleIconLabelSMC,
      );
    } else if (statusKeys.isBeneficiaryReferred) {
      return localizations.translate(
        interventionType == InterventionTypes.oncho.toValue()
            ? i18Local.householdOverView
                .householdOverViewBeneficiaryReferredLabelOncho
            : i18Local
                .householdOverView.householdOverViewBeneficiaryReferredLabelSMC,
      );
    } else if (taskData != null) {
      if (taskData.isEmpty) {
        return localizations.translate(
          interventionType == InterventionTypes.oncho.toValue()
              ? i18Local
                  .householdOverView.householdOverViewNotDeliveredIconLabelOncho
              : i18Local
                  .householdOverView.householdOverViewNotDeliveredIconLabelSMC,
        );
      } else if (statusKeys.isBeneficiaryRefused && !statusKeys.isStatusReset) {
        return localizations.translate(
          interventionType == InterventionTypes.oncho.toValue()
              ? i18Local.householdOverView
                  .householdOverViewBeneficiaryRefusedLabelOncho
              : i18Local.householdOverView
                  .householdOverViewBeneficiaryRefusedLabelSMC,
        );
      } else if (statusKeys.isStatusReset) {
        return localizations.translate(
          interventionType == InterventionTypes.oncho.toValue()
              ? i18Local
                  .householdOverView.householdOverViewNotDeliveredIconLabelOncho
              : i18Local
                  .householdOverView.householdOverViewNotDeliveredIconLabelSMC,
        );
      } else {
        return localizations.translate(
          interventionType == InterventionTypes.oncho.toValue()
              ? i18Local
                  .householdOverView.householdOverViewDeliveredIconLabelOncho
              : i18Local
                  .householdOverView.householdOverViewDeliveredIconLabelSMC,
        );
      }
    } else {
      return localizations.translate(
        interventionType == InterventionTypes.oncho.toValue()
            ? i18Local
                .householdOverView.householdOverViewNotDeliveredIconLabelOncho
            : i18Local
                .householdOverView.householdOverViewNotDeliveredIconLabelSMC,
      );
    }
  }

  // ignore: long-parameter-list
  Color getTableCellTextColor({
    required bool isNotEligible,
    required List<TaskModel>? taskdata,
    required bool isBeneficiaryRefused,
    required bool isStatusReset,
    required ThemeData theme,
    required bool isBeneficiaryIneligible,
  }) {
    return taskdata != null &&
            taskdata.isNotEmpty &&
            !isBeneficiaryRefused &&
            !isNotEligible &&
            !isStatusReset &&
            !isBeneficiaryIneligible
        ? theme.colorScheme.onSurfaceVariant
        : theme.colorScheme.error;
  }

  getStatus(
      Iterable<TaskModel> tasks,
      List<ProjectBeneficiaryModel> projectBeneficiaries,
      bool isNotEligible,
      bool isBeneficiaryRefused) {
    if (projectBeneficiaries.isNotEmpty) {
      if (tasks.isEmpty || tasks.last.status == "NOT_ADMINISTERED") {
        // INFO : for closed household status update on edit
        return Status.registered.toValue();
      } else {
        return getTaskStatus(tasks).toValue();
      }
    } else {
      return Status.notRegistered.toValue();
    }
  }

  dynamic getValueForTheKey(String key, HouseholdModel? householdModel) {
    if (householdModel == null ||
        householdModel.additionalFields == null ||
        householdModel.additionalFields!.fields.isEmpty) {
      return null;
    }
    final object = householdModel.additionalFields!.fields
        .where((element) => element.key == key)
        .firstOrNull;

    return object == null ? object : object.value;
  }
  // todo verify this , not_delivered removed check from product

  Status getTaskStatus(Iterable<TaskModel> tasks) {
    final statusMap = {
      Status.delivered.toValue(): Status.delivered,
      Status.notAdministered.toValue(): Status.notAdministered,
      Status.visited.toValue(): Status.visited,
      Status.notVisited.toValue(): Status.notVisited,
      Status.beneficiaryRefused.toValue(): Status.beneficiaryRefused,
      Status.beneficiaryReferred.toValue(): Status.beneficiaryReferred,
      Status.administeredSuccess.toValue(): Status.administeredSuccess,
      Status.administeredFailed.toValue(): Status.administeredFailed,
      Status.inComplete.toValue(): Status.inComplete,
      Status.toAdminister.toValue(): Status.toAdminister,
      Status.closeHousehold.toValue(): Status.closeHousehold,
    };

    if (tasks.isNotEmpty) {
      final mappedStatus = statusMap[tasks.last.status];
      if (mappedStatus != null) {
        return mappedStatus;
      }
    }

    // for (var task in tasks) {
    //   final mappedStatus = statusMap[task.status];
    //   if (mappedStatus != null) {
    //     return mappedStatus;
    //   }
    // }

    return Status.registered;
  }
}
