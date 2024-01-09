import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_collection_attendee.freezed.dart';
part 'attendance_collection_attendee.g.dart';

@freezed
class AttendeeCollectionModel with _$AttendeeCollectionModel {
  factory AttendeeCollectionModel({
    String? userName,
    String? name,
    int? id,
    String? registerId,
    String? individualId,
    String? tenantId,
    @Default(0) int entryTime,
    @Default(0) int exitTime,
    @Default(0) int eventStartDate,
    @Default(0) int eventEndDate,
    String? type,
    @Default(-1) int status,
  }) = _AttendeeCollectionModel;

  factory AttendeeCollectionModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AttendeeCollectionModelFromJson(json);
}
