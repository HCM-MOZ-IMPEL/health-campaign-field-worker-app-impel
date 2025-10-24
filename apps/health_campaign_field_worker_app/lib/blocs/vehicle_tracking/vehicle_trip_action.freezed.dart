// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_trip_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VehicleTripActionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)
        handleStartTip,
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)
        handleEndTip,
    required TResult Function(UserActionModel vehicleTripSearch) handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)?
        handleEndTip,
    TResult? Function(UserActionModel vehicleTripSearch)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)?
        handleEndTip,
    TResult Function(UserActionModel vehicleTripSearch)? handleSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleTripActionStartTripEvent value)
        handleStartTip,
    required TResult Function(VehicleTripActionEndTripEvent value) handleEndTip,
    required TResult Function(VehicleTripActionSearchEvent value) handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VehicleTripActionStartTripEvent value)? handleStartTip,
    TResult? Function(VehicleTripActionEndTripEvent value)? handleEndTip,
    TResult? Function(VehicleTripActionSearchEvent value)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleTripActionStartTripEvent value)? handleStartTip,
    TResult Function(VehicleTripActionEndTripEvent value)? handleEndTip,
    TResult Function(VehicleTripActionSearchEvent value)? handleSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleTripActionEventCopyWith<$Res> {
  factory $VehicleTripActionEventCopyWith(VehicleTripActionEvent value,
          $Res Function(VehicleTripActionEvent) then) =
      _$VehicleTripActionEventCopyWithImpl<$Res, VehicleTripActionEvent>;
}

/// @nodoc
class _$VehicleTripActionEventCopyWithImpl<$Res,
        $Val extends VehicleTripActionEvent>
    implements $VehicleTripActionEventCopyWith<$Res> {
  _$VehicleTripActionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$VehicleTripActionStartTripEventImplCopyWith<$Res> {
  factory _$$VehicleTripActionStartTripEventImplCopyWith(
          _$VehicleTripActionStartTripEventImpl value,
          $Res Function(_$VehicleTripActionStartTripEventImpl) then) =
      __$$VehicleTripActionStartTripEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {bool isEditing,
      BoundaryModel boundaryModel,
      UserActionModel tripBookAction,
      bool navigateToSummary});
}

/// @nodoc
class __$$VehicleTripActionStartTripEventImplCopyWithImpl<$Res>
    extends _$VehicleTripActionEventCopyWithImpl<$Res,
        _$VehicleTripActionStartTripEventImpl>
    implements _$$VehicleTripActionStartTripEventImplCopyWith<$Res> {
  __$$VehicleTripActionStartTripEventImplCopyWithImpl(
      _$VehicleTripActionStartTripEventImpl _value,
      $Res Function(_$VehicleTripActionStartTripEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEditing = null,
    Object? boundaryModel = null,
    Object? tripBookAction = null,
    Object? navigateToSummary = null,
  }) {
    return _then(_$VehicleTripActionStartTripEventImpl(
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      boundaryModel: null == boundaryModel
          ? _value.boundaryModel
          : boundaryModel // ignore: cast_nullable_to_non_nullable
              as BoundaryModel,
      tripBookAction: null == tripBookAction
          ? _value.tripBookAction
          : tripBookAction // ignore: cast_nullable_to_non_nullable
              as UserActionModel,
      navigateToSummary: null == navigateToSummary
          ? _value.navigateToSummary
          : navigateToSummary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$VehicleTripActionStartTripEventImpl
    implements VehicleTripActionStartTripEvent {
  const _$VehicleTripActionStartTripEventImpl(
      {required this.isEditing,
      required this.boundaryModel,
      required this.tripBookAction,
      this.navigateToSummary = false});

  @override
  final bool isEditing;
  @override
  final BoundaryModel boundaryModel;
  @override
  final UserActionModel tripBookAction;
  @override
  @JsonKey()
  final bool navigateToSummary;

  @override
  String toString() {
    return 'VehicleTripActionEvent.handleStartTip(isEditing: $isEditing, boundaryModel: $boundaryModel, tripBookAction: $tripBookAction, navigateToSummary: $navigateToSummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleTripActionStartTripEventImpl &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.boundaryModel, boundaryModel) ||
                other.boundaryModel == boundaryModel) &&
            (identical(other.tripBookAction, tripBookAction) ||
                other.tripBookAction == tripBookAction) &&
            (identical(other.navigateToSummary, navigateToSummary) ||
                other.navigateToSummary == navigateToSummary));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isEditing, boundaryModel, tripBookAction, navigateToSummary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleTripActionStartTripEventImplCopyWith<
          _$VehicleTripActionStartTripEventImpl>
      get copyWith => __$$VehicleTripActionStartTripEventImplCopyWithImpl<
          _$VehicleTripActionStartTripEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)
        handleStartTip,
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)
        handleEndTip,
    required TResult Function(UserActionModel vehicleTripSearch) handleSearch,
  }) {
    return handleStartTip(
        isEditing, boundaryModel, tripBookAction, navigateToSummary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)?
        handleEndTip,
    TResult? Function(UserActionModel vehicleTripSearch)? handleSearch,
  }) {
    return handleStartTip?.call(
        isEditing, boundaryModel, tripBookAction, navigateToSummary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)?
        handleEndTip,
    TResult Function(UserActionModel vehicleTripSearch)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleStartTip != null) {
      return handleStartTip(
          isEditing, boundaryModel, tripBookAction, navigateToSummary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleTripActionStartTripEvent value)
        handleStartTip,
    required TResult Function(VehicleTripActionEndTripEvent value) handleEndTip,
    required TResult Function(VehicleTripActionSearchEvent value) handleSearch,
  }) {
    return handleStartTip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VehicleTripActionStartTripEvent value)? handleStartTip,
    TResult? Function(VehicleTripActionEndTripEvent value)? handleEndTip,
    TResult? Function(VehicleTripActionSearchEvent value)? handleSearch,
  }) {
    return handleStartTip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleTripActionStartTripEvent value)? handleStartTip,
    TResult Function(VehicleTripActionEndTripEvent value)? handleEndTip,
    TResult Function(VehicleTripActionSearchEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleStartTip != null) {
      return handleStartTip(this);
    }
    return orElse();
  }
}

abstract class VehicleTripActionStartTripEvent
    implements VehicleTripActionEvent {
  const factory VehicleTripActionStartTripEvent(
      {required final bool isEditing,
      required final BoundaryModel boundaryModel,
      required final UserActionModel tripBookAction,
      final bool navigateToSummary}) = _$VehicleTripActionStartTripEventImpl;

  bool get isEditing;
  BoundaryModel get boundaryModel;
  UserActionModel get tripBookAction;
  bool get navigateToSummary;
  @JsonKey(ignore: true)
  _$$VehicleTripActionStartTripEventImplCopyWith<
          _$VehicleTripActionStartTripEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VehicleTripActionEndTripEventImplCopyWith<$Res> {
  factory _$$VehicleTripActionEndTripEventImplCopyWith(
          _$VehicleTripActionEndTripEventImpl value,
          $Res Function(_$VehicleTripActionEndTripEventImpl) then) =
      __$$VehicleTripActionEndTripEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {bool isEditing,
      BoundaryModel boundaryModel,
      UserActionModel tripAction,
      bool navigateToSummary});
}

/// @nodoc
class __$$VehicleTripActionEndTripEventImplCopyWithImpl<$Res>
    extends _$VehicleTripActionEventCopyWithImpl<$Res,
        _$VehicleTripActionEndTripEventImpl>
    implements _$$VehicleTripActionEndTripEventImplCopyWith<$Res> {
  __$$VehicleTripActionEndTripEventImplCopyWithImpl(
      _$VehicleTripActionEndTripEventImpl _value,
      $Res Function(_$VehicleTripActionEndTripEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEditing = null,
    Object? boundaryModel = null,
    Object? tripAction = null,
    Object? navigateToSummary = null,
  }) {
    return _then(_$VehicleTripActionEndTripEventImpl(
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      boundaryModel: null == boundaryModel
          ? _value.boundaryModel
          : boundaryModel // ignore: cast_nullable_to_non_nullable
              as BoundaryModel,
      tripAction: null == tripAction
          ? _value.tripAction
          : tripAction // ignore: cast_nullable_to_non_nullable
              as UserActionModel,
      navigateToSummary: null == navigateToSummary
          ? _value.navigateToSummary
          : navigateToSummary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$VehicleTripActionEndTripEventImpl
    implements VehicleTripActionEndTripEvent {
  const _$VehicleTripActionEndTripEventImpl(
      {required this.isEditing,
      required this.boundaryModel,
      required this.tripAction,
      this.navigateToSummary = false});

  @override
  final bool isEditing;
  @override
  final BoundaryModel boundaryModel;
  @override
  final UserActionModel tripAction;
  @override
  @JsonKey()
  final bool navigateToSummary;

  @override
  String toString() {
    return 'VehicleTripActionEvent.handleEndTip(isEditing: $isEditing, boundaryModel: $boundaryModel, tripAction: $tripAction, navigateToSummary: $navigateToSummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleTripActionEndTripEventImpl &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.boundaryModel, boundaryModel) ||
                other.boundaryModel == boundaryModel) &&
            (identical(other.tripAction, tripAction) ||
                other.tripAction == tripAction) &&
            (identical(other.navigateToSummary, navigateToSummary) ||
                other.navigateToSummary == navigateToSummary));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isEditing, boundaryModel, tripAction, navigateToSummary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleTripActionEndTripEventImplCopyWith<
          _$VehicleTripActionEndTripEventImpl>
      get copyWith => __$$VehicleTripActionEndTripEventImplCopyWithImpl<
          _$VehicleTripActionEndTripEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)
        handleStartTip,
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)
        handleEndTip,
    required TResult Function(UserActionModel vehicleTripSearch) handleSearch,
  }) {
    return handleEndTip(
        isEditing, boundaryModel, tripAction, navigateToSummary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)?
        handleEndTip,
    TResult? Function(UserActionModel vehicleTripSearch)? handleSearch,
  }) {
    return handleEndTip?.call(
        isEditing, boundaryModel, tripAction, navigateToSummary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)?
        handleEndTip,
    TResult Function(UserActionModel vehicleTripSearch)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleEndTip != null) {
      return handleEndTip(
          isEditing, boundaryModel, tripAction, navigateToSummary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleTripActionStartTripEvent value)
        handleStartTip,
    required TResult Function(VehicleTripActionEndTripEvent value) handleEndTip,
    required TResult Function(VehicleTripActionSearchEvent value) handleSearch,
  }) {
    return handleEndTip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VehicleTripActionStartTripEvent value)? handleStartTip,
    TResult? Function(VehicleTripActionEndTripEvent value)? handleEndTip,
    TResult? Function(VehicleTripActionSearchEvent value)? handleSearch,
  }) {
    return handleEndTip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleTripActionStartTripEvent value)? handleStartTip,
    TResult Function(VehicleTripActionEndTripEvent value)? handleEndTip,
    TResult Function(VehicleTripActionSearchEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleEndTip != null) {
      return handleEndTip(this);
    }
    return orElse();
  }
}

abstract class VehicleTripActionEndTripEvent implements VehicleTripActionEvent {
  const factory VehicleTripActionEndTripEvent(
      {required final bool isEditing,
      required final BoundaryModel boundaryModel,
      required final UserActionModel tripAction,
      final bool navigateToSummary}) = _$VehicleTripActionEndTripEventImpl;

  bool get isEditing;
  BoundaryModel get boundaryModel;
  UserActionModel get tripAction;
  bool get navigateToSummary;
  @JsonKey(ignore: true)
  _$$VehicleTripActionEndTripEventImplCopyWith<
          _$VehicleTripActionEndTripEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VehicleTripActionSearchEventImplCopyWith<$Res> {
  factory _$$VehicleTripActionSearchEventImplCopyWith(
          _$VehicleTripActionSearchEventImpl value,
          $Res Function(_$VehicleTripActionSearchEventImpl) then) =
      __$$VehicleTripActionSearchEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserActionModel vehicleTripSearch});
}

/// @nodoc
class __$$VehicleTripActionSearchEventImplCopyWithImpl<$Res>
    extends _$VehicleTripActionEventCopyWithImpl<$Res,
        _$VehicleTripActionSearchEventImpl>
    implements _$$VehicleTripActionSearchEventImplCopyWith<$Res> {
  __$$VehicleTripActionSearchEventImplCopyWithImpl(
      _$VehicleTripActionSearchEventImpl _value,
      $Res Function(_$VehicleTripActionSearchEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleTripSearch = null,
  }) {
    return _then(_$VehicleTripActionSearchEventImpl(
      vehicleTripSearch: null == vehicleTripSearch
          ? _value.vehicleTripSearch
          : vehicleTripSearch // ignore: cast_nullable_to_non_nullable
              as UserActionModel,
    ));
  }
}

/// @nodoc

class _$VehicleTripActionSearchEventImpl
    implements VehicleTripActionSearchEvent {
  const _$VehicleTripActionSearchEventImpl({required this.vehicleTripSearch});

  @override
  final UserActionModel vehicleTripSearch;

  @override
  String toString() {
    return 'VehicleTripActionEvent.handleSearch(vehicleTripSearch: $vehicleTripSearch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleTripActionSearchEventImpl &&
            (identical(other.vehicleTripSearch, vehicleTripSearch) ||
                other.vehicleTripSearch == vehicleTripSearch));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vehicleTripSearch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleTripActionSearchEventImplCopyWith<
          _$VehicleTripActionSearchEventImpl>
      get copyWith => __$$VehicleTripActionSearchEventImplCopyWithImpl<
          _$VehicleTripActionSearchEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)
        handleStartTip,
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)
        handleEndTip,
    required TResult Function(UserActionModel vehicleTripSearch) handleSearch,
  }) {
    return handleSearch(vehicleTripSearch);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)?
        handleEndTip,
    TResult? Function(UserActionModel vehicleTripSearch)? handleSearch,
  }) {
    return handleSearch?.call(vehicleTripSearch);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
            UserActionModel tripAction, bool navigateToSummary)?
        handleEndTip,
    TResult Function(UserActionModel vehicleTripSearch)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSearch != null) {
      return handleSearch(vehicleTripSearch);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleTripActionStartTripEvent value)
        handleStartTip,
    required TResult Function(VehicleTripActionEndTripEvent value) handleEndTip,
    required TResult Function(VehicleTripActionSearchEvent value) handleSearch,
  }) {
    return handleSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VehicleTripActionStartTripEvent value)? handleStartTip,
    TResult? Function(VehicleTripActionEndTripEvent value)? handleEndTip,
    TResult? Function(VehicleTripActionSearchEvent value)? handleSearch,
  }) {
    return handleSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleTripActionStartTripEvent value)? handleStartTip,
    TResult Function(VehicleTripActionEndTripEvent value)? handleEndTip,
    TResult Function(VehicleTripActionSearchEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSearch != null) {
      return handleSearch(this);
    }
    return orElse();
  }
}

abstract class VehicleTripActionSearchEvent implements VehicleTripActionEvent {
  const factory VehicleTripActionSearchEvent(
          {required final UserActionModel vehicleTripSearch}) =
      _$VehicleTripActionSearchEventImpl;

  UserActionModel get vehicleTripSearch;
  @JsonKey(ignore: true)
  _$$VehicleTripActionSearchEventImplCopyWith<
          _$VehicleTripActionSearchEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VehicleTripActionState {
  bool get loading => throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;
  UserActionModel? get tripAction => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VehicleTripActionStateCopyWith<VehicleTripActionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleTripActionStateCopyWith<$Res> {
  factory $VehicleTripActionStateCopyWith(VehicleTripActionState value,
          $Res Function(VehicleTripActionState) then) =
      _$VehicleTripActionStateCopyWithImpl<$Res, VehicleTripActionState>;
  @useResult
  $Res call({bool loading, bool isEditing, UserActionModel? tripAction});
}

/// @nodoc
class _$VehicleTripActionStateCopyWithImpl<$Res,
        $Val extends VehicleTripActionState>
    implements $VehicleTripActionStateCopyWith<$Res> {
  _$VehicleTripActionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? isEditing = null,
    Object? tripAction = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      tripAction: freezed == tripAction
          ? _value.tripAction
          : tripAction // ignore: cast_nullable_to_non_nullable
              as UserActionModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehicleTripActionStateImplCopyWith<$Res>
    implements $VehicleTripActionStateCopyWith<$Res> {
  factory _$$VehicleTripActionStateImplCopyWith(
          _$VehicleTripActionStateImpl value,
          $Res Function(_$VehicleTripActionStateImpl) then) =
      __$$VehicleTripActionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, bool isEditing, UserActionModel? tripAction});
}

/// @nodoc
class __$$VehicleTripActionStateImplCopyWithImpl<$Res>
    extends _$VehicleTripActionStateCopyWithImpl<$Res,
        _$VehicleTripActionStateImpl>
    implements _$$VehicleTripActionStateImplCopyWith<$Res> {
  __$$VehicleTripActionStateImplCopyWithImpl(
      _$VehicleTripActionStateImpl _value,
      $Res Function(_$VehicleTripActionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? isEditing = null,
    Object? tripAction = freezed,
  }) {
    return _then(_$VehicleTripActionStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      tripAction: freezed == tripAction
          ? _value.tripAction
          : tripAction // ignore: cast_nullable_to_non_nullable
              as UserActionModel?,
    ));
  }
}

/// @nodoc

class _$VehicleTripActionStateImpl implements _VehicleTripActionState {
  const _$VehicleTripActionStateImpl(
      {this.loading = false, this.isEditing = false, this.tripAction = null});

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool isEditing;
  @override
  @JsonKey()
  final UserActionModel? tripAction;

  @override
  String toString() {
    return 'VehicleTripActionState(loading: $loading, isEditing: $isEditing, tripAction: $tripAction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleTripActionStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.tripAction, tripAction) ||
                other.tripAction == tripAction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, isEditing, tripAction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleTripActionStateImplCopyWith<_$VehicleTripActionStateImpl>
      get copyWith => __$$VehicleTripActionStateImplCopyWithImpl<
          _$VehicleTripActionStateImpl>(this, _$identity);
}

abstract class _VehicleTripActionState implements VehicleTripActionState {
  const factory _VehicleTripActionState(
      {final bool loading,
      final bool isEditing,
      final UserActionModel? tripAction}) = _$VehicleTripActionStateImpl;

  @override
  bool get loading;
  @override
  bool get isEditing;
  @override
  UserActionModel? get tripAction;
  @override
  @JsonKey(ignore: true)
  _$$VehicleTripActionStateImplCopyWith<_$VehicleTripActionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
