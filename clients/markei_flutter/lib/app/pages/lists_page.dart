import 'package:flutter/material.dart';

import '../../application/product_lists.dart';
import '../../domain/shared/ids.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({
    required this.accountId,
    required this.projections,
    required this.refreshSignal,
    super.key,
  });

  final AccountId accountId;
  final ProductListProjectionRepository projections;
  final int refreshSignal;

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  ProductListView _view = ProductListView.shortage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductListProjection>(
      key: ValueKey('${widget.refreshSignal}-${_view.name}'),
      future: widget.projections.productListProjection(
        accountId: widget.accountId,
        view: _view,
        today: DateTime.now(),
      ),
      builder: (context, snapshot) {
        return ListView(
          key: const Key('lists.page'),
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Lists', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            SegmentedButton<ProductListView>(
              segments: const [
                ButtonSegment(
                  value: ProductListView.storage,
                  label: Text('Storage'),
                ),
                ButtonSegment(
                  value: ProductListView.shortage,
                  label: Text('Shortage'),
                ),
                ButtonSegment(
                  value: ProductListView.market,
                  label: Text('Market'),
                ),
                ButtonSegment(value: ProductListView.all, label: Text('All')),
              ],
              selected: {_view},
              onSelectionChanged: (value) =>
                  setState(() => _view = value.single),
            ),
            const SizedBox(height: 12),
            if (snapshot.connectionState == ConnectionState.waiting)
              const Text('Loading estimates...', key: Key('lists.loading'))
            else if (snapshot.hasError)
              const Text(
                'Lists estimates could not be loaded.',
                key: Key('lists.error'),
              )
            else
              _ProjectionView(projection: snapshot.data!),
          ],
        );
      },
    );
  }
}

class _ProjectionView extends StatelessWidget {
  const _ProjectionView({required this.projection});

  final ProductListProjection projection;

  @override
  Widget build(BuildContext context) {
    if (projection.items.isEmpty) {
      return const Text('Not enough history', key: Key('lists.empty'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Based on your history. Shortage threshold: ${projection.shortageThresholdDays} day(s).',
        ),
        if (projection.approximateTotalMinorUnits != null) ...[
          const SizedBox(height: 8),
          Text(
            'Approximate next-purchase total ${projection.approximateTotalCurrencyCode} ${(projection.approximateTotalMinorUnits! / 100).toStringAsFixed(2)}',
            key: const Key('lists.approxTotal'),
          ),
        ],
        const SizedBox(height: 8),
        for (final item in projection.items)
          Card(
            child: ListTile(
              key: Key('lists.product.${item.productId.value}'),
              title: Text(item.productName),
              subtitle: Text(_subtitle(item)),
            ),
          ),
      ],
    );
  }

  String _subtitle(ProductListProjectionItem item) {
    final cycle = item.cycle;
    if (!cycle.isAvailable) {
      return '${item.productCode} · Not enough history';
    }
    return '${item.productCode} · Estimate: next Purchase ${cycle.expectedNextPurchaseDate!.toLocal().toString().split(' ').first} · ${cycle.remainingDays} day(s)';
  }
}
