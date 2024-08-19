import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/models/digit_table_model.dart';
import 'package:digit_components/utils/date_utils.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:health_campaign_field_worker_app/widgets/beneficiary/custom_beneficiary_card.dart';
import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/models/entities/household.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';

import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/constants.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../utils/i18_key_constants.dart' as i18Local;
import 'package:registration_delivery/utils/utils.dart';
import '../localized.dart';
import 'package:registration_delivery/widgets/beneficiary/beneficiary_card.dart';

class CustomViewBeneficiaryCard extends LocalizedStatefulWidget {
  final HouseholdMemberWrapper householdMember;
  final VoidCallback? onOpenPressed;
  final double? distance;

  const CustomViewBeneficiaryCard({
    super.key,
    super.appLocalizations,
    required this.householdMember,
    this.onOpenPressed,
    this.distance,
  });

  @override
  State<CustomViewBeneficiaryCard> createState() =>
      _CustomViewBeneficiaryCardState();
}

class _CustomViewBeneficiaryCardState
    extends LocalizedState<CustomViewBeneficiaryCard> {
  late HouseholdMemberWrapper householdMember;

  @override
  void initState() {
    householdMember = widget.householdMember;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomViewBeneficiaryCard oldWidget) {
    householdMember = widget.householdMember;
    super.didUpdateWidget(oldWidget);
  }

  bool _isCardExpanded = false;

  bool get isCardExpanded => _isCardExpanded;

  set isCardExpanded(bool value) => setState(() => _isCardExpanded = value);

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
    final childCount =
        getValueForTheKey(AdditionalFieldsType.children.toValue(), household);
    final pregnantWomenCount = getValueForTheKey(
        AdditionalFieldsType.pregnantWomen.toValue(), household);
    final noOfRooms =
        getValueForTheKey(AdditionalFieldsType.noOfRooms.toValue(), household);

    final tableData = householdMember.members?.map(
      (e) {
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
        final referralData = (projectBeneficiary ?? []).isNotEmpty
            ? householdMember.referrals
                ?.where((element) =>
                    element.projectBeneficiaryClientReferenceId ==
                    projectBeneficiary?.first.clientReferenceId)
                .toList()
            : null;
        final sideEffects = taskData != null && taskData.isNotEmpty
            ? householdMember.sideEffects
                ?.where((element) =>
                    element.taskClientReferenceId ==
                    taskData.last.clientReferenceId)
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

        final isNotEligible = !checkEligibilityForAgeAndSideEffect(
          DigitDOBAge(
            years: ageInYears,
            months: ageInMonths,
          ),
          RegistrationDeliverySingleton().projectType,
          (taskData ?? []).isNotEmpty ? taskData?.last : null,
          sideEffects,
        );
        final isSideEffectRecorded = recordedSideEffect(
          currentCycle,
          (taskData ?? []).isNotEmpty ? taskData?.last : null,
          sideEffects,
        );
        final isBeneficiaryRefused = checkIfBeneficiaryRefused(taskData);
        final isBeneficiaryReferred = checkIfBeneficiaryReferred(
          referralData,
          currentCycle,
        );

        final isStatusReset = checkStatus(taskData, currentCycle);

        final rowTableData = [
          TableData(
            [
              e.name?.givenName,
              e.name?.familyName,
            ].whereNotNull().join('-'),
            cellKey: 'beneficiary',
          ),
          TableData(
            getTableCellText(
              StatusKeys(
                isNotEligible,
                isBeneficiaryRefused,
                isBeneficiaryReferred,
                isStatusReset,
              ),
              taskData,
            ),
            cellKey: 'delivery',
            style: TextStyle(
              color: getTableCellTextColor(
                isNotEligible: isNotEligible,
                taskdata: taskData,
                isBeneficiaryRefused:
                    isBeneficiaryRefused || isBeneficiaryReferred,
                isStatusReset: isStatusReset,
                theme: theme,
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
            e.gender?.name ?? '--',
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

    final isNotEligible = !checkEligibilityForAgeAndSideEffect(
      DigitDOBAge(
        years: ageInYears,
        months: ageInMonths,
      ),
      RegistrationDeliverySingleton().projectType,
      householdMember.tasks?.last,
      householdMember.sideEffects,
    );

    final isBeneficiaryRefused =
        checkIfBeneficiaryRefused(householdMember.tasks);
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

    final tasks = householdMember.tasks?.where((t) =>
        t.projectBeneficiaryClientReferenceId ==
        projectBeneficiary?.clientReferenceId);

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
                      '${householdMember.household?.memberCount ?? 1} ${householdMember.members?.length == 1 ? localizations.translate(i18.beneficiaryDetails.householdMemberSingular) : localizations.translate(i18.beneficiaryDetails.householdMemberPlural)}'
                      '${childCount != null ? ' | $childCount ${localizations.translate(i18Local.beneficiaryDetails.childrenLabel)}' : ''}'
                      '${pregnantWomenCount != null ? ' | $pregnantWomenCount ${localizations.translate(i18Local.beneficiaryDetails.pregnantWomenLabel)}' : ''}'
                      '${noOfRooms != null ? ' | $noOfRooms ${localizations.translate(i18Local.beneficiaryDetails.roomsLabel)}' : ''}'
                      '${widget.distance != null ? '\n${((widget.distance!) * 1000).round() > 999 ? '(${((widget.distance!).round())} km)' : '(${((widget.distance!) * 1000).round()} mts) ${localizations.translate(i18.beneficiaryDetails.fromCurrentLocation)}'}' : ''}',
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
                  ].whereNotNull().join(''),
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

  String getTableCellText(
    StatusKeys statusKeys,
    List<TaskModel>? taskData,
  ) {
    if (statusKeys.isNotEligible) {
      return localizations.translate(
          i18.householdOverView.householdOverViewNotEligibleIconLabel);
    } else if (statusKeys.isBeneficiaryReferred) {
      return localizations.translate(Status.beneficiaryReferred.toValue());
    } else if (taskData != null) {
      if (taskData.isEmpty) {
        return localizations.translate(Status.notVisited.toValue());
      } else if (statusKeys.isBeneficiaryRefused && !statusKeys.isStatusReset) {
        return localizations.translate(Status.beneficiaryRefused.toValue());
      } else if (statusKeys.isStatusReset) {
        return localizations.translate(Status.notVisited.toValue());
      } else {
        return localizations.translate(Status.visited.toValue());
      }
    } else {
      return localizations.translate(Status.notVisited.toValue());
    }
  }

  // ignore: long-parameter-list
  Color getTableCellTextColor({
    required bool isNotEligible,
    required List<TaskModel>? taskdata,
    required bool isBeneficiaryRefused,
    required bool isStatusReset,
    required ThemeData theme,
  }) {
    return taskdata != null &&
            taskdata.isNotEmpty &&
            !isBeneficiaryRefused &&
            !isNotEligible &&
            !isStatusReset
        ? theme.colorScheme.onSurfaceVariant
        : theme.colorScheme.error;
  }

  getStatus(
      Iterable<TaskModel> tasks,
      List<ProjectBeneficiaryModel> projectBeneficiaries,
      bool isNotEligible,
      bool isBeneficiaryRefused) {
    if (projectBeneficiaries.isNotEmpty) {
      if (tasks.isEmpty) {
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
