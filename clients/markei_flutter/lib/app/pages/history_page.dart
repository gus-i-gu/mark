import 'package:flutter/material.dart';

import '../../application/purchase_history.dart';
import '../../domain/shared/ids.dart';

class HistoryPage extends StatefulWidget {
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
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _retrySignal = 0;
  PurchaseId? _selectedPurchaseId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PurchaseHistoryEntry>>(
      key: ValueKey('${widget.refreshSignal}-$_retrySignal'),
      future: widget.history.listRecentPurchases(widget.accountId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'Loading purchase history...',
              key: Key('history.loading'),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Purchase history could not be loaded.',
                  key: Key('history.error'),
                ),
                const SizedBox(height: 12),
                FilledButton.tonal(
                  key: const Key('history.retry'),
                  onPressed: () => setState(() => _retrySignal++),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final entries = snapshot.data ?? const <PurchaseHistoryEntry>[];
        if (entries.isEmpty) {
          return const Center(
            child: Text(
              'No purchases registered yet.',
              key: Key('history.empty'),
            ),
          );
        }
        final selected = _selectedPurchaseId;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Purchase History', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            for (final entry in entries) ...[
              ListTile(
                key: Key('history.purchase.${entry.purchaseId.value}'),
                title: Text(entry.storeName),
                subtitle: Text(
                  '${entry.itemCount} Purchase Item(s) · ${entry.occurrenceTime.toLocal()}',
                ),
                trailing: Text(
                  '${entry.currencyCode} ${(entry.totalMinorUnits / 100).toStringAsFixed(2)}',
                ),
                onTap: () =>
                    setState(() => _selectedPurchaseId = entry.purchaseId),
              ),
              const Divider(height: 1),
            ],
            if (selected != null) ...[
              const SizedBox(height: 16),
              _PurchaseDetailView(
                accountId: widget.accountId,
                purchaseId: selected,
                history: widget.history,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _PurchaseDetailView extends StatelessWidget {
  const _PurchaseDetailView({
    required this.accountId,
    required this.purchaseId,
    required this.history,
  });

  final AccountId accountId;
  final PurchaseId purchaseId;
  final PurchaseHistoryRepository history;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PurchaseDetail?>(
      future: history.getPurchaseDetail(accountId, purchaseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading Purchase details...',
            key: Key('history.detail.loading'),
          );
        }
        if (snapshot.hasError) {
          return const Text(
            'Purchase details could not be loaded.',
            key: Key('history.detail.error'),
          );
        }
        final detail = snapshot.data;
        if (detail == null) {
          return const Text(
            'Purchase detail is not available.',
            key: Key('history.detail.empty'),
          );
        }
        return Column(
          key: const Key('history.detail'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Purchase at ${detail.entry.storeName}'),
            Text(
              '${detail.entry.currencyCode} ${(detail.entry.totalMinorUnits / 100).toStringAsFixed(2)}',
            ),
            const SizedBox(height: 8),
            for (final item in detail.items)
              Card(
                child: ListTile(
                  title: Text(item.productName),
                  subtitle: Text(
                    '${item.productCode} · ${item.packageCount} package(s) · ${item.purchasedAmount} ${item.purchasedUnit}',
                  ),
                  trailing: Text(
                    '${item.currencyCode} ${(item.lineTotalMinorUnits / 100).toStringAsFixed(2)}',
                  ),
                ),
              ),
            if (detail.items.isNotEmpty)
              _PriceChangeView(
                accountId: accountId,
                productId: detail.items.first.productId,
                history: history,
              ),
          ],
        );
      },
    );
  }
}

class _PriceChangeView extends StatelessWidget {
  const _PriceChangeView({
    required this.accountId,
    required this.productId,
    required this.history,
  });

  final AccountId accountId;
  final ProductId productId;
  final PurchaseHistoryRepository history;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PriceChangeResult>(
      future: history.priceChangeForProduct(accountId, productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading price comparison...',
            key: Key('history.price.loading'),
          );
        }
        if (snapshot.hasError) {
          return const Text(
            'Price change in your purchases could not be loaded.',
            key: Key('history.price.error'),
          );
        }
        final result = snapshot.data;
        return switch (result) {
          ComparablePriceChange() => Text(
            'Price change in your purchases: ${_formatBasisPoints(result.changeBasisPoints)} from ${result.previous.storeName} to ${result.latest.storeName}.',
            key: const Key('history.price.change'),
          ),
          PriceChangeUnavailable(:final reason) => Text(
            reason,
            key: const Key('history.price.unavailable'),
          ),
          null => const Text(
            'Not enough comparable purchases.',
            key: Key('history.price.unavailable'),
          ),
        };
      },
    );
  }
}

String _formatBasisPoints(int basisPoints) {
  final sign = basisPoints > 0 ? '+' : '';
  return '$sign${(basisPoints / 100).toStringAsFixed(2)}%';
}
