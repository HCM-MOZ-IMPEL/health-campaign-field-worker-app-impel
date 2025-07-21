import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/vehicle_tracking/search_vehicle_bloc_common_wrapper.dart';
import '../../router/app_router.dart';
import '../../widgets/localized.dart';

import '../../utils/i18_key_constants.dart' as i18_local;
import '../../widgets/vehicle_tracking/vehicle_acknowledgement_card.dart';

@RoutePage()
class VehicleAcknowledgementPage extends LocalizedStatefulWidget {
  const VehicleAcknowledgementPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<VehicleAcknowledgementPage> createState() =>
      VehicleAcknowledgementPageState();
}

class VehicleAcknowledgementPageState
    extends LocalizedState<VehicleAcknowledgementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VehicleAcknowledgementCard(
        descriptionWidget: Column(
          children: [
            Text(localizations.translate(
              i18_local.vehicleTracking.acknowledgementDescription,
            )),
            DigitElevatedButton(
              child: Text(localizations
                  .translate(i18_local.acknowledgementSuccess.actionLabelText)),
              onPressed: () {
                final vehicleSearchbloc =
                    context.read<SearchVehicleBlocWrapper>();
                vehicleSearchbloc.clearEvent();
                context.router.popUntil(
                  (route) => route.settings.name == VehicleSearchRoute.name,
                );
                // context.pushRoute(VehicleSearchRoute());
              },
            ),
          ],
        ),
        label: localizations.translate(
          i18_local.vehicleTracking.tipSubmitted,
        ),
        subLabel: localizations.translate(
          i18_local.vehicleTracking.acknowledgementSubLabel,
        ),
        enableBackToSearch: false,
        actionLabel: localizations
            .translate(i18_local.acknowledgementSuccess.actionLabelText),
      ),
    );
  }
}
