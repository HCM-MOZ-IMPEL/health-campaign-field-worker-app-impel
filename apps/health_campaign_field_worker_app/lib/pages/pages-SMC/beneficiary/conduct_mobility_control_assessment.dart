import 'package:auto_route/auto_route.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local_smc;
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/localized.dart';
import '../../../router/app_router.dart';

@RoutePage()
class ConductMobilityControlAssessmentPage extends LocalizedStatefulWidget {
  const ConductMobilityControlAssessmentPage();

  @override
  State<ConductMobilityControlAssessmentPage> createState() =>
      ConductMobilityControlAssessmentPageState();
}

class ConductMobilityControlAssessmentPageState
    extends LocalizedState<ConductMobilityControlAssessmentPage> {
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  bool _checkbox4 = false;
  bool _checkbox5 = false;
  bool _checkbox6 = false;
  bool _checkbox7 = false;
  bool _checkbox8 = false;

  final clickedStatus = ValueNotifier<bool>(false);

  @override
  void dispose() {
    clickedStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Scaffold(
      body: SafeArea(
        child: ScrollableContent(
          enableFixedDigitButton: true,
          header: const Column(
            children: [
              BackNavigationHelpHeaderWidget(
                showBackNavigation: false,
                showHelp: false,
              ),
            ],
          ),
          footer: DigitCard(
            margin: const EdgeInsets.only(top: spacer2),
            children: [
              ValueListenableBuilder(
                valueListenable: clickedStatus,
                builder: (context, bool isClicked, _) {
                  return DigitButton(
                    label: localizations.translate(i18.common.coreCommonNext),
                    type: DigitButtonType.primary,
                    size: DigitButtonSize.large,
                    mainAxisSize: MainAxisSize.max,
                    // isDisabled:
                    //     isClicked || !(_checkbox1 && _checkbox2 && _checkbox3),
                    onPressed: () {},
                  );
                },
              ),
            ],
          ),
          children: [
            DigitCard(
              margin: const EdgeInsets.only(top: spacer2, bottom: spacer2),
              children: [
                Text(
                  localizations.translate(
                    i18.deliverIntervention.wasTheDoseAdministered,
                  ),
                  style: textTheme.headingXl,
                ),
                Column(
                  children: List.generate(8, (index) {
                    final checkboxValues = [
                      _checkbox1,
                      _checkbox2,
                      _checkbox3,
                      _checkbox4,
                      _checkbox5,
                      _checkbox6,
                      _checkbox7,
                      _checkbox8,
                    ];
                    final checkboxSetters = [
                      (bool val) => _checkbox1 = val,
                      (bool val) => _checkbox2 = val,
                      (bool val) => _checkbox3 = val,
                      (bool val) => _checkbox4 = val,
                      (bool val) => _checkbox5 = val,
                      (bool val) => _checkbox6 = val,
                      (bool val) => _checkbox7 = val,
                      (bool val) => _checkbox8 = val,
                    ];
                    final textKeys = [
                      i18_local_smc
                          .deliverIntervention.conductMobilityAssessmentText1,
                      i18_local_smc
                          .deliverIntervention.conductMobilityAssessmentText2,
                      i18_local_smc
                          .deliverIntervention.conductMobilityAssessmentText3,
                      i18_local_smc
                          .deliverIntervention.conductMobilityAssessmentText4,
                      i18_local_smc
                          .deliverIntervention.conductMobilityAssessmentText5,
                      i18_local_smc
                          .deliverIntervention.conductMobilityAssessmentText6,
                      i18_local_smc
                          .deliverIntervention.conductMobilityAssessmentText7,
                      i18_local_smc
                          .deliverIntervention.conductMobilityAssessmentText8,
                    ];
                    return ListTile(
                      title: Text(
                        localizations.translate(textKeys[index]),
                      ),
                      leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: DigitCheckbox(
                            value: checkboxValues[index],
                            onChanged: (bool? value) {
                              setState(() {
                                checkboxSetters[index](value ?? false);
                              });
                            },
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 8,
                      minLeadingWidth: 24,
                      minVerticalPadding: 0,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
