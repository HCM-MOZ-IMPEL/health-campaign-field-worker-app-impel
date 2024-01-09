import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/attendance/attendance_mark_model/register_model.dart';

import '../../data/repositories/remote/repo_attendance_register.dart';

part 'attendance_register.freezed.dart';

typedef AttendanceProjectsSearchEmitter
    = Emitter<AttendanceProjectsSearchState>;

class AttendanceProjectsSearchBloc
    extends Bloc<AttendanceProjectsSearchEvent, AttendanceProjectsSearchState> {
  final AttendanceRegisterRepository attendanceRegisterRepository;
  AttendanceProjectsSearchBloc({required this.attendanceRegisterRepository})
      : super(const AttendanceProjectsSearchState.initial()) {
    on<SearchAttendanceProjectsEvent>(_onSearch);
    on<DisposeAttendanceRegisterEvent>(_onDispose);
  }

  FutureOr<void> _onSearch(
    SearchAttendanceProjectsEvent event,
    AttendanceProjectsSearchEmitter emit,
  ) async {
    // Client client = Client();
    try {
      emit(const AttendanceProjectsSearchState.initial());
      emit(const AttendanceProjectsSearchState.loading());

      AttendanceMarkRegisterModelResponse attendanceRegistersModel =
          await attendanceRegisterRepository.searchAttendanceProjects(
        projectId: event.projectid,
        tenantId: event.tenantId,
      );
      await Future.delayed(const Duration(seconds: 1));
      emit(AttendanceProjectsSearchState.loaded(attendanceRegistersModel));
    } on DioError catch (e) {
      emit(AttendanceProjectsSearchState.error(
        e.response?.data['Errors'][0]['code'],
      ));
    }
  }

  FutureOr<void> _onDispose(
    DisposeAttendanceRegisterEvent event,
    AttendanceProjectsSearchEmitter emit,
  ) async {
    emit(const AttendanceProjectsSearchState.initial());
  }
}

@freezed
class AttendanceProjectsSearchEvent with _$AttendanceProjectsSearchEvent {
  const factory AttendanceProjectsSearchEvent.search({
    required String tenantId,
    required String projectid,
  }) = SearchAttendanceProjectsEvent;
  const factory AttendanceProjectsSearchEvent.dispose() =
      DisposeAttendanceRegisterEvent;
}

@freezed
class AttendanceProjectsSearchState with _$AttendanceProjectsSearchState {
  const AttendanceProjectsSearchState._();
  const factory AttendanceProjectsSearchState.initial() = _Initial;
  const factory AttendanceProjectsSearchState.loading() = _Loading;
  const factory AttendanceProjectsSearchState.loaded(
    AttendanceMarkRegisterModelResponse? attendanceRegistersModel,
  ) = _Loaded;
  const factory AttendanceProjectsSearchState.error(String? error) = _Error;
  // const factory AttendanceProjectsSearchState({
  //   @Default(false) bool loading,
  //   AttendanceRegistersModel? attendanceRegistersModel,
  //   AttendanceRegistersModel? individualAttendanceRegisterModel,
  // }) = _AttendanceProjectsSearchState;
}
