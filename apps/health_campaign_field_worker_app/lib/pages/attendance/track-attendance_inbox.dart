import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../blocs/attendance/attendance_register.dart';
import '../../blocs/localization/app_localization.dart';
import '../../models/attendance/attendance_mark_model/register_model.dart';
import '../../router/app_router.dart';
import '../../utils/environment_config.dart';
import '../../utils/utils.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';
import '../../utils/i18_key_constants.dart' as i18;

class TrackAttendanceInboxPage extends LocalizedStatefulWidget {
  const TrackAttendanceInboxPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<TrackAttendanceInboxPage> createState() =>
      _TrackAttendanceInboxPageState();
}

class _TrackAttendanceInboxPageState extends State<TrackAttendanceInboxPage> {
  List<Map<dynamic, dynamic>> projectList = [];
  List<AttendanceMarkRegisterModel> attendanceRegisters = [];

  @override
  void initState() {
    context.read<AttendanceProjectsSearchBloc>().add(
          SearchAttendanceProjectsEvent(
            projectid: context.projectId,
            tenantId: envConfig.variables.tenantId,
            // tenantId: 'lb',
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<AttendanceProjectsSearchBloc,
            AttendanceProjectsSearchState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              loaded: (AttendanceMarkRegisterModelResponse?
                  attendanceRegistersModel) {
                attendanceRegisters = List<AttendanceMarkRegisterModel>.from(
                  attendanceRegistersModel!.attendanceRegister!,
                );

                attendanceRegisters
                    .sort((a, b) => b.auditDetails!.lastModifiedTime!.compareTo(
                          a.auditDetails!.lastModifiedTime!.toInt(),
                        ));

                projectList = attendanceRegisters!
                    .map((e) => {
                          "Event Type": e.serviceCode,
                          "Description": (e.additionalDetails != null)
                              ? e.additionalDetails!.description ?? ""
                              : "",
                          "Event Location": context.boundary.name,
                          "Total Attendees": e.attendanceAttendees != null
                              ? e.attendanceAttendees
                                  ?.where((att) =>
                                      att.denrollmentDate == null ||
                                      !(att.denrollmentDate! <=
                                          DateTime.now()
                                              .millisecondsSinceEpoch))
                                  .toList()
                                  .length
                              : 0,
                          "Start Date": DateFormat('dd/MM/yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              e.startDate!,
                            ),
                          ),
                          "End date": DateFormat('dd/MM/yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              e.endDate!,
                            ),
                          ),
                          "Event status": e.status,
                        })
                    .toList();
              },
              error: (String? error) => Container(),
              orElse: () => Container(),
            );
          },
          child: BlocBuilder<AttendanceProjectsSearchBloc,
              AttendanceProjectsSearchState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => Container(),
                loading: () => Center(
                  child: Loaders.circularLoader(context),
                ),
                loaded: (AttendanceMarkRegisterModelResponse? attendanceModel) {
                  var list = <Widget>[];

                  for (int i = 0; i < projectList.length; i++) {
                    list.add(RegistarCard(
                      data: projectList[i] as Map<String, dynamic>,
                      regisId: attendanceRegisters![i].id!,
                      tenatId: attendanceRegisters![i].tenantId!,
                      show: true,
                      attendee:
                          attendanceRegisters![i].attendanceAttendees ?? [],
                      startdate: DateTime.fromMillisecondsSinceEpoch(
                        attendanceRegisters[i].startDate!,
                      ),
                      endDate: DateTime.fromMillisecondsSinceEpoch(
                        attendanceRegisters[i].endDate!,
                      ),
                      localizations: localizations,
                    ));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BackNavigationHelpHeaderWidget(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "${localizations.translate(i18.attendance.attendanceRegistarLabel)}(${projectList.length})",
                          style: DigitTheme
                              .instance.mobileTheme.textTheme.headlineLarge
                              ?.apply(color: const DigitColors().black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ...list,
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: PoweredByDigit(
                          version: '1.2.0',
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class RegistarCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String tenatId;
  final String regisId;
  final bool show;
  final DateTime startdate;
  final DateTime endDate;
  final List<AttendanceMarkIndividualModelAttendee> attendee;

  final AppLocalizations localizations;
  const RegistarCard({
    super.key,
    required this.data,
    required this.tenatId,
    required this.regisId,
    this.show = false,
    required this.attendee,
    required this.startdate,
    required this.endDate,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return DigitCard(
      child: Column(
        children: [
          DigitTableCard(
            element: data,
          ),
          show
              ? DigitElevatedButton(
                  child: Text(localizations
                      .translate(i18.attendance.markAttendanceLabel)),
                  onPressed: () {
                    context.router.push(AttendanceDateSessionSelectionRoute(
                      //id: registarId

                      id: regisId,
                      tenantId: tenatId,
                      attendanceMarkIndividualModelAttendee:
                          fetchAttendeeList(attendee),
                      eventEnd: endDate,
                      eventStart: startdate,
                    ));
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  List<String> fetchAttendeeList(
    List<AttendanceMarkIndividualModelAttendee> s,
  ) {
    final d = s
        .map(
          (e) => e.individualId!,
        )
        .toList();

    return d;
  }
}
