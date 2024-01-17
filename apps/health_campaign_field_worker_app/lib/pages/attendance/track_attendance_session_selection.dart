import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_radio_button_list.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../utils/i18_key_constants.dart' as i18;
//import 'package:digit_components/models/digit_table_model.dart';
import '../../blocs/localization/app_localization.dart';
import '../../router/app_router.dart';
import '../../utils/attendance/date_util_attendance.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';

class AttendanceDateSessionSelectionPage extends LocalizedStatefulWidget {
  final String id;
  final String tenantId;
  final List<String> attendanceMarkIndividualModelAttendee;
  final DateTime eventStart;
  final DateTime eventEnd;
  const AttendanceDateSessionSelectionPage({
    required this.attendanceMarkIndividualModelAttendee,
    required this.id,
    required this.tenantId,
    required this.eventStart,
    required this.eventEnd,
    super.key,
    super.appLocalizations,
  });

  @override
  State<AttendanceDateSessionSelectionPage> createState() =>
      _AttendanceDateSessionSelectionPageState();
}

class _AttendanceDateSessionSelectionPageState
    extends State<AttendanceDateSessionSelectionPage> {
  static const _dateOfSession = 'dateOfSession';
  static const _sessionRadio = 'sessionRadio';
  List<String> attendeeList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    // Clear the data when the widget is disposed

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: ReactiveFormBuilder(
        form: () => buildForm(
          context,
        ),
        builder: (context, form, child) {
          return ScrollableContent(
            header: const BackNavigationHelpHeaderWidget(
              showHelp: false,
            ),
            footer: SizedBox(
              height: 85,
              child: DigitCard(
                margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
                child: DigitElevatedButton(
                  child: Text(
                    localizations.translate(i18.attendance.viewAttendance),
                  ),
                  onPressed: () {
                    if (form.control(_sessionRadio).value == null) {
                      form.control(_sessionRadio).setErrors({'': true});
                    }
                    form.markAllAsTouched();
                    DateTime s = form.control(_dateOfSession).value;
                    if (!form.valid) {
                      return;
                    } else {
                      DateTime s1 = DateTime(s.year, s.month, s.day);
                      DateTime s2 = DateTime(
                        widget.eventStart.year,
                        widget.eventStart.month,
                        widget.eventStart.day,
                      );
                      DateTime e1 = DateTime(s.year, s.month, s.day);
                      DateTime e2 = DateTime(
                        widget.eventEnd.year,
                        widget.eventEnd.month,
                        widget.eventEnd.day,
                      );

                      if (!((s.isAfter(widget.eventStart) ||
                              datesAreEqual(s1, s2)) &&
                          (s.isBefore(widget.eventEnd) ||
                              datesAreEqual(e1, e2)))) {
                        DigitToast.show(
                          context,
                          options: DigitToastOptions(
                            localizations.translate(
                              i18.attendance.eventExceedDateSelection,
                            ),
                            true,
                            theme,
                          ),
                        );
                      } else {
                        final entryTime =
                            AttendanceDateTimeManagement.getMillisecondEpoch(
                          s,
                          form.control(_sessionRadio).value.key.toString(),
                          "entryTime",
                        );

                        final exitTime =
                            AttendanceDateTimeManagement.getMillisecondEpoch(
                          s,
                          form.control(_sessionRadio).value.key.toString(),
                          "exitType",
                        );

                        context.router.push(MarkAttendanceRoute(
                          attendeeIds:
                              widget.attendanceMarkIndividualModelAttendee,
                          registerId: widget.id,
                          tenantId: widget.tenantId,
                          dateTime: s,
                          entryTime: entryTime,
                          exitTime: exitTime,
                          eventEndTime: widget.eventEnd,
                          eventStartTime: widget.eventStart,
                        ));
                      }
                    }
                  },
                ),
              ),
            ),
            children: [
              DigitCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.translate(i18.attendance.selectSession),
                      style: DigitTheme
                          .instance.mobileTheme.textTheme.headlineLarge,
                    ),
                    DigitDateFormPicker(
                      start: widget.eventStart,
                      end: widget.eventEnd,
                      label:
                          localizations.translate(i18.attendance.dateOfSession),
                      formControlName: _dateOfSession,
                      cancelText: "Cancel",
                      confirmText: "Select date",
                    ),
                    DigitRadioButtonList<KeyValue>(
                      errorMessage: 'Please Select Session',
                      formControlName: _sessionRadio,
                      options: [
                        KeyValue("morning session", 0),
                        KeyValue("evening session", 1),
                      ],
                      valueMapper: (value) {
                        return value.label;
                      },
                    ),
                    // temporarily commented
                    // CustomInfoCard(
                    //   title:
                    //       " ${localizations.translate(i18.attendance.missedAttendanceInfo)}",
                    //   description:
                    //       " ${localizations.translate(i18.attendance.missedAttendanceDesc)}",
                    // ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool datesAreEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  FormGroup buildForm(BuildContext ctx) {
    return fb.group(<String, Object>{
      _dateOfSession:
          FormControl<DateTime>(value: DateTime.now(), validators: []),
      _sessionRadio: FormControl<KeyValue>(value: null),
    });
  }
}

class KeyValue {
  String label;
  dynamic key;
  KeyValue(this.label, this.key);
}
