import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/models/entities/product_variant.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:registration_delivery/blocs/app_localization.dart';

import 'package:registration_delivery/models/entities/status.dart';
import '../../../utils/i18_key_constants.dart' as i18_local;
import '../../blocs/localization/app_localization.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class VehicleCard extends StatelessWidget {
  final String? description;
  final String? status;
  final String? statusType;
  final List<String>? fields;
  final AppLocalizations appLocalizations;
  final ProductVariantModel vehicle;

  const VehicleCard({
    super.key,
    this.description,
    this.status,
    this.statusType,
    this.fields,
    required this.appLocalizations,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vehicleNo = getVehicleNo(vehicle);
    final color = getAdditionalFieldFromVehicle(vehicle, "Color");
    final brand = getAdditionalFieldFromVehicle(vehicle, "Brand");
    final model = getAdditionalFieldFromVehicle(vehicle, "Model");
    final vehicleType = getAdditionalFieldFromVehicle(vehicle, "Vehicle Type");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              Text(
                vehicleNo ??
                    appLocalizations.translate(i18_local.common.coreCommonNA),
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
        DigitTableCard(
          labelStyle: theme.textTheme.bodySmall,
          descriptionStyle: theme.textTheme.bodySmall,
          element: {
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
    );
  }
}
