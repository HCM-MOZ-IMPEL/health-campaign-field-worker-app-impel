import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_model.freezed.dart';
part 'register_model.g.dart';

@freezed
class AttendanceMarkRegisterModelResponse
    with _$AttendanceMarkRegisterModelResponse {
  factory AttendanceMarkRegisterModelResponse({
    @JsonKey(name: 'attendanceRegister')
        List<AttendanceMarkRegisterModel>? attendanceRegister,
  }) = _AttendanceMarkRegisterModelResponse;

  factory AttendanceMarkRegisterModelResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AttendanceMarkRegisterModelResponseFromJson(json);
}

@freezed
class AttendanceMarkRegisterModel with _$AttendanceMarkRegisterModel {
  factory AttendanceMarkRegisterModel({
    String? id,
    String? tenantId,
    String? registerNumber,
    String? name,
    String? referenceId,
    String? serviceCode,
    int? startDate,
    int? endDate,
    String? status,
    @JsonKey(name: 'attendees')
        List<AttendanceMarkIndividualModelAttendee>? attendanceAttendees,
    @JsonKey(name: 'auditDetails')
        AuditDetails? auditDetails,
    @JsonKey(name: 'additionalDetails')
        AdditionalDetails? additionalDetails,
  }) = _AttendanceMarkRegisterModel;

  factory AttendanceMarkRegisterModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AttendanceMarkRegisterModelFromJson(json);
}

@freezed
class AttendanceMarkIndividualModelAttendee
    with _$AttendanceMarkIndividualModelAttendee {
  factory AttendanceMarkIndividualModelAttendee({
    String? id,
    String? tenantId,
    String? registerId,
    String? individualId,
    int? enrollmentDate,
    int? denrollmentDate,
  }) = _AttendanceMarkIndividualModelAttendee;

  factory AttendanceMarkIndividualModelAttendee.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AttendanceMarkIndividualModelAttendeeFromJson(json);
}

@freezed
class AuditDetails with _$AuditDetails {
  const factory AuditDetails({
    String? createdBy,
    String? lastModifiedBy,
    int? createdTime,
    int? lastModifiedTime,
  }) = _AuditDetails;

  factory AuditDetails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AuditDetailsFromJson(json);
}

@freezed
class AdditionalDetails with _$AdditionalDetails {
  const factory AdditionalDetails({
    String? description,
  }) = _AdditionalDetails;

  factory AdditionalDetails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AdditionalDetailsFromJson(json);
}
