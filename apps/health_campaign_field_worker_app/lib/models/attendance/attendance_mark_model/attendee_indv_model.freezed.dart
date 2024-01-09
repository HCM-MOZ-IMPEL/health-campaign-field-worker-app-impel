// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'attendee_indv_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttendanceMarkIndividualModel _$AttendanceMarkIndividualModelFromJson(
    Map<String, dynamic> json) {
  return _AttendanceMarkIndividualModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceMarkIndividualModel {
  @JsonKey(name: 'Individual')
  List<AttendanceMarkIndividual>? get attendanceRegister =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceMarkIndividualModelCopyWith<AttendanceMarkIndividualModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceMarkIndividualModelCopyWith<$Res> {
  factory $AttendanceMarkIndividualModelCopyWith(
          AttendanceMarkIndividualModel value,
          $Res Function(AttendanceMarkIndividualModel) then) =
      _$AttendanceMarkIndividualModelCopyWithImpl<$Res,
          AttendanceMarkIndividualModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Individual')
          List<AttendanceMarkIndividual>? attendanceRegister});
}

/// @nodoc
class _$AttendanceMarkIndividualModelCopyWithImpl<$Res,
        $Val extends AttendanceMarkIndividualModel>
    implements $AttendanceMarkIndividualModelCopyWith<$Res> {
  _$AttendanceMarkIndividualModelCopyWithImpl(this._value, this._then);

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
              as List<AttendanceMarkIndividual>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttendanceMarkIndividualModelCopyWith<$Res>
    implements $AttendanceMarkIndividualModelCopyWith<$Res> {
  factory _$$_AttendanceMarkIndividualModelCopyWith(
          _$_AttendanceMarkIndividualModel value,
          $Res Function(_$_AttendanceMarkIndividualModel) then) =
      __$$_AttendanceMarkIndividualModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Individual')
          List<AttendanceMarkIndividual>? attendanceRegister});
}

/// @nodoc
class __$$_AttendanceMarkIndividualModelCopyWithImpl<$Res>
    extends _$AttendanceMarkIndividualModelCopyWithImpl<$Res,
        _$_AttendanceMarkIndividualModel>
    implements _$$_AttendanceMarkIndividualModelCopyWith<$Res> {
  __$$_AttendanceMarkIndividualModelCopyWithImpl(
      _$_AttendanceMarkIndividualModel _value,
      $Res Function(_$_AttendanceMarkIndividualModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendanceRegister = freezed,
  }) {
    return _then(_$_AttendanceMarkIndividualModel(
      attendanceRegister: freezed == attendanceRegister
          ? _value._attendanceRegister
          : attendanceRegister // ignore: cast_nullable_to_non_nullable
              as List<AttendanceMarkIndividual>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttendanceMarkIndividualModel
    implements _AttendanceMarkIndividualModel {
  _$_AttendanceMarkIndividualModel(
      {@JsonKey(name: 'Individual')
          final List<AttendanceMarkIndividual>? attendanceRegister})
      : _attendanceRegister = attendanceRegister;

  factory _$_AttendanceMarkIndividualModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_AttendanceMarkIndividualModelFromJson(json);

  final List<AttendanceMarkIndividual>? _attendanceRegister;
  @override
  @JsonKey(name: 'Individual')
  List<AttendanceMarkIndividual>? get attendanceRegister {
    final value = _attendanceRegister;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AttendanceMarkIndividualModel(attendanceRegister: $attendanceRegister)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendanceMarkIndividualModel &&
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
  _$$_AttendanceMarkIndividualModelCopyWith<_$_AttendanceMarkIndividualModel>
      get copyWith => __$$_AttendanceMarkIndividualModelCopyWithImpl<
          _$_AttendanceMarkIndividualModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttendanceMarkIndividualModelToJson(
      this,
    );
  }
}

abstract class _AttendanceMarkIndividualModel
    implements AttendanceMarkIndividualModel {
  factory _AttendanceMarkIndividualModel(
          {@JsonKey(name: 'Individual')
              final List<AttendanceMarkIndividual>? attendanceRegister}) =
      _$_AttendanceMarkIndividualModel;

  factory _AttendanceMarkIndividualModel.fromJson(Map<String, dynamic> json) =
      _$_AttendanceMarkIndividualModel.fromJson;

  @override
  @JsonKey(name: 'Individual')
  List<AttendanceMarkIndividual>? get attendanceRegister;
  @override
  @JsonKey(ignore: true)
  _$$_AttendanceMarkIndividualModelCopyWith<_$_AttendanceMarkIndividualModel>
      get copyWith => throw _privateConstructorUsedError;
}

AttendanceMarkIndividual _$AttendanceMarkIndividualFromJson(
    Map<String, dynamic> json) {
  return _AttendanceMarkIndividual.fromJson(json);
}

/// @nodoc
mixin _$AttendanceMarkIndividual {
  String? get id => throw _privateConstructorUsedError;
  String? get individualId => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get clientReferenceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  NameData? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'userDetails')
  UserDetails? get userDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceMarkIndividualCopyWith<AttendanceMarkIndividual> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceMarkIndividualCopyWith<$Res> {
  factory $AttendanceMarkIndividualCopyWith(AttendanceMarkIndividual value,
          $Res Function(AttendanceMarkIndividual) then) =
      _$AttendanceMarkIndividualCopyWithImpl<$Res, AttendanceMarkIndividual>;
  @useResult
  $Res call(
      {String? id,
      String? individualId,
      String? tenantId,
      String? clientReferenceId,
      @JsonKey(name: 'name') NameData? name,
      @JsonKey(name: 'userDetails') UserDetails? userDetails});

  $NameDataCopyWith<$Res>? get name;
  $UserDetailsCopyWith<$Res>? get userDetails;
}

/// @nodoc
class _$AttendanceMarkIndividualCopyWithImpl<$Res,
        $Val extends AttendanceMarkIndividual>
    implements $AttendanceMarkIndividualCopyWith<$Res> {
  _$AttendanceMarkIndividualCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? individualId = freezed,
    Object? tenantId = freezed,
    Object? clientReferenceId = freezed,
    Object? name = freezed,
    Object? userDetails = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      individualId: freezed == individualId
          ? _value.individualId
          : individualId // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      clientReferenceId: freezed == clientReferenceId
          ? _value.clientReferenceId
          : clientReferenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameData?,
      userDetails: freezed == userDetails
          ? _value.userDetails
          : userDetails // ignore: cast_nullable_to_non_nullable
              as UserDetails?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NameDataCopyWith<$Res>? get name {
    if (_value.name == null) {
      return null;
    }

    return $NameDataCopyWith<$Res>(_value.name!, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDetailsCopyWith<$Res>? get userDetails {
    if (_value.userDetails == null) {
      return null;
    }

    return $UserDetailsCopyWith<$Res>(_value.userDetails!, (value) {
      return _then(_value.copyWith(userDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AttendanceMarkIndividualCopyWith<$Res>
    implements $AttendanceMarkIndividualCopyWith<$Res> {
  factory _$$_AttendanceMarkIndividualCopyWith(
          _$_AttendanceMarkIndividual value,
          $Res Function(_$_AttendanceMarkIndividual) then) =
      __$$_AttendanceMarkIndividualCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? individualId,
      String? tenantId,
      String? clientReferenceId,
      @JsonKey(name: 'name') NameData? name,
      @JsonKey(name: 'userDetails') UserDetails? userDetails});

  @override
  $NameDataCopyWith<$Res>? get name;
  @override
  $UserDetailsCopyWith<$Res>? get userDetails;
}

/// @nodoc
class __$$_AttendanceMarkIndividualCopyWithImpl<$Res>
    extends _$AttendanceMarkIndividualCopyWithImpl<$Res,
        _$_AttendanceMarkIndividual>
    implements _$$_AttendanceMarkIndividualCopyWith<$Res> {
  __$$_AttendanceMarkIndividualCopyWithImpl(_$_AttendanceMarkIndividual _value,
      $Res Function(_$_AttendanceMarkIndividual) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? individualId = freezed,
    Object? tenantId = freezed,
    Object? clientReferenceId = freezed,
    Object? name = freezed,
    Object? userDetails = freezed,
  }) {
    return _then(_$_AttendanceMarkIndividual(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      individualId: freezed == individualId
          ? _value.individualId
          : individualId // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      clientReferenceId: freezed == clientReferenceId
          ? _value.clientReferenceId
          : clientReferenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameData?,
      userDetails: freezed == userDetails
          ? _value.userDetails
          : userDetails // ignore: cast_nullable_to_non_nullable
              as UserDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttendanceMarkIndividual implements _AttendanceMarkIndividual {
  _$_AttendanceMarkIndividual(
      {this.id,
      this.individualId,
      this.tenantId,
      this.clientReferenceId,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'userDetails') this.userDetails});

  factory _$_AttendanceMarkIndividual.fromJson(Map<String, dynamic> json) =>
      _$$_AttendanceMarkIndividualFromJson(json);

  @override
  final String? id;
  @override
  final String? individualId;
  @override
  final String? tenantId;
  @override
  final String? clientReferenceId;
  @override
  @JsonKey(name: 'name')
  final NameData? name;
  @override
  @JsonKey(name: 'userDetails')
  final UserDetails? userDetails;

  @override
  String toString() {
    return 'AttendanceMarkIndividual(id: $id, individualId: $individualId, tenantId: $tenantId, clientReferenceId: $clientReferenceId, name: $name, userDetails: $userDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendanceMarkIndividual &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.individualId, individualId) ||
                other.individualId == individualId) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.clientReferenceId, clientReferenceId) ||
                other.clientReferenceId == clientReferenceId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userDetails, userDetails) ||
                other.userDetails == userDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, individualId, tenantId,
      clientReferenceId, name, userDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttendanceMarkIndividualCopyWith<_$_AttendanceMarkIndividual>
      get copyWith => __$$_AttendanceMarkIndividualCopyWithImpl<
          _$_AttendanceMarkIndividual>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttendanceMarkIndividualToJson(
      this,
    );
  }
}

abstract class _AttendanceMarkIndividual implements AttendanceMarkIndividual {
  factory _AttendanceMarkIndividual(
          {final String? id,
          final String? individualId,
          final String? tenantId,
          final String? clientReferenceId,
          @JsonKey(name: 'name') final NameData? name,
          @JsonKey(name: 'userDetails') final UserDetails? userDetails}) =
      _$_AttendanceMarkIndividual;

  factory _AttendanceMarkIndividual.fromJson(Map<String, dynamic> json) =
      _$_AttendanceMarkIndividual.fromJson;

  @override
  String? get id;
  @override
  String? get individualId;
  @override
  String? get tenantId;
  @override
  String? get clientReferenceId;
  @override
  @JsonKey(name: 'name')
  NameData? get name;
  @override
  @JsonKey(name: 'userDetails')
  UserDetails? get userDetails;
  @override
  @JsonKey(ignore: true)
  _$$_AttendanceMarkIndividualCopyWith<_$_AttendanceMarkIndividual>
      get copyWith => throw _privateConstructorUsedError;
}

NameData _$NameDataFromJson(Map<String, dynamic> json) {
  return _NameData.fromJson(json);
}

/// @nodoc
mixin _$NameData {
  String? get givenName => throw _privateConstructorUsedError;
  String? get familyName => throw _privateConstructorUsedError;
  String? get otherNames => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NameDataCopyWith<NameData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NameDataCopyWith<$Res> {
  factory $NameDataCopyWith(NameData value, $Res Function(NameData) then) =
      _$NameDataCopyWithImpl<$Res, NameData>;
  @useResult
  $Res call({String? givenName, String? familyName, String? otherNames});
}

/// @nodoc
class _$NameDataCopyWithImpl<$Res, $Val extends NameData>
    implements $NameDataCopyWith<$Res> {
  _$NameDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? givenName = freezed,
    Object? familyName = freezed,
    Object? otherNames = freezed,
  }) {
    return _then(_value.copyWith(
      givenName: freezed == givenName
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: freezed == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      otherNames: freezed == otherNames
          ? _value.otherNames
          : otherNames // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NameDataCopyWith<$Res> implements $NameDataCopyWith<$Res> {
  factory _$$_NameDataCopyWith(
          _$_NameData value, $Res Function(_$_NameData) then) =
      __$$_NameDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? givenName, String? familyName, String? otherNames});
}

/// @nodoc
class __$$_NameDataCopyWithImpl<$Res>
    extends _$NameDataCopyWithImpl<$Res, _$_NameData>
    implements _$$_NameDataCopyWith<$Res> {
  __$$_NameDataCopyWithImpl(
      _$_NameData _value, $Res Function(_$_NameData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? givenName = freezed,
    Object? familyName = freezed,
    Object? otherNames = freezed,
  }) {
    return _then(_$_NameData(
      givenName: freezed == givenName
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: freezed == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      otherNames: freezed == otherNames
          ? _value.otherNames
          : otherNames // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NameData implements _NameData {
  _$_NameData({this.givenName, this.familyName, this.otherNames});

  factory _$_NameData.fromJson(Map<String, dynamic> json) =>
      _$$_NameDataFromJson(json);

  @override
  final String? givenName;
  @override
  final String? familyName;
  @override
  final String? otherNames;

  @override
  String toString() {
    return 'NameData(givenName: $givenName, familyName: $familyName, otherNames: $otherNames)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NameData &&
            (identical(other.givenName, givenName) ||
                other.givenName == givenName) &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            (identical(other.otherNames, otherNames) ||
                other.otherNames == otherNames));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, givenName, familyName, otherNames);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NameDataCopyWith<_$_NameData> get copyWith =>
      __$$_NameDataCopyWithImpl<_$_NameData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NameDataToJson(
      this,
    );
  }
}

abstract class _NameData implements NameData {
  factory _NameData(
      {final String? givenName,
      final String? familyName,
      final String? otherNames}) = _$_NameData;

  factory _NameData.fromJson(Map<String, dynamic> json) = _$_NameData.fromJson;

  @override
  String? get givenName;
  @override
  String? get familyName;
  @override
  String? get otherNames;
  @override
  @JsonKey(ignore: true)
  _$$_NameDataCopyWith<_$_NameData> get copyWith =>
      throw _privateConstructorUsedError;
}

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) {
  return _UserDetails.fromJson(json);
}

/// @nodoc
mixin _$UserDetails {
  String? get username => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles')
  List<Role>? get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDetailsCopyWith<UserDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDetailsCopyWith<$Res> {
  factory $UserDetailsCopyWith(
          UserDetails value, $Res Function(UserDetails) then) =
      _$UserDetailsCopyWithImpl<$Res, UserDetails>;
  @useResult
  $Res call(
      {String? username,
      String? tenantId,
      String? type,
      @JsonKey(name: 'roles') List<Role>? role});
}

/// @nodoc
class _$UserDetailsCopyWithImpl<$Res, $Val extends UserDetails>
    implements $UserDetailsCopyWith<$Res> {
  _$UserDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? tenantId = freezed,
    Object? type = freezed,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as List<Role>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserDetailsCopyWith<$Res>
    implements $UserDetailsCopyWith<$Res> {
  factory _$$_UserDetailsCopyWith(
          _$_UserDetails value, $Res Function(_$_UserDetails) then) =
      __$$_UserDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? username,
      String? tenantId,
      String? type,
      @JsonKey(name: 'roles') List<Role>? role});
}

/// @nodoc
class __$$_UserDetailsCopyWithImpl<$Res>
    extends _$UserDetailsCopyWithImpl<$Res, _$_UserDetails>
    implements _$$_UserDetailsCopyWith<$Res> {
  __$$_UserDetailsCopyWithImpl(
      _$_UserDetails _value, $Res Function(_$_UserDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? tenantId = freezed,
    Object? type = freezed,
    Object? role = freezed,
  }) {
    return _then(_$_UserDetails(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value._role
          : role // ignore: cast_nullable_to_non_nullable
              as List<Role>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserDetails implements _UserDetails {
  _$_UserDetails(
      {this.username,
      this.tenantId,
      this.type,
      @JsonKey(name: 'roles') final List<Role>? role})
      : _role = role;

  factory _$_UserDetails.fromJson(Map<String, dynamic> json) =>
      _$$_UserDetailsFromJson(json);

  @override
  final String? username;
  @override
  final String? tenantId;
  @override
  final String? type;
  final List<Role>? _role;
  @override
  @JsonKey(name: 'roles')
  List<Role>? get role {
    final value = _role;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserDetails(username: $username, tenantId: $tenantId, type: $type, role: $role)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserDetails &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._role, _role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username, tenantId, type,
      const DeepCollectionEquality().hash(_role));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserDetailsCopyWith<_$_UserDetails> get copyWith =>
      __$$_UserDetailsCopyWithImpl<_$_UserDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDetailsToJson(
      this,
    );
  }
}

abstract class _UserDetails implements UserDetails {
  factory _UserDetails(
      {final String? username,
      final String? tenantId,
      final String? type,
      @JsonKey(name: 'roles') final List<Role>? role}) = _$_UserDetails;

  factory _UserDetails.fromJson(Map<String, dynamic> json) =
      _$_UserDetails.fromJson;

  @override
  String? get username;
  @override
  String? get tenantId;
  @override
  String? get type;
  @override
  @JsonKey(name: 'roles')
  List<Role>? get role;
  @override
  @JsonKey(ignore: true)
  _$$_UserDetailsCopyWith<_$_UserDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

Role _$RoleFromJson(Map<String, dynamic> json) {
  return _Role.fromJson(json);
}

/// @nodoc
mixin _$Role {
  String? get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoleCopyWith<Role> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoleCopyWith<$Res> {
  factory $RoleCopyWith(Role value, $Res Function(Role) then) =
      _$RoleCopyWithImpl<$Res, Role>;
  @useResult
  $Res call({String? name, String? code, String? description});
}

/// @nodoc
class _$RoleCopyWithImpl<$Res, $Val extends Role>
    implements $RoleCopyWith<$Res> {
  _$RoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoleCopyWith<$Res> implements $RoleCopyWith<$Res> {
  factory _$$_RoleCopyWith(_$_Role value, $Res Function(_$_Role) then) =
      __$$_RoleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? code, String? description});
}

/// @nodoc
class __$$_RoleCopyWithImpl<$Res> extends _$RoleCopyWithImpl<$Res, _$_Role>
    implements _$$_RoleCopyWith<$Res> {
  __$$_RoleCopyWithImpl(_$_Role _value, $Res Function(_$_Role) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_Role(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Role implements _Role {
  _$_Role({this.name, this.code, this.description});

  factory _$_Role.fromJson(Map<String, dynamic> json) => _$$_RoleFromJson(json);

  @override
  final String? name;
  @override
  final String? code;
  @override
  final String? description;

  @override
  String toString() {
    return 'Role(name: $name, code: $code, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Role &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoleCopyWith<_$_Role> get copyWith =>
      __$$_RoleCopyWithImpl<_$_Role>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoleToJson(
      this,
    );
  }
}

abstract class _Role implements Role {
  factory _Role(
      {final String? name,
      final String? code,
      final String? description}) = _$_Role;

  factory _Role.fromJson(Map<String, dynamic> json) = _$_Role.fromJson;

  @override
  String? get name;
  @override
  String? get code;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_RoleCopyWith<_$_Role> get copyWith => throw _privateConstructorUsedError;
}
