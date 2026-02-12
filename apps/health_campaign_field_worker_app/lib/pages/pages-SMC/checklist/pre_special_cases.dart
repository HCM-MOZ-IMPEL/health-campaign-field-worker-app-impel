import 'package:auto_route/auto_route.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../router/app_router.dart';
import '../../../widgets/custom_pop_route.dart';
import '../../../widgets/localized.dart';
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local;
import 'package:survey_form/utils/i18_key_constants.dart' as i18;
import 'package:survey_form/widgets/back_navigation_help_header.dart';

@RoutePage()
class PreSpecialCasesPage extends LocalizedStatefulWidget {
  const PreSpecialCasesPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<PreSpecialCasesPage> createState() => _PreSpecialCasesPageState();
}

class _PreSpecialCasesPageState extends LocalizedState<PreSpecialCasesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _dateController;
  late TextEditingController _organizationalUnitController;
  bool _submitTriggered = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _organizationalUnitController = TextEditingController(text: 'Mabanja');
  }

  @override
  void dispose() {
    _dateController.dispose();
    _organizationalUnitController.dispose();
    super.dispose();
  }

  /// Handle back button press
  Future<bool> _onBackPressed(BuildContext context) async {
    context.router.pop();
    return true;
  }

  /// Handle date picker selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  /// Handle form submission
  void _handleSubmit() {
    setState(() {
      _submitTriggered = true;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Handle successful submission
    showCustomPopup(
      context: context,
      builder: (popUpContext) => Popup(
        type: PopUpType.simple,
        title: localizations.translate(
          i18.acknowledgementSuccess.acknowledgementDescriptionText,
        ),
        description: localizations.translate(
          i18.acknowledgementSuccess.acknowledgementDescriptionText,
        ),
        actions: [
          DigitButton(
            label: localizations.translate(i18.common.coreCommonOk),
            onPressed: () {
              Navigator.of(popUpContext).pop();
              context.router.pop();
            },
            type: DigitButtonType.primary,
            size: DigitButtonSize.large,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: GlobalBackHandler(
        child: Scaffold(
          body: ScrollableContent(
            header: const BackNavigationHelpHeaderWidget(),
            enableFixedDigitButton: true,
            footer: DigitCard(
              cardType: CardType.primary,
              margin: const EdgeInsets.only(top: spacer2),
              children: [
                DigitButton(
                  label: localizations.translate(i18.common.coreCommonSubmit),
                  type: DigitButtonType.primary,
                  size: DigitButtonSize.large,
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _handleSubmit,
                ),
              ],
            ),
            children: [
              /// Main content card with form
              DigitCard(
                cardType: CardType.primary,
                margin: const EdgeInsets.all(spacer2),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Title
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localizations.translate(
                              i18_local.checklist.checklistDetailsTitle,
                            ),
                            style: textTheme.headingXl.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: spacer2),

                        /// Date Field
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${localizations.translate(i18_local.checklist.checklistDetailsDateLabel)}*',
                                style: textTheme.headingS.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: spacer1),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _submitTriggered &&
                                            _dateController.text.isEmpty
                                        ? theme.colorScheme.error
                                        : theme.colorScheme.outline,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 10.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _dateController.text.isEmpty
                                            ? localizations.translate(
                                                i18_local.checklist
                                                    .checklistDetailsDatePlaceholder,
                                              )
                                            : _dateController.text,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: _dateController.text.isEmpty
                                              ? theme.colorScheme.onSurface
                                                  .withOpacity(0.5)
                                              : theme.colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: theme.colorScheme.primary,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (_submitTriggered &&
                                _dateController.text.isEmpty) ...[
                              SizedBox(height: spacer1),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  localizations.translate(
                                    i18_local
                                        .checklist.checklistDetailsDateRequired,
                                  ),
                                  style: TextStyle(
                                    color: theme.colorScheme.error,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        SizedBox(height: spacer3),

                        /// Organizational Unit Field
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${localizations.translate(i18_local.checklist.checklistDetailsOrgUnitLabel)}*',
                                style: textTheme.headingS.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: spacer1),
                            TextFormField(
                              controller: _organizationalUnitController,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: _submitTriggered &&
                                            _organizationalUnitController
                                                .text.isEmpty
                                        ? theme.colorScheme.error
                                        : theme.colorScheme.outline,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.outline,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 10.0,
                                ),
                              ),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                              validator: (value) {
                                if (_submitTriggered &&
                                    value?.isEmpty == true) {
                                  return localizations.translate(
                                    i18_local.checklist
                                        .checklistDetailsOrgUnitRequired,
                                  );
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
