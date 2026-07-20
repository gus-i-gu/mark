import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/sync/sync_event.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_device_identity_repository.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/sync/local_sync_repositories.dart';
import 'package:markei/infrastructure/local/sync/remote_purchase_event_applier.dart';

import 'real_convergence_harness_support.dart';

void main() {
  test(
    'CONVERGED=true for HTTP/PostgreSQL backed local synchronization',
    () async {
      if (Platform.environment['MARKEI_RUN_SYNC_LAB'] != '1') {
        markTestSkipped('Set MARKEI_RUN_SYNC_LAB=1 to run disposable lab.');
        return;
      }
      final repo = Directory.current.parent.parent;
      final lab = Directory('${repo.path}/infra/sync_lab');
      await Directory('${lab.path}/secrets').create(recursive: true);
      await File(
        '${lab.path}/secrets/migrator_password.txt',
      ).writeAsString('migrator-${DateTime.now().microsecondsSinceEpoch}');
      final temp = await Directory.systemTemp.createTemp('markei_real_sync_');
      addTearDown(() => temp.delete(recursive: true));
      await labDocker(lab, ['compose', 'down', '--volumes']);
      addTearDown(() => labDocker(lab, ['compose', 'down', '--volumes']));
      await labDocker(lab, ['compose', 'up', '-d']);
      await waitForPostgres(lab);
      await labPsql(
        lab,
        File(
          '${repo.path}/services/markei_sync_api/migrations/001_init.sql',
        ).readAsStringSync(),
      );
      await labPsql(
        lab,
        File(
          '${repo.path}/services/markei_sync_api/migrations/002_coordination_hardening.sql',
        ).readAsStringSync(),
      );

      final a = LocalDatabase.file(File('${temp.path}/local01.sqlite'));
      final b = LocalDatabase.file(File('${temp.path}/local02.sqlite'));
      addTearDown(a.close);
      addTearDown(b.close);
      final account = const AccountId('11111111-1111-4111-8111-111111111111');
      const localOnlyDevice = DeviceId('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb');
      final deviceA = await LocalDeviceIdentityRepository(
        a,
      ).loadOrCreateDeviceId(account);
      const deviceB = DeviceId('22222222-2222-4222-8222-222222222222');
      await seedLocalDevice(b, account, deviceB);
      final runtimePassword =
          'runtime-${DateTime.now().microsecondsSinceEpoch}';
      await labPsql(lab, """
        alter role markei_runtime login password '$runtimePassword';
        insert into accounts(account_id) values('${account.value}');
        insert into account_cursor_state(account_id, next_cursor) values('${account.value}', 1);
        insert into devices(account_id, device_id, status, next_expected_sequence)
          values('${account.value}', '${deviceA.value}', 'active', 1),
                ('${account.value}', '${deviceB.value}', 'active', 1);
      """);

      await LocalPurchaseRepository(
        a,
      ).registerPurchase(fixturePurchaseCommand(localOnlyDevice));
      await LocalPurchaseRepository(
        a,
      ).registerPurchase(fixturePurchaseCommand(deviceA));
      final apiA = await startLabApi(
        repo,
        account.value,
        deviceA.value,
        runtimePassword,
      );
      final apiB = await startLabApi(
        repo,
        account.value,
        deviceB.value,
        runtimePassword,
      );
      addTearDown(apiA.close);
      addTearDown(apiB.close);
      final outbox = DriftSyncOutboxRepository.scoped(
        a,
        accountId: account,
        deviceId: deviceA,
      );
      final first = await outbox.leasePending(limit: 25);
      expect(first?.events, hasLength(1));
      expect(first?.events.single['accountId'], account.value);
      final timeoutTransport = labTransport(apiA.uri, CommitDropClient());
      final unknown = await timeoutTransport.uploadSubmission(first!);
      await outbox.persistUploadResult(first.id, unknown);
      expect(unknown.code, SyncStatusCode.unknownOutcome);
      final retry = await outbox.leasePending(limit: 25);
      expect(retry!.id, first.id);
      final accepted = await labTransport(
        apiA.uri,
        http.Client(),
      ).uploadSubmission(retry);
      await outbox.persistUploadResult(retry.id, accepted);
      expect(accepted.code, SyncStatusCode.serverAccepted);
      expect(await labCount(lab, 'sync_events'), 1);

      expect(
        (await a.select(a.pendingEvents).get()).where(
          (row) => row.state == 'pending',
        ),
        hasLength(1),
      );

      final applier = DriftRemoteEventApplier.scoped(b, accountId: account);
      final page = await labTransport(
        apiB.uri,
        http.Client(),
      ).downloadAfter(null, limit: 25);
      expect(page.events, hasLength(1));
      expect(
        (await applier.applyPage(page)).code,
        SyncStatusCode.downloadedApplied,
      );
      expect(
        (await applier.applyPage(page)).code,
        SyncStatusCode.duplicateIgnored,
      );
      expect(await b.select(b.pendingEvents).get(), isEmpty);
      final ack = await labTransport(
        apiB.uri,
        http.Client(),
      ).acknowledge((await applier.greatestContiguousAppliedCursor())!);
      expect(ack.code, SyncStatusCode.acknowledged);
      expect(await labCount(lab, 'device_acknowledgements'), 1);

      await a.close();
      await b.close();
      final reopenedA = LocalDatabase.file(File('${temp.path}/local01.sqlite'));
      final reopenedB = LocalDatabase.file(File('${temp.path}/local02.sqlite'));
      addTearDown(reopenedA.close);
      addTearDown(reopenedB.close);
      expect(await reopenedA.select(reopenedA.purchases).get(), hasLength(2));
      expect(await reopenedB.select(reopenedB.purchases).get(), hasLength(1));
      expect(
        await reopenedA.select(reopenedA.purchaseItems).get(),
        hasLength(2),
      );
      expect(
        await reopenedB.select(reopenedB.purchaseItems).get(),
        hasLength(1),
      );
      stdout.writeln('CONVERGED=true');
    },
    timeout: const Timeout(Duration(minutes: 4)),
  );
}
