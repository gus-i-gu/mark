import 'dart:io';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
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

void main() {
  test(
    'two isolated Drift files converge through local replay harness',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'markei_sync_lab_test_',
      );
      addTearDown(() => temp.delete(recursive: true));
      final a = LocalDatabase.file(File('${temp.path}/local01.sqlite'));
      final b = LocalDatabase.file(File('${temp.path}/local02.sqlite'));
      addTearDown(a.close);
      addTearDown(b.close);

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
      expect(retry!.id, first.id);

      final event = await a.select(a.syncEvents).getSingle();
      final eventPayload =
          jsonDecode(event.payloadJson) as Map<String, Object?>;
      await b
          .into(b.localAccounts)
          .insertOnConflictUpdate(
            LocalAccountsCompanion.insert(
              id: account.value,
              defaultCurrencyCode: 'BRL',
              createdAt: DateTime.now().toUtc(),
            ),
          );
      final applier = DriftRemoteEventApplier(b);
      final page = DownloadPage(
        nextCursor: 'c10b:1',
        events: [DownloadedEvent(event: eventPayload, serverCursor: 'c10b:1')],
      );
      await applier.applyPage(page);
      await applier.applyPage(page);

      expect(await a.select(a.purchases).get(), hasLength(1));
      expect(await b.select(b.purchases).get(), hasLength(1));
      expect(await b.select(b.syncInbox).get(), hasLength(1));
      expect(await applier.greatestContiguousAppliedCursor(), 'c10b:1');

      await a.close();
      await b.close();
      final reopenedA = LocalDatabase.file(File('${temp.path}/local01.sqlite'));
      final reopenedB = LocalDatabase.file(File('${temp.path}/local02.sqlite'));
      addTearDown(reopenedA.close);
      addTearDown(reopenedB.close);
      expect(await reopenedA.select(reopenedA.purchases).get(), hasLength(1));
      expect(await reopenedB.select(reopenedB.purchases).get(), hasLength(1));
    },
  );
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
