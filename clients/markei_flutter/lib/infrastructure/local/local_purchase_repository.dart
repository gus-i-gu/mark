import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../application/register_purchase.dart';
import '../../domain/catalogue/product.dart' as domain;
import '../../domain/catalogue/product_code.dart' as domain_code;
import '../../domain/purchase/purchase.dart' as domain_purchase;
import '../../domain/shared/ids.dart';
import '../../domain/shared/quantity.dart' as domain_quantity;
import '../../domain/store/store.dart' as domain_store;
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
    return _db.transaction(() async {
      if (command.items.isEmpty) {
        throw ArgumentError('Purchase requires at least one Item.');
      }

      final now = DateTime.now().toUtc();
      await _db
          .into(_db.localAccounts)
          .insertOnConflictUpdate(
            LocalAccountsCompanion.insert(
              id: command.accountId.value,
              defaultCurrencyCode: command.currencyCode,
              createdAt: now,
            ),
          );
      await _db
          .into(_db.syncState)
          .insertOnConflictUpdate(
            SyncStateCompanion.insert(
              accountId: command.accountId.value,
              accountCursor: const Value(null),
              updatedAt: now,
            ),
          );
      await _db
          .into(_db.devices)
          .insert(
            DevicesCompanion.insert(
              id: command.deviceId.value,
              accountId: command.accountId.value,
              nextSequence: 1,
              createdAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );

      final store = await _resolveStore(command, now);
      final purchaseId = PurchaseId(_uuid.v4());
      final itemModels = <domain_purchase.PurchaseItem>[];

      for (final draft in command.items) {
        final product = await _resolveProduct(command.accountId, draft, now);
        final item = domain_purchase.PurchaseItem(
          id: PurchaseItemId(_uuid.v4()),
          purchaseId: purchaseId,
          productId: product.id,
          packageCount: draft.packageCount,
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

      await _db
          .into(_db.purchases)
          .insert(
            PurchasesCompanion.insert(
              id: purchase.id.value,
              accountId: command.accountId.value,
              storeId: store.id.value,
              occurrenceTime: command.occurrenceTime.toUtc(),
              currencyCode: command.currencyCode,
              totalMinorUnits: purchase.totalMinorUnits,
              createdAt: now,
            ),
          );

      for (final item in purchase.items) {
        await _db
            .into(_db.purchaseItems)
            .insert(
              PurchaseItemsCompanion.insert(
                id: item.id.value,
                purchaseId: item.purchaseId.value,
                productId: item.productId.value,
                packageCount: item.packageCount,
                measurementKind: item.purchasedQuantity.kind.name.toUpperCase(),
                purchasedAmount: item.purchasedQuantity.decimalText,
                purchasedUnit: item.purchasedQuantity.unit.name.toUpperCase(),
                currencyCode: item.lineTotal.currencyCode,
                lineTotalMinorUnits: item.lineTotal.minorUnits,
              ),
            );
      }

      final sequence = await _allocateDeviceSequence(command.deviceId);
      final event = domain_sync.SyncEvent(
        id: EventId(_uuid.v4()),
        accountId: command.accountId,
        deviceId: command.deviceId,
        deviceSequence: sequence,
        eventType: 'purchase.registered',
        payloadVersion: 2,
        occurrenceTime: command.occurrenceTime,
        purchase: purchase,
      );
      final payload = jsonEncode(event.toJson());
      final contentHash = sha256.convert(utf8.encode(payload)).toString();

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
    });
  }

  Future<domain_store.Store> _resolveStore(
    RegisterPurchaseCommand command,
    DateTime now,
  ) async {
    final name = command.storeName.trim();
    if (name.isEmpty) {
      throw ArgumentError('Store display name is required.');
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
          throw ArgumentError('Existing Product does not belong to account.');
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
