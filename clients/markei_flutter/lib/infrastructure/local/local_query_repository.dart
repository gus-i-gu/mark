import 'package:drift/drift.dart';

import '../../application/catalogue_queries.dart';
import '../../application/purchase_history.dart';
import '../../domain/catalogue/product.dart' as domain;
import '../../domain/catalogue/product_code.dart' as domain_code;
import '../../domain/shared/ids.dart';
import '../../domain/shared/quantity.dart' as domain_quantity;
import '../../domain/store/store.dart' as domain_store;
import 'local_database.dart';

class LocalQueryRepository
    implements CatalogueQueryRepository, PurchaseHistoryRepository {
  const LocalQueryRepository(this._db);

  final LocalDatabase _db;

  @override
  Future<List<domain.Product>> listProducts(AccountId accountId) async {
    final rows =
        await (_db.select(_db.products)
              ..where((table) => table.accountId.equals(accountId.value))
              ..orderBy([
                (table) => OrderingTerm(expression: table.displayName),
                (table) => OrderingTerm(expression: table.normalizedName),
              ]))
            .get();
    return rows.map(_productFromRow).toList(growable: false);
  }

  @override
  Future<List<domain_store.Store>> listStores(AccountId accountId) async {
    final rows =
        await (_db.select(_db.stores)
              ..where((table) => table.accountId.equals(accountId.value))
              ..orderBy([
                (table) => OrderingTerm(expression: table.displayName),
              ]))
            .get();
    return rows
        .map(
          (row) => domain_store.Store(
            id: StoreId(row.id),
            accountId: AccountId(row.accountId),
            displayName: row.displayName,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<ProductSimilarityWarning>> similarityWarnings(
    AccountId accountId,
    domain.ProductDraft draft,
  ) async {
    final draftProduct = domain.createProductFromDraft(
      accountId: accountId,
      draft: draft,
    );
    final facts = domain.normalizeProductFacts(draft);
    final existing = await listProducts(accountId);
    return existing
        .where((product) => domain.isSimilarButNotExact(product, draftProduct))
        .map(
          (product) => ProductSimilarityWarning(
            existingProduct: product,
            draftFacts: facts,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<PurchaseHistoryEntry>> listRecentPurchases(
    AccountId accountId,
  ) async {
    final query =
        _db.select(_db.purchases).join([
            innerJoin(
              _db.stores,
              _db.stores.id.equalsExp(_db.purchases.storeId),
            ),
          ])
          ..where(_db.purchases.accountId.equals(accountId.value))
          ..orderBy([OrderingTerm.desc(_db.purchases.occurrenceTime)])
          ..limit(50);

    final rows = await query.get();
    final entries = <PurchaseHistoryEntry>[];
    for (final row in rows) {
      final purchase = row.readTable(_db.purchases);
      final store = row.readTable(_db.stores);
      final itemCount =
          await (_db.selectOnly(_db.purchaseItems)
                ..addColumns([_db.purchaseItems.id.count()])
                ..where(_db.purchaseItems.purchaseId.equals(purchase.id)))
              .map((row) => row.read(_db.purchaseItems.id.count()) ?? 0)
              .getSingle();
      entries.add(
        PurchaseHistoryEntry(
          purchaseId: PurchaseId(purchase.id),
          storeName: store.displayName,
          occurrenceTime: purchase.occurrenceTime,
          currencyCode: purchase.currencyCode,
          totalMinorUnits: purchase.totalMinorUnits,
          itemCount: itemCount,
        ),
      );
    }
    return entries;
  }

  domain.Product _productFromRow(Product row) {
    final mode = row.mode == 'BULK'
        ? domain.ProductMode.bulk
        : domain.ProductMode.packaged;
    final kind = switch (row.measurementKind) {
      'MASS' => domain_quantity.MeasurementKind.mass,
      'VOLUME' => domain_quantity.MeasurementKind.volume,
      'COUNT' => domain_quantity.MeasurementKind.count,
      _ => throw StateError('Unknown measurement kind ${row.measurementKind}.'),
    };
    final unit = switch (row.packageUnit) {
      'KG' => domain_quantity.CanonicalUnit.kg,
      'L' => domain_quantity.CanonicalUnit.l,
      'UNIT' => domain_quantity.CanonicalUnit.unit,
      null => null,
      _ => throw StateError('Unknown package unit ${row.packageUnit}.'),
    };
    return domain.Product(
      id: ProductId(row.id),
      accountId: AccountId(row.accountId),
      userProductCode: domain_code.ProductCode(
        displayValue: row.userProductCode ?? 'legacy',
        normalizedKey: row.normalizedUserProductCode ?? 'legacy',
      ),
      normalizationVersion: row.normalizationVersion,
      displayName: row.displayName ?? row.normalizedName,
      displayBrand: row.displayBrand ?? row.normalizedBrand,
      normalizedName: row.normalizedName,
      normalizedBrand: row.normalizedBrand,
      mode: mode,
      measurementKind: kind,
      packageQuantity: row.packageAmount == null || unit == null
          ? null
          : domain_quantity.NormalizedQuantity.fromDecimalString(
              kind: kind,
              unit: unit,
              decimal: row.packageAmount!,
            ),
    );
  }
}
