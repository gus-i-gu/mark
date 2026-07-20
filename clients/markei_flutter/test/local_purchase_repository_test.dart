import 'dart:convert';
import 'dart:io';

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
