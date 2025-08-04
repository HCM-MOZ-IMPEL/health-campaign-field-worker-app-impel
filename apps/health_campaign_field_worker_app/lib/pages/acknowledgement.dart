import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../models/entities/project_types.dart';
import '../router/app_router.dart';
import '../utils/extensions/extensions.dart';
import '../utils/i18_key_constants.dart' as i18;
import '../widgets/localized.dart';

@RoutePage()
class AcknowledgementPage extends LocalizedStatefulWidget {
  bool isDataRecordSuccess;
  String? label;
  String? description;
  Map<String, dynamic>? descriptionTableData;
  AcknowledgementPage({
    super.key,
    super.appLocalizations,
    this.isDataRecordSuccess = false,
    this.label,
    this.description,
    this.descriptionTableData,
  });

  @override
  State<AcknowledgementPage> createState() => _AcknowledgementPageState();
}

class _AcknowledgementPageState extends LocalizedState<AcknowledgementPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DigitAcknowledgement.success(
        description: widget.description ??
            localizations.translate(
              i18.acknowledgementSuccess.acknowledgementDescriptionText,
            ),
        descriptionWidget: widget.isDataRecordSuccess
            ? DigitTableCard(
                element: widget.descriptionTableData ?? {},
              )
            : null,
        label: widget.label ??
            localizations.translate(
              i18.acknowledgementSuccess.acknowledgementLabelText,
            ),
        action: () {
          context.router.maybePop();
        },
        enableBackToSearch: widget.isDataRecordSuccess ? false : true,
        actionLabel:
            localizations.translate(i18.acknowledgementSuccess.actionLabelText),
      ),
      bottomNavigationBar: Offstage(
        offstage: !widget.isDataRecordSuccess,
        // Show the bottom navigation bar if `isDataRecordSuccess` is true
        child: SizedBox(
          height: 150,
          child: DigitCard(
            margin: const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
            padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
            child: Column(
              children: [
                DigitElevatedButton(
                  child: Text(localizations
                      .translate(i18.acknowledgementSuccess.goToHome)),
                  onPressed: () {
                    if (isProjectTypeSMC(context)) {
                      context.router.replaceAll([
                        const SMCWrapperRoute(),
                      ]);
                    } else if (isProjectTypeIRS(context)) {
                      // context.router.replaceAll([
                      //   const IRSWrapperRoute(),
                      // ]);
                      context.router.maybePop();
                    } else {
                      context.router.replaceAll([
                        const BednetWrapperRoute(),
                      ]);
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                DigitOutLineButton(
                  onPressed: () {
                    if (isProjectTypeSMC(context)) {
                      context.router.replaceAll([
                        const SMCWrapperRoute(),
                        BoundarySelectionRoute(),
                      ]);
                    } else if (isProjectTypeIRS(context)) {
                      context.router.replaceAll([
                        const IRSWrapperRoute(),
                        BoundarySelectionRoute(),
                      ]);
                    } else {
                      context.router.replaceAll([
                        const BednetWrapperRoute(),
                        BoundarySelectionRoute(),
                      ]);
                    }
                  },
                  label: localizations
                      .translate(i18.acknowledgementSuccess.downloadmoredata),
                  buttonStyle: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    side: BorderSide(
                      width: 1.0,
                      color: theme.colorScheme.secondary,
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isProjectTypeSMC(BuildContext context) {
  return context.projectTypeCode == ProjectTypes.smc.toValue();
}

bool isProjectTypeIRS(BuildContext context) {
  return context.projectTypeCode == ProjectTypes.irs.toValue();
}
