import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/application/sync/sync_use_cases.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/domain/sync/sync_event.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_device_identity_repository.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/sync/local_sync_repositories.dart';
import 'package:markei/infrastructure/local/sync/remote_purchase_event_applier.dart';

void main() {
  test('local registration works when transport is absent', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final device = await LocalDeviceIdentityRepository(
      db,
    ).loadOrCreateDeviceId(const AccountId('local-account'));

    final result = await LocalPurchaseRepository(
      db,
    ).registerPurchase(_command(device, 'ARROZ-001'));

    expect(result.deviceSequence, 1);
    expect(await db.select(db.pendingEvents).get(), hasLength(1));
  });

  test('unknown outcome retries same submission', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final device = await LocalDeviceIdentityRepository(
      db,
    ).loadOrCreateDeviceId(const AccountId('local-account'));
    await LocalPurchaseRepository(
      db,
    ).registerPurchase(_command(device, 'ARROZ-002'));
    final outbox = DriftSyncOutboxRepository(db);
    final first = await outbox.leasePending(limit: 25);

    await outbox.persistUploadResult(
      first!.id,
      const SyncResult(
        code: SyncStatusCode.unknownOutcome,
        outcome: SyncOutcome.unknown,
        retryable: true,
      ),
    );
    final retry = await outbox.leasePending(limit: 25);

    expect(retry!.id, first.id);
    expect(retry.requestHash, first.requestHash);
  });

  test('duplicate event is applied once and can be acknowledged', () async {
    final source = LocalDatabase.memory();
    final target = LocalDatabase.memory();
    addTearDown(source.close);
    addTearDown(target.close);
    final device = await LocalDeviceIdentityRepository(
      source,
    ).loadOrCreateDeviceId(const AccountId('local-account'));
    await LocalPurchaseRepository(
      source,
    ).registerPurchase(_command(device, 'ARROZ-003'));
    final event = await source.select(source.syncEvents).getSingle();
    final eventPayload = jsonDecode(event.payloadJson) as Map<String, Object?>;
    final applier = DriftRemoteEventApplier(target);
    final page = DownloadPage(
      nextCursor: 'c10b:1',
      events: [DownloadedEvent(event: eventPayload, serverCursor: 'c10b:1')],
    );

    final result = await applier.applyPage(page);
    final replay = await applier.applyPage(page);

    expect(result.code, SyncStatusCode.downloadedApplied);
    expect(replay.code, SyncStatusCode.duplicateIgnored);
    expect(await target.select(target.purchases).get(), hasLength(1));
    expect(await target.select(target.syncInbox).get(), hasLength(1));
    expect(await applier.greatestContiguousAppliedCursor(), 'c10b:1');
  });

  test('acknowledgement waits until local apply committed', () async {
    final transport = _RecordingTransport();
    final applier = _MemoryApplier();
    final acknowledge = AcknowledgeAppliedCursor(transport, applier);

    expect(await acknowledge(), isNull);
    applier.cursor = '2';
    await acknowledge();

    expect(transport.acknowledged, '2');
  });
}

RegisterPurchaseCommand _command(DeviceId deviceId, String productCode) {
  return RegisterPurchaseCommand(
    accountId: const AccountId('local-account'),
    deviceId: deviceId,
    storeName: 'Mercado Central',
    occurrenceTime: DateTime.utc(2026, 7, 14, 10),
    currencyCode: 'BRL',
    items: [
      PurchaseItemDraft(
        productReference: NewProductReference(
          ProductDraft(
            userCode: productCode,
            name: 'Arroz Branco',
            brand: 'Marca A',
            mode: ProductMode.packaged,
            measurementKind: MeasurementKind.mass,
            packageAmount: '1',
            packageUnit: 'kg',
          ),
        ),
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

final class _MemoryApplier implements RemoteEventApplier {
  String? cursor;

  @override
  Future<SyncResult> applyPage(DownloadPage page) async {
    cursor = page.nextCursor;
    return const SyncResult(
      code: SyncStatusCode.downloadedApplied,
      outcome: SyncOutcome.applied,
      retryable: false,
    );
  }

  @override
  Future<String?> greatestContiguousAppliedCursor() async => cursor;
}

final class _RecordingTransport implements SyncTransport {
  String? acknowledged;

  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) async {
    acknowledged = greatestContiguousCursor;
    return const SyncResult(
      code: SyncStatusCode.duplicateIgnored,
      outcome: SyncOutcome.duplicateEquivalent,
      retryable: false,
    );
  }

  @override
  Future<DownloadPage> downloadAfter(String? cursor, {required int limit}) {
    throw UnimplementedError();
  }

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) {
    throw UnimplementedError();
  }
}
