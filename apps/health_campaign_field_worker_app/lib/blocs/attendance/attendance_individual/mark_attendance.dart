import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/local_store/no_sql/schema/absent_attendee.dart';
import '../../../data/repositories/remote/repo_attendance_register.dart';

part 'mark_attendance.freezed.dart';

typedef MarkAttendanceEmitter = Emitter<MarkAttendanceState>;

class MarkAttendanceBloc
    extends Bloc<MarkAttendanceEvent, MarkAttendanceState> {
  final AttendanceRegisterRepository attendanceRegisterRepository;
  MarkAttendanceBloc({required this.attendanceRegisterRepository})
      : super(const MarkAttendanceState.initial()) {
    on<UploadAttendanceMarkEvent>(_onUpload);
    on<DisposeAttendanceEvent>(_onDispose);
  }

  FutureOr<void> _onUpload(
    UploadAttendanceMarkEvent event,
    MarkAttendanceEmitter emit,
  ) async {
    emit(const MarkAttendanceState.loading());

    Future.delayed(const Duration(milliseconds: 800));
    List<Map<String, dynamic>> m = [];
    List<AbsentAttendee> filterData =
        await attendanceRegisterRepository.getAttendeeListFromLocalDB(
      tenantId: event.tenantId,
      entryTime: event.entryTime,
      exitTime: event.exitTime,
      registarId: event.registarId,
    );

    try {
      for (var element in filterData) {
        if (element.status == 1) {
          final entry = {
            "registerId": element.registerId,
            "individualId": element.individualId,
            "tenantId": element.tenantId,
            "time": element.entryTime,
            "type": "ENTRY",
            "status": "ACTIVE",
            "documentIds": [],
            "additionalDetails": {},
          };

          final exit = {
            "registerId": element.registerId,
            "individualId": element.individualId,
            "tenantId": element.tenantId,
            "time": element.exitTime,
            "type": "EXIT",
            "status": "ACTIVE",
            "documentIds": [],
            "additionalDetails": {},
          };
          m.add(entry);
          m.add(exit);
        }
      }

      final check = await attendanceRegisterRepository.createAttendanceLog(
        attedeesList: m,
        registartId: event.registarId,
      );

      if (check) {
        emit(const MarkAttendanceState.loaded(
          flagStatus: true,
          responseMsg: "Data Inserted Successfully",
        ));
      }
    } catch (e) {
      // emit(value.copyWith(
      //   flag: false,
      // ));
      emit(MarkAttendanceState.error(e.toString()));
    }
  }

  FutureOr<void> _onDispose(
    DisposeAttendanceEvent event,
    MarkAttendanceEmitter emit,
  ) async {}
}

@freezed
class MarkAttendanceEvent with _$MarkAttendanceEvent {
  factory MarkAttendanceEvent.uploadAttendance({
    required int entryTime,
    required int exitTime,
    required int status,
    required String tenantId,
    required String registarId,
    required String projectId,
  }) = UploadAttendanceMarkEvent;
  const factory MarkAttendanceEvent.dispose() = DisposeAttendanceEvent;
}

@freezed
class MarkAttendanceState with _$MarkAttendanceState {
  const MarkAttendanceState._();
  const factory MarkAttendanceState.initial() = _Initial;
  const factory MarkAttendanceState.loading() = _Loading;
  const factory MarkAttendanceState.loaded({
    @Default(false) bool flagStatus,
    @Default('') String responseMsg,
  }) = _Loaded;
  const factory MarkAttendanceState.error(String? error) = _Error;
  // const factory AttendanceProjectsSearchState({
  //   @Default(false) bool loading,
  //   AttendanceRegistersModel? attendanceRegistersModel,
  //   AttendanceRegistersModel? individualAttendanceRegisterModel,
  // }) = _AttendanceProjectsSearchState;
}
