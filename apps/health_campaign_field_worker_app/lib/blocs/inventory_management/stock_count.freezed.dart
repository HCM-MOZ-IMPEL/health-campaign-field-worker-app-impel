// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StockCountEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(String facilityId) calculateSKU,
    required TResult Function() clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(String facilityId)? calculateSKU,
    TResult? Function()? clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(String facilityId)? calculateSKU,
    TResult Function()? clear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StockCountInitializedEvent value) initialize,
    required TResult Function(StockCountCalculateSKUEvent value) calculateSKU,
    required TResult Function(StockCountClearEvent value) clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StockCountInitializedEvent value)? initialize,
    TResult? Function(StockCountCalculateSKUEvent value)? calculateSKU,
    TResult? Function(StockCountClearEvent value)? clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StockCountInitializedEvent value)? initialize,
    TResult Function(StockCountCalculateSKUEvent value)? calculateSKU,
    TResult Function(StockCountClearEvent value)? clear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockCountEventCopyWith<$Res> {
  factory $StockCountEventCopyWith(
          StockCountEvent value, $Res Function(StockCountEvent) then) =
      _$StockCountEventCopyWithImpl<$Res, StockCountEvent>;
}

/// @nodoc
class _$StockCountEventCopyWithImpl<$Res, $Val extends StockCountEvent>
    implements $StockCountEventCopyWith<$Res> {
  _$StockCountEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StockCountInitializedEventImplCopyWith<$Res> {
  factory _$$StockCountInitializedEventImplCopyWith(
          _$StockCountInitializedEventImpl value,
          $Res Function(_$StockCountInitializedEventImpl) then) =
      __$$StockCountInitializedEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StockCountInitializedEventImplCopyWithImpl<$Res>
    extends _$StockCountEventCopyWithImpl<$Res,
        _$StockCountInitializedEventImpl>
    implements _$$StockCountInitializedEventImplCopyWith<$Res> {
  __$$StockCountInitializedEventImplCopyWithImpl(
      _$StockCountInitializedEventImpl _value,
      $Res Function(_$StockCountInitializedEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StockCountInitializedEventImpl implements StockCountInitializedEvent {
  const _$StockCountInitializedEventImpl();

  @override
  String toString() {
    return 'StockCountEvent.initialize()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockCountInitializedEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(String facilityId) calculateSKU,
    required TResult Function() clear,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(String facilityId)? calculateSKU,
    TResult? Function()? clear,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(String facilityId)? calculateSKU,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StockCountInitializedEvent value) initialize,
    required TResult Function(StockCountCalculateSKUEvent value) calculateSKU,
    required TResult Function(StockCountClearEvent value) clear,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StockCountInitializedEvent value)? initialize,
    TResult? Function(StockCountCalculateSKUEvent value)? calculateSKU,
    TResult? Function(StockCountClearEvent value)? clear,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StockCountInitializedEvent value)? initialize,
    TResult Function(StockCountCalculateSKUEvent value)? calculateSKU,
    TResult Function(StockCountClearEvent value)? clear,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class StockCountInitializedEvent implements StockCountEvent {
  const factory StockCountInitializedEvent() = _$StockCountInitializedEventImpl;
}

/// @nodoc
abstract class _$$StockCountCalculateSKUEventImplCopyWith<$Res> {
  factory _$$StockCountCalculateSKUEventImplCopyWith(
          _$StockCountCalculateSKUEventImpl value,
          $Res Function(_$StockCountCalculateSKUEventImpl) then) =
      __$$StockCountCalculateSKUEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String facilityId});
}

/// @nodoc
class __$$StockCountCalculateSKUEventImplCopyWithImpl<$Res>
    extends _$StockCountEventCopyWithImpl<$Res,
        _$StockCountCalculateSKUEventImpl>
    implements _$$StockCountCalculateSKUEventImplCopyWith<$Res> {
  __$$StockCountCalculateSKUEventImplCopyWithImpl(
      _$StockCountCalculateSKUEventImpl _value,
      $Res Function(_$StockCountCalculateSKUEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facilityId = null,
  }) {
    return _then(_$StockCountCalculateSKUEventImpl(
      facilityId: null == facilityId
          ? _value.facilityId
          : facilityId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StockCountCalculateSKUEventImpl implements StockCountCalculateSKUEvent {
  const _$StockCountCalculateSKUEventImpl({required this.facilityId});

  @override
  final String facilityId;

  @override
  String toString() {
    return 'StockCountEvent.calculateSKU(facilityId: $facilityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockCountCalculateSKUEventImpl &&
            (identical(other.facilityId, facilityId) ||
                other.facilityId == facilityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, facilityId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StockCountCalculateSKUEventImplCopyWith<_$StockCountCalculateSKUEventImpl>
      get copyWith => __$$StockCountCalculateSKUEventImplCopyWithImpl<
          _$StockCountCalculateSKUEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(String facilityId) calculateSKU,
    required TResult Function() clear,
  }) {
    return calculateSKU(facilityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(String facilityId)? calculateSKU,
    TResult? Function()? clear,
  }) {
    return calculateSKU?.call(facilityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(String facilityId)? calculateSKU,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (calculateSKU != null) {
      return calculateSKU(facilityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StockCountInitializedEvent value) initialize,
    required TResult Function(StockCountCalculateSKUEvent value) calculateSKU,
    required TResult Function(StockCountClearEvent value) clear,
  }) {
    return calculateSKU(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StockCountInitializedEvent value)? initialize,
    TResult? Function(StockCountCalculateSKUEvent value)? calculateSKU,
    TResult? Function(StockCountClearEvent value)? clear,
  }) {
    return calculateSKU?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StockCountInitializedEvent value)? initialize,
    TResult Function(StockCountCalculateSKUEvent value)? calculateSKU,
    TResult Function(StockCountClearEvent value)? clear,
    required TResult orElse(),
  }) {
    if (calculateSKU != null) {
      return calculateSKU(this);
    }
    return orElse();
  }
}

abstract class StockCountCalculateSKUEvent implements StockCountEvent {
  const factory StockCountCalculateSKUEvent(
      {required final String facilityId}) = _$StockCountCalculateSKUEventImpl;

  String get facilityId;
  @JsonKey(ignore: true)
  _$$StockCountCalculateSKUEventImplCopyWith<_$StockCountCalculateSKUEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StockCountClearEventImplCopyWith<$Res> {
  factory _$$StockCountClearEventImplCopyWith(_$StockCountClearEventImpl value,
          $Res Function(_$StockCountClearEventImpl) then) =
      __$$StockCountClearEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StockCountClearEventImplCopyWithImpl<$Res>
    extends _$StockCountEventCopyWithImpl<$Res, _$StockCountClearEventImpl>
    implements _$$StockCountClearEventImplCopyWith<$Res> {
  __$$StockCountClearEventImplCopyWithImpl(_$StockCountClearEventImpl _value,
      $Res Function(_$StockCountClearEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StockCountClearEventImpl implements StockCountClearEvent {
  const _$StockCountClearEventImpl();

  @override
  String toString() {
    return 'StockCountEvent.clear()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockCountClearEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(String facilityId) calculateSKU,
    required TResult Function() clear,
  }) {
    return clear();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(String facilityId)? calculateSKU,
    TResult? Function()? clear,
  }) {
    return clear?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(String facilityId)? calculateSKU,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StockCountInitializedEvent value) initialize,
    required TResult Function(StockCountCalculateSKUEvent value) calculateSKU,
    required TResult Function(StockCountClearEvent value) clear,
  }) {
    return clear(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StockCountInitializedEvent value)? initialize,
    TResult? Function(StockCountCalculateSKUEvent value)? calculateSKU,
    TResult? Function(StockCountClearEvent value)? clear,
  }) {
    return clear?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StockCountInitializedEvent value)? initialize,
    TResult Function(StockCountCalculateSKUEvent value)? calculateSKU,
    TResult Function(StockCountClearEvent value)? clear,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear(this);
    }
    return orElse();
  }
}

abstract class StockCountClearEvent implements StockCountEvent {
  const factory StockCountClearEvent() = _$StockCountClearEventImpl;
}

/// @nodoc
mixin _$StockCountState {
  bool get loading => throw _privateConstructorUsedError;
  Map<String, int> get skuCounts => throw _privateConstructorUsedError;
  int get totalResults => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StockCountStateCopyWith<StockCountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockCountStateCopyWith<$Res> {
  factory $StockCountStateCopyWith(
          StockCountState value, $Res Function(StockCountState) then) =
      _$StockCountStateCopyWithImpl<$Res, StockCountState>;
  @useResult
  $Res call({bool loading, Map<String, int> skuCounts, int totalResults});
}

/// @nodoc
class _$StockCountStateCopyWithImpl<$Res, $Val extends StockCountState>
    implements $StockCountStateCopyWith<$Res> {
  _$StockCountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? skuCounts = null,
    Object? totalResults = null,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      skuCounts: null == skuCounts
          ? _value.skuCounts
          : skuCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockCountCalculateSKUStateImplCopyWith<$Res>
    implements $StockCountStateCopyWith<$Res> {
  factory _$$StockCountCalculateSKUStateImplCopyWith(
          _$StockCountCalculateSKUStateImpl value,
          $Res Function(_$StockCountCalculateSKUStateImpl) then) =
      __$$StockCountCalculateSKUStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, Map<String, int> skuCounts, int totalResults});
}

/// @nodoc
class __$$StockCountCalculateSKUStateImplCopyWithImpl<$Res>
    extends _$StockCountStateCopyWithImpl<$Res,
        _$StockCountCalculateSKUStateImpl>
    implements _$$StockCountCalculateSKUStateImplCopyWith<$Res> {
  __$$StockCountCalculateSKUStateImplCopyWithImpl(
      _$StockCountCalculateSKUStateImpl _value,
      $Res Function(_$StockCountCalculateSKUStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? skuCounts = null,
    Object? totalResults = null,
  }) {
    return _then(_$StockCountCalculateSKUStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      skuCounts: null == skuCounts
          ? _value._skuCounts
          : skuCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$StockCountCalculateSKUStateImpl extends _StockCountCalculateSKUState {
  const _$StockCountCalculateSKUStateImpl(
      {this.loading = false,
      final Map<String, int> skuCounts = const {},
      this.totalResults = 0})
      : _skuCounts = skuCounts,
        super._();

  @override
  @JsonKey()
  final bool loading;
  final Map<String, int> _skuCounts;
  @override
  @JsonKey()
  Map<String, int> get skuCounts {
    if (_skuCounts is EqualUnmodifiableMapView) return _skuCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_skuCounts);
  }

  @override
  @JsonKey()
  final int totalResults;

  @override
  String toString() {
    return 'StockCountState(loading: $loading, skuCounts: $skuCounts, totalResults: $totalResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockCountCalculateSKUStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality()
                .equals(other._skuCounts, _skuCounts) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading,
      const DeepCollectionEquality().hash(_skuCounts), totalResults);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StockCountCalculateSKUStateImplCopyWith<_$StockCountCalculateSKUStateImpl>
      get copyWith => __$$StockCountCalculateSKUStateImplCopyWithImpl<
          _$StockCountCalculateSKUStateImpl>(this, _$identity);
}

abstract class _StockCountCalculateSKUState extends StockCountState {
  const factory _StockCountCalculateSKUState(
      {final bool loading,
      final Map<String, int> skuCounts,
      final int totalResults}) = _$StockCountCalculateSKUStateImpl;
  const _StockCountCalculateSKUState._() : super._();

  @override
  bool get loading;
  @override
  Map<String, int> get skuCounts;
  @override
  int get totalResults;
  @override
  @JsonKey(ignore: true)
  _$$StockCountCalculateSKUStateImplCopyWith<_$StockCountCalculateSKUStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
