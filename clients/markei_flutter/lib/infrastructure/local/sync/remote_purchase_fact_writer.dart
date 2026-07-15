import 'package:drift/drift.dart';

import '../local_database.dart';

final class RemotePurchaseFactWriter {
  const RemotePurchaseFactWriter(this._db);

  final LocalDatabase _db;

  Future<void> applyPurchaseRegistered(Map<String, Object?> event) async {
    final payload = event['payload'] as Map<String, Object?>;
    final purchase = payload['purchase'] as Map<String, Object?>;
    final accountId = event['accountId'] as String;
    if (purchase['personId'] != null || purchase['paymentMethodId'] != null) {
      throw StateError('Remote reference snapshots are required.');
    }
    await _db
        .into(_db.localAccounts)
        .insert(
          LocalAccountsCompanion.insert(
            id: accountId,
            defaultCurrencyCode: purchase['currencyCode'] as String,
            createdAt: DateTime.now().toUtc(),
          ),
          mode: InsertMode.insertOrIgnore,
        );
    await _applyStore(purchase['store'] as Map<String, Object?>);
    final products = (payload['productSnapshots'] as List<Object?>)
        .cast<Map<String, Object?>>();
    for (final product in products) {
      await _applyProduct(product);
    }
    await _applyPurchase(purchase);
  }

  Future<void> _applyStore(Map<String, Object?> store) async {
    final id = store['id'] as String;
    final accountId = store['accountId'] as String;
    final existing = await (_db.select(
      _db.stores,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing != null) {
      if (existing.accountId != accountId ||
          existing.displayName != store['displayName']) {
        throw StateError('Store identity conflict.');
      }
      return;
    }
    await _db
        .into(_db.stores)
        .insert(
          StoresCompanion.insert(
            id: id,
            accountId: accountId,
            displayName: store['displayName'] as String,
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> _applyProduct(Map<String, Object?> product) async {
    final id = product['id'] as String;
    final userCode = product['userProductCode'] as Map<String, Object?>;
    final packageQuantity = product['packageQuantity'] as Map<String, Object?>?;
    final existing = await (_db.select(
      _db.products,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing != null) {
      if (existing.accountId != product['accountId'] ||
          existing.exactIdentityKey != product['identityKey']) {
        throw StateError('Product identity conflict.');
      }
      return;
    }
    await _db
        .into(_db.products)
        .insert(
          ProductsCompanion.insert(
            id: id,
            accountId: product['accountId'] as String,
            userProductCode: userCode['displayValue'] as String,
            normalizedUserProductCode: userCode['normalizedKey'] as String,
            normalizationVersion: product['normalizationVersion'] as int,
            displayName: Value(product['displayName'] as String?),
            displayBrand: Value(product['displayBrand'] as String?),
            normalizedName: product['normalizedName'] as String,
            normalizedBrand: product['normalizedBrand'] as String,
            mode: product['mode'] as String,
            measurementKind: product['measurementKind'] as String,
            packageAmount: Value(packageQuantity?['amount'] as String?),
            packageUnit: Value(packageQuantity?['unit'] as String?),
            exactIdentityKey: product['identityKey'] as String,
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> _applyPurchase(Map<String, Object?> purchase) async {
    final id = purchase['id'] as String;
    final existing = await (_db.select(
      _db.purchases,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing != null) {
      if (existing.totalMinorUnits != purchase['totalMinorUnits']) {
        throw StateError('Purchase identity conflict.');
      }
      return;
    }
    await _db
        .into(_db.purchases)
        .insert(
          PurchasesCompanion.insert(
            id: id,
            accountId: purchase['accountId'] as String,
            storeId:
                (purchase['store'] as Map<String, Object?>)['id'] as String,
            personId: const Value(null),
            paymentMethodId: const Value(null),
            occurrenceTime: DateTime.parse(
              purchase['occurrenceTime'] as String,
            ),
            currencyCode: purchase['currencyCode'] as String,
            totalMinorUnits: purchase['totalMinorUnits'] as int,
            createdAt: DateTime.now().toUtc(),
          ),
        );
    for (final item
        in (purchase['items'] as List<Object?>).cast<Map<String, Object?>>()) {
      await _applyItem(item);
    }
  }

  Future<void> _applyItem(Map<String, Object?> item) async {
    final quantity = item['purchasedQuantity'] as Map<String, Object?>;
    final money = item['lineTotal'] as Map<String, Object?>;
    await _db
        .into(_db.purchaseItems)
        .insert(
          PurchaseItemsCompanion.insert(
            id: item['id'] as String,
            purchaseId: item['purchaseId'] as String,
            productId: item['productId'] as String,
            packageCount: Value(item['packageCount'] as int?),
            measurementKind: quantity['kind'] as String,
            purchasedAmount: quantity['amount'] as String,
            purchasedUnit: quantity['unit'] as String,
            currencyCode: money['currencyCode'] as String,
            lineTotalMinorUnits: money['minorUnits'] as int,
          ),
        );
  }
}
