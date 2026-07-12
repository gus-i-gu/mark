import 'package:flutter/material.dart';

import '../../application/catalogue_queries.dart';
import '../../application/register_purchase.dart';
import '../../domain/catalogue/product.dart';
import '../../domain/purchase/purchase.dart';
import '../../domain/shared/ids.dart';
import '../../domain/shared/money.dart';
import '../../domain/shared/quantity.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({
    required this.accountId,
    required this.deviceId,
    required this.registration,
    required this.catalogueQueries,
    required this.onRegistered,
    super.key,
  });

  final AccountId accountId;
  final DeviceId deviceId;
  final PurchaseRegistrationRepository registration;
  final CatalogueQueryRepository catalogueQueries;
  final VoidCallback onRegistered;

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final _storeController = TextEditingController(text: 'Mercado Central');
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _packageAmountController = TextEditingController(text: '1');
  final _packageUnitController = TextEditingController(text: 'kg');
  final _purchasedAmountController = TextEditingController(text: '1');
  final _purchasedUnitController = TextEditingController(text: 'kg');
  final _packageCountController = TextEditingController(text: '1');
  final _lineTotalController = TextEditingController();
  final List<PurchaseItemDraft> _items = [];
  List<ProductSimilarityWarning> _warnings = [];
  bool _bulk = false;
  String? _message;

  @override
  void dispose() {
    _storeController.dispose();
    _codeController.dispose();
    _nameController.dispose();
    _brandController.dispose();
    _packageAmountController.dispose();
    _packageUnitController.dispose();
    _purchasedAmountController.dispose();
    _purchasedUnitController.dispose();
    _packageCountController.dispose();
    _lineTotalController.dispose();
    super.dispose();
  }

  Future<void> _addItem() async {
    try {
      final draft = _productDraft();
      final warnings = await widget.catalogueQueries.similarityWarnings(
        widget.accountId,
        draft,
      );
      final item = PurchaseItemDraft(
        productReference: NewProductReference(draft),
        packageCount: int.parse(_packageCountController.text.trim()),
        purchasedQuantity: normalizeDisplayQuantity(
          kind: MeasurementKind.mass,
          amount: _purchasedAmountController.text,
          unit: _purchasedUnitController.text,
        ),
        lineTotal: Money(
          currencyCode: 'BRL',
          minorUnits: _parseMinorUnits(_lineTotalController.text),
        ),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _items.add(item);
        _warnings = warnings;
        _message = warnings.isEmpty
            ? 'Item staged.'
            : 'Similar product warning only; no merge was performed.';
      });
      _codeController.clear();
      _nameController.clear();
      _brandController.clear();
      _lineTotalController.clear();
    } on Object catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<void> _registerPurchase() async {
    try {
      final result = await widget.registration.registerPurchase(
        RegisterPurchaseCommand(
          accountId: widget.accountId,
          deviceId: widget.deviceId,
          storeName: _storeController.text,
          occurrenceTime: DateTime.now().toUtc(),
          currencyCode: 'BRL',
          items: List.unmodifiable(_items),
        ),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _items.clear();
        _warnings = [];
        _message =
            'Purchase registered. Device sequence ${result.deviceSequence}.';
      });
      widget.onRegistered();
    } on Object catch (error) {
      setState(() => _message = error.toString());
    }
  }

  ProductDraft _productDraft() {
    return ProductDraft(
      userCode: _codeController.text,
      name: _nameController.text,
      brand: _brandController.text,
      mode: _bulk ? ProductMode.bulk : ProductMode.packaged,
      measurementKind: MeasurementKind.mass,
      packageAmount: _bulk ? null : _packageAmountController.text,
      packageUnit: _bulk ? null : _packageUnitController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          key: const Key('purchase.store'),
          controller: _storeController,
          decoration: const InputDecoration(labelText: 'Store'),
        ),
        const SizedBox(height: 12),
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: false, label: Text('Packaged')),
            ButtonSegment(value: true, label: Text('Bulk')),
          ],
          selected: {_bulk},
          onSelectionChanged: (value) => setState(() => _bulk = value.single),
        ),
        TextField(
          key: const Key('product.code'),
          controller: _codeController,
          decoration: const InputDecoration(labelText: 'Product code'),
        ),
        TextField(
          key: const Key('product.name'),
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Product name'),
        ),
        TextField(
          key: const Key('product.brand'),
          controller: _brandController,
          decoration: const InputDecoration(labelText: 'Brand'),
        ),
        if (!_bulk)
          Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key('product.packageAmount'),
                  controller: _packageAmountController,
                  decoration: const InputDecoration(
                    labelText: 'Package amount',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  key: const Key('product.packageUnit'),
                  controller: _packageUnitController,
                  decoration: const InputDecoration(labelText: 'Package unit'),
                ),
              ),
            ],
          ),
        Row(
          children: [
            Expanded(
              child: TextField(
                key: const Key('item.quantity'),
                controller: _purchasedAmountController,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                key: const Key('item.unit'),
                controller: _purchasedUnitController,
                decoration: const InputDecoration(labelText: 'Unit'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                key: const Key('item.packageCount'),
                controller: _packageCountController,
                decoration: const InputDecoration(labelText: 'Packages'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                key: const Key('item.lineTotal'),
                controller: _lineTotalController,
                decoration: const InputDecoration(labelText: 'Line total'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            FilledButton(
              key: const Key('item.add'),
              onPressed: _addItem,
              child: const Text('Add item'),
            ),
            FilledButton.tonal(
              key: const Key('purchase.register'),
              onPressed: _items.isEmpty ? null : _registerPurchase,
              child: Text('Register ${_items.length} item(s)'),
            ),
          ],
        ),
        if (_message != null) ...[
          const SizedBox(height: 12),
          Text(_message!, key: const Key('purchase.message')),
        ],
        if (_warnings.isNotEmpty) ...[
          const SizedBox(height: 12),
          for (final warning in _warnings)
            Text(
              'Similar: ${warning.existingProduct.displayName}',
              key: const Key('product.similarityWarning'),
            ),
        ],
      ],
    );
  }
}

int _parseMinorUnits(String value) {
  final trimmed = value.trim().replaceAll(',', '.');
  final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(trimmed);
  if (match == null) {
    throw ArgumentError('Invalid money amount: $value');
  }
  final whole = int.parse(match.group(1)!);
  final fraction = (match.group(2) ?? '').padRight(2, '0');
  return whole * 100 + int.parse(fraction);
}
