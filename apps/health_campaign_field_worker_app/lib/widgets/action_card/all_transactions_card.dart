import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/theme/spacers.dart';

import 'package:flutter/material.dart';
import 'package:inventory_management/utils/utils.dart';

import '../../utils/i18_key_constants.dart' as i18_local;

import '../localized.dart';

class TransactionsCard extends LocalizedStatefulWidget {
  final String minNumber;
  final String cddCode;
  final String date;
  final List<Map<String, String>> items;
  final Map<String, dynamic> data;
  final String waybillNumber;
  final Color? backgroundColor;

  const TransactionsCard({
    super.key,
    required this.minNumber,
    required this.cddCode,
    required this.date,
    required this.items,
    required this.data,
    required this.waybillNumber,
    this.backgroundColor,
  });

  @override
  State<TransactionsCard> createState() => _TransactionsCardState();
}

class _TransactionsCardState extends LocalizedState<TransactionsCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.grey[200],
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0), // Replace spacer2 with 8.0
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Replace spacer4 with 16.0
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0), // Replace spacer2
              ),
              padding: const EdgeInsets.all(8.0), // Replace spacer2
              child: Text(
                widget.minNumber,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            if (!InventorySingleton().isWareHouseMgr)
              const SizedBox(height: 8.0), // Replace spacer2
            Text(widget.cddCode),
            const SizedBox(height: 8.0), // Replace spacer2

            const SizedBox(height: 8.0), // Replace spacer2
            ...widget.items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Replace spacer2
                child: Row(
                  children: [
                    Text(
                      item['name']!,
                      style: textTheme.bodyL,
                    ),
                    const SizedBox(width: 8.0), // Replace spacer2
                    Text(
                      "|",
                      style: textTheme.bodyL,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      "${item['quantity']!} Units",
                      style: textTheme.bodyL,
                    ),
                    // const SizedBox(width: 8.0),
                    // Text(
                    //   "|",
                    //   style: textTheme.bodyL,
                    // ),
                    // Replace spacer2
                  ],
                ),
              );
            }).toList(),

            if (widget.date.trim().isNotEmpty) ...[
              const SizedBox(width: 8.0),
              Text(
                widget.date,
                style: textTheme.bodyL,
              ),
            ],

            const SizedBox(height: 8.0), // Replace spacer2
            Row(
              children: [
                Text(localizations.translate(i18_local.stockDetails.waybill),
                    style: textTheme.bodyL.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  width: spacer4,
                ), // Replace spacer2
                Text(widget.waybillNumber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
