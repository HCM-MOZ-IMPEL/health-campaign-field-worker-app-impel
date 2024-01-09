// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee_indv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AttendanceMarkIndividualModel _$$_AttendanceMarkIndividualModelFromJson(
        Map<String, dynamic> json) =>
    _$_AttendanceMarkIndividualModel(
      attendanceRegister: (json['Individual'] as List<dynamic>?)
          ?.map((e) =>
              AttendanceMarkIndividual.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AttendanceMarkIndividualModelToJson(
        _$_AttendanceMarkIndividualModel instance) =>
    <String, dynamic>{
      'Individual': instance.attendanceRegister,
    };

_$_AttendanceMarkIndividual _$$_AttendanceMarkIndividualFromJson(
        Map<String, dynamic> json) =>
    _$_AttendanceMarkIndividual(
      id: json['id'] as String?,
      individualId: json['individualId'] as String?,
      tenantId: json['tenantId'] as String?,
      clientReferenceId: json['clientReferenceId'] as String?,
      name: json['name'] == null
          ? null
          : NameData.fromJson(json['name'] as Map<String, dynamic>),
      userDetails: json['userDetails'] == null
          ? null
          : UserDetails.fromJson(json['userDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AttendanceMarkIndividualToJson(
        _$_AttendanceMarkIndividual instance) =>
    <String, dynamic>{
      'id': instance.id,
      'individualId': instance.individualId,
      'tenantId': instance.tenantId,
      'clientReferenceId': instance.clientReferenceId,
      'name': instance.name,
      'userDetails': instance.userDetails,
    };

_$_NameData _$$_NameDataFromJson(Map<String, dynamic> json) => _$_NameData(
      givenName: json['givenName'] as String?,
      familyName: json['familyName'] as String?,
      otherNames: json['otherNames'] as String?,
    );

Map<String, dynamic> _$$_NameDataToJson(_$_NameData instance) =>
    <String, dynamic>{
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'otherNames': instance.otherNames,
    };

_$_UserDetails _$$_UserDetailsFromJson(Map<String, dynamic> json) =>
    _$_UserDetails(
      username: json['username'] as String?,
      tenantId: json['tenantId'] as String?,
      type: json['type'] as String?,
      role: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserDetailsToJson(_$_UserDetails instance) =>
    <String, dynamic>{
      'username': instance.username,
      'tenantId': instance.tenantId,
      'type': instance.type,
      'roles': instance.role,
    };

_$_Role _$$_RoleFromJson(Map<String, dynamic> json) => _$_Role(
      name: json['name'] as String?,
      code: json['code'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$_RoleToJson(_$_Role instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
    };
