import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../localized.dart';

import 'vehicle_card.dart';

class ViewVehicleCard extends LocalizedStatefulWidget {
  final ProductVariantModel vehicle;
  final VoidCallback? onOpenPressed;
  final double? distance;
  final VehicleStatusEnum? status;

  const ViewVehicleCard({
    super.key,
    super.appLocalizations,
    required this.vehicle,
    this.onOpenPressed,
    this.distance,
    this.status,
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
    return DigitCard(
      child: VehicleCard(
        vehicle: widget.vehicle,
        appLocalizations: localizations,
        status: widget.status,
        buttonText: localizations.translate(i18.searchBeneficiary.iconLabel),
        onTap: widget.onOpenPressed ?? () {},
        enableMap: true,
      ),
    );
  }
}
