import 'dart:convert';
import 'dart:io';

import 'package:markei/application/register_purchase.dart';
import 'package:markei/application/sync/sync_ports.dart';
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

Future<void> main() async {
  final temp = await Directory.systemTemp.createTemp('markei_sync_lab_');
  try {
    final a = LocalDatabase.file(File('${temp.path}/local01.sqlite'));
    final b = LocalDatabase.file(File('${temp.path}/local02.sqlite'));
    try {
      final account = const AccountId('11111111-1111-4111-8111-111111111111');
      final deviceA = await LocalDeviceIdentityRepository(
        a,
      ).loadOrCreateDeviceId(account);
      await LocalDeviceIdentityRepository(b).loadOrCreateDeviceId(account);
      await LocalPurchaseRepository(a).registerPurchase(_command(deviceA));

      final outbox = DriftSyncOutboxRepository(a);
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
      if (retry!.id != first.id) {
        throw StateError('SubmissionId changed after unknown outcome.');
      }

      final event = await a.select(a.syncEvents).getSingle();
      final eventPayload =
          jsonDecode(event.payloadJson) as Map<String, Object?>;
      final applier = DriftRemoteEventApplier(b);
      final page = DownloadPage(
        nextCursor: 'c10b:1',
        events: [DownloadedEvent(event: eventPayload, serverCursor: 'c10b:1')],
      );
      await applier.applyPage(page);
      await applier.applyPage(page);

      final inboxCount = await b.select(b.syncInbox).get();
      final purchasesA = await a.select(a.purchases).get();
      await a.close();
      await b.close();

      final reopenedA = LocalDatabase.file(File('${temp.path}/local01.sqlite'));
      final reopenedB = LocalDatabase.file(File('${temp.path}/local02.sqlite'));
      try {
        final reopenedPurchasesA = await reopenedA
            .select(reopenedA.purchases)
            .get();
        final reopenedInboxB = await reopenedB
            .select(reopenedB.syncInbox)
            .get();
        stdout.writeln(
          'sync-lab local01_purchases=${purchasesA.length} '
          'reopened_local01_purchases=${reopenedPurchasesA.length} '
          'local02_inbox=${inboxCount.length} '
          'reopened_local02_inbox=${reopenedInboxB.length} '
          'submission_retry_same_id=true',
        );
      } finally {
        await reopenedA.close();
        await reopenedB.close();
      }
    } finally {
      await a.close();
      await b.close();
    }
  } finally {
    await temp.delete(recursive: true);
  }
}

RegisterPurchaseCommand _command(DeviceId deviceId) {
  return RegisterPurchaseCommand(
    accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
    deviceId: deviceId,
    storeName: 'test-store',
    occurrenceTime: DateTime.utc(2026, 7, 14, 12),
    currencyCode: 'BRL',
    items: [
      PurchaseItemDraft(
        productReference: NewProductReference(
          ProductDraft(
            userCode: 'RICE-001',
            name: 'Synthetic rice',
            brand: 'Fixture',
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
