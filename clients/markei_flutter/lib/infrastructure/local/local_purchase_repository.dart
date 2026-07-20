import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../application/app_failure.dart';
import '../../application/register_purchase.dart';
import '../../domain/catalogue/product.dart' as domain;
import '../../domain/catalogue/product_code.dart' as domain_code;
import '../../domain/purchase/purchase.dart' as domain_purchase;
import '../../domain/shared/ids.dart';
import '../../domain/shared/quantity.dart' as domain_quantity;
import '../../domain/store/store.dart' as domain_store;
import '../../domain/sync/canonical_json.dart';
import '../../domain/sync/sync_event.dart' as domain_sync;
import 'local_database.dart';

class LocalPurchaseRepository implements PurchaseRegistrationRepository {
  LocalPurchaseRepository(this._db, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final LocalDatabase _db;
  final Uuid _uuid;

  @override
  Future<PurchaseRegistrationResult> registerPurchase(
    RegisterPurchaseCommand command,
  ) {
    var phase = _PurchaseRegistrationPhase.ensureAccount;
    return _db.transaction(() async {
      try {
        if (command.items.isEmpty) {
          throw ArgumentError('Purchase requires at least one Item.');
        }

        final now = DateTime.now().toUtc();
        await _db
            .into(_db.localAccounts)
            .insert(
              LocalAccountsCompanion.insert(
                id: command.accountId.value,
                defaultCurrencyCode: command.currencyCode,
                createdAt: now,
              ),
              mode: InsertMode.insertOrIgnore,
            );
        phase = _PurchaseRegistrationPhase.ensureSyncState;
        await _db
            .into(_db.syncState)
            .insert(
              SyncStateCompanion.insert(
                accountId: command.accountId.value,
                accountCursor: const Value(null),
                updatedAt: now,
              ),
              mode: InsertMode.insertOrIgnore,
            );
        phase = _PurchaseRegistrationPhase.ensureDevice;
        await _ensureDevice(command, now);

        phase = _PurchaseRegistrationPhase.resolveStore;
        final store = await _resolveStore(command, now);
        phase = _PurchaseRegistrationPhase.resolveReferences;
        await _assertOptionalReference(
          tableName: 'people',
          accountId: command.accountId,
          id: command.personId,
          operation: 'Person selection',
        );
        await _assertOptionalReference(
          tableName: 'payment_methods',
          accountId: command.accountId,
          id: command.paymentMethodId,
          operation: 'Payment Method selection',
        );
        phase = _PurchaseRegistrationPhase.buildPurchase;
        final purchaseId = PurchaseId(_uuid.v4());
        final itemModels = <domain_purchase.PurchaseItem>[];
        final productSnapshots = <Map<String, Object?>>[];

        for (final draft in command.items) {
          phase = _PurchaseRegistrationPhase.resolveProduct;
          final product = await _resolveProduct(command.accountId, draft, now);
          phase = _PurchaseRegistrationPhase.buildPurchase;
          productSnapshots.add(product.toJson());
          final packageCount = product.mode == domain.ProductMode.bulk
              ? null
              : draft.packageCount;
          if (product.mode == domain.ProductMode.packaged &&
              (packageCount == null || packageCount <= 0)) {
            throw const AppFailure(
              code: 'invalid-package-count',
              operation: 'Purchase registration',
              field: 'Packages bought',
              recovery: 'Enter a positive whole package count.',
              retryable: true,
              outcome: FailureOutcome.notApplied,
            );
          }
          final item = domain_purchase.PurchaseItem(
            id: PurchaseItemId(_uuid.v4()),
            purchaseId: purchaseId,
            productId: product.id,
            packageCount: packageCount,
            purchasedQuantity: draft.purchasedQuantity,
            lineTotal: draft.lineTotal,
          );
          item.validate();
          itemModels.add(item);
        }

        final purchase = domain_purchase.Purchase(
          id: purchaseId,
          accountId: command.accountId,
          store: store,
          occurrenceTime: command.occurrenceTime,
          currencyCode: command.currencyCode,
          items: itemModels,
        )..validate();

        phase = _PurchaseRegistrationPhase.insertPurchase;
        await _db
            .into(_db.purchases)
            .insert(
              PurchasesCompanion.insert(
                id: purchase.id.value,
                accountId: command.accountId.value,
                storeId: store.id.value,
                personId: Value(command.personId),
                paymentMethodId: Value(command.paymentMethodId),
                occurrenceTime: command.occurrenceTime.toUtc(),
                currencyCode: command.currencyCode,
                totalMinorUnits: purchase.totalMinorUnits,
                createdAt: now,
              ),
            );

        phase = _PurchaseRegistrationPhase.insertItems;
        for (final item in purchase.items) {
          await _db
              .into(_db.purchaseItems)
              .insert(
                PurchaseItemsCompanion.insert(
                  id: item.id.value,
                  purchaseId: item.purchaseId.value,
                  productId: item.productId.value,
                  packageCount: Value(item.packageCount),
                  measurementKind: item.purchasedQuantity.kind.name
                      .toUpperCase(),
                  purchasedAmount: item.purchasedQuantity.decimalText,
                  purchasedUnit: item.purchasedQuantity.unit.name.toUpperCase(),
                  currencyCode: item.lineTotal.currencyCode,
                  lineTotalMinorUnits: item.lineTotal.minorUnits,
                ),
              );
        }

        phase = _PurchaseRegistrationPhase.allocateSequence;
        final sequence = await _allocateDeviceSequence(command.deviceId);
        phase = _PurchaseRegistrationPhase.serializeEvent;
        final event = domain_sync.SyncEvent(
          id: EventId(_uuid.v4()),
          accountId: command.accountId,
          deviceId: command.deviceId,
          deviceSequence: sequence,
          eventType: 'purchase.registered',
          payloadVersion: 3,
          occurrenceTime: command.occurrenceTime,
          purchase: purchase,
          productSnapshots: productSnapshots,
        );
        final payload = canonicalJson(event.toJson());
        final contentHash = event.contentHash;

        phase = _PurchaseRegistrationPhase.insertEvent;
        await _db
            .into(_db.syncEvents)
            .insert(
              SyncEventsCompanion.insert(
                id: event.id.value,
                accountId: command.accountId.value,
                deviceId: command.deviceId.value,
                deviceSequence: sequence,
                eventType: event.eventType,
                payloadVersion: event.payloadVersion,
                occurrenceTime: command.occurrenceTime.toUtc(),
                payloadJson: payload,
                contentHash: contentHash,
                createdAt: now,
              ),
            );
        phase = _PurchaseRegistrationPhase.insertOutbox;
        await _db
            .into(_db.pendingEvents)
            .insert(
              PendingEventsCompanion.insert(
                eventId: event.id.value,
                state: domain_sync.PendingEventState.pending.name,
                enqueuedAt: now,
              ),
            );

        return PurchaseRegistrationResult(
          purchaseId: purchase.id,
          eventId: event.id,
          deviceSequence: sequence,
        );
      } on AppFailure {
        rethrow;
      } on Object catch (error) {
        throw _phaseFailure(phase, error);
      }
    });
  }

  Future<void> _ensureDevice(
    RegisterPurchaseCommand command,
    DateTime now,
  ) async {
    final existing =
        await (_db.select(_db.devices)
              ..where((table) => table.id.equals(command.deviceId.value)))
            .getSingleOrNull();
    if (existing != null) {
      if (existing.accountId != command.accountId.value) {
        throw const AppFailure(
          code: 'device-account-mismatch',
          operation: 'Purchase registration',
          field: 'Device',
          recovery: 'Restart the app and verify hosted enrollment.',
          retryable: false,
          outcome: FailureOutcome.notApplied,
        );
      }
      return;
    }
    await _db
        .into(_db.devices)
        .insert(
          DevicesCompanion.insert(
            id: command.deviceId.value,
            accountId: command.accountId.value,
            nextSequence: 1,
            createdAt: now,
          ),
        );
  }

  Future<domain_store.Store> _resolveStore(
    RegisterPurchaseCommand command,
    DateTime now,
  ) async {
    switch (command.storeReference) {
      case ExistingStoreReference(:final storeId):
        final existing =
            await (_db.select(_db.stores)..where(
                  (table) =>
                      table.accountId.equals(command.accountId.value) &
                      table.id.equals(storeId.value),
                ))
                .getSingleOrNull();
        if (existing == null) {
          throw const AppFailure(
            code: 'missing-store',
            operation: 'Purchase registration',
            field: 'Store',
            recovery:
                'Choose an existing Store for this account or create one.',
            retryable: true,
            outcome: FailureOutcome.notApplied,
          );
        }
        return domain_store.Store(
          id: StoreId(existing.id),
          accountId: command.accountId,
          displayName: existing.displayName,
        );
      case NewStoreReference(:final displayName):
        final name = displayName.trim();
        if (name.isEmpty) {
          throw const AppFailure(
            code: 'missing-store',
            operation: 'Purchase registration',
            field: 'Store',
            recovery: 'Enter a Store name.',
            retryable: true,
            outcome: FailureOutcome.notApplied,
          );
        }
        final existing =
            await (_db.select(_db.stores)..where(
                  (table) =>
                      table.accountId.equals(command.accountId.value) &
                      table.displayName.equals(name),
                ))
                .getSingleOrNull();
        if (existing != null) {
          return domain_store.Store(
            id: StoreId(existing.id),
            accountId: command.accountId,
            displayName: existing.displayName,
          );
        }
        final store = domain_store.Store(
          id: StoreId(_uuid.v4()),
          accountId: command.accountId,
          displayName: name,
        );
        await _db
            .into(_db.stores)
            .insert(
              StoresCompanion.insert(
                id: store.id.value,
                accountId: command.accountId.value,
                displayName: store.displayName,
                createdAt: now,
              ),
            );
        return store;
    }
  }

  Future<domain.Product> _resolveProduct(
    AccountId accountId,
    domain_purchase.PurchaseItemDraft draft,
    DateTime now,
  ) async {
    switch (draft.productReference) {
      case domain_purchase.ExistingProductReference(:final productId):
        final existing =
            await (_db.select(_db.products)..where(
                  (table) =>
                      table.accountId.equals(accountId.value) &
                      table.id.equals(productId.value),
                ))
                .getSingleOrNull();
        if (existing == null) {
          throw const AppFailure(
            code: 'missing-product',
            operation: 'Purchase registration',
            field: 'Product',
            recovery: 'Use a Product that belongs to this account.',
            retryable: true,
            outcome: FailureOutcome.notApplied,
          );
        }
        return _productFromRow(existing);
      case domain_purchase.NewProductReference(:final productDraft):
        final product = domain.createProductFromDraft(
          accountId: accountId,
          draft: productDraft,
          uuid: _uuid,
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
          throw const AppFailure(
            code: 'product-code-collision',
            operation: 'Product creation',
            field: 'Product code',
            recovery: 'Use the existing Product or choose a different code.',
            retryable: true,
            outcome: FailureOutcome.notApplied,
          );
        }
        await _db
            .into(_db.products)
            .insert(
              ProductsCompanion.insert(
                id: product.id.value,
                accountId: product.accountId.value,
                userProductCode: product.userProductCode.displayValue,
                normalizedUserProductCode:
                    product.userProductCode.normalizedKey,
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
  }

  Future<void> _assertOptionalReference({
    required String tableName,
    required AccountId accountId,
    required String? id,
    required String operation,
  }) async {
    if (id == null) {
      return;
    }
    final row = await _db
        .customSelect(
          'SELECT id FROM $tableName WHERE account_id = ? AND id = ?',
          variables: [
            Variable.withString(accountId.value),
            Variable.withString(id),
          ],
        )
        .getSingleOrNull();
    if (row == null) {
      throw AppFailure(
        code: 'missing-reference',
        operation: operation,
        field: operation,
        recovery: 'Choose an active local label or leave it Not assigned.',
        retryable: true,
        outcome: FailureOutcome.notApplied,
      );
    }
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
        displayValue: row.userProductCode,
        normalizedKey: row.normalizedUserProductCode,
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

  Future<int> _allocateDeviceSequence(DeviceId deviceId) async {
    final device = await (_db.select(
      _db.devices,
    )..where((table) => table.id.equals(deviceId.value))).getSingle();
    final sequence = device.nextSequence;
    await (_db.update(_db.devices)
          ..where((table) => table.id.equals(deviceId.value)))
        .write(DevicesCompanion(nextSequence: Value(sequence + 1)));
    return sequence;
  }
}

enum _PurchaseRegistrationPhase {
  ensureAccount('ensure-account'),
  ensureSyncState('ensure-sync-state'),
  ensureDevice('ensure-device'),
  resolveStore('resolve-store'),
  resolveReferences('resolve-references'),
  resolveProduct('resolve-product'),
  buildPurchase('build-purchase'),
  insertPurchase('insert-purchase'),
  insertItems('insert-items'),
  allocateSequence('allocate-sequence'),
  serializeEvent('serialize-event'),
  insertEvent('insert-event'),
  insertOutbox('insert-outbox');

  const _PurchaseRegistrationPhase(this.code);

  final String code;
}

AppFailure _phaseFailure(_PurchaseRegistrationPhase phase, Object cause) {
  return AppFailure(
    code: 'purchase-registration-${phase.code}-failed',
    operation: 'Purchase registration',
    recovery:
        'The operation was rolled back. Keep the draft and report this code.',
    retryable: false,
    outcome: FailureOutcome.notApplied,
    debugCause: cause,
  );
}
