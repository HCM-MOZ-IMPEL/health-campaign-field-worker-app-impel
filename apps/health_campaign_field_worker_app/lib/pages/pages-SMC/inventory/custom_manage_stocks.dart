import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/blocs/record_stock.dart';
import 'package:inventory_management/inventory_management.dart';
import 'package:inventory_management/router/inventory_router.gm.dart';

import 'package:inventory_management/utils/i18_key_constants.dart' as i18;
import 'package:inventory_management/widgets/back_navigation_help_header.dart';

import '../../../widgets/localized.dart';

@RoutePage()
class CustomManageStocksPage extends LocalizedStatefulWidget {
  const CustomManageStocksPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<CustomManageStocksPage> createState() => _CustomManageStocksPageState();
}

class _CustomManageStocksPageState
    extends LocalizedState<CustomManageStocksPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ScrollableContent(
        header: const BackNavigationHelpHeaderWidget(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kPadding * 2, kPadding, kPadding * 2, kPadding),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    localizations.translate(i18.manageStock.label),
                    style: theme.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Column(children: [
                DigitListView(
                  title: localizations
                      .translate(i18.manageStock.recordStockReceiptLabel),
                  description: localizations
                      .translate(i18.manageStock.recordStockReceiptDescription),
                  prefixIcon: Icons.file_download_outlined,
                  sufixIcon: Icons.arrow_circle_right,
                  onPressed: () {
                    context.router.push(
                      RecordStockWrapperRoute(
                        type: StockRecordEntryType.receipt,
                      ),
                    );
                  },
                ),
                DigitListView(
                    title: localizations
                        .translate(i18.manageStock.recordStockIssuedLabel),
                    description: localizations.translate(
                        i18.manageStock.recordStockIssuedDescription),
                    prefixIcon: Icons.file_upload_outlined,
                    sufixIcon: Icons.arrow_circle_right,
                    onPressed: () => context.router.push(
                          RecordStockWrapperRoute(
                            type: StockRecordEntryType.dispatch,
                          ),
                        )),
                if (!InventorySingleton().isDistributor)
                  DigitListView(
                      title: localizations
                          .translate(i18.manageStock.recordStockReturnedLabel),
                      description: localizations.translate(
                        i18.manageStock.recordStockReturnedDescription,
                      ),
                      prefixIcon: Icons.settings_backup_restore,
                      sufixIcon: Icons.arrow_circle_right,
                      onPressed: () => context.router.push(
                            RecordStockWrapperRoute(
                              type: StockRecordEntryType.returned,
                            ),
                          ))
              ]),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
