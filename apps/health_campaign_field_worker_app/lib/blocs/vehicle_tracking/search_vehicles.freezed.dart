// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_vehicles.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchVehiclesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(String projectId, String vehicleNo)
        searchByVehicleNo,
    required TResult Function() clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(String projectId, String vehicleNo)? searchByVehicleNo,
    TResult? Function()? clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(String projectId, String vehicleNo)? searchByVehicleNo,
    TResult Function()? clear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchVehiclesInitializedEvent value) initialize,
    required TResult Function(SearchVehiclesByVehicleEvent value)
        searchByVehicleNo,
    required TResult Function(SearchVehiclesClearEvent value) clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchVehiclesInitializedEvent value)? initialize,
    TResult? Function(SearchVehiclesByVehicleEvent value)? searchByVehicleNo,
    TResult? Function(SearchVehiclesClearEvent value)? clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchVehiclesInitializedEvent value)? initialize,
    TResult Function(SearchVehiclesByVehicleEvent value)? searchByVehicleNo,
    TResult Function(SearchVehiclesClearEvent value)? clear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchVehiclesEventCopyWith<$Res> {
  factory $SearchVehiclesEventCopyWith(
          SearchVehiclesEvent value, $Res Function(SearchVehiclesEvent) then) =
      _$SearchVehiclesEventCopyWithImpl<$Res, SearchVehiclesEvent>;
}

/// @nodoc
class _$SearchVehiclesEventCopyWithImpl<$Res, $Val extends SearchVehiclesEvent>
    implements $SearchVehiclesEventCopyWith<$Res> {
  _$SearchVehiclesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SearchVehiclesInitializedEventImplCopyWith<$Res> {
  factory _$$SearchVehiclesInitializedEventImplCopyWith(
          _$SearchVehiclesInitializedEventImpl value,
          $Res Function(_$SearchVehiclesInitializedEventImpl) then) =
      __$$SearchVehiclesInitializedEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchVehiclesInitializedEventImplCopyWithImpl<$Res>
    extends _$SearchVehiclesEventCopyWithImpl<$Res,
        _$SearchVehiclesInitializedEventImpl>
    implements _$$SearchVehiclesInitializedEventImplCopyWith<$Res> {
  __$$SearchVehiclesInitializedEventImplCopyWithImpl(
      _$SearchVehiclesInitializedEventImpl _value,
      $Res Function(_$SearchVehiclesInitializedEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SearchVehiclesInitializedEventImpl
    implements SearchVehiclesInitializedEvent {
  const _$SearchVehiclesInitializedEventImpl();

  @override
  String toString() {
    return 'SearchVehiclesEvent.initialize()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchVehiclesInitializedEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(String projectId, String vehicleNo)
        searchByVehicleNo,
    required TResult Function() clear,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(String projectId, String vehicleNo)? searchByVehicleNo,
    TResult? Function()? clear,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(String projectId, String vehicleNo)? searchByVehicleNo,
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
    required TResult Function(SearchVehiclesInitializedEvent value) initialize,
    required TResult Function(SearchVehiclesByVehicleEvent value)
        searchByVehicleNo,
    required TResult Function(SearchVehiclesClearEvent value) clear,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchVehiclesInitializedEvent value)? initialize,
    TResult? Function(SearchVehiclesByVehicleEvent value)? searchByVehicleNo,
    TResult? Function(SearchVehiclesClearEvent value)? clear,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchVehiclesInitializedEvent value)? initialize,
    TResult Function(SearchVehiclesByVehicleEvent value)? searchByVehicleNo,
    TResult Function(SearchVehiclesClearEvent value)? clear,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class SearchVehiclesInitializedEvent implements SearchVehiclesEvent {
  const factory SearchVehiclesInitializedEvent() =
      _$SearchVehiclesInitializedEventImpl;
}

/// @nodoc
abstract class _$$SearchVehiclesByVehicleEventImplCopyWith<$Res> {
  factory _$$SearchVehiclesByVehicleEventImplCopyWith(
          _$SearchVehiclesByVehicleEventImpl value,
          $Res Function(_$SearchVehiclesByVehicleEventImpl) then) =
      __$$SearchVehiclesByVehicleEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String projectId, String vehicleNo});
}

/// @nodoc
class __$$SearchVehiclesByVehicleEventImplCopyWithImpl<$Res>
    extends _$SearchVehiclesEventCopyWithImpl<$Res,
        _$SearchVehiclesByVehicleEventImpl>
    implements _$$SearchVehiclesByVehicleEventImplCopyWith<$Res> {
  __$$SearchVehiclesByVehicleEventImplCopyWithImpl(
      _$SearchVehiclesByVehicleEventImpl _value,
      $Res Function(_$SearchVehiclesByVehicleEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? vehicleNo = null,
  }) {
    return _then(_$SearchVehiclesByVehicleEventImpl(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleNo: null == vehicleNo
          ? _value.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchVehiclesByVehicleEventImpl
    implements SearchVehiclesByVehicleEvent {
  const _$SearchVehiclesByVehicleEventImpl(
      {required this.projectId, required this.vehicleNo});

  @override
  final String projectId;
  @override
  final String vehicleNo;

  @override
  String toString() {
    return 'SearchVehiclesEvent.searchByVehicleNo(projectId: $projectId, vehicleNo: $vehicleNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchVehiclesByVehicleEventImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.vehicleNo, vehicleNo) ||
                other.vehicleNo == vehicleNo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectId, vehicleNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchVehiclesByVehicleEventImplCopyWith<
          _$SearchVehiclesByVehicleEventImpl>
      get copyWith => __$$SearchVehiclesByVehicleEventImplCopyWithImpl<
          _$SearchVehiclesByVehicleEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(String projectId, String vehicleNo)
        searchByVehicleNo,
    required TResult Function() clear,
  }) {
    return searchByVehicleNo(projectId, vehicleNo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(String projectId, String vehicleNo)? searchByVehicleNo,
    TResult? Function()? clear,
  }) {
    return searchByVehicleNo?.call(projectId, vehicleNo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(String projectId, String vehicleNo)? searchByVehicleNo,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (searchByVehicleNo != null) {
      return searchByVehicleNo(projectId, vehicleNo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchVehiclesInitializedEvent value) initialize,
    required TResult Function(SearchVehiclesByVehicleEvent value)
        searchByVehicleNo,
    required TResult Function(SearchVehiclesClearEvent value) clear,
  }) {
    return searchByVehicleNo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchVehiclesInitializedEvent value)? initialize,
    TResult? Function(SearchVehiclesByVehicleEvent value)? searchByVehicleNo,
    TResult? Function(SearchVehiclesClearEvent value)? clear,
  }) {
    return searchByVehicleNo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchVehiclesInitializedEvent value)? initialize,
    TResult Function(SearchVehiclesByVehicleEvent value)? searchByVehicleNo,
    TResult Function(SearchVehiclesClearEvent value)? clear,
    required TResult orElse(),
  }) {
    if (searchByVehicleNo != null) {
      return searchByVehicleNo(this);
    }
    return orElse();
  }
}

abstract class SearchVehiclesByVehicleEvent implements SearchVehiclesEvent {
  const factory SearchVehiclesByVehicleEvent(
      {required final String projectId,
      required final String vehicleNo}) = _$SearchVehiclesByVehicleEventImpl;

  String get projectId;
  String get vehicleNo;
  @JsonKey(ignore: true)
  _$$SearchVehiclesByVehicleEventImplCopyWith<
          _$SearchVehiclesByVehicleEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchVehiclesClearEventImplCopyWith<$Res> {
  factory _$$SearchVehiclesClearEventImplCopyWith(
          _$SearchVehiclesClearEventImpl value,
          $Res Function(_$SearchVehiclesClearEventImpl) then) =
      __$$SearchVehiclesClearEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchVehiclesClearEventImplCopyWithImpl<$Res>
    extends _$SearchVehiclesEventCopyWithImpl<$Res,
        _$SearchVehiclesClearEventImpl>
    implements _$$SearchVehiclesClearEventImplCopyWith<$Res> {
  __$$SearchVehiclesClearEventImplCopyWithImpl(
      _$SearchVehiclesClearEventImpl _value,
      $Res Function(_$SearchVehiclesClearEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SearchVehiclesClearEventImpl implements SearchVehiclesClearEvent {
  const _$SearchVehiclesClearEventImpl();

  @override
  String toString() {
    return 'SearchVehiclesEvent.clear()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchVehiclesClearEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(String projectId, String vehicleNo)
        searchByVehicleNo,
    required TResult Function() clear,
  }) {
    return clear();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialize,
    TResult? Function(String projectId, String vehicleNo)? searchByVehicleNo,
    TResult? Function()? clear,
  }) {
    return clear?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(String projectId, String vehicleNo)? searchByVehicleNo,
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
    required TResult Function(SearchVehiclesInitializedEvent value) initialize,
    required TResult Function(SearchVehiclesByVehicleEvent value)
        searchByVehicleNo,
    required TResult Function(SearchVehiclesClearEvent value) clear,
  }) {
    return clear(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchVehiclesInitializedEvent value)? initialize,
    TResult? Function(SearchVehiclesByVehicleEvent value)? searchByVehicleNo,
    TResult? Function(SearchVehiclesClearEvent value)? clear,
  }) {
    return clear?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchVehiclesInitializedEvent value)? initialize,
    TResult Function(SearchVehiclesByVehicleEvent value)? searchByVehicleNo,
    TResult Function(SearchVehiclesClearEvent value)? clear,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear(this);
    }
    return orElse();
  }
}

abstract class SearchVehiclesClearEvent implements SearchVehiclesEvent {
  const factory SearchVehiclesClearEvent() = _$SearchVehiclesClearEventImpl;
}

/// @nodoc
mixin _$SearchVehiclesState {
  int get offset => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  String? get tag => throw _privateConstructorUsedError;
  List<ProductVariantModel> get vehicles => throw _privateConstructorUsedError;
  int get totalResults => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchVehiclesStateCopyWith<SearchVehiclesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchVehiclesStateCopyWith<$Res> {
  factory $SearchVehiclesStateCopyWith(
          SearchVehiclesState value, $Res Function(SearchVehiclesState) then) =
      _$SearchVehiclesStateCopyWithImpl<$Res, SearchVehiclesState>;
  @useResult
  $Res call(
      {int offset,
      int limit,
      bool loading,
      String? searchQuery,
      String? tag,
      List<ProductVariantModel> vehicles,
      int totalResults});
}

/// @nodoc
class _$SearchVehiclesStateCopyWithImpl<$Res, $Val extends SearchVehiclesState>
    implements $SearchVehiclesStateCopyWith<$Res> {
  _$SearchVehiclesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? limit = null,
    Object? loading = null,
    Object? searchQuery = freezed,
    Object? tag = freezed,
    Object? vehicles = null,
    Object? totalResults = null,
  }) {
    return _then(_value.copyWith(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicles: null == vehicles
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchVehiclesStateImplCopyWith<$Res>
    implements $SearchVehiclesStateCopyWith<$Res> {
  factory _$$SearchVehiclesStateImplCopyWith(_$SearchVehiclesStateImpl value,
          $Res Function(_$SearchVehiclesStateImpl) then) =
      __$$SearchVehiclesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int offset,
      int limit,
      bool loading,
      String? searchQuery,
      String? tag,
      List<ProductVariantModel> vehicles,
      int totalResults});
}

/// @nodoc
class __$$SearchVehiclesStateImplCopyWithImpl<$Res>
    extends _$SearchVehiclesStateCopyWithImpl<$Res, _$SearchVehiclesStateImpl>
    implements _$$SearchVehiclesStateImplCopyWith<$Res> {
  __$$SearchVehiclesStateImplCopyWithImpl(_$SearchVehiclesStateImpl _value,
      $Res Function(_$SearchVehiclesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? limit = null,
    Object? loading = null,
    Object? searchQuery = freezed,
    Object? tag = freezed,
    Object? vehicles = null,
    Object? totalResults = null,
  }) {
    return _then(_$SearchVehiclesStateImpl(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicles: null == vehicles
          ? _value._vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SearchVehiclesStateImpl extends _SearchVehiclesState {
  const _$SearchVehiclesStateImpl(
      {this.offset = 0,
      this.limit = 10,
      this.loading = false,
      this.searchQuery,
      this.tag,
      final List<ProductVariantModel> vehicles = const [],
      this.totalResults = 0})
      : _vehicles = vehicles,
        super._();

  @override
  @JsonKey()
  final int offset;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String? searchQuery;
  @override
  final String? tag;
  final List<ProductVariantModel> _vehicles;
  @override
  @JsonKey()
  List<ProductVariantModel> get vehicles {
    if (_vehicles is EqualUnmodifiableListView) return _vehicles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicles);
  }

  @override
  @JsonKey()
  final int totalResults;

  @override
  String toString() {
    return 'SearchVehiclesState(offset: $offset, limit: $limit, loading: $loading, searchQuery: $searchQuery, tag: $tag, vehicles: $vehicles, totalResults: $totalResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchVehiclesStateImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            const DeepCollectionEquality().equals(other._vehicles, _vehicles) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      offset,
      limit,
      loading,
      searchQuery,
      tag,
      const DeepCollectionEquality().hash(_vehicles),
      totalResults);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchVehiclesStateImplCopyWith<_$SearchVehiclesStateImpl> get copyWith =>
      __$$SearchVehiclesStateImplCopyWithImpl<_$SearchVehiclesStateImpl>(
          this, _$identity);
}

abstract class _SearchVehiclesState extends SearchVehiclesState {
  const factory _SearchVehiclesState(
      {final int offset,
      final int limit,
      final bool loading,
      final String? searchQuery,
      final String? tag,
      final List<ProductVariantModel> vehicles,
      final int totalResults}) = _$SearchVehiclesStateImpl;
  const _SearchVehiclesState._() : super._();

  @override
  int get offset;
  @override
  int get limit;
  @override
  bool get loading;
  @override
  String? get searchQuery;
  @override
  String? get tag;
  @override
  List<ProductVariantModel> get vehicles;
  @override
  int get totalResults;
  @override
  @JsonKey(ignore: true)
  _$$SearchVehiclesStateImplCopyWith<_$SearchVehiclesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
