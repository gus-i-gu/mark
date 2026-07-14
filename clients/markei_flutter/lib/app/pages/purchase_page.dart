import 'package:flutter/material.dart';

import '../../application/catalogue_queries.dart';
import '../../application/register_purchase.dart';
import '../../domain/catalogue/product.dart';
import '../../domain/purchase/purchase.dart';
import '../../domain/shared/ids.dart';
import '../../domain/shared/money.dart';
import '../../domain/shared/quantity.dart';
import '../../domain/store/store.dart';

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
  final List<_DraftLine> _lines = [];
  List<Product> _products = const [];
  List<Store> _stores = const [];
  List<ProductSimilarityWarning> _warnings = const [];
  Product? _selectedProduct;
  Store? _selectedStore;
  bool _loading = true;
  bool _reviewing = false;
  bool _submitting = false;
  bool _bulk = false;
  int? _editingKey;
  ProductReference? _editingReference;
  String? _editingProductLabel;
  int _nextKey = 1;
  _PurchaseFeedback? _feedback;

  int get _stagedTotalMinorUnits {
    return _lines.fold<int>(
      0,
      (total, line) => total + line.item.lineTotal.minorUnits,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCatalogue();
  }

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

  Future<void> _loadCatalogue({bool clearFeedback = true}) async {
    setState(() => _loading = true);
    try {
      final products = await widget.catalogueQueries.listProducts(
        widget.accountId,
      );
      final stores = await widget.catalogueQueries.listStores(widget.accountId);
      if (!mounted) {
        return;
      }
      final previousStoreId = _selectedStore?.id.value;
      final matchingStores = previousStoreId == null
          ? const <Store>[]
          : stores
                .where((store) => store.id.value == previousStoreId)
                .toList(growable: false);
      final selectedStore = previousStoreId == null
          ? (stores.isEmpty ? null : stores.first)
          : (matchingStores.isEmpty ? null : matchingStores.first);
      setState(() {
        _products = products;
        _stores = stores;
        _selectedStore = selectedStore;
        _loading = false;
        if (clearFeedback) {
          _feedback = null;
        }
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _feedback = _PurchaseFeedback.error(
          'Products and Stores could not be loaded. Try again.',
        );
      });
    }
  }

  Future<void> _checkSimilarProducts() async {
    try {
      final warnings = await widget.catalogueQueries.similarityWarnings(
        widget.accountId,
        _productDraft(),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _warnings = warnings;
        _feedback = warnings.isEmpty
            ? _PurchaseFeedback.success('No similar Product found.')
            : _PurchaseFeedback.success(
                'Similar Product found. Choose a Product or create anyway.',
              );
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _feedback = _PurchaseFeedback.error(
          'Check the Product details and try again.',
        );
      });
    }
  }

  Future<void> _stageNewProduct({required bool createAnyway}) async {
    if (!createAnyway) {
      await _checkSimilarProducts();
      if (_warnings.isNotEmpty) {
        return;
      }
    }
    _stageItem(NewProductReference(_productDraft()), _newProductLabel());
  }

  void _stageExistingProduct(Product product) {
    _stageItem(ExistingProductReference(product.id), product.displayName);
  }

  void _saveEditedLine() {
    final reference = _editingReference;
    final productLabel = _editingProductLabel;
    if (_editingKey == null || reference == null || productLabel == null) {
      setState(() {
        _feedback = _PurchaseFeedback.error(
          'Choose a staged Item to edit before saving.',
        );
      });
      return;
    }
    _stageItem(reference, productLabel);
  }

  void _stageItem(ProductReference reference, String productLabel) {
    try {
      final item = PurchaseItemDraft(
        productReference: reference,
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
      setState(() {
        final line = _DraftLine(
          keyValue: _editingKey ?? _nextKey++,
          productLabel: productLabel,
          item: item,
        );
        final index = _lines.indexWhere((line) => line.keyValue == _editingKey);
        if (index == -1) {
          _lines.add(line);
        } else {
          _lines[index] = line;
        }
        _clearEditState();
        _warnings = const [];
        _feedback = _PurchaseFeedback.success('Staged Item saved.');
        _clearItemInputs();
      });
    } on Object {
      setState(() {
        _feedback = _PurchaseFeedback.error(
          'Check the staged Item details and try again.',
        );
      });
    }
  }

  void _editLine(_DraftLine line) {
    setState(() {
      _editingKey = line.keyValue;
      _editingReference = line.item.productReference;
      _editingProductLabel = line.productLabel;
      _reviewing = false;
      _lineTotalController.text = _formatMinorUnits(line.item.lineTotal);
      _packageCountController.text = line.item.packageCount.toString();
      _purchasedAmountController.text = line.item.purchasedQuantity.decimalText;
      _purchasedUnitController.text = line.item.purchasedQuantity.unit.name;
      _feedback = _PurchaseFeedback.success('Editing staged Item.');
    });
  }

  void _removeLine(_DraftLine line) {
    setState(() {
      _lines.removeWhere((candidate) => candidate.keyValue == line.keyValue);
      if (_editingKey == line.keyValue) {
        _clearEditState();
      }
      _reviewing = false;
      _feedback = _PurchaseFeedback.success('Staged Item removed.');
    });
  }

  Future<void> _registerPurchase() async {
    if (_submitting) {
      return;
    }
    final storeReference = _storeReference();
    if (storeReference == null || _lines.isEmpty) {
      setState(() {
        _feedback = _PurchaseFeedback.error(
          'Choose or create a Store and stage at least one Item.',
        );
      });
      return;
    }
    setState(() {
      _submitting = true;
      _feedback = _PurchaseFeedback.success('Registering purchase locally...');
    });
    try {
      await widget.registration.registerPurchase(
        RegisterPurchaseCommand(
          accountId: widget.accountId,
          deviceId: widget.deviceId,
          storeReference: storeReference,
          occurrenceTime: DateTime.now().toUtc(),
          currencyCode: 'BRL',
          items: List.unmodifiable(_lines.map((line) => line.item)),
        ),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _lines.clear();
        _clearEditState();
        _warnings = const [];
        _reviewing = false;
        _submitting = false;
        _feedback = _PurchaseFeedback.success('Purchase registered locally.');
      });
      await _loadCatalogue(clearFeedback: false);
      widget.onRegistered();
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _submitting = false;
        _feedback = _PurchaseFeedback.error(
          'Purchase could not be registered. The draft is still available.',
        );
      });
    }
  }

  StoreReference? _storeReference() {
    final selected = _selectedStore;
    if (selected != null) {
      return ExistingStoreReference(selected.id);
    }
    final displayName = _storeController.text.trim();
    if (displayName.isEmpty) {
      return null;
    }
    final exact = _stores.where((store) => store.displayName == displayName);
    if (exact.isNotEmpty) {
      return ExistingStoreReference(exact.first.id);
    }
    return NewStoreReference(displayName);
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

  String _newProductLabel() {
    final name = _nameController.text.trim();
    return name.isEmpty ? 'New Product' : name;
  }

  void _clearItemInputs() {
    _codeController.clear();
    _nameController.clear();
    _brandController.clear();
    _lineTotalController.clear();
    _selectedProduct = null;
  }

  void _clearEditState() {
    _editingKey = null;
    _editingReference = null;
    _editingProductLabel = null;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: Text(
          'Loading Products and Stores...',
          key: Key('purchase.loading'),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Purchase draft', style: TextStyle(fontSize: 22)),
        const SizedBox(height: 8),
        const Text(
          'Data is stored on this device. Synchronization is not active, and export or restore is not yet provided.',
          key: Key('purchase.localNotice'),
        ),
        const SizedBox(height: 16),
        _storeSection(),
        const Divider(height: 32),
        if (!_reviewing) ...[
          _productSection(),
          const SizedBox(height: 12),
          _quantitySection(),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(
                key: const Key('item.add'),
                onPressed: _editingKey == null
                    ? () => _stageNewProduct(createAnyway: false)
                    : _saveEditedLine,
                child: Text(
                  _editingKey == null ? 'Add staged Item' : 'Save staged Item',
                ),
              ),
              if (_editingKey == null)
                FilledButton.tonal(
                  key: const Key('product.createAnyway'),
                  onPressed: () => _stageNewProduct(createAnyway: true),
                  child: const Text('Create anyway'),
                ),
              OutlinedButton(
                key: const Key('purchase.review'),
                onPressed: _lines.isEmpty
                    ? null
                    : () => setState(() => _reviewing = true),
                child: const Text('Review purchase'),
              ),
            ],
          ),
        ] else ...[
          const Text('Review purchase', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          FilledButton.tonal(
            key: const Key('purchase.backToEdit'),
            onPressed: _submitting
                ? null
                : () => setState(() => _reviewing = false),
            child: const Text('Back to edit'),
          ),
        ],
        const SizedBox(height: 16),
        _stagedLinesSection(),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Staged total BRL ${(_stagedTotalMinorUnits / 100).toStringAsFixed(2)}',
              key: const Key('purchase.stagedTotal'),
            ),
            FilledButton(
              key: const Key('purchase.register'),
              onPressed: _reviewing && _lines.isNotEmpty && !_submitting
                  ? _registerPurchase
                  : null,
              child: Text(_submitting ? 'Registering...' : 'Register purchase'),
            ),
          ],
        ),
        if (_feedback != null) ...[
          const SizedBox(height: 12),
          Text(
            _feedback!.message,
            key: const Key('purchase.message'),
            style: TextStyle(
              color: _feedback!.isError
                  ? Theme.of(context).colorScheme.error
                  : null,
            ),
          ),
        ],
        if (_warnings.isNotEmpty) ...[
          const SizedBox(height: 12),
          const Text(
            'Similar Product found',
            key: Key('product.similarityWarning'),
          ),
          for (final warning in _warnings)
            ListTile(
              title: Text(warning.existingProduct.displayName),
              subtitle: Text(warning.existingProduct.displayBrand),
              trailing: TextButton(
                key: Key('product.use.${warning.existingProduct.id.value}'),
                onPressed: () => _stageExistingProduct(warning.existingProduct),
                child: const Text('Use this Product'),
              ),
            ),
        ],
      ],
    );
  }

  Widget _storeSection() {
    final exactStore = _stores.any(
      (store) => store.displayName == _storeController.text.trim(),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose Store', style: TextStyle(fontSize: 18)),
        if (_stores.isEmpty)
          const Text('No Stores yet. Create a Store for this purchase.')
        else
          DropdownButton<Store?>(
            key: const Key('purchase.store.select'),
            value: _selectedStore,
            isExpanded: true,
            items: [
              for (final store in _stores)
                DropdownMenuItem(value: store, child: Text(store.displayName)),
              const DropdownMenuItem(value: null, child: Text('Create Store')),
            ],
            onChanged: (value) => setState(() => _selectedStore = value),
          ),
        if (_selectedStore == null)
          TextField(
            key: const Key('purchase.store'),
            controller: _storeController,
            decoration: InputDecoration(
              labelText: 'Create Store',
              helperText: exactStore
                  ? 'Store name already available for reuse.'
                  : null,
            ),
          ),
      ],
    );
  }

  Widget _productSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Find or create Product', style: TextStyle(fontSize: 18)),
        if (_products.isEmpty)
          const Text('No Products yet. Create a Product to stage an Item.')
        else
          DropdownButton<Product?>(
            key: const Key('purchase.product.select'),
            value: _selectedProduct,
            hint: const Text('Use existing Product'),
            isExpanded: true,
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Create new Product'),
              ),
              for (final product in _products)
                DropdownMenuItem(
                  value: product,
                  child: Text(product.displayName),
                ),
            ],
            onChanged: (value) => setState(() => _selectedProduct = value),
          ),
        if (_selectedProduct != null)
          FilledButton.tonal(
            key: const Key('product.useSelected'),
            onPressed: () => _stageExistingProduct(_selectedProduct!),
            child: const Text('Use existing Product'),
          )
        else ...[
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
                      labelText: 'Package size',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    key: const Key('product.packageUnit'),
                    controller: _packageUnitController,
                    decoration: const InputDecoration(
                      labelText: 'Package unit',
                    ),
                  ),
                ),
              ],
            ),
        ],
      ],
    );
  }

  Widget _quantitySection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                key: const Key('item.quantity'),
                controller: _purchasedAmountController,
                decoration: const InputDecoration(
                  labelText: 'Total amount bought',
                ),
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
                decoration: const InputDecoration(labelText: 'Packages bought'),
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
      ],
    );
  }

  Widget _stagedLinesSection() {
    if (_lines.isEmpty) {
      return const Text(
        'No staged Items yet.',
        key: Key('purchase.emptyDraft'),
      );
    }
    return Column(
      children: [
        for (final line in _lines)
          ListTile(
            key: Key('purchase.line.${line.keyValue}'),
            title: Text(line.productLabel),
            subtitle: Text(
              '${line.item.packageCount} package(s) · ${line.item.purchasedQuantity.decimalText} ${line.item.purchasedQuantity.unit.name}',
            ),
            trailing: Wrap(
              spacing: 4,
              children: [
                IconButton(
                  key: Key('purchase.line.edit.${line.keyValue}'),
                  tooltip: 'Edit staged Item',
                  onPressed: _submitting ? null : () => _editLine(line),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  key: Key('purchase.line.remove.${line.keyValue}'),
                  tooltip: 'Remove staged Item',
                  onPressed: _submitting ? null : () => _removeLine(line),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

final class _DraftLine {
  const _DraftLine({
    required this.keyValue,
    required this.productLabel,
    required this.item,
  });

  final int keyValue;
  final String productLabel;
  final PurchaseItemDraft item;
}

final class _PurchaseFeedback {
  const _PurchaseFeedback._(this.message, {required this.isError});

  factory _PurchaseFeedback.success(String message) {
    return _PurchaseFeedback._(message, isError: false);
  }

  factory _PurchaseFeedback.error(String message) {
    return _PurchaseFeedback._(message, isError: true);
  }

  final String message;
  final bool isError;
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

String _formatMinorUnits(Money money) {
  return (money.minorUnits / 100).toStringAsFixed(2);
}
