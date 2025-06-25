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
      slivers: const [
        SliverToBoxAdapter(
          child: DigitCard(margin: EdgeInsets.all(spacer2), children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(spacer2),
                    child: Text("Test Header"),
                  ),
                ),
                Padding(
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
          ]),
        ),
      ],
    ));
  }
}
