import 'dart:async';

import 'package:collection/collection.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/user_action.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/registration_delivery.dart';

import '../../data/repositories/local/vehicle_tracking/custom_user_action.dart';
import '../../models/entities/additional_fields_type.dart';
import '../../models/entities/vehicle_tracking/trip_actions.dart';

part 'vehicle_trip_action.freezed.dart';

typedef VehicleTripActionEmitter = Emitter<VehicleTripActionState>;

class VehicleTripActionBloc
    extends Bloc<VehicleTripActionEvent, VehicleTripActionState> {
  final DataRepository<ProductVariantModel, ProductVariantSearchModel>
      productVariantDataRepository;
  final CustomUserActionLocalRepository userActionLocalRepository;

  VehicleTripActionBloc(
    super.initialState, {
    required this.productVariantDataRepository,
    required this.userActionLocalRepository,
  }) {
    on(_handleStartTip);
    on(_handleSearch);
    on(_handlerEndTrip);
  }

  FutureOr<void> _handlerEndTrip(
    VehicleTripActionEndTripEvent event,
    VehicleTripActionEmitter emit,
  ) async {
    emit(state.copyWith(loading: true));
    UserActionModel tripActionModel = event.tripAction;
    try {
      tripActionModel = tripActionModel.copyWith(
          action: TripActions.end.name,
          auditDetails: tripActionModel.auditDetails?.copyWith(
              lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid!,
              lastModifiedTime: DateTime.now().millisecondsSinceEpoch),
          clientAuditDetails: tripActionModel.clientAuditDetails?.copyWith(
              lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid!,
              lastModifiedTime: DateTime.now().millisecondsSinceEpoch),
          additionalFields: tripActionModel.additionalFields?.fields == null
              ? UserActionAdditionalFields(
                  version: 1,
                  fields: [
                    AdditionalField(
                        "endTripTime", DateTime.now().millisecondsSinceEpoch)
                  ],
                )
              : tripActionModel.additionalFields?.copyWith(fields: [
                  ...tripActionModel.additionalFields!.fields,
                  AdditionalField(
                      "endTripTime", DateTime.now().millisecondsSinceEpoch)
                ]));
      await userActionLocalRepository.updateUserAction(tripActionModel);
      emit(state.copyWith(
        loading: false,
        tripAction: tripActionModel,
      ));
    } catch (e) {}
  }

  // Event handler for submitting a task
  FutureOr<void> _handleStartTip(
    VehicleTripActionStartTripEvent event,
    VehicleTripActionEmitter emit,
  ) async {
    // Update loading state to indicate an operation is in progress
    emit(state.copyWith(loading: true));
    UserActionModel tripBookActionModel = event.tripBookAction;
    try {
      tripBookActionModel = tripBookActionModel.copyWith(
          clientAuditDetails: ClientAuditDetails(
              createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
              createdTime: DateTime.now().millisecondsSinceEpoch),
          auditDetails: AuditDetails(
              createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
              createdTime: DateTime.now().millisecondsSinceEpoch));
      // create the userAction model with trip action as start
      await userActionLocalRepository.createUserAction(tripBookActionModel);
      emit(state.copyWith(
        loading: false,
        tripAction: tripBookActionModel,
      ));
    } catch (e) {}
  }

  // Search for tasks and process the results
  FutureOr<void> _handleSearch(
    VehicleTripActionSearchEvent event,
    VehicleTripActionEmitter emit,
  ) async {}
}

@freezed
class VehicleTripActionEvent with _$VehicleTripActionEvent {
  const factory VehicleTripActionEvent.handleStartTip({
    required bool isEditing,
    required BoundaryModel boundaryModel,
    required UserActionModel tripBookAction,
    @Default(false) bool navigateToSummary,
  }) = VehicleTripActionStartTripEvent;

  const factory VehicleTripActionEvent.handleEndTip({
    required bool isEditing,
    required BoundaryModel boundaryModel,
    required UserActionModel tripAction,
    @Default(false) bool navigateToSummary,
  }) = VehicleTripActionEndTripEvent;

  const factory VehicleTripActionEvent.handleSearch({
    required UserActionModel vehicleTripSearch,
  }) = VehicleTripActionSearchEvent;
}

@freezed
class VehicleTripActionState with _$VehicleTripActionState {
  const factory VehicleTripActionState({
    @Default(false) bool loading,
    @Default(false) bool isEditing,
    @Default(null) UserActionModel? tripAction,
  }) = _VehicleTripActionState;
}
