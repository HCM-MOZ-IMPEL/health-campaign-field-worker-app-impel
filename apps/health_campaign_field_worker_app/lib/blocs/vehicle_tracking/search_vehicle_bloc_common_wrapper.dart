import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/blocs/search_households/individual_global_search.dart';

import 'search_vehicles.dart';

class SearchVehicleBlocWrapper implements StateStreamableSource<Object?> {
  final SearchVehiclesBloc searchVehiclesBloc;

  SearchVehicleBlocWrapper({
    required this.searchVehiclesBloc,
  });

  Stream<SearchVehiclesState> get stateChanges =>
      StreamGroup.merge<SearchVehiclesState>([
        searchVehiclesBloc.stream,
      ]);

  void dispatch(SearchVehiclesByVehicleEvent event) {
    searchVehiclesBloc.add(event);
  }

  void clearEvent() {
    searchVehiclesBloc.add(const SearchVehiclesEvent.clear());
  }

  @override
  SearchVehiclesState get state => searchVehiclesBloc.state;

  @override
  Stream<SearchVehiclesState> get stream => stateChanges;

  @override
  FutureOr<void> close() {
    searchVehiclesBloc.close();
  }

  @override
  bool get isClosed => searchVehiclesBloc.isClosed;
}
