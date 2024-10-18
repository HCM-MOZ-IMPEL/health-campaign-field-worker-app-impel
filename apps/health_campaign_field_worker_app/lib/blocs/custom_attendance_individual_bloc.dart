import 'dart:async';

import 'package:attendance_management/blocs/attendance_individual_bloc.dart';
import 'package:attendance_management/models/entities/attendance_log.dart';
import 'package:attendance_management/models/entities/attendee.dart';
import 'package:attendance_management/models/entities/enum_values.dart';
import 'package:attendance_management/utils/typedefs.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/constants.dart';

part 'custom_attendance_individual_bloc.freezed.dart';

class CustomAttendanceIndividualBloc extends Bloc<
    CustomAttendanceIndividualEvent, CustomAttendanceIndividualState> {
  final AttendanceIndividualBloc attendanceIndividualBloc;
  final AttendanceLogDataRepository? attendanceLogDataRepository;
  final LocalRepository<AttendanceLogModel, AttendanceLogSearchModel>?
      attendanceLogLocalRepository;

  CustomAttendanceIndividualBloc(
      super.initialState,
      this.attendanceIndividualBloc,
      this.attendanceLogDataRepository,
      this.attendanceLogLocalRepository) {
    on<CustomSaveAsDraftEvent>(_onCustomSaveAsDraft);
  }

  // Event handler for SaveAsDraftEvent
  FutureOr<void> _onCustomSaveAsDraft(
    CustomSaveAsDraftEvent event,
    Emitter<CustomAttendanceIndividualState> emit,
  ) async {
    final List<AttendanceLogModel> list = [];
    await attendanceIndividualBloc.state.maybeMap(
      loaded: (value) async {
        DateTime twelvePM = DateTime(event.selectedDate.year,
            event.selectedDate.month, event.selectedDate.day, 11, 58);
        int halfDay = twelvePM.millisecondsSinceEpoch;
        if (value.attendanceCollectionModel != null) {
          value.attendanceCollectionModel?.forEach((e) {
            if (e.status != -1) {
              list.addAll([
                AttendanceLogModel(
                    individualId: e.individualId,
                    registerId: e.registerId,
                    tenantId: e.tenantId,
                    type: EnumValues.entry.toValue(),
                    status: e.status == 0
                        ? EnumValues.inactive.toValue()
                        : EnumValues.active.toValue(),
                    time: event.entryTime,
                    uploadToServer: (event.createOplog ?? false),
                    additionalDetails: {
                      if (event.latitude != null)
                        EnumValues.latitude.toValue(): event.latitude,
                      if (event.longitude != null)
                        EnumValues.longitude.toValue(): event.longitude,
                      Constants.commentsKey: event.comment ?? '',
                    }),
                AttendanceLogModel(
                    individualId: e.individualId,
                    registerId: e.registerId,
                    tenantId: e.tenantId,
                    type: EnumValues.exit.toValue(),
                    status: e.status == 0
                        ? EnumValues.inactive.toValue()
                        : EnumValues.active.toValue(),
                    time: e.status == 0
                        ? event.exitTime
                        : e.status == 0.5
                            ? halfDay
                            : event.exitTime,
                    uploadToServer: (event.createOplog ?? false),
                    additionalDetails: {
                      if (event.latitude != null)
                        EnumValues.latitude.toValue(): event.latitude,
                      if (event.longitude != null)
                        EnumValues.longitude.toValue(): event.longitude,
                      Constants.commentsKey: event.comment ?? '',
                    })
              ]);
            }
          });

          // Saving attendance details as draft if [event.createOplog] is false, else submit the attendance to the server
          attendanceIndividualBloc.submitAttendanceDetails(
              attendeeList: value.attendanceCollectionModel ?? [],
              attendanceLogs: list,
              onMarked: (val) => false,
              createOplog: event.createOplog,
              isSingleSession: event.isSingleSession);
        }
        emit(CustomAttendanceIndividualState.loaded(
          attendanceSearchModelList: value.attendanceSearchModelList,
          attendanceCollectionModel: value.attendanceCollectionModel,
        ));
      },
      orElse: () {},
    );
  }
}

@freezed
class CustomAttendanceIndividualEvent with _$CustomAttendanceIndividualEvent {
  // Event for saving attendance as draft
  const factory CustomAttendanceIndividualEvent.saveAsDraft({
    required int entryTime,
    required int exitTime,
    required DateTime selectedDate,
    @Default(false) bool isSingleSession,
    @Default(false) bool? createOplog,
    double? latitude,
    double? longitude,
    String? comment,
  }) = CustomSaveAsDraftEvent;
}

// Freezed class for defining individual attendance-related states
@freezed
class CustomAttendanceIndividualState with _$CustomAttendanceIndividualState {
  const CustomAttendanceIndividualState._();
  // Initial state
  const factory CustomAttendanceIndividualState.initial() = _Initial;
  // Loaded state with attendance data
  factory CustomAttendanceIndividualState.loaded({
    List<AttendeeModel>? attendanceSearchModelList,
    List<AttendeeModel>? attendanceCollectionModel,
    @Default(0) int offsetData,
    @Default(0) int currentOffset,
    @Default(0) int countData,
    @Default(10) int limitData,
    @Default(false) bool viewOnly,
  }) = _CustomAttendanceRowModelLoaded;
}
