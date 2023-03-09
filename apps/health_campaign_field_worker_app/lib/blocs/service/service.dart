import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/entities/service.dart';
import '../../utils/typedefs.dart';

part 'service.freezed.dart';

typedef ServiceEmitter = Emitter<ServiceState>;

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceDataRepository serviceDataRepository;

  ServiceBloc(
    super.initialState, {
    required this.serviceDataRepository,
  }) {
    on(_handleCreate);
    on(_multichecklistChanged);
    on(_handleSearch);
    on(_handleSelect);
  }

  FutureOr<void> _multichecklistChanged(
    ServiceChecklistEvent event,
    ServiceEmitter emit,
  ) async {
    emit(ServiceState.multichecklistChanged(value: event.value));
  }

  FutureOr<void> _handleCreate(
    ServiceCreateEvent event,
    ServiceEmitter emit,
  ) async {
    await serviceDataRepository.create(event.serviceModel);
  }

  FutureOr<void> _handleSearch(
    ServiceSearchEvent event,
    ServiceEmitter emit,
  ) async {
    final results =
        await serviceDataRepository.search(event.serviceSearchModel);
    emit(ServiceSearchState(serviceList: results));
  }

  FutureOr<void> _handleSelect(
    ServiceSelectionEvent event,
    ServiceEmitter emit,
  ) async {
    state.mapOrNull(
      serviceSearch: (value) => emit(value.copyWith(
        selectedService: event.service,
      )),
    );
  }
}

@freezed
class ServiceEvent with _$ServiceEvent {
  const factory ServiceEvent.create({required ServiceModel serviceModel}) =
      ServiceCreateEvent;

  const factory ServiceEvent.search({
    required ServiceSearchModel serviceSearchModel,
  }) = ServiceSearchEvent;

  const factory ServiceEvent.multichecklistChanged({required String value}) =
      ServiceChecklistEvent;
  const factory ServiceEvent.selectService({
    required ServiceModel service,
  }) = ServiceSelectionEvent;
}

@freezed
class ServiceState with _$ServiceState {
  const factory ServiceState.empty() = ServiceEmptyState;

  const factory ServiceState.isloading() = ServiceIsloadingState;

  const factory ServiceState.multichecklistChanged({
    @Default('') String value,
  }) = ServiceMultichecklistChangedState;

  const factory ServiceState.serviceCreate({
    required ServiceModel serviceList,
    ServiceModel? selectedService,
    @Default(false) bool loading,
    @Default(false) bool isEditing,
  }) = ServiceCreateState;

  const factory ServiceState.serviceSearch({
    required List<ServiceModel> serviceList,
    ServiceModel? selectedService,
    @Default(false) bool loading,
  }) = ServiceSearchState;
}
