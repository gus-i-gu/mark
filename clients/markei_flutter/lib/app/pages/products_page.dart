import 'package:flutter/material.dart';

import '../../application/catalogue_queries.dart';
import '../../domain/catalogue/product.dart';
import '../../domain/shared/ids.dart';
import '../../domain/shared/quantity.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    required this.accountId,
    required this.catalogueQueries,
    required this.refreshSignal,
    required this.onChanged,
    super.key,
  });

  final AccountId accountId;
  final CatalogueQueryRepository catalogueQueries;
  final int refreshSignal;
  final VoidCallback onChanged;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _searchController = TextEditingController();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _packageAmountController = TextEditingController(text: '1');
  final _packageUnitController = TextEditingController(text: 'kg');
  List<Product> _products = const [];
  List<ProductSimilarityWarning> _warnings = const [];
  bool _loading = true;
  bool _bulk = false;
  Product? _selectedProduct;
  Product? _selectedDetail;
  String? _message;
  bool _messageIsError = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void didUpdateWidget(covariant ProductsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshSignal != widget.refreshSignal) {
      _loadProducts(clearMessage: false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _codeController.dispose();
    _nameController.dispose();
    _brandController.dispose();
    _packageAmountController.dispose();
    _packageUnitController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts({bool clearMessage = true}) async {
    setState(() => _loading = true);
    try {
      final products = await widget.catalogueQueries.listProducts(
        widget.accountId,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _products = products;
        _loading = false;
        if (clearMessage) {
          _message = null;
        }
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _message = 'Products could not be loaded. Try again.';
        _messageIsError = true;
      });
    }
  }

  Future<void> _checkSimilar() async {
    try {
      final warnings = await widget.catalogueQueries.similarityWarnings(
        widget.accountId,
        _draft(),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _warnings = warnings;
        _message = warnings.isEmpty
            ? 'No similar Product found.'
            : 'Similar Product found. Use an existing Product or create anyway.';
        _messageIsError = false;
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _message = 'Check the Product details and try again.';
        _messageIsError = true;
      });
    }
  }

  Future<void> _createProduct({required bool createAnyway}) async {
    if (!createAnyway) {
      await _checkSimilar();
      if (_warnings.isNotEmpty) {
        return;
      }
    }
    try {
      await widget.catalogueQueries.createProduct(widget.accountId, _draft());
      if (!mounted) {
        return;
      }
      setState(() {
        _warnings = const [];
        _message = 'Product created locally.';
        _messageIsError = false;
        _codeController.clear();
        _nameController.clear();
        _brandController.clear();
      });
      await _loadProducts();
      widget.onChanged();
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _message =
            'Product could not be created. Check the details and try again.';
        _messageIsError = true;
      });
    }
  }

  ProductDraft _draft() {
    return ProductDraft(
      userCode: _codeController.text,
      name: _nameController.text,
      brand: _brandController.text,
      mode: _bulk ? ProductMode.bulk : ProductMode.packaged,
      measurementKind: _measurementKindFromUnit(),
      packageAmount: _bulk ? null : _packageAmountController.text,
      packageUnit: _bulk ? null : _packageUnitController.text,
    );
  }

  MeasurementKind _measurementKindFromUnit() {
    final unit = _packageUnitController.text.trim().toLowerCase();
    if (unit == 'l' || unit == 'ml') {
      return MeasurementKind.volume;
    }
    if (unit == 'un' || unit == 'unit') {
      return MeasurementKind.count;
    }
    return MeasurementKind.mass;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: Text('Loading Products...', key: Key('products.loading')),
      );
    }
    final query = _searchController.text.trim().toLowerCase();
    final visible = _products
        .where((product) {
          if (query.isEmpty) {
            return true;
          }
          return product.displayName.toLowerCase().contains(query) ||
              product.displayBrand.toLowerCase().contains(query) ||
              product.userProductCode.displayValue.toLowerCase().contains(
                query,
              );
        })
        .toList(growable: false);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Catalogue', style: TextStyle(fontSize: 22)),
        const SizedBox(height: 8),
        TextField(
          key: const Key('products.search'),
          controller: _searchController,
          decoration: const InputDecoration(labelText: 'Product code or name'),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        if (_products.isEmpty)
          const Text('No Products yet.', key: Key('products.empty'))
        else if (visible.isEmpty)
          const Text(
            'No matching Product. Create a Product below.',
            key: Key('products.noMatch'),
          )
        else
          for (final product in visible)
            GestureDetector(
              onDoubleTap: () => setState(() {
                _selectedProduct = product;
                _selectedDetail = product;
              }),
              child: ListTile(
                key: Key('products.product.${product.id.value}'),
                selected: _selectedProduct?.id.value == product.id.value,
                title: Text(product.displayName),
                subtitle: Text(
                  '${product.displayBrand} · ${product.userProductCode.displayValue}',
                ),
                trailing: TextButton(
                  key: Key('products.view.${product.id.value}'),
                  onPressed: () => setState(() {
                    _selectedProduct = product;
                    _selectedDetail = product;
                  }),
                  child: const Text('View details'),
                ),
                onTap: () => setState(() => _selectedProduct = product),
                onLongPress: () => setState(() => _selectedDetail = product),
              ),
            ),
        if (_selectedProduct != null) ...[
          const SizedBox(height: 8),
          Text(
            'Selected ${_selectedProduct!.userProductCode.displayValue} · ${_selectedProduct!.displayName}',
            key: const Key('products.selected'),
          ),
        ],
        if (_selectedDetail != null) ...[
          const Divider(height: 32),
          _ProductDetail(product: _selectedDetail!),
        ],
        const Divider(height: 32),
        const Text('Create Product', style: TextStyle(fontSize: 18)),
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: false, label: Text('Packaged')),
            ButtonSegment(value: true, label: Text('Bulk')),
          ],
          selected: {_bulk},
          onSelectionChanged: (value) => setState(() => _bulk = value.single),
        ),
        TextField(
          key: const Key('products.create.code'),
          controller: _codeController,
          decoration: const InputDecoration(labelText: 'Product code'),
        ),
        TextField(
          key: const Key('products.create.name'),
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Product name'),
        ),
        TextField(
          key: const Key('products.create.brand'),
          controller: _brandController,
          decoration: const InputDecoration(labelText: 'Brand'),
        ),
        if (!_bulk)
          Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key('products.create.packageAmount'),
                  controller: _packageAmountController,
                  decoration: const InputDecoration(labelText: 'Package size'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  key: const Key('products.create.packageUnit'),
                  controller: _packageUnitController,
                  decoration: const InputDecoration(labelText: 'Package unit'),
                ),
              ),
            ],
          ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton(
              key: const Key('products.create'),
              onPressed: () => _createProduct(createAnyway: false),
              child: const Text('Create Product'),
            ),
            FilledButton.tonal(
              key: const Key('products.createAnyway'),
              onPressed: () => _createProduct(createAnyway: true),
              child: const Text('Create anyway'),
            ),
            OutlinedButton(
              key: const Key('products.retry'),
              onPressed: _loadProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
        if (_message != null) ...[
          const SizedBox(height: 12),
          Text(
            _message!,
            key: const Key('products.message'),
            style: TextStyle(
              color: _messageIsError
                  ? Theme.of(context).colorScheme.error
                  : null,
            ),
          ),
        ],
        if (_warnings.isNotEmpty) ...[
          const SizedBox(height: 12),
          const Text('Similar Product found', key: Key('products.similar')),
          for (final warning in _warnings)
            ListTile(
              title: Text(warning.existingProduct.displayName),
              subtitle: Text(warning.existingProduct.displayBrand),
            ),
        ],
      ],
    );
  }
}

class _ProductDetail extends StatelessWidget {
  const _ProductDetail({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final package = product.packageQuantity;
    return Card(
      key: const Key('products.detail'),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Product details', style: TextStyle(fontSize: 18)),
            Text('Product code: ${product.userProductCode.displayValue}'),
            Text('Name: ${product.displayName}'),
            Text('Brand: ${product.displayBrand}'),
            Text('Mode: ${product.mode.name.toUpperCase()}'),
            if (package != null)
              Text(
                'Package quantity: ${package.decimalText} ${package.unit.name}',
              ),
          ],
        ),
      ),
    );
  }
}
