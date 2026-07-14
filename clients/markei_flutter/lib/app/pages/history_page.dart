import 'dart:io';

import 'package:flutter/material.dart';

import '../../application/history_export.dart';
import '../../application/purchase_history.dart';
import '../../domain/shared/ids.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    required this.accountId,
    required this.history,
    required this.exports,
    required this.refreshSignal,
    super.key,
  });

  final AccountId accountId;
  final PurchaseHistoryRepository history;
  final PurchaseExportRepository exports;
  final int refreshSignal;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _retrySignal = 0;
  PurchaseId? _selectedPurchaseId;
  final Set<PurchaseId> _selectedIds = {};
  String? _message;

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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.tonal(
                  onPressed: null,
                  child: const Text('Move to Analytics'),
                ),
                FilledButton.tonal(
                  key: const Key('history.exportCsv'),
                  onPressed: _selectedIds.isEmpty
                      ? null
                      : () => _exportCsv(_selectedIds),
                  child: const Text('Export CSV'),
                ),
                FilledButton.tonal(
                  key: const Key('history.sharePdf'),
                  onPressed: _selectedIds.isEmpty
                      ? null
                      : () => _sharePdf(_selectedIds),
                  child: const Text('Share list (PDF)'),
                ),
                OutlinedButton(onPressed: null, child: const Text('Edit')),
                OutlinedButton(onPressed: null, child: const Text('Delete')),
                TextButton(
                  key: const Key('history.clearSelection'),
                  onPressed: _selectedIds.isEmpty
                      ? null
                      : () => setState(_selectedIds.clear),
                  child: const Text('Clear'),
                ),
              ],
            ),
            if (_message != null) ...[
              const SizedBox(height: 8),
              Text(_message!, key: const Key('history.export.message')),
            ],
            const SizedBox(height: 8),
            for (final entry in entries) ...[
              ListTile(
                key: Key('history.purchase.${entry.purchaseId.value}'),
                leading: Checkbox(
                  value: _selectedIds.any(
                    (id) => id.value == entry.purchaseId.value,
                  ),
                  onChanged: (_) => _toggleSelection(entry.purchaseId),
                ),
                title: Text(entry.storeName),
                subtitle: Text(
                  '${entry.itemCount} Purchase Item(s) · ${entry.occurrenceTime.toLocal()}',
                ),
                trailing: Text(
                  '${entry.currencyCode} ${(entry.totalMinorUnits / 100).toStringAsFixed(2)}',
                ),
                onTap: () {
                  _toggleSelection(entry.purchaseId);
                  setState(() => _selectedPurchaseId = entry.purchaseId);
                },
                onLongPress: () =>
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

  void _toggleSelection(PurchaseId purchaseId) {
    setState(() {
      final existing = _selectedIds
          .where((id) => id.value == purchaseId.value)
          .toList(growable: false);
      if (existing.isEmpty) {
        _selectedIds.add(purchaseId);
      } else {
        _selectedIds.remove(existing.first);
      }
    });
  }

  Future<void> _exportCsv(Set<PurchaseId> ids) async {
    final bundle = await widget.exports.exportBundle(widget.accountId, ids);
    final csv = purchaseBundleCsv(bundle);
    final file = File(
      '${Directory.systemTemp.path}/markei-selected-purchases.csv',
    );
    await file.writeAsString(csv);
    setState(() => _message = 'CSV saved to ${file.path}.');
  }

  Future<void> _sharePdf(Set<PurchaseId> ids) async {
    final bundle = await widget.exports.exportBundle(widget.accountId, ids);
    final bytes = purchaseBundlePdfBytes(bundle);
    final file = File('${Directory.systemTemp.path}/markei-selected-list.pdf');
    await file.writeAsBytes(bytes);
    setState(() => _message = 'PDF saved to ${file.path}. Share it manually.');
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
                    '${item.productCode} · ${item.packageCount == null ? 'BULK' : '${item.packageCount} package(s)'} · ${item.purchasedAmount} ${item.purchasedUnit}',
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
