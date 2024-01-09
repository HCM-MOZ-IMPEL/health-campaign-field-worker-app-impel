// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'attendee_search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttendanceSearchIndividualModel _$AttendanceSearchIndividualModelFromJson(
    Map<String, dynamic> json) {
  return _AttendanceSearchIndividualModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceSearchIndividualModel {
  @JsonKey(name: 'attendance')
  List<AttendeeIndividualModel>? get attendeeIndividuals =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceSearchIndividualModelCopyWith<AttendanceSearchIndividualModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceSearchIndividualModelCopyWith<$Res> {
  factory $AttendanceSearchIndividualModelCopyWith(
          AttendanceSearchIndividualModel value,
          $Res Function(AttendanceSearchIndividualModel) then) =
      _$AttendanceSearchIndividualModelCopyWithImpl<$Res,
          AttendanceSearchIndividualModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'attendance')
          List<AttendeeIndividualModel>? attendeeIndividuals});
}

/// @nodoc
class _$AttendanceSearchIndividualModelCopyWithImpl<$Res,
        $Val extends AttendanceSearchIndividualModel>
    implements $AttendanceSearchIndividualModelCopyWith<$Res> {
  _$AttendanceSearchIndividualModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendeeIndividuals = freezed,
  }) {
    return _then(_value.copyWith(
      attendeeIndividuals: freezed == attendeeIndividuals
          ? _value.attendeeIndividuals
          : attendeeIndividuals // ignore: cast_nullable_to_non_nullable
              as List<AttendeeIndividualModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttendanceSearchIndividualModelCopyWith<$Res>
    implements $AttendanceSearchIndividualModelCopyWith<$Res> {
  factory _$$_AttendanceSearchIndividualModelCopyWith(
          _$_AttendanceSearchIndividualModel value,
          $Res Function(_$_AttendanceSearchIndividualModel) then) =
      __$$_AttendanceSearchIndividualModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'attendance')
          List<AttendeeIndividualModel>? attendeeIndividuals});
}

/// @nodoc
class __$$_AttendanceSearchIndividualModelCopyWithImpl<$Res>
    extends _$AttendanceSearchIndividualModelCopyWithImpl<$Res,
        _$_AttendanceSearchIndividualModel>
    implements _$$_AttendanceSearchIndividualModelCopyWith<$Res> {
  __$$_AttendanceSearchIndividualModelCopyWithImpl(
      _$_AttendanceSearchIndividualModel _value,
      $Res Function(_$_AttendanceSearchIndividualModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendeeIndividuals = freezed,
  }) {
    return _then(_$_AttendanceSearchIndividualModel(
      attendeeIndividuals: freezed == attendeeIndividuals
          ? _value._attendeeIndividuals
          : attendeeIndividuals // ignore: cast_nullable_to_non_nullable
              as List<AttendeeIndividualModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttendanceSearchIndividualModel
    implements _AttendanceSearchIndividualModel {
  _$_AttendanceSearchIndividualModel(
      {@JsonKey(name: 'attendance')
          final List<AttendeeIndividualModel>? attendeeIndividuals})
      : _attendeeIndividuals = attendeeIndividuals;

  factory _$_AttendanceSearchIndividualModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_AttendanceSearchIndividualModelFromJson(json);

  final List<AttendeeIndividualModel>? _attendeeIndividuals;
  @override
  @JsonKey(name: 'attendance')
  List<AttendeeIndividualModel>? get attendeeIndividuals {
    final value = _attendeeIndividuals;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AttendanceSearchIndividualModel(attendeeIndividuals: $attendeeIndividuals)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendanceSearchIndividualModel &&
            const DeepCollectionEquality()
                .equals(other._attendeeIndividuals, _attendeeIndividuals));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_attendeeIndividuals));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttendanceSearchIndividualModelCopyWith<
          _$_AttendanceSearchIndividualModel>
      get copyWith => __$$_AttendanceSearchIndividualModelCopyWithImpl<
          _$_AttendanceSearchIndividualModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttendanceSearchIndividualModelToJson(
      this,
    );
  }
}

abstract class _AttendanceSearchIndividualModel
    implements AttendanceSearchIndividualModel {
  factory _AttendanceSearchIndividualModel(
          {@JsonKey(name: 'attendance')
              final List<AttendeeIndividualModel>? attendeeIndividuals}) =
      _$_AttendanceSearchIndividualModel;

  factory _AttendanceSearchIndividualModel.fromJson(Map<String, dynamic> json) =
      _$_AttendanceSearchIndividualModel.fromJson;

  @override
  @JsonKey(name: 'attendance')
  List<AttendeeIndividualModel>? get attendeeIndividuals;
  @override
  @JsonKey(ignore: true)
  _$$_AttendanceSearchIndividualModelCopyWith<
          _$_AttendanceSearchIndividualModel>
      get copyWith => throw _privateConstructorUsedError;
}

AttendeeIndividualModel _$AttendeeIndividualModelFromJson(
    Map<String, dynamic> json) {
  return _AttendeeIndividualModel.fromJson(json);
}

/// @nodoc
mixin _$AttendeeIndividualModel {
  String? get id => throw _privateConstructorUsedError;
  String? get registerId => throw _privateConstructorUsedError;
  String? get individualId => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendeeIndividualModelCopyWith<AttendeeIndividualModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendeeIndividualModelCopyWith<$Res> {
  factory $AttendeeIndividualModelCopyWith(AttendeeIndividualModel value,
          $Res Function(AttendeeIndividualModel) then) =
      _$AttendeeIndividualModelCopyWithImpl<$Res, AttendeeIndividualModel>;
  @useResult
  $Res call(
      {String? id,
      String? registerId,
      String? individualId,
      String? tenantId,
      int time,
      String? type,
      String? status});
}

/// @nodoc
class _$AttendeeIndividualModelCopyWithImpl<$Res,
        $Val extends AttendeeIndividualModel>
    implements $AttendeeIndividualModelCopyWith<$Res> {
  _$AttendeeIndividualModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? registerId = freezed,
    Object? individualId = freezed,
    Object? tenantId = freezed,
    Object? time = null,
    Object? type = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String?,
      individualId: freezed == individualId
          ? _value.individualId
          : individualId // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttendeeIndividualModelCopyWith<$Res>
    implements $AttendeeIndividualModelCopyWith<$Res> {
  factory _$$_AttendeeIndividualModelCopyWith(_$_AttendeeIndividualModel value,
          $Res Function(_$_AttendeeIndividualModel) then) =
      __$$_AttendeeIndividualModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? registerId,
      String? individualId,
      String? tenantId,
      int time,
      String? type,
      String? status});
}

/// @nodoc
class __$$_AttendeeIndividualModelCopyWithImpl<$Res>
    extends _$AttendeeIndividualModelCopyWithImpl<$Res,
        _$_AttendeeIndividualModel>
    implements _$$_AttendeeIndividualModelCopyWith<$Res> {
  __$$_AttendeeIndividualModelCopyWithImpl(_$_AttendeeIndividualModel _value,
      $Res Function(_$_AttendeeIndividualModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? registerId = freezed,
    Object? individualId = freezed,
    Object? tenantId = freezed,
    Object? time = null,
    Object? type = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_AttendeeIndividualModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String?,
      individualId: freezed == individualId
          ? _value.individualId
          : individualId // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttendeeIndividualModel implements _AttendeeIndividualModel {
  _$_AttendeeIndividualModel(
      {this.id,
      this.registerId,
      this.individualId,
      this.tenantId,
      this.time = 0,
      this.type,
      this.status});

  factory _$_AttendeeIndividualModel.fromJson(Map<String, dynamic> json) =>
      _$$_AttendeeIndividualModelFromJson(json);

  @override
  final String? id;
  @override
  final String? registerId;
  @override
  final String? individualId;
  @override
  final String? tenantId;
  @override
  @JsonKey()
  final int time;
  @override
  final String? type;
  @override
  final String? status;

  @override
  String toString() {
    return 'AttendeeIndividualModel(id: $id, registerId: $registerId, individualId: $individualId, tenantId: $tenantId, time: $time, type: $type, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttendeeIndividualModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.individualId, individualId) ||
                other.individualId == individualId) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, registerId, individualId, tenantId, time, type, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttendeeIndividualModelCopyWith<_$_AttendeeIndividualModel>
      get copyWith =>
          __$$_AttendeeIndividualModelCopyWithImpl<_$_AttendeeIndividualModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttendeeIndividualModelToJson(
      this,
    );
  }
}

abstract class _AttendeeIndividualModel implements AttendeeIndividualModel {
  factory _AttendeeIndividualModel(
      {final String? id,
      final String? registerId,
      final String? individualId,
      final String? tenantId,
      final int time,
      final String? type,
      final String? status}) = _$_AttendeeIndividualModel;

  factory _AttendeeIndividualModel.fromJson(Map<String, dynamic> json) =
      _$_AttendeeIndividualModel.fromJson;

  @override
  String? get id;
  @override
  String? get registerId;
  @override
  String? get individualId;
  @override
  String? get tenantId;
  @override
  int get time;
  @override
  String? get type;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$_AttendeeIndividualModelCopyWith<_$_AttendeeIndividualModel>
      get copyWith => throw _privateConstructorUsedError;
}
