import 'dart:math';

import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/models/entities/product_variant.dart';
import 'package:digit_data_model/models/entities/user_action.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/theme/spacers.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/i18_key_constants.dart' as i18_local;
import '../../blocs/localization/app_localization.dart';
import '../../utils/utils.dart';

class VehicleCard extends StatelessWidget {
  final ProductVariantModel vehicle;
  final UserActionModel? vehicleActionModel;
  final VehicleStatusEnum? status;
  final List<String>? fields;
  final AppLocalizations appLocalizations;

  final VehicleCardType type;
  final String? description;

  final String buttonText;
  final Function onTap;

  const VehicleCard({
    super.key,
    this.description,
    this.status,
    this.fields,
    required this.appLocalizations,
    required this.vehicle,
    this.vehicleActionModel,
    required this.onTap,
    required this.buttonText,
    this.type = VehicleCardType.few,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vehicleNo = getVehicleNo(vehicle);
    final color = getAdditionalFieldFromVehicle(vehicle, "Color");
    final brand = getAdditionalFieldFromVehicle(vehicle, "Brand");
    final model = getAdditionalFieldFromVehicle(vehicle, "Model");
    final vehicleType = getAdditionalFieldFromVehicle(vehicle, "Vehicle Type");
    final startDate = getAdditionalFieldFromVehicleActionModel(
        vehicleActionModel, "tripStartTime");
    final endDate = getAdditionalFieldFromVehicleActionModel(
        vehicleActionModel, "endTripTime");

    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 100,
            child: DigitButton(
              label: buttonText,
              isDisabled: false,
              type: DigitButtonType.secondary,
              size: DigitButtonSize.medium,
              mainAxisSize: MainAxisSize.max,
              onPressed: () {
                onTap();
              },
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  Text(
                    vehicleNo ??
                        appLocalizations
                            .translate(i18_local.common.coreCommonNA),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.local_taxi_rounded,
                    color: theme.colorTheme.primary.primary1,
                  ),
                ],
              ),
            ),
            StatusWidget(status: status),
            DigitTableCard(
              labelStyle: theme.textTheme.bodySmall,
              descriptionStyle: theme.textTheme.bodySmall,
              fraction: 3,
              gap: 8,
              element: {
                if (type == VehicleCardType.all && startDate != null)
                  appLocalizations.translate(
                    i18_local.vehicleTracking.startDate,
                  ): DateFormat().format(DateTime.fromMillisecondsSinceEpoch(
                      int.parse(startDate))),
                appLocalizations.translate(
                  i18_local.vehicleTracking.vehicleType,
                ): vehicleType,
                appLocalizations.translate(
                  i18_local.vehicleTracking.color,
                ): color,
                appLocalizations.translate(
                  i18_local.vehicleTracking.brand,
                ): brand,
                appLocalizations.translate(
                  i18_local.vehicleTracking.model,
                ): model,
                if (type == VehicleCardType.all && endDate != null)
                  appLocalizations.translate(
                    i18_local.vehicleTracking.endDate,
                  ): DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(int.parse(endDate))),
              },
            ),
            if (description != null)
              Padding(
                padding: const EdgeInsets.all(2),
                child: Text(
                  description!,
                  style: theme.textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class StatusWidget extends StatelessWidget {
  final VehicleStatusEnum? status;
  const StatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return const SizedBox.shrink();
    }
    Color statusColor;
    switch (status!) {
      case VehicleStatusEnum.onGoing:
        statusColor = Colors.green;
        break;
      case VehicleStatusEnum.completed:
        statusColor = Colors.green;
        break;
      case VehicleStatusEnum.none:
        statusColor = Colors.red;
        break;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(spacer2),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 15,
              color: statusColor,
            ),
            const SizedBox(width: spacer1),
            Text(vehicleStatusMap[status] ?? ""),
          ],
        ),
      ),
    );
  }
}

enum VehicleCardType {
  few,
  all,
}

enum VehicleStatusEnum {
  none,
  onGoing,
  completed,
}

Map<VehicleStatusEnum, String> vehicleStatusMap = {
  VehicleStatusEnum.none: "Not Started",
  VehicleStatusEnum.onGoing: "On Going",
  VehicleStatusEnum.completed: "Completed",
};
