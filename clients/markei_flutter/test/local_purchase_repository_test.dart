import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/app_failure.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/references/local_reference.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
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
    expect(payload['deviceSequence'], 1);
    expect(payload['purchase'], isA<Map<String, Object?>>());
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
    expect(purchase.personLabel, 'Gus (archived)');
  });

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
