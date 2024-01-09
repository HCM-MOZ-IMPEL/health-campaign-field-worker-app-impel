// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'register_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttendanceMarkRegisterModelResponse
    _$AttendanceMarkRegisterModelResponseFromJson(Map<String, dynamic> json) {
  return _AttendanceMarkRegisterModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AttendanceMarkRegisterModelResponse {
  @JsonKey(name: 'attendanceRegister')
  List<AttendanceMarkRegisterModel>? get attendanceRegister =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceMarkRegisterModelResponseCopyWith<
          AttendanceMarkRegisterModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceMarkRegisterModelResponseCopyWith<$Res> {
  factory $AttendanceMarkRegisterModelResponseCopyWith(
          AttendanceMarkRegisterModelResponse value,
          $Res Function(AttendanceMarkRegisterModelResponse) then) =
      _$AttendanceMarkRegisterModelResponseCopyWithImpl<$Res,
          AttendanceMarkRegisterModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'attendanceRegister')
          List<AttendanceMarkRegisterModel>? attendanceRegister});
}

/// @nodoc
class _$AttendanceMarkRegisterModelResponseCopyWithImpl<$Res,
        $Val extends AttendanceMarkRegisterModelResponse>
    implements $AttendanceMarkRegisterModelResponseCopyWith<$Res> {
  _$AttendanceMarkRegisterModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendanceRegister = freezed,
  }) {
    return _then(_value.copyWith(
      attendanceRegister: freezed == attendanceRegister
          ? _value.attendanceRegister
          : attendanceRegister // ignore: cast_nullable_to_non_nullable
              as List<AttendanceMarkRegisterModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttendanceMarkRegisterModelResponseCopyWith<$Res>
    implements $AttendanceMarkRegisterModelResponseCopyWith<$Res> {
  factory _$$_AttendanceMarkRegisterModelResponseCopyWith(
          _$_AttendanceMarkRegisterModelResponse value,
          $Res Function(_$_AttendanceMarkRegisterModelResponse) then) =
      __$$_AttendanceMarkRegisterModelResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'attendanceRegister')
          List<AttendanceMarkRegisterModel>? attendanceRegister});
}

/// @nodoc
class __$$_AttendanceMarkRegisterModelResponseCopyWithImpl<$Res>
    extends _$AttendanceMarkRegisterModelResponseCopyWithImpl<$Res,
        _$_AttendanceMarkRegisterModelResponse>
    implements _$$_AttendanceMarkRegisterModelResponseCopyWith<$Res> {
  __$$_AttendanceMarkRegisterModelResponseCopyWithImpl(
      _$_AttendanceMarkRegisterModelResponse _value,
      $Res Function(_$_AttendanceMarkRegisterModelResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendanceRegister = freezed,
  }) {
    return _then(_$_AttendanceMarkRegisterModelResponse(
      attendanceRegister: freezed == attendanceRegister
          ? _value._attendanceRegister
          : attendanceRegister // ignore: cast_nullable_to_non_nullable
              as List<AttendanceMarkRegisterModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttendanceMarkRegisterModelResponse
    implements _AttendanceMarkRegisterModelResponse {
  _$_AttendanceMarkRegisterModelResponse(
      {@JsonKey(name: 'attendanceRegister')
          final List<AttendanceMarkRegisterModel>? attendanceRegister})
      : _attendanceRegister = attendanceRegister;

  factory _$_AttendanceMarkRegisterModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$$_AttendanceMarkRegisterModelResponseFromJson(json);

  final List<AttendanceMarkRegisterModel>? _attendanceRegister;
  @override
  @JsonKey(name: 'attendanceRegister')
  List<AttendanceMarkRegisterModel>? get attendanceRegister {
    final value = _attendanceRegister;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AttendanceMarkRegisterModelResponse(attendanceRegister: $attendanceRegister)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendanceMarkRegisterModelResponse &&
            const DeepCollectionEquality()
                .equals(other._attendanceRegister, _attendanceRegister));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_attendanceRegister));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttendanceMarkRegisterModelResponseCopyWith<
          _$_AttendanceMarkRegisterModelResponse>
      get copyWith => __$$_AttendanceMarkRegisterModelResponseCopyWithImpl<
          _$_AttendanceMarkRegisterModelResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttendanceMarkRegisterModelResponseToJson(
      this,
    );
  }
}

abstract class _AttendanceMarkRegisterModelResponse
    implements AttendanceMarkRegisterModelResponse {
  factory _AttendanceMarkRegisterModelResponse(
          {@JsonKey(name: 'attendanceRegister')
              final List<AttendanceMarkRegisterModel>? attendanceRegister}) =
      _$_AttendanceMarkRegisterModelResponse;

  factory _AttendanceMarkRegisterModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$_AttendanceMarkRegisterModelResponse.fromJson;

  @override
  @JsonKey(name: 'attendanceRegister')
  List<AttendanceMarkRegisterModel>? get attendanceRegister;
  @override
  @JsonKey(ignore: true)
  _$$_AttendanceMarkRegisterModelResponseCopyWith<
          _$_AttendanceMarkRegisterModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

AttendanceMarkRegisterModel _$AttendanceMarkRegisterModelFromJson(
    Map<String, dynamic> json) {
  return _AttendanceMarkRegisterModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceMarkRegisterModel {
  String? get id => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get registerNumber => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String? get serviceCode => throw _privateConstructorUsedError;
  int? get startDate => throw _privateConstructorUsedError;
  int? get endDate => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendees')
  List<AttendanceMarkIndividualModelAttendee>? get attendanceAttendees =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'auditDetails')
  AuditDetails? get auditDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'additionalDetails')
  AdditionalDetails? get additionalDetails =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceMarkRegisterModelCopyWith<AttendanceMarkRegisterModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceMarkRegisterModelCopyWith<$Res> {
  factory $AttendanceMarkRegisterModelCopyWith(
          AttendanceMarkRegisterModel value,
          $Res Function(AttendanceMarkRegisterModel) then) =
      _$AttendanceMarkRegisterModelCopyWithImpl<$Res,
          AttendanceMarkRegisterModel>;
  @useResult
  $Res call(
      {String? id,
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
          AdditionalDetails? additionalDetails});

  $AuditDetailsCopyWith<$Res>? get auditDetails;
  $AdditionalDetailsCopyWith<$Res>? get additionalDetails;
}

/// @nodoc
class _$AttendanceMarkRegisterModelCopyWithImpl<$Res,
        $Val extends AttendanceMarkRegisterModel>
    implements $AttendanceMarkRegisterModelCopyWith<$Res> {
  _$AttendanceMarkRegisterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? registerNumber = freezed,
    Object? name = freezed,
    Object? referenceId = freezed,
    Object? serviceCode = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? status = freezed,
    Object? attendanceAttendees = freezed,
    Object? auditDetails = freezed,
    Object? additionalDetails = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerNumber: freezed == registerNumber
          ? _value.registerNumber
          : registerNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceCode: freezed == serviceCode
          ? _value.serviceCode
          : serviceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      attendanceAttendees: freezed == attendanceAttendees
          ? _value.attendanceAttendees
          : attendanceAttendees // ignore: cast_nullable_to_non_nullable
              as List<AttendanceMarkIndividualModelAttendee>?,
      auditDetails: freezed == auditDetails
          ? _value.auditDetails
          : auditDetails // ignore: cast_nullable_to_non_nullable
              as AuditDetails?,
      additionalDetails: freezed == additionalDetails
          ? _value.additionalDetails
          : additionalDetails // ignore: cast_nullable_to_non_nullable
              as AdditionalDetails?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuditDetailsCopyWith<$Res>? get auditDetails {
    if (_value.auditDetails == null) {
      return null;
    }

    return $AuditDetailsCopyWith<$Res>(_value.auditDetails!, (value) {
      return _then(_value.copyWith(auditDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AdditionalDetailsCopyWith<$Res>? get additionalDetails {
    if (_value.additionalDetails == null) {
      return null;
    }

    return $AdditionalDetailsCopyWith<$Res>(_value.additionalDetails!, (value) {
      return _then(_value.copyWith(additionalDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AttendanceMarkRegisterModelCopyWith<$Res>
    implements $AttendanceMarkRegisterModelCopyWith<$Res> {
  factory _$$_AttendanceMarkRegisterModelCopyWith(
          _$_AttendanceMarkRegisterModel value,
          $Res Function(_$_AttendanceMarkRegisterModel) then) =
      __$$_AttendanceMarkRegisterModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
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
          AdditionalDetails? additionalDetails});

  @override
  $AuditDetailsCopyWith<$Res>? get auditDetails;
  @override
  $AdditionalDetailsCopyWith<$Res>? get additionalDetails;
}

/// @nodoc
class __$$_AttendanceMarkRegisterModelCopyWithImpl<$Res>
    extends _$AttendanceMarkRegisterModelCopyWithImpl<$Res,
        _$_AttendanceMarkRegisterModel>
    implements _$$_AttendanceMarkRegisterModelCopyWith<$Res> {
  __$$_AttendanceMarkRegisterModelCopyWithImpl(
      _$_AttendanceMarkRegisterModel _value,
      $Res Function(_$_AttendanceMarkRegisterModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? registerNumber = freezed,
    Object? name = freezed,
    Object? referenceId = freezed,
    Object? serviceCode = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? status = freezed,
    Object? attendanceAttendees = freezed,
    Object? auditDetails = freezed,
    Object? additionalDetails = freezed,
  }) {
    return _then(_$_AttendanceMarkRegisterModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerNumber: freezed == registerNumber
          ? _value.registerNumber
          : registerNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceCode: freezed == serviceCode
          ? _value.serviceCode
          : serviceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      attendanceAttendees: freezed == attendanceAttendees
          ? _value._attendanceAttendees
          : attendanceAttendees // ignore: cast_nullable_to_non_nullable
              as List<AttendanceMarkIndividualModelAttendee>?,
      auditDetails: freezed == auditDetails
          ? _value.auditDetails
          : auditDetails // ignore: cast_nullable_to_non_nullable
              as AuditDetails?,
      additionalDetails: freezed == additionalDetails
          ? _value.additionalDetails
          : additionalDetails // ignore: cast_nullable_to_non_nullable
              as AdditionalDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttendanceMarkRegisterModel implements _AttendanceMarkRegisterModel {
  _$_AttendanceMarkRegisterModel(
      {this.id,
      this.tenantId,
      this.registerNumber,
      this.name,
      this.referenceId,
      this.serviceCode,
      this.startDate,
      this.endDate,
      this.status,
      @JsonKey(name: 'attendees')
          final List<AttendanceMarkIndividualModelAttendee>?
              attendanceAttendees,
      @JsonKey(name: 'auditDetails')
          this.auditDetails,
      @JsonKey(name: 'additionalDetails')
          this.additionalDetails})
      : _attendanceAttendees = attendanceAttendees;

  factory _$_AttendanceMarkRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$$_AttendanceMarkRegisterModelFromJson(json);

  @override
  final String? id;
  @override
  final String? tenantId;
  @override
  final String? registerNumber;
  @override
  final String? name;
  @override
  final String? referenceId;
  @override
  final String? serviceCode;
  @override
  final int? startDate;
  @override
  final int? endDate;
  @override
  final String? status;
  final List<AttendanceMarkIndividualModelAttendee>? _attendanceAttendees;
  @override
  @JsonKey(name: 'attendees')
  List<AttendanceMarkIndividualModelAttendee>? get attendanceAttendees {
    final value = _attendanceAttendees;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'auditDetails')
  final AuditDetails? auditDetails;
  @override
  @JsonKey(name: 'additionalDetails')
  final AdditionalDetails? additionalDetails;

  @override
  String toString() {
    return 'AttendanceMarkRegisterModel(id: $id, tenantId: $tenantId, registerNumber: $registerNumber, name: $name, referenceId: $referenceId, serviceCode: $serviceCode, startDate: $startDate, endDate: $endDate, status: $status, attendanceAttendees: $attendanceAttendees, auditDetails: $auditDetails, additionalDetails: $additionalDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendanceMarkRegisterModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.registerNumber, registerNumber) ||
                other.registerNumber == registerNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.serviceCode, serviceCode) ||
                other.serviceCode == serviceCode) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._attendanceAttendees, _attendanceAttendees) &&
            (identical(other.auditDetails, auditDetails) ||
                other.auditDetails == auditDetails) &&
            (identical(other.additionalDetails, additionalDetails) ||
                other.additionalDetails == additionalDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tenantId,
      registerNumber,
      name,
      referenceId,
      serviceCode,
      startDate,
      endDate,
      status,
      const DeepCollectionEquality().hash(_attendanceAttendees),
      auditDetails,
      additionalDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttendanceMarkRegisterModelCopyWith<_$_AttendanceMarkRegisterModel>
      get copyWith => __$$_AttendanceMarkRegisterModelCopyWithImpl<
          _$_AttendanceMarkRegisterModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttendanceMarkRegisterModelToJson(
      this,
    );
  }
}

abstract class _AttendanceMarkRegisterModel
    implements AttendanceMarkRegisterModel {
  factory _AttendanceMarkRegisterModel(
          {final String? id,
          final String? tenantId,
          final String? registerNumber,
          final String? name,
          final String? referenceId,
          final String? serviceCode,
          final int? startDate,
          final int? endDate,
          final String? status,
          @JsonKey(name: 'attendees')
              final List<AttendanceMarkIndividualModelAttendee>?
                  attendanceAttendees,
          @JsonKey(name: 'auditDetails')
              final AuditDetails? auditDetails,
          @JsonKey(name: 'additionalDetails')
              final AdditionalDetails? additionalDetails}) =
      _$_AttendanceMarkRegisterModel;

  factory _AttendanceMarkRegisterModel.fromJson(Map<String, dynamic> json) =
      _$_AttendanceMarkRegisterModel.fromJson;

  @override
  String? get id;
  @override
  String? get tenantId;
  @override
  String? get registerNumber;
  @override
  String? get name;
  @override
  String? get referenceId;
  @override
  String? get serviceCode;
  @override
  int? get startDate;
  @override
  int? get endDate;
  @override
  String? get status;
  @override
  @JsonKey(name: 'attendees')
  List<AttendanceMarkIndividualModelAttendee>? get attendanceAttendees;
  @override
  @JsonKey(name: 'auditDetails')
  AuditDetails? get auditDetails;
  @override
  @JsonKey(name: 'additionalDetails')
  AdditionalDetails? get additionalDetails;
  @override
  @JsonKey(ignore: true)
  _$$_AttendanceMarkRegisterModelCopyWith<_$_AttendanceMarkRegisterModel>
      get copyWith => throw _privateConstructorUsedError;
}

AttendanceMarkIndividualModelAttendee
    _$AttendanceMarkIndividualModelAttendeeFromJson(Map<String, dynamic> json) {
  return _AttendanceMarkIndividualModelAttendee.fromJson(json);
}

/// @nodoc
mixin _$AttendanceMarkIndividualModelAttendee {
  String? get id => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get registerId => throw _privateConstructorUsedError;
  String? get individualId => throw _privateConstructorUsedError;
  int? get enrollmentDate => throw _privateConstructorUsedError;
  int? get denrollmentDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceMarkIndividualModelAttendeeCopyWith<
          AttendanceMarkIndividualModelAttendee>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceMarkIndividualModelAttendeeCopyWith<$Res> {
  factory $AttendanceMarkIndividualModelAttendeeCopyWith(
          AttendanceMarkIndividualModelAttendee value,
          $Res Function(AttendanceMarkIndividualModelAttendee) then) =
      _$AttendanceMarkIndividualModelAttendeeCopyWithImpl<$Res,
          AttendanceMarkIndividualModelAttendee>;
  @useResult
  $Res call(
      {String? id,
      String? tenantId,
      String? registerId,
      String? individualId,
      int? enrollmentDate,
      int? denrollmentDate});
}

/// @nodoc
class _$AttendanceMarkIndividualModelAttendeeCopyWithImpl<$Res,
        $Val extends AttendanceMarkIndividualModelAttendee>
    implements $AttendanceMarkIndividualModelAttendeeCopyWith<$Res> {
  _$AttendanceMarkIndividualModelAttendeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? registerId = freezed,
    Object? individualId = freezed,
    Object? enrollmentDate = freezed,
    Object? denrollmentDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String?,
      individualId: freezed == individualId
          ? _value.individualId
          : individualId // ignore: cast_nullable_to_non_nullable
              as String?,
      enrollmentDate: freezed == enrollmentDate
          ? _value.enrollmentDate
          : enrollmentDate // ignore: cast_nullable_to_non_nullable
              as int?,
      denrollmentDate: freezed == denrollmentDate
          ? _value.denrollmentDate
          : denrollmentDate // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttendanceMarkIndividualModelAttendeeCopyWith<$Res>
    implements $AttendanceMarkIndividualModelAttendeeCopyWith<$Res> {
  factory _$$_AttendanceMarkIndividualModelAttendeeCopyWith(
          _$_AttendanceMarkIndividualModelAttendee value,
          $Res Function(_$_AttendanceMarkIndividualModelAttendee) then) =
      __$$_AttendanceMarkIndividualModelAttendeeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? tenantId,
      String? registerId,
      String? individualId,
      int? enrollmentDate,
      int? denrollmentDate});
}

/// @nodoc
class __$$_AttendanceMarkIndividualModelAttendeeCopyWithImpl<$Res>
    extends _$AttendanceMarkIndividualModelAttendeeCopyWithImpl<$Res,
        _$_AttendanceMarkIndividualModelAttendee>
    implements _$$_AttendanceMarkIndividualModelAttendeeCopyWith<$Res> {
  __$$_AttendanceMarkIndividualModelAttendeeCopyWithImpl(
      _$_AttendanceMarkIndividualModelAttendee _value,
      $Res Function(_$_AttendanceMarkIndividualModelAttendee) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tenantId = freezed,
    Object? registerId = freezed,
    Object? individualId = freezed,
    Object? enrollmentDate = freezed,
    Object? denrollmentDate = freezed,
  }) {
    return _then(_$_AttendanceMarkIndividualModelAttendee(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String?,
      individualId: freezed == individualId
          ? _value.individualId
          : individualId // ignore: cast_nullable_to_non_nullable
              as String?,
      enrollmentDate: freezed == enrollmentDate
          ? _value.enrollmentDate
          : enrollmentDate // ignore: cast_nullable_to_non_nullable
              as int?,
      denrollmentDate: freezed == denrollmentDate
          ? _value.denrollmentDate
          : denrollmentDate // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttendanceMarkIndividualModelAttendee
    implements _AttendanceMarkIndividualModelAttendee {
  _$_AttendanceMarkIndividualModelAttendee(
      {this.id,
      this.tenantId,
      this.registerId,
      this.individualId,
      this.enrollmentDate,
      this.denrollmentDate});

  factory _$_AttendanceMarkIndividualModelAttendee.fromJson(
          Map<String, dynamic> json) =>
      _$$_AttendanceMarkIndividualModelAttendeeFromJson(json);

  @override
  final String? id;
  @override
  final String? tenantId;
  @override
  final String? registerId;
  @override
  final String? individualId;
  @override
  final int? enrollmentDate;
  @override
  final int? denrollmentDate;

  @override
  String toString() {
    return 'AttendanceMarkIndividualModelAttendee(id: $id, tenantId: $tenantId, registerId: $registerId, individualId: $individualId, enrollmentDate: $enrollmentDate, denrollmentDate: $denrollmentDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendanceMarkIndividualModelAttendee &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.individualId, individualId) ||
                other.individualId == individualId) &&
            (identical(other.enrollmentDate, enrollmentDate) ||
                other.enrollmentDate == enrollmentDate) &&
            (identical(other.denrollmentDate, denrollmentDate) ||
                other.denrollmentDate == denrollmentDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, tenantId, registerId,
      individualId, enrollmentDate, denrollmentDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttendanceMarkIndividualModelAttendeeCopyWith<
          _$_AttendanceMarkIndividualModelAttendee>
      get copyWith => __$$_AttendanceMarkIndividualModelAttendeeCopyWithImpl<
          _$_AttendanceMarkIndividualModelAttendee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttendanceMarkIndividualModelAttendeeToJson(
      this,
    );
  }
}

abstract class _AttendanceMarkIndividualModelAttendee
    implements AttendanceMarkIndividualModelAttendee {
  factory _AttendanceMarkIndividualModelAttendee(
      {final String? id,
      final String? tenantId,
      final String? registerId,
      final String? individualId,
      final int? enrollmentDate,
      final int? denrollmentDate}) = _$_AttendanceMarkIndividualModelAttendee;

  factory _AttendanceMarkIndividualModelAttendee.fromJson(
          Map<String, dynamic> json) =
      _$_AttendanceMarkIndividualModelAttendee.fromJson;

  @override
  String? get id;
  @override
  String? get tenantId;
  @override
  String? get registerId;
  @override
  String? get individualId;
  @override
  int? get enrollmentDate;
  @override
  int? get denrollmentDate;
  @override
  @JsonKey(ignore: true)
  _$$_AttendanceMarkIndividualModelAttendeeCopyWith<
          _$_AttendanceMarkIndividualModelAttendee>
      get copyWith => throw _privateConstructorUsedError;
}

AuditDetails _$AuditDetailsFromJson(Map<String, dynamic> json) {
  return _AuditDetails.fromJson(json);
}

/// @nodoc
mixin _$AuditDetails {
  String? get createdBy => throw _privateConstructorUsedError;
  String? get lastModifiedBy => throw _privateConstructorUsedError;
  int? get createdTime => throw _privateConstructorUsedError;
  int? get lastModifiedTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuditDetailsCopyWith<AuditDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditDetailsCopyWith<$Res> {
  factory $AuditDetailsCopyWith(
          AuditDetails value, $Res Function(AuditDetails) then) =
      _$AuditDetailsCopyWithImpl<$Res, AuditDetails>;
  @useResult
  $Res call(
      {String? createdBy,
      String? lastModifiedBy,
      int? createdTime,
      int? lastModifiedTime});
}

/// @nodoc
class _$AuditDetailsCopyWithImpl<$Res, $Val extends AuditDetails>
    implements $AuditDetailsCopyWith<$Res> {
  _$AuditDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdBy = freezed,
    Object? lastModifiedBy = freezed,
    Object? createdTime = freezed,
    Object? lastModifiedTime = freezed,
  }) {
    return _then(_value.copyWith(
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastModifiedBy: freezed == lastModifiedBy
          ? _value.lastModifiedBy
          : lastModifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as int?,
      lastModifiedTime: freezed == lastModifiedTime
          ? _value.lastModifiedTime
          : lastModifiedTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuditDetailsCopyWith<$Res>
    implements $AuditDetailsCopyWith<$Res> {
  factory _$$_AuditDetailsCopyWith(
          _$_AuditDetails value, $Res Function(_$_AuditDetails) then) =
      __$$_AuditDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? createdBy,
      String? lastModifiedBy,
      int? createdTime,
      int? lastModifiedTime});
}

/// @nodoc
class __$$_AuditDetailsCopyWithImpl<$Res>
    extends _$AuditDetailsCopyWithImpl<$Res, _$_AuditDetails>
    implements _$$_AuditDetailsCopyWith<$Res> {
  __$$_AuditDetailsCopyWithImpl(
      _$_AuditDetails _value, $Res Function(_$_AuditDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdBy = freezed,
    Object? lastModifiedBy = freezed,
    Object? createdTime = freezed,
    Object? lastModifiedTime = freezed,
  }) {
    return _then(_$_AuditDetails(
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastModifiedBy: freezed == lastModifiedBy
          ? _value.lastModifiedBy
          : lastModifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as int?,
      lastModifiedTime: freezed == lastModifiedTime
          ? _value.lastModifiedTime
          : lastModifiedTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuditDetails implements _AuditDetails {
  const _$_AuditDetails(
      {this.createdBy,
      this.lastModifiedBy,
      this.createdTime,
      this.lastModifiedTime});

  factory _$_AuditDetails.fromJson(Map<String, dynamic> json) =>
      _$$_AuditDetailsFromJson(json);

  @override
  final String? createdBy;
  @override
  final String? lastModifiedBy;
  @override
  final int? createdTime;
  @override
  final int? lastModifiedTime;

  @override
  String toString() {
    return 'AuditDetails(createdBy: $createdBy, lastModifiedBy: $lastModifiedBy, createdTime: $createdTime, lastModifiedTime: $lastModifiedTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuditDetails &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.lastModifiedBy, lastModifiedBy) ||
                other.lastModifiedBy == lastModifiedBy) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.lastModifiedTime, lastModifiedTime) ||
                other.lastModifiedTime == lastModifiedTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, createdBy, lastModifiedBy, createdTime, lastModifiedTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuditDetailsCopyWith<_$_AuditDetails> get copyWith =>
      __$$_AuditDetailsCopyWithImpl<_$_AuditDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuditDetailsToJson(
      this,
    );
  }
}

abstract class _AuditDetails implements AuditDetails {
  const factory _AuditDetails(
      {final String? createdBy,
      final String? lastModifiedBy,
      final int? createdTime,
      final int? lastModifiedTime}) = _$_AuditDetails;

  factory _AuditDetails.fromJson(Map<String, dynamic> json) =
      _$_AuditDetails.fromJson;

  @override
  String? get createdBy;
  @override
  String? get lastModifiedBy;
  @override
  int? get createdTime;
  @override
  int? get lastModifiedTime;
  @override
  @JsonKey(ignore: true)
  _$$_AuditDetailsCopyWith<_$_AuditDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

AdditionalDetails _$AdditionalDetailsFromJson(Map<String, dynamic> json) {
  return _AdditionalDetails.fromJson(json);
}

/// @nodoc
mixin _$AdditionalDetails {
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdditionalDetailsCopyWith<AdditionalDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdditionalDetailsCopyWith<$Res> {
  factory $AdditionalDetailsCopyWith(
          AdditionalDetails value, $Res Function(AdditionalDetails) then) =
      _$AdditionalDetailsCopyWithImpl<$Res, AdditionalDetails>;
  @useResult
  $Res call({String? description});
}

/// @nodoc
class _$AdditionalDetailsCopyWithImpl<$Res, $Val extends AdditionalDetails>
    implements $AdditionalDetailsCopyWith<$Res> {
  _$AdditionalDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdditionalDetailsCopyWith<$Res>
    implements $AdditionalDetailsCopyWith<$Res> {
  factory _$$_AdditionalDetailsCopyWith(_$_AdditionalDetails value,
          $Res Function(_$_AdditionalDetails) then) =
      __$$_AdditionalDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? description});
}

/// @nodoc
class __$$_AdditionalDetailsCopyWithImpl<$Res>
    extends _$AdditionalDetailsCopyWithImpl<$Res, _$_AdditionalDetails>
    implements _$$_AdditionalDetailsCopyWith<$Res> {
  __$$_AdditionalDetailsCopyWithImpl(
      _$_AdditionalDetails _value, $Res Function(_$_AdditionalDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_$_AdditionalDetails(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AdditionalDetails implements _AdditionalDetails {
  const _$_AdditionalDetails({this.description});

  factory _$_AdditionalDetails.fromJson(Map<String, dynamic> json) =>
      _$$_AdditionalDetailsFromJson(json);

  @override
  final String? description;

  @override
  String toString() {
    return 'AdditionalDetails(description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdditionalDetails &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdditionalDetailsCopyWith<_$_AdditionalDetails> get copyWith =>
      __$$_AdditionalDetailsCopyWithImpl<_$_AdditionalDetails>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdditionalDetailsToJson(
      this,
    );
  }
}

abstract class _AdditionalDetails implements AdditionalDetails {
  const factory _AdditionalDetails({final String? description}) =
      _$_AdditionalDetails;

  factory _AdditionalDetails.fromJson(Map<String, dynamic> json) =
      _$_AdditionalDetails.fromJson;

  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_AdditionalDetailsCopyWith<_$_AdditionalDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
