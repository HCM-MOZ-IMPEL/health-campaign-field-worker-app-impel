// GENERATED using mason_cli
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:digit_data_model/models/entities/product_variant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_management/models/entities/stock.dart';
import 'package:inventory_management/models/entities/transaction_type.dart';
import 'package:inventory_management/utils/typedefs.dart';
import 'package:inventory_management/utils/utils.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../data/repositories/custom_product_variant.dart';
import '../../utils/constants.dart';

part 'stock_count.freezed.dart';

typedef StockCountEmitter = Emitter<StockCountState>;

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class StockCountBloc extends Bloc<StockCountEvent, StockCountState> {
  final StockDataRepository stockRepository;
  final ProductVariantDataRepository productVariantDataRepository;

  StockCountBloc({
    required this.stockRepository,
    required this.productVariantDataRepository,
  }) : super(const StockCountState()) {
    on(_calculateSKU);
    on(_handleClear);
  }

  // This function is been used in Individual details screen.
  Future<void> _calculateSKU(
    StockCountCalculateSKUEvent event,
    StockCountEmitter emit,
  ) async {
    emit(state.copyWith(
      loading: true,
    ));
    final facilityId = event.facilityId;

    ProductVariantSearchModel productVariantSearchModel =
        ProductVariantSearchModel();

    final productVariants = await (productVariantDataRepository
            as CustomProductVariantLocalRepository)
        .customSearch(productVariantSearchModel);

    List<ProductVariantModel> filteredProductVariants = productVariants
        .whereNot((element) => element.sku == Constants.vehicleSKU)
        .toList();

    Map<String, int> skuCounts = {};

    for (ProductVariantModel productVariantId in filteredProductVariants) {
// Fetching the stock reconciliation details
      final receivedStocks = (await stockRepository.search(
        StockSearchModel(
            productVariantId: productVariantId.id,
            receiverId: [facilityId],
            transactionType: [TransactionType.received.toValue()]),
      ))
          .where((element) =>
              element.auditDetails != null &&
              element.auditDetails?.createdBy ==
                  InventorySingleton().loggedInUserUuid)
          .toList();
      final sentStocks = (await stockRepository.search(
        StockSearchModel(
            productVariantId: productVariantId.id,
            senderId: facilityId,
            transactionType: [TransactionType.dispatched.toValue()]),
      ))
          .where((element) =>
              element.auditDetails != null &&
              element.auditDetails?.createdBy ==
                  InventorySingleton().loggedInUserUuid)
          .toList();
      int receivedStockCount = 0;
      int sentStockCount = 0;

      for (var stock in receivedStocks) {
        receivedStockCount += int.parse(stock.quantity ?? "0");
      }
      for (var stock in sentStocks) {
        sentStockCount += int.parse(stock.quantity ?? "0");
      }
      if (productVariantId.sku != null) {
        skuCounts[productVariantId.sku!] = receivedStockCount - sentStockCount;
      }
    }

    // Emitting the state with the fetched stock reconciliation details
    emit(state.copyWith(
      loading: false,
      skuCounts: skuCounts,
    ));
  }

  FutureOr<void> _handleClear(
    StockCountClearEvent event,
    StockCountEmitter emit,
  ) async {
    emit(state.copyWith(
      skuCounts: {},
    ));
  }
}

@freezed
class StockCountEvent with _$StockCountEvent {
  const factory StockCountEvent.initialize() = StockCountInitializedEvent;

  const factory StockCountEvent.calculateSKU({
    required String facilityId,
  }) = StockCountCalculateSKUEvent;

  const factory StockCountEvent.clear() = StockCountClearEvent;
}

@freezed
class StockCountState with _$StockCountState {
  const StockCountState._();

  const factory StockCountState({
    @Default(false) bool loading,
    @Default({}) Map<String, int> skuCounts,
    @Default(0) int totalResults,
  }) = _StockCountCalculateSKUState;
}
