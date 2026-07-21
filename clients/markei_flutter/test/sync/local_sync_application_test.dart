import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:markei/application/register_purchase.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/hosted_sync_coordinator.dart';
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/application/sync/sync_use_cases.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/domain/sync/canonical_json.dart';
import 'package:markei/domain/sync/sync_event.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_device_identity_repository.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/sync/local_sync_repositories.dart';
import 'package:markei/infrastructure/local/sync/remote_purchase_event_applier.dart';
import 'package:markei/infrastructure/remote/http_sync_transport.dart';

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

  test(
    'file-backed outbox canonicalizes reversed physical event order',
    () async {
      final fixture = await _fileBackedOutboxFixture();
      final db = fixture.db;
      addTearDown(fixture.close);
      final account = const AccountId('11111111-1111-4111-8111-111111111111');
      const device = DeviceId('22222222-2222-4222-8222-222222222222');
      final seq2 = _eventPayload(sequence: 2, eventId: _eventId(2));
      final seq1 = _eventPayload(sequence: 1, eventId: _eventId(1));
      await _insertRawEvent(db, seq2);
      await _insertRawEvent(db, seq1);

      expect(await _legacyUnorderedLeaseSequences(db), [2, 1]);

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
      final members =
          await (db.select(db.syncSubmissionEvents)
                ..where((table) => table.submissionId.equals(submission.id))
                ..orderBy([(table) => OrderingTerm.asc(table.position)]))
              .get();
      expect(members.map((member) => member.eventId).toList(), [
        _eventId(1),
        _eventId(2),
      ]);
    },
  );

  test(
    'file-backed unknown retry reuses exact submission for sequences one and two',
    () async {
      final fixture = await _fileBackedOutboxFixture();
      final db = fixture.db;
      addTearDown(fixture.close);
      final seq2 = _eventPayload(sequence: 2, eventId: _eventId(2));
      final seq1 = _eventPayload(sequence: 1, eventId: _eventId(1));
      await _insertRawEvent(db, seq2, state: 'unknown');
      await _insertRawEvent(db, seq1, state: 'unknown');
      final requestHash = await _insertUnknownSubmission(db, 'unknown-one', [
        seq1,
        seq2,
      ]);

      final retry = await DriftSyncOutboxRepository.scoped(
        db,
        accountId: _accountId(),
        deviceId: _deviceId(),
      ).leasePending(limit: 25);

      expect(retry!.id, 'unknown-one');
      expect(retry.requestHash, requestHash);
      expect(retry.events.map((event) => event['deviceSequence']), [1, 2]);
      expect((await db.select(db.devices).getSingle()).nextSequence, 3);
      expect(
        (await db.select(db.syncSubmissions).getSingle()).state,
        'unknown',
      );
      expect(
        (await db.select(db.pendingEvents).get()).map((row) => row.state),
        everyElement('unknown'),
      );
    },
  );

  for (final scenario in [
    (
      name: 'accepted',
      result: const SyncResult(
        code: SyncStatusCode.serverAccepted,
        outcome: SyncOutcome.applied,
        retryable: false,
      ),
      expectedState: 'accepted',
    ),
    (
      name: 'duplicate-equivalent',
      result: const SyncResult(
        code: SyncStatusCode.duplicateIgnored,
        outcome: SyncOutcome.duplicateEquivalent,
        retryable: false,
      ),
      expectedState: 'accepted',
    ),
    (
      name: 'repeated-unknown',
      result: const SyncResult(
        code: SyncStatusCode.unknownOutcome,
        outcome: SyncOutcome.unknown,
        retryable: true,
      ),
      expectedState: 'unknown',
    ),
    (
      name: 'stable-not-applied',
      result: const SyncResult(
        code: SyncStatusCode.sequenceGap,
        outcome: SyncOutcome.notApplied,
        retryable: false,
        protocolCode: 'sequence-gap',
      ),
      expectedState: 'failed',
    ),
  ]) {
    test('same-submission unknown retry persists ${scenario.name}', () async {
      final fixture = await _fileBackedOutboxFixture();
      final db = fixture.db;
      addTearDown(fixture.close);
      final seq1 = _eventPayload(sequence: 1, eventId: _eventId(1));
      final seq2 = _eventPayload(sequence: 2, eventId: _eventId(2));
      await _insertRawEvent(db, seq2, state: 'unknown');
      await _insertRawEvent(db, seq1, state: 'unknown');
      final requestHash = await _insertUnknownSubmission(db, 'unknown-one', [
        seq1,
        seq2,
      ]);
      final transport = _RecordingUploadTransport(result: scenario.result);

      final result = await UploadPendingEvents(
        DriftSyncOutboxRepository.scoped(
          db,
          accountId: _accountId(),
          deviceId: _deviceId(),
        ),
        transport,
      )();

      final submission = await db.select(db.syncSubmissions).getSingle();
      expect(result, scenario.result);
      expect(transport.uploadCount, 1);
      expect(transport.uploadedSequences.single, [1, 2]);
      expect(submission.id, 'unknown-one');
      expect(submission.requestHash, requestHash);
      expect(submission.state, scenario.expectedState);
      expect(
        (await db.select(db.pendingEvents).get()).map((row) => row.state),
        everyElement(scenario.expectedState),
      );
    });
  }

  test('file-backed outbox preflight blocks non-contiguous batches', () async {
    final fixture = await _fileBackedOutboxFixture();
    final db = fixture.db;
    addTearDown(fixture.close);
    await _insertRawEvent(db, _eventPayload(sequence: 1, eventId: _eventId(1)));
    await _insertRawEvent(db, _eventPayload(sequence: 3, eventId: _eventId(3)));
    final transport = _RecordingUploadTransport();
    final upload = UploadPendingEvents(
      DriftSyncOutboxRepository(db),
      transport,
    );

    final result = await upload();

    expect(result!.code, SyncStatusCode.localBatchInvalid);
    expect(result.protocolCode, 'local-batch-invalid');
    expect(transport.uploadCount, 0);
    expect(await db.select(db.syncSubmissions).get(), isEmpty);
    expect(
      (await db.select(db.pendingEvents).get()).map((row) => row.state),
      everyElement('pending'),
    );
  });

  test(
    'ordinary sync cannot bypass a scoped unknown submission with pending work',
    () async {
      final fixture = await _fileBackedOutboxFixture();
      final db = fixture.db;
      addTearDown(fixture.close);
      final seq1 = _eventPayload(sequence: 1, eventId: _eventId(1));
      final seq2 = _eventPayload(sequence: 2, eventId: _eventId(2));
      await _insertRawEvent(db, seq1, state: 'unknown');
      await _insertRawEvent(db, seq2);
      await _insertUnknownSubmission(db, 'unknown-one', [seq1]);
      final transport = _RecordingUploadTransport();

      final result = await UploadPendingEvents(
        DriftSyncOutboxRepository.scoped(
          db,
          accountId: _accountId(),
          deviceId: _deviceId(),
        ),
        transport,
      )();

      expect(result!.code, SyncStatusCode.localBatchInvalid);
      expect(transport.uploadCount, 0);
      expect(
        (await db.select(db.pendingEvents).get()).map((row) => row.state),
        containsAll(['unknown', 'pending']),
      );
    },
  );

  test('ordinary sync fails closed for multiple unknown submissions', () async {
    final fixture = await _fileBackedOutboxFixture();
    final db = fixture.db;
    addTearDown(fixture.close);
    final seq1 = _eventPayload(sequence: 1, eventId: _eventId(1));
    final seq2 = _eventPayload(sequence: 2, eventId: _eventId(2));
    await _insertRawEvent(db, seq1, state: 'unknown');
    await _insertRawEvent(db, seq2, state: 'unknown');
    await _insertUnknownSubmission(db, 'unknown-one', [seq1]);
    await _insertUnknownSubmission(db, 'unknown-two', [seq2]);
    final transport = _RecordingUploadTransport();

    final result = await UploadPendingEvents(
      DriftSyncOutboxRepository.scoped(
        db,
        accountId: _accountId(),
        deviceId: _deviceId(),
      ),
      transport,
    )();

    expect(result!.code, SyncStatusCode.localBatchInvalid);
    expect(transport.uploadCount, 0);
    expect(
      (await db.select(db.syncSubmissions).get()).map((row) => row.state),
      everyElement('unknown'),
    );
  });

  test(
    'file-backed failed notApplied recovery requeues one ordered retry',
    () async {
      final fixture = await _fileBackedOutboxFixture();
      final db = fixture.db;
      addTearDown(fixture.close);
      final seq2 = _eventPayload(sequence: 2, eventId: _eventId(2));
      final seq1 = _eventPayload(sequence: 1, eventId: _eventId(1));
      await _insertRawEvent(db, seq2, state: 'failed');
      await _insertRawEvent(db, seq1, state: 'failed');
      await _insertFailedSubmission(db, 'failed-submission', [
        _eventId(2),
        _eventId(1),
      ]);
      final outbox = DriftSyncOutboxRepository(db);

      final recovered = await outbox.recoverFailedNotApplied(
        'failed-submission',
      );

      expect(recovered.code, SyncStatusCode.failedRecoveryAvailable);
      var failed = await (db.select(
        db.syncSubmissions,
      )..where((table) => table.id.equals('failed-submission'))).getSingle();
      expect(failed.state, 'superseded');
      await db.close();
      final reopened = LocalDatabase.file(fixture.file);
      fixture.db = reopened;
      final retry = await DriftSyncOutboxRepository(
        reopened,
      ).leasePending(limit: 25);
      expect(retry!.events.map((event) => event['deviceSequence']).toList(), [
        1,
        2,
      ]);
      expect(retry.id, isNot('failed-submission'));
      expect(
        await DriftSyncOutboxRepository(
          reopened,
        ).recoverFailedNotApplied('failed-submission'),
        isA<SyncResult>().having(
          (result) => result.code,
          'code',
          SyncStatusCode.failedRecoveryBlocked,
        ),
      );
    },
  );

  test('scoped recovery discovery reports no candidate as no-op', () async {
    final fixture = await _fileBackedOutboxFixture();
    final db = fixture.db;
    addTearDown(fixture.close);
    final result = await DriftSyncOutboxRepository.scoped(
      db,
      accountId: _accountId(),
      deviceId: _deviceId(),
    ).recoverOneFailedNotApplied();

    expect(result.code, SyncStatusCode.noRecoverableFailure);
    expect(result.protocolCode, 'no-recoverable-failure');
  });

  test('scoped recovery discovery blocks ambiguous candidates', () async {
    final fixture = await _fileBackedOutboxFixture();
    final db = fixture.db;
    addTearDown(fixture.close);
    await _insertRawEvent(
      db,
      _eventPayload(sequence: 1, eventId: _eventId(1)),
      state: 'failed',
    );
    await _insertFailedSubmission(db, 'failed-a', [_eventId(1)]);
    await _insertRawEvent(
      db,
      _eventPayload(sequence: 2, eventId: _eventId(2)),
      state: 'failed',
    );
    await _insertFailedSubmission(db, 'failed-b', [_eventId(2)]);

    final result = await DriftSyncOutboxRepository.scoped(
      db,
      accountId: _accountId(),
      deviceId: _deviceId(),
    ).recoverOneFailedNotApplied();

    expect(result.code, SyncStatusCode.failedRecoveryBlocked);
    expect(
      (await db.select(db.syncSubmissions).get()).map((row) => row.state),
      everyElement('failed'),
    );
  });

  test('scoped recovery discovery blocks malformed failed candidate', () async {
    final fixture = await _fileBackedOutboxFixture();
    final db = fixture.db;
    addTearDown(fixture.close);
    await _insertRawEvent(
      db,
      _eventPayload(sequence: 1, eventId: _eventId(1)),
      state: 'failed',
    );
    await _insertFailedSubmission(db, 'failed-gap', [_eventId(1)]);
    await (db.update(db.syncEvents)
          ..where((table) => table.id.equals(_eventId(1))))
        .write(const SyncEventsCompanion(deviceSequence: Value(3)));

    final result = await DriftSyncOutboxRepository.scoped(
      db,
      accountId: _accountId(),
      deviceId: _deviceId(),
    ).recoverOneFailedNotApplied();

    expect(result.code, SyncStatusCode.failedRecoveryBlocked);
    expect((await db.select(db.pendingEvents).getSingle()).state, 'failed');
  });

  test('scoped recovery ignores non-failed-notApplied states', () async {
    final fixture = await _fileBackedOutboxFixture();
    final db = fixture.db;
    addTearDown(fixture.close);
    await _insertRawEvent(
      db,
      _eventPayload(sequence: 1, eventId: _eventId(1)),
      state: 'unknown',
    );
    await _insertFailedSubmission(
      db,
      'unknown-submission',
      [_eventId(1)],
      state: 'unknown',
      outcome: SyncOutcome.unknown.name,
    );
    final result = await DriftSyncOutboxRepository.scoped(
      db,
      accountId: _accountId(),
      deviceId: _deviceId(),
    ).recoverOneFailedNotApplied();

    expect(result.code, SyncStatusCode.noRecoverableFailure);
    expect((await db.select(db.pendingEvents).getSingle()).state, 'unknown');
  });

  test('scoped recovery blocks missing membership and hash mismatch', () async {
    final missing = await _fileBackedOutboxFixture();
    addTearDown(missing.close);
    await _insertFailedSubmission(missing.db, 'missing-membership', []);
    expect(
      (await DriftSyncOutboxRepository.scoped(
        missing.db,
        accountId: _accountId(),
        deviceId: _deviceId(),
      ).recoverOneFailedNotApplied()).code,
      SyncStatusCode.failedRecoveryBlocked,
    );

    final mismatch = await _fileBackedOutboxFixture();
    addTearDown(mismatch.close);
    await _insertRawEvent(
      mismatch.db,
      _eventPayload(sequence: 1, eventId: _eventId(1)),
      state: 'failed',
    );
    await (mismatch.db.update(mismatch.db.syncEvents)
          ..where((table) => table.id.equals(_eventId(1))))
        .write(const SyncEventsCompanion(contentHash: Value('bad-hash')));
    await _insertFailedSubmission(mismatch.db, 'hash-mismatch', [_eventId(1)]);
    expect(
      (await DriftSyncOutboxRepository.scoped(
        mismatch.db,
        accountId: _accountId(),
        deviceId: _deviceId(),
      ).recoverOneFailedNotApplied()).code,
      SyncStatusCode.failedRecoveryBlocked,
    );
  });

  test(
    'scoped recovery leaves cross-device failed attempts untouched',
    () async {
      final fixture = await _fileBackedOutboxFixture();
      final db = fixture.db;
      addTearDown(fixture.close);
      const otherDevice = DeviceId('33333333-3333-4333-8333-333333333333');
      await db
          .into(db.devices)
          .insert(
            DevicesCompanion.insert(
              id: otherDevice.value,
              accountId: _accountId().value,
              nextSequence: 1,
              createdAt: DateTime.utc(2026, 7, 21),
            ),
          );
      final event = _eventPayload(sequence: 1, eventId: _eventId(1));
      await _insertRawEvent(db, {
        ...event,
        'deviceId': otherDevice.value,
      }, state: 'failed');
      await db
          .into(db.syncSubmissions)
          .insert(
            SyncSubmissionsCompanion.insert(
              id: 'other-device-failed',
              accountId: _accountId().value,
              deviceId: otherDevice.value,
              requestHash: 'legacy-request-hash',
              state: 'failed',
              outcome: const Value('notApplied'),
              responseCode: const Value('conflict'),
              attemptCount: const Value(1),
              createdAt: DateTime.utc(2026, 7, 21, 1),
              updatedAt: DateTime.utc(2026, 7, 21, 1),
            ),
          );

      final result = await DriftSyncOutboxRepository.scoped(
        db,
        accountId: _accountId(),
        deviceId: _deviceId(),
      ).recoverOneFailedNotApplied();

      expect(result.code, SyncStatusCode.noRecoverableFailure);
      expect((await db.select(db.syncSubmissions).getSingle()).state, 'failed');
    },
  );

  test(
    'coordinator discovers failed recovery and uploads canonically',
    () async {
      final fixture = await _fileBackedOutboxFixture();
      final db = fixture.db;
      addTearDown(fixture.close);
      await _insertRawEvent(
        db,
        _eventPayload(sequence: 2, eventId: _eventId(2)),
        state: 'failed',
      );
      await _insertRawEvent(
        db,
        _eventPayload(sequence: 1, eventId: _eventId(1)),
        state: 'failed',
      );
      await _insertFailedSubmission(db, 'legacy-failed', [
        _eventId(2),
        _eventId(1),
      ]);
      await db.close();
      final reopened = LocalDatabase.file(fixture.file);
      fixture.db = reopened;
      final outbox = DriftSyncOutboxRepository.scoped(
        reopened,
        accountId: _accountId(),
        deviceId: _deviceId(),
      );
      final transport = _RecordingUploadTransport();
      final coordinator = HostedSyncCoordinator(
        authenticationSession: const _SignedInSession(),
        syncGuard: const _AllowedGuard(),
        applier: _MemoryApplier(),
        recoverFailedNotApplied: RecoverFailedNotApplied(outbox),
        uploadPendingEvents: UploadPendingEvents(outbox, transport),
        downloadAndApplyEvents: DownloadAndApplyEvents(
          _DownloadOnlyTransport(),
          _MemoryApplier(),
        ),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
          _RecordingTransport(),
          _MemoryApplier(),
        ),
      );

      expect((await coordinator.run('native')).state, 'sync-completed');
      expect(transport.uploadCount, 1);
      expect(transport.uploadedSequences.single, [1, 2]);
      expect(
        (await reopened.select(reopened.syncSubmissions).get()).where(
          (row) => row.state == 'superseded',
        ),
        hasLength(1),
      );

      expect((await coordinator.run('native')).state, 'sync-completed');
      expect(transport.uploadCount, 1);
    },
  );

  test('concurrent scoped recovery creates one pending recovery', () async {
    final fixture = await _fileBackedOutboxFixture();
    final db = fixture.db;
    addTearDown(fixture.close);
    await _insertRawEvent(
      db,
      _eventPayload(sequence: 1, eventId: _eventId(1)),
      state: 'failed',
    );
    await _insertFailedSubmission(db, 'failed-submission', [_eventId(1)]);
    final outbox = DriftSyncOutboxRepository.scoped(
      db,
      accountId: _accountId(),
      deviceId: _deviceId(),
    );

    final results = await Future.wait([
      outbox.recoverOneFailedNotApplied(),
      outbox.recoverOneFailedNotApplied(),
    ]);

    expect(
      results.where(
        (result) => result.code == SyncStatusCode.failedRecoveryAvailable,
      ),
      hasLength(1),
    );
    expect((await db.select(db.pendingEvents).getSingle()).state, 'pending');
    expect(
      (await db.select(db.syncSubmissions).get()).where(
        (row) => row.state == 'superseded',
      ),
      hasLength(1),
    );
  });

  test(
    'unknown upload after recovery preserves same retry submission',
    () async {
      final fixture = await _fileBackedOutboxFixture();
      final db = fixture.db;
      addTearDown(fixture.close);
      await _insertRawEvent(
        db,
        _eventPayload(sequence: 1, eventId: _eventId(1)),
        state: 'failed',
      );
      await _insertFailedSubmission(db, 'failed-submission', [_eventId(1)]);
      final outbox = DriftSyncOutboxRepository.scoped(
        db,
        accountId: _accountId(),
        deviceId: _deviceId(),
      );
      await outbox.recoverOneFailedNotApplied();
      final upload = UploadPendingEvents(outbox, _UnknownUploadTransport());

      final result = await upload();
      final retry = await outbox.leasePending(limit: 25);

      expect(result!.code, SyncStatusCode.unknownOutcome);
      expect(retry!.id, isNot('failed-submission'));
      expect(retry.requestHash, isNotEmpty);
      expect(
        (await db.select(db.syncSubmissions).get()).where(
          (row) => row.state == 'unknown',
        ),
        hasLength(1),
      );
    },
  );

  test('file-backed recovery blocks unknown outcomes', () async {
    final fixture = await _fileBackedOutboxFixture();
    final db = fixture.db;
    addTearDown(fixture.close);
    await _insertRawEvent(
      db,
      _eventPayload(sequence: 1, eventId: _eventId(1)),
      state: 'unknown',
    );
    await _insertFailedSubmission(
      db,
      'unknown-submission',
      [_eventId(1)],
      state: 'unknown',
      outcome: SyncOutcome.unknown.name,
    );

    final result = await DriftSyncOutboxRepository(
      db,
    ).recoverFailedNotApplied('unknown-submission');

    expect(result.code, SyncStatusCode.failedRecoveryBlocked);
    expect((await db.select(db.pendingEvents).getSingle()).state, 'unknown');
  });

  test('HTTP upload preserves recognized not-applied protocol codes', () async {
    final cases = {
      'sequence-gap': SyncStatusCode.sequenceGap,
      'wrong-account': SyncStatusCode.wrongAccount,
      'hash-mismatch': SyncStatusCode.hashMismatch,
      'future-code': SyncStatusCode.conflict,
    };
    for (final entry in cases.entries) {
      final server = await _protocolFailureServer(entry.key);
      addTearDown(server.close);
      final transport = HttpSyncTransport(
        client: http.Client(),
        baseUri: Uri.parse('http://127.0.0.1:${server.port}'),
        tokenSource: () => 'fixture-token',
        correlationSource: () => 'fixture-correlation',
        hostedDeviceId: '22222222-2222-4222-8222-222222222222',
      );

      final result = await transport.uploadSubmission(
        const SyncUploadSubmission(
          id: 'submission-1',
          deviceId: '22222222-2222-4222-8222-222222222222',
          requestHash: 'request-hash',
          events: [],
        ),
      );

      expect(result.code, entry.value, reason: entry.key);
      expect(result.protocolCode, entry.key, reason: entry.key);
      expect(result.outcome, SyncOutcome.notApplied);
    }
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

final class _RecordingUploadTransport implements SyncTransport {
  _RecordingUploadTransport({
    this.result = const SyncResult(
      code: SyncStatusCode.serverAccepted,
      outcome: SyncOutcome.applied,
      retryable: false,
    ),
  });

  final SyncResult result;
  int uploadCount = 0;
  final uploadedSequences = <List<int>>[];

  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) {
    throw UnimplementedError();
  }

  @override
  Future<DownloadPage> downloadAfter(String? cursor, {required int limit}) {
    throw UnimplementedError();
  }

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) async {
    uploadCount++;
    uploadedSequences.add(
      submission.events
          .map((event) => event['deviceSequence']! as int)
          .toList(growable: false),
    );
    return result;
  }
}

final class _UnknownUploadTransport implements SyncTransport {
  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) {
    throw UnimplementedError();
  }

  @override
  Future<DownloadPage> downloadAfter(String? cursor, {required int limit}) {
    throw UnimplementedError();
  }

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) async {
    return const SyncResult(
      code: SyncStatusCode.unknownOutcome,
      outcome: SyncOutcome.unknown,
      retryable: true,
    );
  }
}

final class _DownloadOnlyTransport implements SyncTransport {
  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) {
    throw UnimplementedError();
  }

  @override
  Future<DownloadPage> downloadAfter(
    String? cursor, {
    required int limit,
  }) async {
    return const DownloadPage(nextCursor: 'c10b:0', events: []);
  }

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) {
    throw UnimplementedError();
  }
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

final class _FileBackedOutboxFixture {
  _FileBackedOutboxFixture(this.directory, this.file, this.db);

  final Directory directory;
  final File file;
  LocalDatabase db;

  Future<void> close() async {
    await db.close();
    await directory.delete(recursive: true);
  }
}

Future<_FileBackedOutboxFixture> _fileBackedOutboxFixture() async {
  final directory = await Directory.systemTemp.createTemp('markei-outbox-');
  final file = File('${directory.path}/local.sqlite');
  final db = LocalDatabase.file(file);
  final now = DateTime.utc(2026, 7, 21);
  await db
      .into(db.localAccounts)
      .insert(
        LocalAccountsCompanion.insert(
          id: '11111111-1111-4111-8111-111111111111',
          defaultCurrencyCode: 'BRL',
          createdAt: now,
        ),
      );
  await db
      .into(db.devices)
      .insert(
        DevicesCompanion.insert(
          id: '22222222-2222-4222-8222-222222222222',
          accountId: '11111111-1111-4111-8111-111111111111',
          nextSequence: 1,
          createdAt: now,
        ),
      );
  return _FileBackedOutboxFixture(directory, file, db);
}

AccountId _accountId() =>
    const AccountId('11111111-1111-4111-8111-111111111111');

DeviceId _deviceId() => const DeviceId('22222222-2222-4222-8222-222222222222');

Future<void> _insertRawEvent(
  LocalDatabase db,
  Map<String, Object?> event, {
  String state = 'pending',
}) async {
  final now = DateTime.utc(
    2026,
    7,
    21,
  ).add(Duration(milliseconds: event['deviceSequence']! as int));
  await db
      .into(db.syncEvents)
      .insert(
        SyncEventsCompanion.insert(
          id: event['eventId']! as String,
          accountId: event['accountId']! as String,
          deviceId: event['deviceId']! as String,
          deviceSequence: event['deviceSequence']! as int,
          eventType: event['eventType']! as String,
          payloadVersion: event['payloadVersion']! as int,
          occurrenceTime: DateTime.parse(event['occurrenceTime']! as String),
          payloadJson: jsonEncode(event),
          contentHash: event['contentHash']! as String,
          createdAt: now,
        ),
      );
  await db
      .into(db.pendingEvents)
      .insert(
        PendingEventsCompanion.insert(
          eventId: event['eventId']! as String,
          state: state,
          enqueuedAt: now,
        ),
      );
  await (db.update(db.devices)..where(
        (table) =>
            table.id.equals(event['deviceId']! as String) &
            table.accountId.equals(event['accountId']! as String) &
            table.nextSequence.isSmallerThanValue(
              (event['deviceSequence']! as int) + 1,
            ),
      ))
      .write(
        DevicesCompanion(
          nextSequence: Value((event['deviceSequence']! as int) + 1),
        ),
      );
}

Future<void> _insertFailedSubmission(
  LocalDatabase db,
  String submissionId,
  List<String> eventIds, {
  String state = 'failed',
  String outcome = 'notApplied',
}) async {
  final now = DateTime.utc(2026, 7, 21, 1);
  await db
      .into(db.syncSubmissions)
      .insert(
        SyncSubmissionsCompanion.insert(
          id: submissionId,
          accountId: '11111111-1111-4111-8111-111111111111',
          deviceId: '22222222-2222-4222-8222-222222222222',
          requestHash: 'legacy-request-hash',
          state: state,
          outcome: Value(outcome),
          responseCode: const Value('conflict'),
          attemptCount: const Value(1),
          createdAt: now,
          updatedAt: now,
        ),
      );
  for (var i = 0; i < eventIds.length; i++) {
    await db
        .into(db.syncSubmissionEvents)
        .insert(
          SyncSubmissionEventsCompanion.insert(
            submissionId: submissionId,
            eventId: eventIds[i],
            position: i,
          ),
        );
  }
}

Future<String> _insertUnknownSubmission(
  LocalDatabase db,
  String submissionId,
  List<Map<String, Object?>> events,
) async {
  final requestHash = canonicalUtf8Sha256({
    'deviceId': events.first['deviceId'],
    'events': events,
    'submissionId': submissionId,
  });
  final now = DateTime.utc(2026, 7, 21, 1);
  await db
      .into(db.syncSubmissions)
      .insert(
        SyncSubmissionsCompanion.insert(
          id: submissionId,
          accountId: events.first['accountId']! as String,
          deviceId: events.first['deviceId']! as String,
          requestHash: requestHash,
          state: 'unknown',
          outcome: const Value('unknown'),
          responseCode: const Value('unknownOutcome'),
          attemptCount: const Value(1),
          createdAt: now,
          updatedAt: now,
        ),
      );
  for (var i = 0; i < events.length; i++) {
    await db
        .into(db.syncSubmissionEvents)
        .insert(
          SyncSubmissionEventsCompanion.insert(
            submissionId: submissionId,
            eventId: events[i]['eventId']! as String,
            position: i,
          ),
        );
  }
  return requestHash;
}

Future<List<int>> _legacyUnorderedLeaseSequences(LocalDatabase db) async {
  final pendingQuery =
      db.select(db.pendingEvents).join([
          innerJoin(
            db.syncEvents,
            db.syncEvents.id.equalsExp(db.pendingEvents.eventId),
          ),
        ])
        ..where(db.pendingEvents.state.equals('pending'))
        ..limit(25);
  final pending = (await pendingQuery.get())
      .map((row) => row.readTable(db.pendingEvents))
      .toList(growable: false);
  final events =
      await (db.select(db.syncEvents)..where(
            (table) => table.id.isIn(
              pending.map((row) => row.eventId).toList(growable: false),
            ),
          ))
          .get();
  return events.map((event) => event.deviceSequence).toList(growable: false);
}

String _eventId(int sequence) => switch (sequence) {
  1 => '00000000-0000-4000-8000-999999999999',
  2 => '00000000-0000-4000-8000-000000000002',
  3 => '00000000-0000-4000-8000-000000000003',
  _ => '00000000-0000-4000-8000-${sequence.toString().padLeft(12, '0')}',
};

Map<String, Object?> _eventPayload({
  required int sequence,
  required String eventId,
}) {
  final content = <String, Object?>{
    'eventId': eventId,
    'accountId': '11111111-1111-4111-8111-111111111111',
    'deviceId': '22222222-2222-4222-8222-222222222222',
    'deviceSequence': sequence,
    'eventType': 'purchase.registered',
    'payloadVersion': 3,
    'occurrenceTime': DateTime.utc(2026, 7, 21, 12, sequence).toIso8601String(),
    'payload': <String, Object?>{
      'purchase': <String, Object?>{'id': 'purchase-$sequence'},
      'productSnapshots': <Object?>[],
    },
  };
  return {...content, 'contentHash': canonicalUtf8Sha256(content)};
}

Future<HttpServer> _protocolFailureServer(String code) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  server.listen((request) async {
    await request.drain<void>();
    request.response.statusCode = HttpStatus.conflict;
    request.response.headers.contentType = ContentType.json;
    request.response.write(
      jsonEncode({
        'code': code,
        'operation': 'upload-submission',
        'outcome': 'not-applied',
        'retryable': false,
        'safeAction': 'stop and preserve evidence',
        'correlationId': 'fixture-correlation',
      }),
    );
    await request.response.close();
  });
  return server;
}
