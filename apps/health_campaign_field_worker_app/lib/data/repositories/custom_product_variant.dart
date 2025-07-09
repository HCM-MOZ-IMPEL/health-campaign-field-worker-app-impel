import 'dart:async';

import 'package:digit_data_model/data_model.dart';
import 'package:drift/drift.dart';

class CustomProductVariantLocalRepository
    extends ProductVariantLocalRepository {
  CustomProductVariantLocalRepository(super.sql, super.opLogManager);

  FutureOr<List<ProductVariantModel>> customSearch(
    ProductVariantSearchModel query,
  ) async {
    return retryLocalCallOperation(() async {
      final selectQuery = sql.select(sql.productVariant).join([]);

      final results = await (selectQuery
            ..where(buildAnd([
              if (query.id != null) sql.productVariant.id.isIn(query.id!),
              if (query.productId != null)
                sql.productVariant.productId.isIn(query.productId!),
              if (query.sku != null) sql.productVariant.sku.equals(query.sku!),
              if (query.variation != null)
                sql.productVariant.variation.contains(query.variation!),
            ])))
          .get();

      return results.map((e) {
        final productVariant = e.readTable(sql.productVariant);

        return ProductVariantModel(
          tenantId: productVariant.tenantId,
          isDeleted: productVariant.isDeleted,
          id: productVariant.id,
          rowVersion: productVariant.rowVersion,
          productId: productVariant.productId,
          sku: productVariant.sku,
          variation: productVariant.variation,
          additionalFields: productVariant.additionalFields == null
              ? null
              : ProductVariantAdditionalFieldsMapper.fromJson(
                  productVariant.additionalFields!,
                ),
        );
      }).toList();
    });
  }
}
