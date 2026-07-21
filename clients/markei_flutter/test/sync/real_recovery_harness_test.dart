import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/sync/canonical_json.dart';
import 'package:markei/domain/sync/sync_event.dart';
import 'package:markei/infrastructure/local/local_database.dart'
    hide RecoveryChunk, RecoverySession;
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/sync/local_recovery_repositories.dart';
import 'package:markei/infrastructure/local/sync/local_sync_repositories.dart';
import 'package:markei/infrastructure/local/sync/remote_purchase_event_applier.dart';

import 'real_convergence_harness_support.dart';

void main() {
  test(
    'RECOVERY_CONVERGED=true for disposable retention snapshot rebootstrap',
    () async {
      if (Platform.environment['MARKEI_RUN_SYNC_LAB'] != '1') {
        markTestSkipped('Set MARKEI_RUN_SYNC_LAB=1 to run disposable lab.');
        return;
      }
      final repo = Directory.current.parent.parent;
      final lab = Directory('${repo.path}/infra/sync_lab');
      await Directory('${lab.path}/secrets').create(recursive: true);
      final migratorPassword =
          'migrator-${DateTime.now().microsecondsSinceEpoch}';
      await File(
        '${lab.path}/secrets/migrator_password.txt',
      ).writeAsString(migratorPassword);
      final temp = await Directory.systemTemp.createTemp('markei_recovery_');
      addTearDown(() => temp.delete(recursive: true));
      await labDocker(lab, ['compose', 'down', '--volumes']);
      addTearDown(() => labDocker(lab, ['compose', 'down', '--volumes']));
      await labDocker(lab, ['compose', 'up', '-d']);
      await waitForPostgres(lab);
      for (final migration in [
        '001_init.sql',
        '002_coordination_hardening.sql',
        '003_retention_snapshot_recovery.sql',
      ]) {
        await labPsql(
          lab,
          File(
            '${repo.path}/services/markei_sync_api/migrations/$migration',
          ).readAsStringSync(),
        );
      }

      final account = const AccountId('11111111-1111-4111-8111-111111111111');
      const deviceA = DeviceId('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa');
      const deviceB = DeviceId('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb');
      const deviceC = DeviceId('cccccccc-cccc-4ccc-8ccc-cccccccccccc');
      final runtimePassword =
          'runtime-${DateTime.now().microsecondsSinceEpoch}';
      await labPsql(lab, """
        alter role markei_runtime login password '$runtimePassword';
        insert into accounts(account_id) values('${account.value}');
        insert into account_cursor_state(account_id, next_cursor) values('${account.value}', 1);
        insert into devices(account_id, device_id, status, next_expected_sequence, last_seen_at, lease_expires_at)
          values('${account.value}', '${deviceA.value}', 'active', 1, now(), now() + interval '5 minutes'),
                ('${account.value}', '${deviceB.value}', 'active', 1, now(), now() + interval '5 minutes'),
                ('${account.value}', '${deviceC.value}', 'active', 1, now() - interval '2 minutes', now() + interval '5 minutes');
      """);

      final a = LocalDatabase.file(File('${temp.path}/a.sqlite'));
      final b = LocalDatabase.file(File('${temp.path}/b.sqlite'));
      final c = LocalDatabase.file(File('${temp.path}/c.sqlite'));
      addTearDown(a.close);
      addTearDown(b.close);
      addTearDown(c.close);
      await seedLocalDevice(a, account, deviceA);
      await seedLocalDevice(b, account, deviceB);

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
      final apiC = await startLabApi(
        repo,
        account.value,
        deviceC.value,
        runtimePassword,
      );
      addTearDown(apiA.close);
      addTearDown(apiB.close);
      addTearDown(apiC.close);
      final transportA = labTransport(
        apiA.uri,
        http.Client(),
        hostedDeviceId: deviceA.value,
      );
      final transportB = labTransport(
        apiB.uri,
        http.Client(),
        hostedDeviceId: deviceB.value,
      );
      final transportC = labTransport(
        apiC.uri,
        http.Client(),
        hostedDeviceId: deviceC.value,
      );

      final purchaseRepo = LocalPurchaseRepository(a);
      final outboxA = DriftSyncOutboxRepository(a);
      for (var i = 0; i < 2; i++) {
        await purchaseRepo.registerPurchase(fixturePurchaseCommand(deviceA));
        final submission = await outboxA.leasePending(limit: 25);
        final result = await transportA.uploadSubmission(submission!);
        await outboxA.persistUploadResult(submission.id, result);
        expect(result.code, SyncStatusCode.serverAccepted);
      }
      final pageB = await transportB.downloadAfter(null, limit: 25);
      expect(pageB.events, hasLength(2));
      final applierB = DriftRemoteEventApplier(b);
      expect(
        (await applierB.applyPage(pageB)).code,
        SyncStatusCode.downloadedApplied,
      );
      final ackB = await transportB.acknowledge(
        (await applierB.greatestContiguousAppliedCursor())!,
      );
      expect(ackB.code, SyncStatusCode.acknowledged);
      await labPsql(lab, """
        insert into device_acknowledgements(account_id, device_id, greatest_contiguous_cursor)
        values('${account.value}', '${deviceA.value}', 2)
        on conflict(account_id, device_id) do update set greatest_contiguous_cursor=2;
      """);

      final snapshot = await runRecoveryLab(
        repo,
        account.value,
        deviceA.value,
        migratorPassword,
        'snapshot',
      );
      expect(snapshot['formatVersion'], 1);
      expect(snapshot['coveredThroughCursor'], 'c10b:2');

      await purchaseRepo.registerPurchase(fixturePurchaseCommand(deviceA));
      final later = await outboxA.leasePending(limit: 25);
      final laterResult = await transportA.uploadSubmission(later!);
      await outboxA.persistUploadResult(later.id, laterResult);
      expect(laterResult.code, SyncStatusCode.serverAccepted);

      final blockedCleanup = await runRecoveryLab(
        repo,
        account.value,
        deviceA.value,
        migratorPassword,
        'cleanup',
        environment: {
          'MARKEI_SYNC_LAB_CLEANUP_RUN_ID':
              '44444444-4444-4444-8444-444444444441',
        },
      );
      expect(blockedCleanup['deletedCount'], 0);
      await labPsql(lab, """
        update devices
           set lease_expires_at = now() - interval '1 second'
         where account_id='${account.value}' and device_id='${deviceC.value}';
      """);
      final cleanup = await runRecoveryLab(
        repo,
        account.value,
        deviceA.value,
        migratorPassword,
        'cleanup',
        environment: {
          'MARKEI_SYNC_LAB_CLEANUP_RUN_ID':
              '44444444-4444-4444-8444-444444444442',
        },
      );
      expect(cleanup['deletedCount'], 2);
      expect(await labCount(lab, 'sync_events'), 1);
      await expectLater(
        transportC.downloadAfter('c10b:0', limit: 25),
        throwsA(isA<StateError>()),
      );

      final sessionId = '55555555-5555-4555-8555-555555555555';
      final start = await transportC.startRecovery(
        recoverySessionId: sessionId,
        requestHash: canonicalUtf8Sha256({
          'recoverySessionId': sessionId,
          'deviceId': deviceC.value,
          'format': 1,
        }),
      );
      final progress = DriftRecoveryProgressRepository(c);
      await progress.saveSession(start);
      final firstChunk = await transportC.downloadChunk(sessionId, 0);
      await progress.saveChunk(sessionId, firstChunk);
      final resumed = await transportC.queryRecovery(sessionId);
      expect(resumed.id, sessionId);
      final chunks = <RecoveryChunk>[firstChunk];
      for (var i = 1; i < resumed.manifest.chunks.length; i++) {
        final chunk = await transportC.downloadChunk(sessionId, i);
        await progress.saveChunk(sessionId, chunk);
        chunks.add(chunk);
      }
      final corrupt = [...chunks];
      corrupt[0] = RecoveryChunk(
        index: corrupt[0].index,
        length: corrupt[0].length,
        hash: corrupt[0].hash,
        bytes: [...corrupt[0].bytes]..[0] = corrupt[0].bytes[0] ^ 1,
      );
      final corruptTarget = LocalDatabase.file(
        File('${temp.path}/corrupt.sqlite'),
      );
      addTearDown(corruptTarget.close);
      expect(
        (await DriftSnapshotFactApplier(
          corruptTarget,
        ).applySnapshotFacts(manifest: resumed.manifest, chunks: corrupt)).code,
        SyncStatusCode.conflict,
      );
      expect(
        await corruptTarget.select(corruptTarget.purchases).get(),
        isEmpty,
      );

      final apply = await DriftSnapshotFactApplier(c).applySnapshotFacts(
        manifest: resumed.manifest,
        chunks: await progress.loadedChunks(sessionId),
      );
      expect(apply.code, SyncStatusCode.downloadedApplied);
      final catchUp = await transportC.downloadAfter(
        resumed.manifest.coveredThroughCursor,
        limit: 25,
      );
      expect(catchUp.events, hasLength(1));
      final applierC = DriftRemoteEventApplier(c);
      expect(
        (await applierC.applyPage(catchUp)).code,
        SyncStatusCode.downloadedApplied,
      );
      final cCursor = (await applierC.greatestContiguousAppliedCursor())!;
      expect(
        (await transportC.acknowledge(cCursor)).code,
        SyncStatusCode.acknowledged,
      );
      expect(
        (await transportC.completeRecovery(
          recoverySessionId: sessionId,
          snapshotId: resumed.manifest.snapshotId,
          manifestHash: resumed.manifest.manifestHash,
          committedCatchUpCursor: cCursor,
        )).outcome,
        SyncOutcome.applied,
      );

      await c.close();
      final reopenedC = LocalDatabase.file(File('${temp.path}/c.sqlite'));
      addTearDown(reopenedC.close);
      expect(await reopenedC.select(reopenedC.purchases).get(), hasLength(3));
      expect(await a.select(a.purchases).get(), hasLength(3));
      expect(await b.select(b.purchases).get(), hasLength(2));

      final unsafe = LocalDatabase.file(File('${temp.path}/unsafe.sqlite'));
      addTearDown(unsafe.close);
      await seedLocalDevice(unsafe, account, deviceC);
      await LocalPurchaseRepository(
        unsafe,
      ).registerPurchase(fixturePurchaseCommand(deviceC));
      expect(
        (await DriftLocalRecoveryGuard(unsafe).ensureRebootstrapAllowed()).code,
        SyncStatusCode.localChangesBlockRebootstrap,
      );

      stdout.writeln('RECOVERY_CONVERGED=true');
    },
    timeout: const Timeout(Duration(minutes: 6)),
  );
}
