import 'dart:async';
import 'dart:convert';

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

  FutureOr<List<UserActionModel>> searchUserAction(
      {String? action, String? vehicleNo}) {
    return retryLocalCallOperation<List<UserActionModel>>(() async {
      final selectQuery = sql.select(sql.userAction).join(
        [
          leftOuterJoin(
            sql.address,
            sql.address.relatedClientReferenceId.equalsExp(sql.userAction.id),
          ),
        ],
      );

      final results = await (selectQuery
            ..where(
              buildAnd(
                [
                  if (action != null)
                    sql.userAction.action.isIn([action])
                  else
                    const Constant(true),
                  if (vehicleNo != null)
                    sql.userAction.beneficiaryTag.isIn([vehicleNo])
                  else
                    const Constant(true),
                  // if (query.isPermanent != null)
                  //   sql.facility.isPermanent.equals(
                  //     query.isPermanent!,
                  //   ),
                ],
              ),
            )
            ..orderBy([
              OrderingTerm(
                expression: sql.userAction.clientModifiedTime,
                mode: OrderingMode.asc,
              ),
            ]))
          .get();

      return results.map((e) {
        final userActionModel = e.readTable(sql.userAction);
        String? additionalFieldString = userActionModel.additionalFields;
        Map<String, dynamic>? additionalFieldsMap =
            additionalFieldString == null
                ? null
                : json.decode(additionalFieldString);
        List<dynamic>? additionalField = additionalFieldsMap?["fields"];
        return UserActionModel(
            latitude: double.parse(userActionModel.latitude),
            longitude: double.parse(userActionModel.longitude),
            locationAccuracy: double.parse(userActionModel.locationAccuracy),
            clientReferenceId: userActionModel.clientReferenceId,
            isSync: userActionModel.isSync,
            timestamp: userActionModel.timestamp,
            nonRecoverableError: userActionModel.nonRecoverableError,
            tenantId: userActionModel.tenantId,
            id: userActionModel.id,
            rowVersion: userActionModel.rowVersion,
            projectId: userActionModel.projectId,
            boundaryCode: userActionModel.boundaryCode,
            action: userActionModel.action,
            beneficiaryTag: userActionModel.beneficiaryTag,
            resourceTag: userActionModel.resourceTag,
            additionalFields: additionalField == null
                ? null
                : UserActionAdditionalFields(
                    version: 1,
                    fields: additionalField
                        .map((e) => AdditionalField(e["key"], e["value"]))
                        .toList(),
                  ));
      }).toList();
    });
  }
}
