import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../application/catalogue_queries.dart';
import '../../application/history_export.dart';
import '../../application/local_references.dart';
import '../../application/product_lists.dart';
import '../../application/purchase_history.dart';
import '../../domain/catalogue/product.dart' as domain;
import '../../domain/catalogue/product_code.dart' as domain_code;
import '../../domain/references/local_reference.dart';
import '../../domain/shared/ids.dart';
import '../../domain/shared/quantity.dart' as domain_quantity;
import '../../domain/store/store.dart' as domain_store;
import 'local_database.dart';

class LocalQueryRepository
    implements
        CatalogueQueryRepository,
        PurchaseHistoryRepository,
        LocalReferenceRepository,
        AccountPreferenceRepository,
        ProductListProjectionRepository,
        PurchaseExportRepository {
  LocalQueryRepository(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final LocalDatabase _db;
  final Uuid _uuid;

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
  Future<domain.Product?> productByCode(
    AccountId accountId,
    String productCode,
  ) async {
    final code = domain_code.normalizeProductCode(productCode).normalizedKey;
    final row =
        await (_db.select(_db.products)..where(
              (table) =>
                  table.accountId.equals(accountId.value) &
                  table.normalizedUserProductCode.equals(code),
            ))
            .getSingleOrNull();
    return row == null ? null : _productFromRow(row);
  }

  @override
  Future<domain.Product?> productByExactIdentity(
    AccountId accountId,
    domain.ProductDraft draft,
  ) async {
    final product = domain.createProductFromDraft(
      accountId: accountId,
      draft: draft,
    );
    final row =
        await (_db.select(_db.products)..where(
              (table) =>
                  table.accountId.equals(accountId.value) &
                  table.exactIdentityKey.equals(product.identityKey),
            ))
            .getSingleOrNull();
    return row == null ? null : _productFromRow(row);
  }

  @override
  Future<domain.Product?> productDetail(
    AccountId accountId,
    ProductId productId,
  ) async {
    final row =
        await (_db.select(_db.products)..where(
              (table) =>
                  table.accountId.equals(accountId.value) &
                  table.id.equals(productId.value),
            ))
            .getSingleOrNull();
    return row == null ? null : _productFromRow(row);
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
  Future<domain.Product> createProduct(
    AccountId accountId,
    domain.ProductDraft draft,
  ) async {
    final now = DateTime.now().toUtc();
    final product = domain.createProductFromDraft(
      accountId: accountId,
      draft: draft,
      uuid: _uuid,
    );
    await _db
        .into(_db.localAccounts)
        .insertOnConflictUpdate(
          LocalAccountsCompanion.insert(
            id: accountId.value,
            defaultCurrencyCode: 'BRL',
            createdAt: now,
          ),
        );
    final exact =
        await (_db.select(_db.products)..where(
              (table) =>
                  table.accountId.equals(accountId.value) &
                  table.exactIdentityKey.equals(product.identityKey),
            ))
            .getSingleOrNull();
    if (exact != null) {
      return _productFromRow(exact);
    }
    final code =
        await (_db.select(_db.products)..where(
              (table) =>
                  table.accountId.equals(accountId.value) &
                  table.normalizedUserProductCode.equals(
                    product.userProductCode.normalizedKey,
                  ),
            ))
            .getSingleOrNull();
    if (code != null) {
      throw ArgumentError('Product code already exists in this account.');
    }
    await _db
        .into(_db.products)
        .insert(
          ProductsCompanion.insert(
            id: product.id.value,
            accountId: product.accountId.value,
            userProductCode: Value(product.userProductCode.displayValue),
            normalizedUserProductCode: Value(
              product.userProductCode.normalizedKey,
            ),
            normalizationVersion: product.normalizationVersion,
            displayName: Value(product.displayName),
            displayBrand: Value(product.displayBrand),
            normalizedName: product.normalizedName,
            normalizedBrand: product.normalizedBrand,
            mode: product.mode.name.toUpperCase(),
            measurementKind: product.measurementKind.name.toUpperCase(),
            packageAmount: Value(product.packageQuantity?.decimalText),
            packageUnit: Value(
              product.packageQuantity?.unit.name.toUpperCase(),
            ),
            exactIdentityKey: product.identityKey,
            createdAt: now,
          ),
        );
    return product;
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
            leftOuterJoin(
              _db.people,
              _db.people.id.equalsExp(_db.purchases.personId),
            ),
            leftOuterJoin(
              _db.paymentMethods,
              _db.paymentMethods.id.equalsExp(_db.purchases.paymentMethodId),
            ),
          ])
          ..where(_db.purchases.accountId.equals(accountId.value))
          ..orderBy([OrderingTerm.desc(_db.purchases.occurrenceTime)])
          ..limit(50);

    final rows = await query.get();
    final purchaseIds = rows
        .map((row) => row.readTable(_db.purchases).id)
        .toList(growable: false);
    final counts = <String, int>{};
    if (purchaseIds.isNotEmpty) {
      final countRows =
          await (_db.selectOnly(_db.purchaseItems)
                ..addColumns([
                  _db.purchaseItems.purchaseId,
                  _db.purchaseItems.id.count(),
                ])
                ..where(_db.purchaseItems.purchaseId.isIn(purchaseIds))
                ..groupBy([_db.purchaseItems.purchaseId]))
              .get();
      for (final row in countRows) {
        counts[row.read(_db.purchaseItems.purchaseId)!] =
            row.read(_db.purchaseItems.id.count()) ?? 0;
      }
    }
    return rows
        .map((row) {
          final purchase = row.readTable(_db.purchases);
          final store = row.readTable(_db.stores);
          final person = row.readTableOrNull(_db.people);
          final paymentMethod = row.readTableOrNull(_db.paymentMethods);
          return PurchaseHistoryEntry(
            purchaseId: PurchaseId(purchase.id),
            storeName: store.displayName,
            occurrenceTime: purchase.occurrenceTime,
            currencyCode: purchase.currencyCode,
            totalMinorUnits: purchase.totalMinorUnits,
            itemCount: counts[purchase.id] ?? 0,
            personLabel: _referenceLabel(person?.nickname, person?.active),
            paymentMethodLabel: _referenceLabel(
              paymentMethod?.nickname,
              paymentMethod?.active,
            ),
          );
        })
        .toList(growable: false);
  }

  @override
  Future<PurchaseDetail?> getPurchaseDetail(
    AccountId accountId,
    PurchaseId purchaseId,
  ) async {
    final purchaseRows =
        await (_db.select(_db.purchases).join([
              innerJoin(
                _db.stores,
                _db.stores.id.equalsExp(_db.purchases.storeId),
              ),
              leftOuterJoin(
                _db.people,
                _db.people.id.equalsExp(_db.purchases.personId),
              ),
              leftOuterJoin(
                _db.paymentMethods,
                _db.paymentMethods.id.equalsExp(_db.purchases.paymentMethodId),
              ),
            ])..where(
              _db.purchases.accountId.equals(accountId.value) &
                  _db.purchases.id.equals(purchaseId.value),
            ))
            .get();
    if (purchaseRows.isEmpty) {
      return null;
    }
    final purchase = purchaseRows.single.readTable(_db.purchases);
    final store = purchaseRows.single.readTable(_db.stores);
    final person = purchaseRows.single.readTableOrNull(_db.people);
    final paymentMethod = purchaseRows.single.readTableOrNull(
      _db.paymentMethods,
    );
    final itemRows =
        await (_db.select(_db.purchaseItems).join([
                innerJoin(
                  _db.products,
                  _db.products.id.equalsExp(_db.purchaseItems.productId),
                ),
              ])
              ..where(_db.purchaseItems.purchaseId.equals(purchase.id))
              ..orderBy([OrderingTerm.asc(_db.products.displayName)]))
            .get();
    final items = itemRows
        .map((row) {
          final item = row.readTable(_db.purchaseItems);
          final product = row.readTable(_db.products);
          return PurchaseDetailItem(
            productId: ProductId(product.id),
            productName: product.displayName ?? product.normalizedName,
            productBrand: product.displayBrand ?? product.normalizedBrand,
            productCode: product.userProductCode ?? 'legacy',
            packageCount: item.packageCount,
            measurementKind: item.measurementKind,
            purchasedAmount: item.purchasedAmount,
            purchasedUnit: item.purchasedUnit,
            currencyCode: item.currencyCode,
            lineTotalMinorUnits: item.lineTotalMinorUnits,
          );
        })
        .toList(growable: false);
    return PurchaseDetail(
      entry: PurchaseHistoryEntry(
        purchaseId: PurchaseId(purchase.id),
        storeName: store.displayName,
        occurrenceTime: purchase.occurrenceTime,
        currencyCode: purchase.currencyCode,
        totalMinorUnits: purchase.totalMinorUnits,
        itemCount: items.length,
        personLabel: _referenceLabel(person?.nickname, person?.active),
        paymentMethodLabel: _referenceLabel(
          paymentMethod?.nickname,
          paymentMethod?.active,
        ),
      ),
      items: items,
    );
  }

  @override
  Future<PurchaseExportBundle> exportBundle(
    AccountId accountId,
    Set<PurchaseId> purchaseIds,
  ) async {
    final details = <PurchaseDetail>[];
    for (final purchaseId in purchaseIds) {
      final detail = await getPurchaseDetail(accountId, purchaseId);
      if (detail != null) {
        details.add(detail);
      }
    }
    details.sort(
      (a, b) => a.entry.occurrenceTime.compareTo(b.entry.occurrenceTime),
    );
    return PurchaseExportBundle(purchases: details);
  }

  @override
  Future<List<LocalReference>> listReferences(
    AccountId accountId,
    LocalReferenceKind kind, {
    bool includeArchived = false,
  }) async {
    if (kind == LocalReferenceKind.person) {
      final rows =
          await (_db.select(_db.people)
                ..where((row) {
                  final activeExpr = includeArchived
                      ? const Constant(true)
                      : row.active.equals(true);
                  return row.accountId.equals(accountId.value) & activeExpr;
                })
                ..orderBy([(row) => OrderingTerm(expression: row.nickname)]))
              .get();
      return rows
          .map((row) => _referenceFromRow(kind, row))
          .toList(growable: false);
    }
    final rows =
        await (_db.select(_db.paymentMethods)
              ..where((row) {
                final activeExpr = includeArchived
                    ? const Constant(true)
                    : row.active.equals(true);
                return row.accountId.equals(accountId.value) & activeExpr;
              })
              ..orderBy([(row) => OrderingTerm(expression: row.nickname)]))
            .get();
    return rows
        .map((row) => _referenceFromRow(kind, row))
        .toList(growable: false);
  }

  @override
  Future<LocalReference> saveReference({
    required AccountId accountId,
    required LocalReferenceKind kind,
    String? id,
    required String nickname,
    bool active = true,
  }) async {
    final now = DateTime.now().toUtc();
    final trimmed = nickname.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Nickname is required.');
    }
    await _ensureAccount(accountId, now);
    final normalized = normalizeReferenceNickname(trimmed);
    final referenceId = id ?? _uuid.v4();
    if (kind == LocalReferenceKind.person) {
      await _db
          .into(_db.people)
          .insertOnConflictUpdate(
            PeopleCompanion.insert(
              id: referenceId,
              accountId: accountId.value,
              nickname: trimmed,
              normalizedNickname: normalized,
              active: Value(active),
              createdAt: now,
              updatedAt: now,
              archivedAt: Value(active ? null : now),
            ),
          );
      final row = await (_db.select(
        _db.people,
      )..where((table) => table.id.equals(referenceId))).getSingle();
      return _referenceFromRow(kind, row);
    }
    await _db
        .into(_db.paymentMethods)
        .insertOnConflictUpdate(
          PaymentMethodsCompanion.insert(
            id: referenceId,
            accountId: accountId.value,
            nickname: trimmed,
            normalizedNickname: normalized,
            active: Value(active),
            createdAt: now,
            updatedAt: now,
            archivedAt: Value(active ? null : now),
          ),
        );
    final row = await (_db.select(
      _db.paymentMethods,
    )..where((table) => table.id.equals(referenceId))).getSingle();
    return _referenceFromRow(kind, row);
  }

  @override
  Future<void> archiveReference({
    required AccountId accountId,
    required LocalReferenceKind kind,
    required String id,
  }) async {
    final now = DateTime.now().toUtc();
    if (kind == LocalReferenceKind.person) {
      await (_db.update(_db.people)..where(
            (table) =>
                table.accountId.equals(accountId.value) & table.id.equals(id),
          ))
          .write(
            PeopleCompanion(
              active: const Value(false),
              updatedAt: Value(now),
              archivedAt: Value(now),
            ),
          );
      return;
    }
    await (_db.update(_db.paymentMethods)..where(
          (table) =>
              table.accountId.equals(accountId.value) & table.id.equals(id),
        ))
        .write(
          PaymentMethodsCompanion(
            active: const Value(false),
            updatedAt: Value(now),
            archivedAt: Value(now),
          ),
        );
  }

  @override
  Future<int> shortageThresholdDays(AccountId accountId) async {
    final row =
        await (_db.select(_db.accountPreferences)
              ..where((table) => table.accountId.equals(accountId.value)))
            .getSingleOrNull();
    return row?.shortageThresholdDays ?? 5;
  }

  @override
  Future<void> setShortageThresholdDays(AccountId accountId, int days) async {
    if (days < 0 || days > 365) {
      throw ArgumentError('Shortage threshold must be 0-365 days.');
    }
    final now = DateTime.now().toUtc();
    await _ensureAccount(accountId, now);
    await _db
        .into(_db.accountPreferences)
        .insertOnConflictUpdate(
          AccountPreferencesCompanion.insert(
            accountId: accountId.value,
            shortageThresholdDays: Value(days),
            updatedAt: now,
          ),
        );
  }

  @override
  Future<ProductListProjection> productListProjection({
    required AccountId accountId,
    required ProductListView view,
    required DateTime today,
  }) async {
    final threshold = await shortageThresholdDays(accountId);
    final rows =
        await (_db.select(_db.products).join([
                leftOuterJoin(
                  _db.purchaseItems,
                  _db.purchaseItems.productId.equalsExp(_db.products.id),
                ),
                leftOuterJoin(
                  _db.purchases,
                  _db.purchases.id.equalsExp(_db.purchaseItems.purchaseId),
                ),
              ])
              ..where(_db.products.accountId.equals(accountId.value))
              ..orderBy([
                OrderingTerm.asc(_db.products.displayName),
                OrderingTerm.asc(_db.purchases.occurrenceTime),
              ]))
            .get();
    final observations = <String, List<_ListObservation>>{};
    final productRows = <String, Product>{};
    for (final row in rows) {
      final product = row.readTable(_db.products);
      productRows[product.id] = product;
      final purchase = row.readTableOrNull(_db.purchases);
      final item = row.readTableOrNull(_db.purchaseItems);
      if (purchase != null && item != null) {
        observations
            .putIfAbsent(product.id, () => [])
            .add(
              _ListObservation(
                date: purchase.occurrenceTime.toLocal(),
                currencyCode: item.currencyCode,
                lineTotalMinorUnits: item.lineTotalMinorUnits,
              ),
            );
      }
    }
    final allItems = productRows.values
        .map((product) {
          final productObservations = observations[product.id] ?? const [];
          final cycle = personalCycleV1(
            productObservations.map((observation) => observation.date).toList(),
            today,
          );
          final latest = productObservations.isEmpty
              ? null
              : productObservations.reduce(
                  (a, b) => a.date.isAfter(b.date) ? a : b,
                );
          return ProductListProjectionItem(
            productId: ProductId(product.id),
            productCode: product.userProductCode ?? 'legacy',
            productName: product.displayName ?? product.normalizedName,
            productBrand: product.displayBrand ?? product.normalizedBrand,
            cycle: cycle,
            latestCurrencyCode: latest?.currencyCode,
            latestLineTotalMinorUnits: latest?.lineTotalMinorUnits,
          );
        })
        .toList(growable: false);
    final visible = allItems
        .where((item) => itemBelongsToView(item, view, threshold))
        .toList(growable: false);
    final totalCandidates = allItems
        .where(
          (item) =>
              itemBelongsToView(item, ProductListView.shortage, threshold) ||
              itemBelongsToView(item, ProductListView.market, threshold),
        )
        .toList(growable: false);
    final currencies = totalCandidates
        .map((item) => item.latestCurrencyCode)
        .whereType<String>()
        .toSet();
    final total =
        currencies.length == 1 &&
            totalCandidates.every(
              (item) => item.latestLineTotalMinorUnits != null,
            )
        ? totalCandidates.fold<int>(
            0,
            (sum, item) => sum + item.latestLineTotalMinorUnits!,
          )
        : null;
    return ProductListProjection(
      view: view,
      items: visible,
      shortageThresholdDays: threshold,
      approximateTotalCurrencyCode: total == null ? null : currencies.single,
      approximateTotalMinorUnits: total,
    );
  }

  @override
  Future<PriceChangeResult> priceChangeForProduct(
    AccountId accountId,
    ProductId productId,
  ) async {
    final rows =
        await (_db.select(_db.purchaseItems).join([
                innerJoin(
                  _db.purchases,
                  _db.purchases.id.equalsExp(_db.purchaseItems.purchaseId),
                ),
                innerJoin(
                  _db.stores,
                  _db.stores.id.equalsExp(_db.purchases.storeId),
                ),
              ])
              ..where(
                _db.purchases.accountId.equals(accountId.value) &
                    _db.purchaseItems.productId.equals(productId.value),
              )
              ..orderBy([OrderingTerm.desc(_db.purchases.occurrenceTime)]))
            .get();
    final observations = <ProductPriceObservation>[];
    for (final row in rows) {
      final item = row.readTable(_db.purchaseItems);
      final purchase = row.readTable(_db.purchases);
      final store = row.readTable(_db.stores);
      final kind = _measurementKind(item.measurementKind);
      final unit = _canonicalUnit(item.purchasedUnit);
      observations.add(
        ProductPriceObservation(
          productId: ProductId(item.productId),
          storeName: store.displayName,
          occurrenceTime: purchase.occurrenceTime,
          currencyCode: item.currencyCode,
          measurementKind: kind,
          purchasedUnit: unit,
          purchasedMicrounits:
              domain_quantity.NormalizedQuantity.fromDecimalString(
                kind: kind,
                unit: unit,
                decimal: item.purchasedAmount,
              ).microunits,
          lineTotalMinorUnits: item.lineTotalMinorUnits,
        ),
      );
    }
    return compareLatestCompatibleObservations(observations);
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

  LocalReference _referenceFromRow(LocalReferenceKind kind, dynamic row) {
    return LocalReference(
      id: row.id as String,
      accountId: AccountId(row.accountId as String),
      kind: kind,
      nickname: row.nickname as String,
      normalizedNickname: row.normalizedNickname as String,
      active: row.active as bool,
      createdAt: row.createdAt as DateTime,
      updatedAt: row.updatedAt as DateTime,
      archivedAt: row.archivedAt as DateTime?,
    );
  }

  String? _referenceLabel(String? nickname, bool? active) {
    if (nickname == null) {
      return null;
    }
    return active == false ? '$nickname (archived)' : nickname;
  }

  Future<void> _ensureAccount(AccountId accountId, DateTime now) async {
    await _db
        .into(_db.localAccounts)
        .insertOnConflictUpdate(
          LocalAccountsCompanion.insert(
            id: accountId.value,
            defaultCurrencyCode: 'BRL',
            createdAt: now,
          ),
        );
  }

  domain_quantity.MeasurementKind _measurementKind(String value) {
    return switch (value) {
      'MASS' => domain_quantity.MeasurementKind.mass,
      'VOLUME' => domain_quantity.MeasurementKind.volume,
      'COUNT' => domain_quantity.MeasurementKind.count,
      _ => throw StateError('Unknown measurement kind $value.'),
    };
  }

  domain_quantity.CanonicalUnit _canonicalUnit(String value) {
    return switch (value) {
      'KG' => domain_quantity.CanonicalUnit.kg,
      'L' => domain_quantity.CanonicalUnit.l,
      'UNIT' => domain_quantity.CanonicalUnit.unit,
      _ => throw StateError('Unknown purchased unit $value.'),
    };
  }
}

final class _ListObservation {
  const _ListObservation({
    required this.date,
    required this.currencyCode,
    required this.lineTotalMinorUnits,
  });

  final DateTime date;
  final String currencyCode;
  final int lineTotalMinorUnits;
}
