// GENERATED using mason_cli
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../data/data_repository.dart';
import '../../data/local_store/no_sql/schema/oplog.dart';
import '../../data/network_manager.dart';
import '../../models/data_model.dart';

part 'sync.freezed.dart';

typedef SyncEmitter = Emitter<SyncState>;

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final Isar isar;
  final NetworkManager networkManager;

  SyncBloc({
    required this.isar,
    required this.networkManager,
  }) : super(const SyncPendingState()) {
    on(_handleRefresh);
    on(_handleSyncUp);
    on(_handleSyncDown);
  }

  FutureOr<void> _handleRefresh(
    SyncRefreshEvent event,
    SyncEmitter emit,
  ) async {
    final previousCount = state.maybeWhen(
      pendingSync: (count) => count,
      orElse: () => 0,
    );

    int? length = event.count;
    emit(const SyncState.loading());
    try {
      length ??= (await isar.opLogs.filter().isSyncedEqualTo(false).findAll())
          .where((element) {
        switch (element.entityType) {
          case DataModelType.household:
          case DataModelType.individual:
          case DataModelType.task:
            return true;
          default:
            return false;
        }
      }).length;
    } catch (_) {
      rethrow;
    } finally {
      emit(SyncPendingState(count: length ?? previousCount));
    }
  }

  FutureOr<void> _handleSyncUp(
    SyncSyncUpEvent event,
    SyncEmitter emit,
  ) async {
    final previousCount = state.maybeWhen(
      pendingSync: (count) => count,
      orElse: () => 0,
    );

    try {
      emit(const SyncInProgressState());
      await networkManager.syncUp(
        localRepositories: event.localRepositories,
        remoteRepositories: event.remoteRepositories,
      );
      emit(const SyncCompletedState());
    } catch (error) {
      emit(const SyncFailedState());
      rethrow;
    } finally {
      add(const SyncRefreshEvent());
    }
  }

  FutureOr<void> _handleSyncDown(
    SyncSyncDownEvent event,
    SyncEmitter emit,
  ) async {
    // handle logic for syncDown here
  }
}

@freezed
class SyncEvent with _$SyncEvent {
  const factory SyncEvent.refresh([int? count]) = SyncRefreshEvent;

  const factory SyncEvent.syncUp({
    required List<LocalRepository> localRepositories,
    required List<RemoteRepository> remoteRepositories,
  }) = SyncSyncUpEvent;

  const factory SyncEvent.syncDown() = SyncSyncDownEvent;
}

@freezed
class SyncState with _$SyncState {
  const factory SyncState.loading() = SyncLoadingState;

  const factory SyncState.syncInProgress() = SyncInProgressState;

  const factory SyncState.pendingSync({@Default(0) int count}) =
      SyncPendingState;

  const factory SyncState.completedSync() = SyncCompletedState;

  const factory SyncState.failedSync() = SyncFailedState;
}
