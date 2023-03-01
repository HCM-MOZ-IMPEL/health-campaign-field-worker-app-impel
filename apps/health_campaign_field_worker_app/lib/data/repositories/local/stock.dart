import 'dart:async';

import '../../../models/data_model.dart';
import '../../../utils/utils.dart';
import '../../data_repository.dart';

class StockLocalRepository
    extends LocalRepository<StockModel, StockSearchModel> {
  StockLocalRepository(super.sql, super.opLogManager);

  @override
  FutureOr<void> create(
    StockModel entity, {
    bool createOpLog = true,
  }) async {
    final stockCompanion = entity.companion;
    await sql.batch((batch) {
      batch.insert(sql.stock, stockCompanion);
    });
    await super.create(entity);
  }

  @override
  FutureOr<List<StockModel>> search(StockSearchModel query) async {
    final selectQuery = sql.select(sql.stock).join([]);
    final results = await (selectQuery
          ..where(buildAnd([
            if (query.clientReferenceId != null)
              sql.stock.id.equals(
                query.id,
              ),
          ])))
        .get();

    return results.map((e) {
      final data = e.readTable(sql.stock);

      return StockModel(
        id: data.id,
        tenantId: data.tenantId,
        facilityId: data.facilityId,
        productVariantId: data.productVariantId,
        referenceId: data.referenceId,
        referenceIdType: data.referenceIdType,
        transactionType: data.transactionType,
        transactionReason: data.transactionReason,
        transactingPartyId: data.transactingPartyId,
        transactingPartyType: data.transactingPartyType,
        quantity: data.quantity,
        waybillNumber: data.waybillNumber,
        clientReferenceId: data.clientReferenceId,
        isDeleted: data.isDeleted,
        rowVersion: data.rowVersion,
      );
    }).toList();
  }

  @override
  // TODO: implement type
  DataModelType get type => throw UnimplementedError();
}