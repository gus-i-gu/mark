import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/app_failure.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/references/local_reference.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/domain/sync/canonical_json.dart';
import 'package:markei/infrastructure/local/hosted_identity_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

import 'fixture_support.dart';

void main() {
  test('atomically persists purchase aggregate and pending event', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final repository = LocalPurchaseRepository(db);
    final fixture = loadFixture('purchase_aggregate.json');
    final expected = fixture['multiItemPurchase']! as Map<String, Object?>;

    final result = await repository.registerPurchase(
      _command(fixture, items: [_riceItem(), _bananaItem()]),
    );

    expect(result.deviceSequence, 1);
    expect(await db.select(db.stores).get(), hasLength(1));
    expect(await db.select(db.products).get(), hasLength(2));
    expect(await db.select(db.purchases).get(), hasLength(1));
    expect(
      await db.select(db.purchaseItems).get(),
      hasLength(expected['expectedItems']! as int),
    );
    expect(await db.select(db.syncEvents).get(), hasLength(1));
    expect(await db.select(db.pendingEvents).get(), hasLength(1));

    final purchase = (await db.select(db.purchases).get()).single;
    expect(purchase.totalMinorUnits, expected['expectedTotalMinorUnits']);
    final event = (await db.select(db.syncEvents).get()).single;
    final payload = jsonDecode(event.payloadJson) as Map<String, Object?>;
    expect(payload['eventType'], 'purchase.registered');
    expect(payload['payloadVersion'], 3);
    expect(payload['deviceSequence'], 1);
    expect(payload['contentHash'], event.contentHash);
    expect(
      (payload['payload']! as Map<String, Object?>)['purchase'],
      isA<Map<String, Object?>>(),
    );
  });

  test('invalid purchase item rolls back all aggregate writes', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final repository = LocalPurchaseRepository(db);
    final fixture = loadFixture('purchase_aggregate.json');

    await expectLater(
      repository.registerPurchase(_command(fixture, items: [_invalidItem()])),
      throwsA(isA<AppFailure>()),
    );

    expect(await db.select(db.stores).get(), isEmpty);
    expect(await db.select(db.products).get(), isEmpty);
    expect(await db.select(db.purchases).get(), isEmpty);
    expect(await db.select(db.purchaseItems).get(), isEmpty);
    expect(await db.select(db.syncEvents).get(), isEmpty);
    expect(await db.select(db.pendingEvents).get(), isEmpty);
  });

  test('fresh file database preserves facts after close and reopen', () async {
    final temp = await Directory.systemTemp.createTemp('markei_flutter_test_');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');
    final fixture = loadFixture('purchase_aggregate.json');

    final firstDb = LocalDatabase.file(file);
    await LocalPurchaseRepository(
      firstDb,
    ).registerPurchase(_command(fixture, items: [_riceItem()]));
    await firstDb.close();

    final reopenedDb = LocalDatabase.file(file);
    addTearDown(reopenedDb.close);
    final expected = fixture['closeReopen']! as Map<String, Object?>;

    expect(
      await reopenedDb.select(reopenedDb.purchases).get(),
      hasLength(expected['expectedPurchasesAfterReopen']! as int),
    );
    expect(
      await reopenedDb.select(reopenedDb.pendingEvents).get(),
      hasLength(expected['expectedPendingEventsAfterReopen']! as int),
    );
  });

  test('local-only purchase registration still succeeds', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    final repository = LocalPurchaseRepository(db);
    const accountId = AccountId('11111111-1111-4111-8111-111111111111');
    const deviceId = DeviceId('22222222-2222-4222-8222-222222222222');
    final store = await queries.createStore(accountId, 'Mercado Central');
    final product = await queries.createProduct(accountId, _packagedDraft());

    final result = await repository.registerPurchase(
      _existingCommand(
        accountId: accountId,
        deviceId: deviceId,
        storeId: store.id,
        productId: product.id,
      ),
    );

    expect(result.deviceSequence, 1);
    expect(await db.select(db.purchases).get(), hasLength(1));
    expect(await db.select(db.syncEvents).get(), hasLength(1));
    expect(await db.select(db.pendingEvents).get(), hasLength(1));
  });

  test('hosted-bound Purchase A registration succeeds', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    final repository = LocalPurchaseRepository(db);
    final bindingRepository = DriftHostedIdentityRepository(db);
    const accountId = AccountId('11111111-1111-4111-8111-111111111111');
    const deviceId = DeviceId('22222222-2222-4222-8222-222222222222');
    await bindingRepository.save(_hostedState());
    final binding = await bindingRepository.loadActiveBinding(
      'provider-native',
    );
    await bindingRepository.ensureLocalHostedIdentity(binding!);
    final store = await queries.createStore(accountId, 'Mercado Central');
    final product = await queries.createProduct(accountId, _packagedDraft());

    final result = await repository.registerPurchase(
      _existingCommand(
        accountId: accountId,
        deviceId: deviceId,
        storeId: store.id,
        productId: product.id,
      ),
    );

    expect(result.deviceSequence, 1);
    final event = (await db.select(db.syncEvents).get()).single;
    expect(event.accountId, accountId.value);
    expect(event.deviceId, deviceId.value);
    expect(event.eventType, 'purchase.registered');
    expect(event.payloadVersion, 3);
  });

  test(
    'registration creates exactly one event and one pending outbox record',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final queries = LocalQueryRepository(db);
      final repository = LocalPurchaseRepository(db);
      const accountId = AccountId('11111111-1111-4111-8111-111111111111');
      const deviceId = DeviceId('22222222-2222-4222-8222-222222222222');
      final store = await queries.createStore(accountId, 'Mercado Central');
      final product = await queries.createProduct(accountId, _packagedDraft());

      await repository.registerPurchase(
        _existingCommand(
          accountId: accountId,
          deviceId: deviceId,
          storeId: store.id,
          productId: product.id,
        ),
      );

      final events = await db.select(db.syncEvents).get();
      final pending = await db.select(db.pendingEvents).get();
      expect(events, hasLength(1));
      expect(pending, hasLength(1));
      expect(pending.single.eventId, events.single.id);
      final payload =
          jsonDecode(events.single.payloadJson) as Map<String, Object?>;
      final withoutHash = Map<String, Object?>.of(payload)
        ..remove('contentHash');
      expect(canonicalUtf8Sha256(withoutHash), events.single.contentHash);
    },
  );

  test(
    'transaction rollback leaves no partial Store/Purchase/Event mutation',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final queries = LocalQueryRepository(db);
      final repository = LocalPurchaseRepository(db);
      const accountId = AccountId('11111111-1111-4111-8111-111111111111');
      const deviceId = DeviceId('22222222-2222-4222-8222-222222222222');
      final product = await queries.createProduct(accountId, _packagedDraft());

      await expectLater(
        repository.registerPurchase(
          _existingCommand(
            accountId: accountId,
            deviceId: deviceId,
            storeId: const StoreId('33333333-3333-4333-8333-333333333333'),
            productId: product.id,
          ),
        ),
        throwsA(
          isA<AppFailure>().having(
            (failure) => failure.code,
            'code',
            'missing-store',
          ),
        ),
      );

      expect(await db.select(db.stores).get(), isEmpty);
      expect(await db.select(db.purchases).get(), isEmpty);
      expect(await db.select(db.purchaseItems).get(), isEmpty);
      expect(await db.select(db.syncEvents).get(), isEmpty);
      expect(await db.select(db.pendingEvents).get(), isEmpty);
      expect(await db.select(db.devices).get(), isEmpty);
    },
  );

  test(
    'reopening the database preserves Store, Purchase, event, outbox, binding, and device sequence',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'markei_hosted_purchase_',
      );
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/markei.sqlite');
      const accountId = AccountId('11111111-1111-4111-8111-111111111111');
      const deviceId = DeviceId('22222222-2222-4222-8222-222222222222');

      final firstDb = LocalDatabase.file(file);
      final firstQueries = LocalQueryRepository(firstDb);
      final firstHosted = DriftHostedIdentityRepository(firstDb);
      await firstHosted.save(_hostedState());
      final binding = await firstHosted.loadActiveBinding('provider-native');
      await firstHosted.ensureLocalHostedIdentity(binding!);
      final store = await firstQueries.createStore(
        accountId,
        'Mercado Central',
      );
      final product = await firstQueries.createProduct(
        accountId,
        _packagedDraft(),
      );
      await LocalPurchaseRepository(firstDb).registerPurchase(
        _existingCommand(
          accountId: accountId,
          deviceId: deviceId,
          storeId: store.id,
          productId: product.id,
        ),
      );
      await firstDb.close();

      final reopenedDb = LocalDatabase.file(file);
      addTearDown(reopenedDb.close);
      final reopenedHosted = DriftHostedIdentityRepository(reopenedDb);

      expect(
        await reopenedHosted.loadActiveBinding('provider-native'),
        isNotNull,
      );
      expect(await reopenedDb.select(reopenedDb.stores).get(), hasLength(1));
      expect(await reopenedDb.select(reopenedDb.purchases).get(), hasLength(1));
      expect(
        await reopenedDb.select(reopenedDb.syncEvents).get(),
        hasLength(1),
      );
      expect(
        await reopenedDb.select(reopenedDb.pendingEvents).get(),
        hasLength(1),
      );
      final device = (await reopenedDb.select(reopenedDb.devices).get()).single;
      expect(device.id, deviceId.value);
      expect(device.nextSequence, 2);
    },
  );

  test(
    'migrated hosted lifecycle reports insert-purchase phase and preserves state',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'markei_migrated_purchase_',
      );
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/markei.sqlite');
      const accountId = AccountId('11111111-1111-4111-8111-111111111111');
      const serverDeviceId = DeviceId('22222222-2222-4222-8222-222222222222');

      final migratingDb = LocalDatabase(
        NativeDatabase.createInBackground(
          file,
          setup: _createV2PersistentHostedLifecycle,
        ),
      );
      await migratingDb.select(migratingDb.products).get();
      await migratingDb.close();

      final boundDb = LocalDatabase.file(file);
      final hosted = DriftHostedIdentityRepository(boundDb);
      await hosted.save(_hostedState());
      final binding = await hosted.loadActiveBinding('provider-native');
      await hosted.ensureLocalHostedIdentity(binding!);
      await boundDb.close();

      final reopenedDb = LocalDatabase.file(file);
      try {
        final queries = LocalQueryRepository(reopenedDb);
        final stores = await queries.listStores(accountId);
        final products = await queries.listProducts(accountId);

        await expectLater(
          LocalPurchaseRepository(reopenedDb).registerPurchase(
            _existingCommand(
              accountId: accountId,
              deviceId: serverDeviceId,
              storeId: stores.single.id,
              productId: products.single.id,
            ),
          ),
          throwsA(
            isA<AppFailure>()
                .having(
                  (failure) => failure.code,
                  'code',
                  'purchase-registration-insert-purchase-failed',
                )
                .having(
                  (failure) => failure.outcome,
                  'outcome',
                  FailureOutcome.notApplied,
                )
                .having(
                  (failure) => failure.debugCause,
                  'debugCause',
                  isNotNull,
                )
                .having(
                  (failure) => failure.userMessage,
                  'userMessage',
                  allOf(
                    isNot(contains('people_old')),
                    isNot(contains('payment_methods_old')),
                    isNot(contains('11111111-1111')),
                    isNot(contains('22222222-2222')),
                    isNot(contains('C:')),
                  ),
                ),
          ),
        );
      } finally {
        await reopenedDb.close();
      }

      final verifiedDb = LocalDatabase.file(file);
      addTearDown(verifiedDb.close);
      final history = await LocalQueryRepository(
        verifiedDb,
      ).listRecentPurchases(accountId);
      final purchases = await verifiedDb.select(verifiedDb.purchases).get();
      final events = await verifiedDb.select(verifiedDb.syncEvents).get();
      final pending = await verifiedDb.select(verifiedDb.pendingEvents).get();
      final syncState = await verifiedDb.select(verifiedDb.syncState).get();
      final device = await (verifiedDb.select(
        verifiedDb.devices,
      )..where((table) => table.id.equals(serverDeviceId.value))).getSingle();

      expect(history, hasLength(1));
      expect(purchases, hasLength(1));
      expect(events, hasLength(2));
      expect(pending, hasLength(2));
      expect(syncState.single.accountCursor, 'cursor-before-hosted-purchase');
      expect(device.nextSequence, 1);
    },
  );

  test('archived local references remain resolvable in history', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    final repository = LocalPurchaseRepository(db);
    final fixture = loadFixture('purchase_aggregate.json');
    final accountId = AccountId(fixture['accountId']! as String);
    final person = await queries.saveReference(
      accountId: accountId,
      kind: LocalReferenceKind.person,
      nickname: 'Gus',
    );

    await repository.registerPurchase(
      _command(fixture, items: [_riceItem()], personId: person.id),
    );
    await queries.archiveReference(
      accountId: accountId,
      kind: LocalReferenceKind.person,
      id: person.id,
    );

    final purchase = (await queries.listRecentPurchases(accountId)).single;
    expect(purchase.personLabel, '@001 · Gus (archived)');
  });

  test(
    'existing Product reference is retained without duplicate Product',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = LocalPurchaseRepository(db);
      final fixture = loadFixture('purchase_aggregate.json');

      await repository.registerPurchase(
        _command(fixture, items: [_riceItem()]),
      );
      final existingProduct = (await db.select(db.products).get()).single;

      await repository.registerPurchase(
        _command(
          fixture,
          items: [
            PurchaseItemDraft(
              productReference: ExistingProductReference(
                ProductId(existingProduct.id),
              ),
              packageCount: 2,
              purchasedQuantity: NormalizedQuantity.fromDecimalString(
                kind: MeasurementKind.mass,
                unit: CanonicalUnit.kg,
                decimal: '2',
              ),
              lineTotal: const Money(currencyCode: 'BRL', minorUnits: 2598),
            ),
          ],
        ),
      );

      final products = await db.select(db.products).get();
      final items = await db.select(db.purchaseItems).get();
      expect(products, hasLength(1));
      expect(items.last.productId, existingProduct.id);
      expect(items.last.packageCount, 2);
      expect(items.last.lineTotalMinorUnits, 2598);
    },
  );

  test('sync event fixture states required envelope fields', () {
    final fixture = loadFixture('sync_event.json');

    expect(fixture['eventType'], 'purchase.registered');
    expect(fixture['payloadVersion'], 2);
    expect(fixture['deviceSequence'], 1);
    expect(fixture['queueState'], 'pending');
  });
}

RegisterPurchaseCommand _command(
  Map<String, Object?> fixture, {
  required List<PurchaseItemDraft> items,
  String? personId,
}) {
  return RegisterPurchaseCommand(
    accountId: AccountId(fixture['accountId']! as String),
    deviceId: DeviceId(fixture['deviceId']! as String),
    storeName: fixture['storeName']! as String,
    occurrenceTime: DateTime.parse(fixture['occurrenceTime']! as String),
    currencyCode: fixture['currencyCode']! as String,
    personId: personId,
    items: items,
  );
}

PurchaseItemDraft _riceItem({int packageCount = 1}) {
  return PurchaseItemDraft(
    productReference: const NewProductReference(
      ProductDraft(
        userCode: 'ARROZ-001',
        name: 'Arroz Branco',
        brand: 'Marca A',
        mode: ProductMode.packaged,
        measurementKind: MeasurementKind.mass,
        packageAmount: '1',
        packageUnit: 'kg',
      ),
    ),
    packageCount: packageCount,
    purchasedQuantity: NormalizedQuantity.fromDecimalString(
      kind: MeasurementKind.mass,
      unit: CanonicalUnit.kg,
      decimal: '1',
    ),
    lineTotal: const Money(currencyCode: 'BRL', minorUnits: 1299),
  );
}

PurchaseItemDraft _bananaItem() {
  return PurchaseItemDraft(
    productReference: const NewProductReference(
      ProductDraft(
        userCode: 'BANANA-001',
        name: 'Banana Prata',
        brand: '',
        mode: ProductMode.bulk,
        measurementKind: MeasurementKind.mass,
      ),
    ),
    packageCount: 1,
    purchasedQuantity: NormalizedQuantity.fromDecimalString(
      kind: MeasurementKind.mass,
      unit: CanonicalUnit.kg,
      decimal: '1',
    ),
    lineTotal: const Money(currencyCode: 'BRL', minorUnits: 500),
  );
}

PurchaseItemDraft _invalidItem() => _riceItem(packageCount: 0);

ProductDraft _packagedDraft() {
  return const ProductDraft(
    userCode: 'ARROZ-001',
    name: 'Arroz Branco',
    brand: 'Marca A',
    mode: ProductMode.packaged,
    measurementKind: MeasurementKind.mass,
    packageAmount: '1',
    packageUnit: 'kg',
  );
}

RegisterPurchaseCommand _existingCommand({
  required AccountId accountId,
  required DeviceId deviceId,
  required StoreId storeId,
  required ProductId productId,
}) {
  return RegisterPurchaseCommand(
    accountId: accountId,
    deviceId: deviceId,
    storeReference: ExistingStoreReference(storeId),
    occurrenceTime: DateTime.utc(2026, 7, 20, 12),
    currencyCode: 'BRL',
    items: [
      PurchaseItemDraft(
        productReference: ExistingProductReference(productId),
        packageCount: 1,
        purchasedQuantity: NormalizedQuantity.fromDecimalString(
          kind: MeasurementKind.mass,
          unit: CanonicalUnit.kg,
          decimal: '1',
        ),
        lineTotal: const Money(currencyCode: 'BRL', minorUnits: 1299),
      ),
    ],
  );
}

HostedIdentityState _hostedState() {
  return HostedIdentityState(
    environmentAlias: 'provider-native',
    installationId: 'stable-installation-hosted-a',
    enrollmentRequestId: '55555555-5555-4555-8555-555555555555',
    enrollmentState: 'device-enrolled',
    accountId: '11111111-1111-4111-8111-111111111111',
    serverDeviceId: '22222222-2222-4222-8222-222222222222',
    generation: 1,
    updatedAt: DateTime.utc(2026, 7, 20, 12),
  );
}

void _createV2PersistentHostedLifecycle(dynamic database) {
  database.execute('PRAGMA foreign_keys = OFF');
  database.execute('''
CREATE TABLE local_accounts (
  id TEXT NOT NULL PRIMARY KEY,
  default_currency_code TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE devices (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  next_sequence INTEGER NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, id)
);
''');
  database.execute('''
CREATE TABLE products (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  user_product_code TEXT,
  normalized_user_product_code TEXT,
  normalization_version INTEGER NOT NULL,
  display_name TEXT,
  display_brand TEXT,
  normalized_name TEXT NOT NULL,
  normalized_brand TEXT NOT NULL,
  mode TEXT NOT NULL,
  measurement_kind TEXT NOT NULL,
  package_amount TEXT,
  package_unit TEXT,
  exact_identity_key TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, normalized_user_product_code),
  UNIQUE(account_id, exact_identity_key)
);
''');
  database.execute('''
CREATE TABLE stores (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  display_name TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE purchases (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  store_id TEXT NOT NULL REFERENCES stores(id),
  occurrence_time INTEGER NOT NULL,
  currency_code TEXT NOT NULL,
  total_minor_units INTEGER NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE purchase_items (
  id TEXT NOT NULL PRIMARY KEY,
  purchase_id TEXT NOT NULL REFERENCES purchases(id),
  product_id TEXT NOT NULL REFERENCES products(id),
  package_count INTEGER NOT NULL,
  measurement_kind TEXT NOT NULL,
  purchased_amount TEXT NOT NULL,
  purchased_unit TEXT NOT NULL,
  currency_code TEXT NOT NULL,
  line_total_minor_units INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_events (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  device_id TEXT NOT NULL REFERENCES devices(id),
  device_sequence INTEGER NOT NULL,
  event_type TEXT NOT NULL,
  payload_version INTEGER NOT NULL,
  occurrence_time INTEGER NOT NULL,
  payload_json TEXT NOT NULL,
  content_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, device_id, device_sequence)
);
''');
  database.execute('''
CREATE TABLE pending_events (
  event_id TEXT NOT NULL PRIMARY KEY REFERENCES sync_events(id),
  state TEXT NOT NULL,
  enqueued_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_state (
  account_id TEXT NOT NULL PRIMARY KEY REFERENCES local_accounts(id),
  account_cursor TEXT,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE migration_ledger (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  schema_name TEXT NOT NULL,
  schema_version INTEGER NOT NULL,
  from_version INTEGER,
  to_version INTEGER,
  migration_id TEXT,
  applied_at INTEGER NOT NULL
);
''');
  database.execute(
    "INSERT INTO local_accounts VALUES ('11111111-1111-4111-8111-111111111111', 'BRL', 1783857600000)",
  );
  database.execute(
    "INSERT INTO devices VALUES ('local-device-legacy', '11111111-1111-4111-8111-111111111111', 3, 1783857600000)",
  );
  database.execute(
    "INSERT INTO stores VALUES ('33333333-3333-4333-8333-333333333333', '11111111-1111-4111-8111-111111111111', 'Provider Proof Store', 1783857600000)",
  );
  database.execute(
    "INSERT INTO products VALUES ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', '11111111-1111-4111-8111-111111111111', 'ARROZ-001', 'arroz-001', 2, 'Arroz Branco', 'Marca A', 'arroz branco', 'marca a', 'PACKAGED', 'MASS', '1.000000', 'KG', '11111111-1111-4111-8111-111111111111|v2|arroz branco|marca a|PACKAGED|MASS|1.000000|KG', 1783857600000)",
  );
  database.execute(
    "INSERT INTO purchases VALUES ('44444444-4444-4444-8444-444444444444', '11111111-1111-4111-8111-111111111111', '33333333-3333-4333-8333-333333333333', 1783857600000, 'BRL', 1299, 1783857600000)",
  );
  database.execute(
    "INSERT INTO purchase_items VALUES ('55555555-5555-4555-8555-555555555555', '44444444-4444-4444-8444-444444444444', 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 1, 'MASS', '1.000000', 'KG', 'BRL', 1299)",
  );
  database.execute(
    "INSERT INTO sync_events VALUES ('66666666-6666-4666-8666-666666666666', '11111111-1111-4111-8111-111111111111', 'local-device-legacy', 1, 'purchase.registered', 3, 1783857600000, '{}', 'local-event-hash', 1783857600000)",
  );
  database.execute(
    "INSERT INTO pending_events VALUES ('66666666-6666-4666-8666-666666666666', 'pending', 1783857600000)",
  );
  database.execute(
    "INSERT INTO sync_events VALUES ('77777777-7777-4777-8777-777777777777', '11111111-1111-4111-8111-111111111111', '22222222-2222-4222-8222-222222222222', 1, 'purchase.registered', 3, 1783857600001, '{}', 'hosted-event-hash', 1783857600001)",
  );
  database.execute(
    "INSERT INTO pending_events VALUES ('77777777-7777-4777-8777-777777777777', 'accepted', 1783857600001)",
  );
  database.execute(
    "INSERT INTO sync_state VALUES ('11111111-1111-4111-8111-111111111111', 'cursor-before-hosted-purchase', 1783857600001)",
  );
  database.execute(
    "INSERT INTO migration_ledger (schema_name, schema_version, from_version, to_version, migration_id, applied_at) VALUES ('shared_beta_local', 2, 1, 2, 'v1-to-v2-product-code-display', 1783857600000)",
  );
  database.execute('PRAGMA user_version = 2');
}
