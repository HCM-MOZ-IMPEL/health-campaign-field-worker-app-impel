import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/spacers.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_ui_components/widgets/scrollable_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:registration_delivery/widgets/table_card/table_card.dart';

import '../../blocs/localization/app_localization.dart';
import '../../router/app_router.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';
import '../../utils/i18_key_constants.dart' as i18_local;

enum VehicleStatusEnum {
  onGoing,
  completed,
  cancelled,
}

@RoutePage()
class VehicleOverviewPage extends LocalizedStatefulWidget {
  const VehicleOverviewPage({super.key});

  @override
  State<VehicleOverviewPage> createState() => _VehicleOverviewPageState();
}

class _VehicleOverviewPageState extends State<VehicleOverviewPage> {
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return Scaffold(
        body: ScrollableContent(
      header: BackNavigationHelpHeaderWidget(
        handleBack: () {},
        showHelp: false,
      ),
      enableFixedDigitButton: true,
      footer: DigitCard(margin: const EdgeInsets.only(top: spacer2), children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: spacer2),
          child: DigitButton(
            label: localizations.translate(
              i18_local.vehicleTracking.vehicleOverviewLabel,
            ),
            isDisabled: false,
            type: DigitButtonType.secondary,
            size: DigitButtonSize.large,
            mainAxisSize: MainAxisSize.max,
            onPressed: () {},
          ),
        ),
      ]),
      slivers: [
        SliverToBoxAdapter(
          child: DigitCard(margin: const EdgeInsets.all(spacer2), children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 100,
                    child: DigitButton(
                      label: localizations.translate(
                        i18_local.vehicleTracking.mapLabel,
                      ),
                      isDisabled: false,
                      type: DigitButtonType.secondary,
                      size: DigitButtonSize.medium,
                      mainAxisSize: MainAxisSize.max,
                      onPressed: () {},
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(spacer2),
                      child: Text(
                        "Test Header",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const StatusWidget(
                      status: VehicleStatusEnum.onGoing,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: spacer2,
                        right: spacer2,
                      ),
                      child: Column(
                        children: [
                          DigitTableCard(
                            element: {
                              "test": "test01",
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ],
    ));
  }
}

class StatusWidget extends StatelessWidget {
  final VehicleStatusEnum status;
  const StatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case VehicleStatusEnum.onGoing:
        statusColor = Colors.green;
        break;
      case VehicleStatusEnum.completed:
        statusColor = Colors.blue;
        break;
      case VehicleStatusEnum.cancelled:
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
            Text(status.name),
          ],
        ),
      ),
    );
  }
}
