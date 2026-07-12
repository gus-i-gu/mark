import 'package:flutter/material.dart';

import '../../application/purchase_history.dart';
import '../../domain/shared/ids.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    required this.accountId,
    required this.history,
    required this.refreshSignal,
    super.key,
  });

  final AccountId accountId;
  final PurchaseHistoryRepository history;
  final int refreshSignal;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PurchaseHistoryEntry>>(
      key: ValueKey(refreshSignal),
      future: history.listRecentPurchases(accountId),
      builder: (context, snapshot) {
        final entries = snapshot.data ?? const <PurchaseHistoryEntry>[];
        if (entries.isEmpty) {
          return const Center(child: Text('No purchases registered.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: entries.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final entry = entries[index];
            return ListTile(
              key: Key('history.purchase.${entry.purchaseId.value}'),
              title: Text(entry.storeName),
              subtitle: Text('${entry.itemCount} item(s)'),
              trailing: Text(
                '${entry.currencyCode} ${(entry.totalMinorUnits / 100).toStringAsFixed(2)}',
              ),
            );
          },
        );
      },
    );
  }
}
