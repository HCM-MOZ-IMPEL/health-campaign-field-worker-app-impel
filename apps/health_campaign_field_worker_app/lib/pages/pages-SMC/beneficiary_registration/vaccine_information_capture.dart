import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../../../router/app_router.dart';
import '../../../widgets/header/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';

@RoutePage()
class VaccineInformationCapturePage extends LocalizedStatefulWidget {
  const VaccineInformationCapturePage({super.key, super.appLocalizations});

  @override
  State<VaccineInformationCapturePage> createState() =>
      _VaccineInformationCapturePageState();
}

class _VaccineInformationCapturePageState
    extends LocalizedState<VaccineInformationCapturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableContent(
        header: BackNavigationHelpHeaderWidget(
          handleBack: () {},
          showHelp: false,
          showcaseButton: null,
        ),
        enableFixedButton: true,
        footer: null,
        slivers: [
          SliverToBoxAdapter(
              child: DigitCard(
            child: Text('Vaccine Information Capture Page'),
          ))
        ],
      ),
    );
  }
}
