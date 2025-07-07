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
  final ProductVariantModel vehicle;
  final VoidCallback? onOpenPressed;
  final double? distance;

  const ViewVehicleCard({
    super.key,
    super.appLocalizations,
    required this.vehicle,
    this.onOpenPressed,
    this.distance,
  });

  @override
  State<ViewVehicleCard> createState() => ViewVehicleCardState();
}

class ViewVehicleCardState extends LocalizedState<ViewVehicleCard> {
  late ProductVariantModel vehicle;

  @override
  void initState() {
    vehicle = widget.vehicle;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ViewVehicleCard oldWidget) {
    vehicle = widget.vehicle;
    super.didUpdateWidget(oldWidget);
  }

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
                  vehicle: widget.vehicle,
                  appLocalizations: localizations,
                  status: "Booked",
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
        ],
      ),
    );
  }
}
