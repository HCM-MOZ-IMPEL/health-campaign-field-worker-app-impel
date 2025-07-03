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
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)
        handleSubmit,
=======
            UserActionModel tripBookAction, bool navigateToSummary)
        handleStartTip,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
    required TResult Function(UserActionModel vechicleTripSearch) handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)?
        handleSubmit,
=======
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
    TResult? Function(UserActionModel vechicleTripSearch)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)?
        handleSubmit,
=======
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
    TResult Function(UserActionModel vechicleTripSearch)? handleSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleTripActionSubmitEvent value)
        handleStartTip,
    required TResult Function(VehicleTripActionSearchEvent value) handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VehicleTripActionSubmitEvent value)? handleStartTip,
    TResult? Function(VehicleTripActionSearchEvent value)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleTripActionSubmitEvent value)? handleStartTip,
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
abstract class _$$VehicleTripActionSubmitEventImplCopyWith<$Res> {
  factory _$$VehicleTripActionSubmitEventImplCopyWith(
          _$VehicleTripActionSubmitEventImpl value,
          $Res Function(_$VehicleTripActionSubmitEventImpl) then) =
      __$$VehicleTripActionSubmitEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {bool isEditing,
      BoundaryModel boundaryModel,
<<<<<<< HEAD
      UserActionModel vehicle,
=======
      UserActionModel tripBookAction,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
      bool navigateToSummary});
}

/// @nodoc
class __$$VehicleTripActionSubmitEventImplCopyWithImpl<$Res>
    extends _$VehicleTripActionEventCopyWithImpl<$Res,
        _$VehicleTripActionSubmitEventImpl>
    implements _$$VehicleTripActionSubmitEventImplCopyWith<$Res> {
  __$$VehicleTripActionSubmitEventImplCopyWithImpl(
      _$VehicleTripActionSubmitEventImpl _value,
      $Res Function(_$VehicleTripActionSubmitEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEditing = null,
    Object? boundaryModel = null,
<<<<<<< HEAD
    Object? vehicle = null,
=======
    Object? tripBookAction = null,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
    Object? navigateToSummary = null,
  }) {
    return _then(_$VehicleTripActionSubmitEventImpl(
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      boundaryModel: null == boundaryModel
          ? _value.boundaryModel
          : boundaryModel // ignore: cast_nullable_to_non_nullable
              as BoundaryModel,
<<<<<<< HEAD
      vehicle: null == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
=======
      tripBookAction: null == tripBookAction
          ? _value.tripBookAction
          : tripBookAction // ignore: cast_nullable_to_non_nullable
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
              as UserActionModel,
      navigateToSummary: null == navigateToSummary
          ? _value.navigateToSummary
          : navigateToSummary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$VehicleTripActionSubmitEventImpl
    implements VehicleTripActionSubmitEvent {
  const _$VehicleTripActionSubmitEventImpl(
      {required this.isEditing,
      required this.boundaryModel,
<<<<<<< HEAD
      required this.vehicle,
=======
      required this.tripBookAction,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
      this.navigateToSummary = false});

  @override
  final bool isEditing;
  @override
  final BoundaryModel boundaryModel;
  @override
<<<<<<< HEAD
  final UserActionModel vehicle;
=======
  final UserActionModel tripBookAction;
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
  @override
  @JsonKey()
  final bool navigateToSummary;

  @override
  String toString() {
<<<<<<< HEAD
    return 'VehicleTripActionEvent.handleSubmit(isEditing: $isEditing, boundaryModel: $boundaryModel, vehicle: $vehicle, navigateToSummary: $navigateToSummary)';
=======
    return 'VehicleTripActionEvent.handleStartTip(isEditing: $isEditing, boundaryModel: $boundaryModel, tripBookAction: $tripBookAction, navigateToSummary: $navigateToSummary)';
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleTripActionSubmitEventImpl &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.boundaryModel, boundaryModel) ||
                other.boundaryModel == boundaryModel) &&
<<<<<<< HEAD
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
=======
            (identical(other.tripBookAction, tripBookAction) ||
                other.tripBookAction == tripBookAction) &&
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
            (identical(other.navigateToSummary, navigateToSummary) ||
                other.navigateToSummary == navigateToSummary));
  }

  @override
  int get hashCode => Object.hash(
<<<<<<< HEAD
      runtimeType, isEditing, boundaryModel, vehicle, navigateToSummary);
=======
      runtimeType, isEditing, boundaryModel, tripBookAction, navigateToSummary);
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleTripActionSubmitEventImplCopyWith<
          _$VehicleTripActionSubmitEventImpl>
      get copyWith => __$$VehicleTripActionSubmitEventImplCopyWithImpl<
          _$VehicleTripActionSubmitEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isEditing, BoundaryModel boundaryModel,
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)
        handleSubmit,
    required TResult Function(UserActionModel vechicleTripSearch) handleSearch,
  }) {
    return handleSubmit(isEditing, boundaryModel, vehicle, navigateToSummary);
=======
            UserActionModel tripBookAction, bool navigateToSummary)
        handleStartTip,
    required TResult Function(UserActionModel vechicleTripSearch) handleSearch,
  }) {
    return handleStartTip(
        isEditing, boundaryModel, tripBookAction, navigateToSummary);
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)?
        handleSubmit,
    TResult? Function(UserActionModel vechicleTripSearch)? handleSearch,
  }) {
    return handleSubmit?.call(
        isEditing, boundaryModel, vehicle, navigateToSummary);
=======
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult? Function(UserActionModel vechicleTripSearch)? handleSearch,
  }) {
    return handleStartTip?.call(
        isEditing, boundaryModel, tripBookAction, navigateToSummary);
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)?
        handleSubmit,
    TResult Function(UserActionModel vechicleTripSearch)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSubmit != null) {
      return handleSubmit(isEditing, boundaryModel, vehicle, navigateToSummary);
=======
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
    TResult Function(UserActionModel vechicleTripSearch)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleStartTip != null) {
      return handleStartTip(
          isEditing, boundaryModel, tripBookAction, navigateToSummary);
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleTripActionSubmitEvent value)
        handleStartTip,
    required TResult Function(VehicleTripActionSearchEvent value) handleSearch,
  }) {
    return handleStartTip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VehicleTripActionSubmitEvent value)? handleStartTip,
    TResult? Function(VehicleTripActionSearchEvent value)? handleSearch,
  }) {
    return handleStartTip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleTripActionSubmitEvent value)? handleStartTip,
    TResult Function(VehicleTripActionSearchEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleStartTip != null) {
      return handleStartTip(this);
    }
    return orElse();
  }
}

abstract class VehicleTripActionSubmitEvent implements VehicleTripActionEvent {
  const factory VehicleTripActionSubmitEvent(
      {required final bool isEditing,
      required final BoundaryModel boundaryModel,
<<<<<<< HEAD
      required final UserActionModel vehicle,
=======
      required final UserActionModel tripBookAction,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
      final bool navigateToSummary}) = _$VehicleTripActionSubmitEventImpl;

  bool get isEditing;
  BoundaryModel get boundaryModel;
<<<<<<< HEAD
  UserActionModel get vehicle;
=======
  UserActionModel get tripBookAction;
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
  bool get navigateToSummary;
  @JsonKey(ignore: true)
  _$$VehicleTripActionSubmitEventImplCopyWith<
          _$VehicleTripActionSubmitEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VehicleTripActionSearchEventImplCopyWith<$Res> {
  factory _$$VehicleTripActionSearchEventImplCopyWith(
          _$VehicleTripActionSearchEventImpl value,
          $Res Function(_$VehicleTripActionSearchEventImpl) then) =
      __$$VehicleTripActionSearchEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserActionModel vechicleTripSearch});
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
    Object? vechicleTripSearch = null,
  }) {
    return _then(_$VehicleTripActionSearchEventImpl(
      vechicleTripSearch: null == vechicleTripSearch
          ? _value.vechicleTripSearch
          : vechicleTripSearch // ignore: cast_nullable_to_non_nullable
              as UserActionModel,
    ));
  }
}

/// @nodoc

class _$VehicleTripActionSearchEventImpl
    implements VehicleTripActionSearchEvent {
  const _$VehicleTripActionSearchEventImpl({required this.vechicleTripSearch});

  @override
  final UserActionModel vechicleTripSearch;

  @override
  String toString() {
    return 'VehicleTripActionEvent.handleSearch(vechicleTripSearch: $vechicleTripSearch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleTripActionSearchEventImpl &&
            (identical(other.vechicleTripSearch, vechicleTripSearch) ||
                other.vechicleTripSearch == vechicleTripSearch));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vechicleTripSearch);

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
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)
        handleSubmit,
=======
            UserActionModel tripBookAction, bool navigateToSummary)
        handleStartTip,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
    required TResult Function(UserActionModel vechicleTripSearch) handleSearch,
  }) {
    return handleSearch(vechicleTripSearch);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isEditing, BoundaryModel boundaryModel,
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)?
        handleSubmit,
=======
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
    TResult? Function(UserActionModel vechicleTripSearch)? handleSearch,
  }) {
    return handleSearch?.call(vechicleTripSearch);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isEditing, BoundaryModel boundaryModel,
<<<<<<< HEAD
            UserActionModel vehicle, bool navigateToSummary)?
        handleSubmit,
=======
            UserActionModel tripBookAction, bool navigateToSummary)?
        handleStartTip,
>>>>>>> 015366fdafd10118aa7514713e0cd1ad4d6889ed
    TResult Function(UserActionModel vechicleTripSearch)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSearch != null) {
      return handleSearch(vechicleTripSearch);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleTripActionSubmitEvent value)
        handleStartTip,
    required TResult Function(VehicleTripActionSearchEvent value) handleSearch,
  }) {
    return handleSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VehicleTripActionSubmitEvent value)? handleStartTip,
    TResult? Function(VehicleTripActionSearchEvent value)? handleSearch,
  }) {
    return handleSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleTripActionSubmitEvent value)? handleStartTip,
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
          {required final UserActionModel vechicleTripSearch}) =
      _$VehicleTripActionSearchEventImpl;

  UserActionModel get vechicleTripSearch;
  @JsonKey(ignore: true)
  _$$VehicleTripActionSearchEventImplCopyWith<
          _$VehicleTripActionSearchEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VehicleTripActionState {
  bool get loading => throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;

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
  $Res call({bool loading, bool isEditing});
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
  $Res call({bool loading, bool isEditing});
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
    ));
  }
}

/// @nodoc

class _$VehicleTripActionStateImpl implements _VehicleTripActionState {
  const _$VehicleTripActionStateImpl(
      {this.loading = false, this.isEditing = false});

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool isEditing;

  @override
  String toString() {
    return 'VehicleTripActionState(loading: $loading, isEditing: $isEditing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleTripActionStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, isEditing);

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
      final bool isEditing}) = _$VehicleTripActionStateImpl;

  @override
  bool get loading;
  @override
  bool get isEditing;
  @override
  @JsonKey(ignore: true)
  _$$VehicleTripActionStateImplCopyWith<_$VehicleTripActionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
