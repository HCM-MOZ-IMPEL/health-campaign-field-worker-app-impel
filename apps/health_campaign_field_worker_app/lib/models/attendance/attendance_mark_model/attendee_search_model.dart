import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendee_search_model.freezed.dart';
part 'attendee_search_model.g.dart';

@freezed
class AttendanceSearchIndividualModel with _$AttendanceSearchIndividualModel {
  factory AttendanceSearchIndividualModel({
    @JsonKey(name: 'attendance')
        List<AttendeeIndividualModel>? attendeeIndividuals,
  }) = _AttendanceSearchIndividualModel;

  factory AttendanceSearchIndividualModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AttendanceSearchIndividualModelFromJson(json);
}

@freezed
class AttendeeIndividualModel with _$AttendeeIndividualModel {
  factory AttendeeIndividualModel({
    String? id,
    String? registerId,
    String? individualId,
    String? tenantId,
    @Default(0) int time,
    String? type,
    String? status,
  }) = _AttendeeIndividualModel;

  factory AttendeeIndividualModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AttendeeIndividualModelFromJson(json);
}
