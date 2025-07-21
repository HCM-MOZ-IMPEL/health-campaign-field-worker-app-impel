// GENERATED using mason_cli
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:digit_data_model/models/entities/product_variant.dart';
import 'package:digit_data_model/utils/typedefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:stream_transform/stream_transform.dart';

import '../../data/repositories/custom_product_variant.dart';
import '../../utils/constants.dart';

part 'search_vehicles.freezed.dart';

typedef SearchVehiclesEmitter = Emitter<SearchVehiclesState>;

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchVehiclesBloc
    extends Bloc<SearchVehiclesEvent, SearchVehiclesState> {
  final String projectId;
  final String userUid;
  final IndividualDataRepository individual;
  final ProductVariantDataRepository productVariantDataRepository;

  SearchVehiclesBloc({
    required this.userUid,
    required this.projectId,
    required this.individual,
    required this.productVariantDataRepository,
  }) : super(const SearchVehiclesState()) {
    on(_handleClear);
    on(_searchByVehicleNo);
  }

  // This function is been used in Individual details screen.
  Future<void> _searchByVehicleNo(
    SearchVehiclesByVehicleEvent event,
    SearchVehiclesEmitter emit,
  ) async {
    emit(state.copyWith(
      loading: true,
    ));
    try {
      final vehicleNo = event.vehicleNo.toUpperCase();

      ProductVariantSearchModel productVariantSearchModel =
          ProductVariantSearchModel(
              sku: Constants.vechileSKU, variation: vehicleNo);

      final productVariants = await (productVariantDataRepository
              as CustomProductVariantLocalRepository)
          .customSearch(productVariantSearchModel);

      emit(state.copyWith(
        loading: false,
        vehicles: productVariants,
        searchQuery: vehicleNo,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, vehicles: []));
    }
  }

  FutureOr<void> _handleClear(
    SearchVehiclesClearEvent event,
    SearchVehiclesEmitter emit,
  ) async {
    emit(state.copyWith(vehicles: [], loading: false));
  }
}

@freezed
class SearchVehiclesEvent with _$SearchVehiclesEvent {
  const factory SearchVehiclesEvent.initialize() =
      SearchVehiclesInitializedEvent;

  const factory SearchVehiclesEvent.searchByVehicleNo({
    required String projectId,
    required String vehicleNo,
  }) = SearchVehiclesByVehicleEvent;

  const factory SearchVehiclesEvent.clear() = SearchVehiclesClearEvent;
}

@freezed
class SearchVehiclesState with _$SearchVehiclesState {
  const SearchVehiclesState._();

  const factory SearchVehiclesState({
    @Default(0) int offset,
    @Default(10) int limit,
    @Default(false) bool loading,
    String? searchQuery,
    String? tag,
    @Default([]) List<ProductVariantModel> vehicles,
    @Default(0) int totalResults,
  }) = _SearchVehiclesState;

  bool get resultsNotFound {
    if (loading) return false;

    if (searchQuery?.isEmpty ?? true && tag == null) return false;

    return vehicles.isEmpty;
  }
}
