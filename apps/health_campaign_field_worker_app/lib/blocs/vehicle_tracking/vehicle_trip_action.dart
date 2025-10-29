import 'dart:async';

import 'package:collection/collection.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/user_action.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:transit_post/transit_post.dart';

import '../../data/repositories/local/vehicle_tracking/custom_user_action.dart';
import '../../models/entities/vehicle_tracking/trip_actions.dart';
import '../../utils/utils.dart';

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
    on(_handleStartTrip);
    on(_handleSearch);
    on(_handlerEndTrip);
  }

  FutureOr<void> _handlerEndTrip(
    VehicleTripActionEndTripEvent event,
    VehicleTripActionEmitter emit,
  ) async {
    emit(state.copyWith(loading: true));
    UserActionModel tripActionModel = event.tripAction;
    var clientReferenceId = IdGen.i.identifier;
    try {
      var tripEndTime = DateTime.now().millisecondsSinceEpoch;
      tripActionModel = tripActionModel.copyWith(
          clientReferenceId: clientReferenceId,
          action: TripActions.end.toValue(),
          timestamp: tripEndTime,
          isSync: false,
          latitude: event.latitude,
          longitude: event.longitude,
          locationAccuracy: event.locationAccurracy,
          auditDetails: tripActionModel.auditDetails?.copyWith(
              lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid!,
              lastModifiedTime: DateTime.now().millisecondsSinceEpoch),
          clientAuditDetails: tripActionModel.clientAuditDetails?.copyWith(
              lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid!,
              lastModifiedTime: DateTime.now().millisecondsSinceEpoch),
          additionalFields: tripActionModel.additionalFields?.fields == null
              ? UserActionAdditionalFields(
                  version: 1,
                  fields: [AdditionalField("endTripTime", tripEndTime)],
                )
              : tripActionModel.additionalFields?.copyWith(fields: [
                  ...tripActionModel.additionalFields!.fields,
                  AdditionalField("endTripTime", tripEndTime)
                ]));
      await userActionLocalRepository.createUserAction(tripActionModel);
      emit(state.copyWith(
        loading: false,
        tripAction: tripActionModel,
      ));
    } catch (e) {}
  }

  // Event handler for submitting a task
  FutureOr<void> _handleStartTrip(
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
  ) async {
    // it will return all the userActions , we will pick the latest one and see what is the action for it
    List<UserActionModel> vehicleUserActions = await userActionLocalRepository
        .searchUserAction(vehicleNo: event.vehicleNo);
    emit(state.copyWith(
      loading: false,
      tripAction: vehicleUserActions.firstOrNull,
    ));
  }
}

@freezed
class VehicleTripActionEvent with _$VehicleTripActionEvent {
  const factory VehicleTripActionEvent.handleStartTrip({
    required bool isEditing,
    required BoundaryModel boundaryModel,
    required UserActionModel tripBookAction,
    @Default(false) bool navigateToSummary,
  }) = VehicleTripActionStartTripEvent;

  const factory VehicleTripActionEvent.handleEndTrip({
    required bool isEditing,
    required BoundaryModel boundaryModel,
    required String vehicleNo,
    required UserActionModel tripAction,
    required double latitude,
    required double longitude,
    required double locationAccurracy,
    @Default(false) bool navigateToSummary,
  }) = VehicleTripActionEndTripEvent;

  const factory VehicleTripActionEvent.handleSearch({
    required String vehicleNo,
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
