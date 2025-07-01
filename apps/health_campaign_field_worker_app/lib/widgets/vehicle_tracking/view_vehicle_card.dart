import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/models/digit_table_model.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_ui_components/utils/date_utils.dart';
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
import '../../utils/i18_key_constants.dart' as i18_local;
import 'package:registration_delivery/utils/utils.dart';
import '../localized.dart';
import 'package:registration_delivery/widgets/beneficiary/beneficiary_card.dart';

import 'vehicle_card.dart';

class ViewVehicleCard extends LocalizedStatefulWidget {
  final VoidCallback? onOpenPressed;
  final double? distance;

  const ViewVehicleCard({
    super.key,
    super.appLocalizations,
    this.onOpenPressed,
    this.distance,
  });

  @override
  State<ViewVehicleCard> createState() => ViewVehicleCardState();
}

class ViewVehicleCardState extends LocalizedState<ViewVehicleCard> {
  late HouseholdMemberWrapper householdMember;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ViewVehicleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  bool _isCardExpanded = false;

  bool get isCardExpanded => _isCardExpanded;

  set isCardExpanded(bool value) => setState(() => _isCardExpanded = value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DigitCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.7,
                child: VehicleCard(
                  description: [
                    "Vehicle No.",
                    "Brand",
                    "Color",
                    "Model",
                    "Driver Name",
                  ].whereNotNull().take(2).join(' '),
                  subtitle: "Subtitle",
                  status: "Booked",
                  title: [
                    "Name" ?? localizations.translate(i18.common.coreCommonNA),
                    "Last Name",
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
              headerList: [],
              tableData: [] ?? [],
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
