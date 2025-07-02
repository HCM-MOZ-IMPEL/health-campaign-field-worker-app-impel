import 'dart:async';

import 'package:collection/collection.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';

import '../../models/entities/additional_fields_type.dart';

part 'vehicle_trip_action.freezed.dart';

typedef VehicleTripActionEmitter = Emitter<VehicleTripActionState>;

class VehicleTripActionBloc
    extends Bloc<VehicleTripActionEvent, VehicleTripActionState> {
  final DataRepository<ProductVariantModel, ProductVariantSearchModel>
      productVariantDataRepository;

  VehicleTripActionBloc(
    super.initialState, {
    required this.productVariantDataRepository,
  }) {
    on(_handleSubmit);
    on(_handleSearch);
  }

  // Event handler for submitting a task
  FutureOr<void> _handleSubmit(
    VehicleTripActionSubmitEvent event,
    VehicleTripActionEmitter emit,
  ) async {
    // Update loading state to indicate an operation is in progress
  }

  // Search for tasks and process the results
  FutureOr<void> _handleSearch(
    VehicleTripActionSearchEvent event,
    VehicleTripActionEmitter emit,
  ) async {}
}

@freezed
class VehicleTripActionEvent with _$VehicleTripActionEvent {
  const factory VehicleTripActionEvent.handleSubmit({
    required bool isEditing,
    required BoundaryModel boundaryModel,
    @Default(false) bool navigateToSummary,
  }) = VehicleTripActionSubmitEvent;

  const factory VehicleTripActionEvent.handleSearch({
    required ProductVariantModel vechicleTripSearch,
  }) = VehicleTripActionSearchEvent;
}

@freezed
class VehicleTripActionState with _$VehicleTripActionState {
  const factory VehicleTripActionState({
    @Default(false) bool loading,
    @Default(false) bool isEditing,
  }) = _VehicleTripActionState;
}
