import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/hosted_sync_coordinator.dart';
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/application/sync/sync_use_cases.dart';
import 'package:http/http.dart' as http;
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/sync/canonical_json.dart';
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
      final timeoutTransport = labTransport(
        apiA.uri,
        CommitDropClient(),
        hostedDeviceId: deviceA.value,
      );
      final unknown = await timeoutTransport.uploadSubmission(first!);
      await outbox.persistUploadResult(first.id, unknown);
      expect(unknown.code, SyncStatusCode.unknownOutcome);
      final retry = await outbox.leasePending(limit: 25);
      expect(retry!.id, first.id);
      final accepted = await labTransport(
        apiA.uri,
        http.Client(),
        hostedDeviceId: deviceA.value,
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
        hostedDeviceId: deviceB.value,
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
        hostedDeviceId: deviceB.value,
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

  test(
    'ORDERED_OUTBOX_HTTP_PROOF=true for two-event hosted upload',
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
      final temp = await Directory.systemTemp.createTemp(
        'markei_ordered_outbox_',
      );
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

      final account = const AccountId('11111111-1111-4111-8111-111111111111');
      const device = DeviceId('22222222-2222-4222-8222-222222222222');
      final db = LocalDatabase.file(File('${temp.path}/local.sqlite'));
      addTearDown(db.close);
      await seedLocalDevice(db, account, device);
      final seq2 = orderedProofEvent(
        sequence: 2,
        accountId: account.value,
        deviceId: device.value,
      );
      final seq1 = orderedProofEvent(
        sequence: 1,
        accountId: account.value,
        deviceId: device.value,
      );
      await insertOrderedProofEvent(db, seq2);
      await insertOrderedProofEvent(db, seq1);
      final runtimePassword =
          'runtime-${DateTime.now().microsecondsSinceEpoch}';
      await labPsql(lab, """
        alter role markei_runtime login password '$runtimePassword';
        insert into accounts(account_id) values('${account.value}');
        insert into account_cursor_state(account_id, next_cursor) values('${account.value}', 1);
        insert into devices(account_id, device_id, status, next_expected_sequence)
          values('${account.value}', '${device.value}', 'active', 1);
      """);
      expect(
        await labInt(
          lab,
          "select next_expected_sequence from devices where account_id='${account.value}' and device_id='${device.value}'",
        ),
        1,
      );
      final api = await startLabApi(
        repo,
        account.value,
        device.value,
        runtimePassword,
      );
      addTearDown(api.close);
      final transport = labTransport(
        api.uri,
        http.Client(),
        hostedDeviceId: device.value,
      );

      final reversedEvents = [seq2, seq1];
      final reversedId = '11111111-2222-4333-8444-555555555555';
      final reversed = SyncUploadSubmission(
        id: reversedId,
        deviceId: device.value,
        requestHash: canonicalUtf8Sha256({
          'deviceId': device.value,
          'events': reversedEvents,
          'submissionId': reversedId,
        }),
        events: reversedEvents,
      );
      final rejected = await transport.uploadSubmission(reversed);
      expect(rejected.code, SyncStatusCode.sequenceGap);
      expect(await labCount(lab, 'sync_events'), 0);
      expect(await labCount(lab, 'submissions'), 0);

      final outbox = DriftSyncOutboxRepository.scoped(
        db,
        accountId: account,
        deviceId: device,
      );
      final submission = await outbox.leasePending(limit: 25);
      expect(
        submission!.events.map((event) => event['deviceSequence']).toList(),
        [1, 2],
      );
      final accepted = await transport.uploadSubmission(submission);
      await outbox.persistUploadResult(submission.id, accepted);
      expect(accepted.code, SyncStatusCode.serverAccepted);
      expect(await labCount(lab, 'sync_events'), 2);
      expect(await labCount(lab, 'submissions'), 1);
      expect(
        await labInt(
          lab,
          "select next_expected_sequence from devices where account_id='${account.value}' and device_id='${device.value}'",
        ),
        3,
      );
      final replay = await transport.uploadSubmission(submission);
      expect(replay.code, SyncStatusCode.serverAccepted);
      expect(await labCount(lab, 'sync_events'), 2);
      expect(await labCount(lab, 'submissions'), 1);
      stdout.writeln('ORDERED_OUTBOX_HTTP_PROOF=true sequences=1,2');
    },
    timeout: const Timeout(Duration(minutes: 4)),
  );

  test(
    'RECOVERY_ORCHESTRATION_HTTP_PROOF=true for coordinator recovery upload',
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
      final temp = await Directory.systemTemp.createTemp(
        'markei_recovery_orchestration_',
      );
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

      final account = const AccountId('11111111-1111-4111-8111-111111111111');
      const device = DeviceId('22222222-2222-4222-8222-222222222222');
      const localOnlyDevice = DeviceId('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb');
      var db = LocalDatabase.file(File('${temp.path}/local.sqlite'));
      addTearDown(() async {
        await db.close();
      });
      await seedLocalDevice(db, account, device);
      await seedLocalDevice(db, account, localOnlyDevice);
      await LocalPurchaseRepository(
        db,
      ).registerPurchase(fixturePurchaseCommand(device));
      await LocalPurchaseRepository(
        db,
      ).registerPurchase(fixturePurchaseCommand(device));
      final hostedEvents =
          await (db.select(db.syncEvents)
                ..where((table) => table.deviceId.equals(device.value))
                ..orderBy([(table) => OrderingTerm.asc(table.deviceSequence)]))
              .get();
      final seq1 = hostedEvents[0];
      final seq2 = hostedEvents[1];
      await (db.update(db.pendingEvents)
            ..where((table) => table.eventId.isIn([seq1.id, seq2.id])))
          .write(const PendingEventsCompanion(state: Value('failed')));
      await insertLegacyFailedSubmission(db, 'legacy-failed-submission', [
        seq2.id,
        seq1.id,
      ]);
      await LocalPurchaseRepository(
        db,
      ).registerPurchase(fixturePurchaseCommand(localOnlyDevice));
      final localOnlyEvent =
          await (db.select(
                db.syncEvents,
              )..where((table) => table.deviceId.equals(localOnlyDevice.value)))
              .getSingle();
      await db.close();
      db = LocalDatabase.file(File('${temp.path}/local.sqlite'));

      final runtimePassword =
          'runtime-${DateTime.now().microsecondsSinceEpoch}';
      await labPsql(lab, """
        alter role markei_runtime login password '$runtimePassword';
        insert into accounts(account_id) values('${account.value}');
        insert into account_cursor_state(account_id, next_cursor) values('${account.value}', 1);
        insert into devices(account_id, device_id, status, next_expected_sequence)
          values('${account.value}', '${device.value}', 'active', 1);
      """);
      expect(
        await labInt(
          lab,
          "select next_expected_sequence from devices where account_id='${account.value}' and device_id='${device.value}'",
        ),
        1,
      );
      final api = await startLabApi(
        repo,
        account.value,
        device.value,
        runtimePassword,
      );
      addTearDown(api.close);
      final transport = labTransport(
        api.uri,
        http.Client(),
        hostedDeviceId: device.value,
      );
      final outbox = DriftSyncOutboxRepository.scoped(
        db,
        accountId: account,
        deviceId: device,
      );
      final applier = DriftRemoteEventApplier.scoped(db, accountId: account);
      final coordinator = HostedSyncCoordinator(
        authenticationSession: const _SignedInSession(),
        syncGuard: const _AllowedGuard(),
        applier: applier,
        recoverFailedNotApplied: RecoverFailedNotApplied(outbox),
        uploadPendingEvents: UploadPendingEvents(outbox, transport),
        downloadAndApplyEvents: DownloadAndApplyEvents(transport, applier),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(transport, applier),
      );

      expect((await coordinator.run('native')).state, 'sync-completed');
      expect(await labCount(lab, 'sync_events'), 2);
      expect(await labCount(lab, 'submissions'), 1);
      expect(
        await labInt(
          lab,
          "select next_expected_sequence from devices where account_id='${account.value}' and device_id='${device.value}'",
        ),
        3,
      );
      expect(
        (await db.select(db.syncSubmissions).get()).where(
          (row) => row.state == 'superseded',
        ),
        hasLength(1),
      );
      expect(
        (await db.select(db.pendingEvents).get()).where(
          (row) => row.state == 'accepted',
        ),
        hasLength(2),
      );
      expect(
        (await db.select(db.pendingEvents).get())
            .where((row) => row.state == 'pending')
            .map((row) => row.eventId),
        [localOnlyEvent.id],
      );

      expect((await coordinator.run('native')).state, 'sync-completed');
      expect(await labCount(lab, 'sync_events'), 2);
      expect(await labCount(lab, 'submissions'), 1);
      stdout.writeln('RECOVERY_ORCHESTRATION_HTTP_PROOF=true sequences=1,2');
    },
    timeout: const Timeout(Duration(minutes: 4)),
  );
}

final class _SignedInSession implements ExternalAuthenticationSession {
  const _SignedInSession();

  @override
  Future<ExternalAuthenticationState> currentState() async => const SignedIn();

  @override
  Future<void> logout() async {}

  @override
  Future<ExternalAuthenticationState> signIn() async => const SignedIn();
}

final class _AllowedGuard implements HostedSyncGuard {
  const _AllowedGuard();

  @override
  Future<HostedSyncDecision> evaluate(String environmentAlias) async =>
      const HostedSyncDecision.allowed('22222222-2222-4222-8222-222222222222');
}
