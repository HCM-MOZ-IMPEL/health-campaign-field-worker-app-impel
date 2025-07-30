import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../router/app_router.dart';
import '../utils/i18_key_constants.dart' as i18;
import '../widgets/localized.dart';

@RoutePage()
class CustomComplaintsAcknowledgementPage extends LocalizedStatefulWidget {
  const CustomComplaintsAcknowledgementPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<CustomComplaintsAcknowledgementPage> createState() =>
      _ComplaintsAcknowledgementPageState();
}

class _ComplaintsAcknowledgementPageState
    extends LocalizedState<CustomComplaintsAcknowledgementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DigitAcknowledgement.success(
        action: () {
          context.router.maybePop();
        },
        actionLabel:
            localizations.translate(i18.complaints.acknowledgementAction),
        description: localizations.translate(
          i18.complaints.acknowledgementDescription,
        ),
        label: localizations.translate(i18.complaints.acknowledgementLabel),
        subLabel:
            "${localizations.translate(i18.complaints.acknowledgementSubLabelMain)}\n${localizations.translate(i18.complaints.acknowledgementSubLabelSub)}",
      ),
    );
  }
}
