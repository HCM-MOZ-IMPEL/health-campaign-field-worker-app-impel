import 'dart:async';

import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/user_action.dart';
import 'package:drift/drift.dart';
import 'package:transit_post/transit_post.dart';

// This will create , update and search data from local Repository
class CustomUserActionLocalRepository extends UserActionLocalRepository {
  CustomUserActionLocalRepository(super.sql, super.opLogManager);

  FutureOr<void> createUserAction(
    UserActionModel entity, {
    bool createOpLog = true,
    DataOperation dataOperation = DataOperation.create,
  }) async {
    return retryLocalCallOperation(() async {
      await sql.batch((batch) {
        batch.insert(
          sql.userAction,
          entity.companion,
          mode: InsertMode.insertOrReplace,
        );
      });

      await super.create(
        entity,
        createOpLog: createOpLog,
      );
    });
  }

  FutureOr<void> updateUserAction(
    UserActionModel entity, {
    bool createOpLog = true,
    DataOperation dataOperation = DataOperation.update,
  }) async {
    return retryLocalCallOperation(() async {
      await sql.batch((batch) {
        batch.update(
          sql.userAction,
          entity.companion,
          where: (table) => table.clientReferenceId.equals(
            entity.clientReferenceId,
          ),
        );
      });

      await super.update(entity, createOpLog: createOpLog);
    });
  }

  @override
  DataModelType get type => DataModelType.userAction;

  @override
  FutureOr<List<UserActionModel>> search(UserActionSearchModel query) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
