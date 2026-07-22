import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/sync/canonical_json.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/closure_diagnostics_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/sync/local_sync_repositories.dart';

void main() {
  const accountA = AccountId('11111111-1111-4111-8111-111111111111');
  const accountB = AccountId('99999999-9999-4999-8999-999999999999');
  const deviceA = DeviceId('22222222-2222-4222-8222-222222222222');
  const deviceB = DeviceId('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa');
  const environment = 'provider-native';

  test('snapshot is scoped, ordered, bounded and redacted', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    await _seedAccount(db, accountA.value, deviceA.value);
    await _seedAccount(db, accountB.value, deviceB.value);
    await db
        .into(db.hostedAuthStates)
        .insert(
          HostedAuthStatesCompanion.insert(
            environmentAlias: environment,
            installationId: 'install-fixture',
            enrollmentState: 'device-enrolled',
            updatedAt: DateTime.utc(2026, 7, 21),
            accountId: Value(accountA.value),
            serverDeviceId: Value(deviceA.value),
            generation: const Value(1),
          ),
        );
    for (var i = 0; i < 25; i++) {
      await _insertEvent(
        db,
        accountId: accountA.value,
        deviceId: deviceA.value,
        index: i,
        state: i.isEven ? 'pending' : 'failed',
      );
      final id = await DriftClosureDiagnosticsRepository(
        db,
        accountId: accountA,
        deviceId: deviceA,
        environmentAlias: environment,
        now: () => DateTime.utc(2026, 7, 21, 12, i),
      ).beginSyncAttempt();
      await DriftClosureDiagnosticsRepository(
        db,
        accountId: accountA,
        deviceId: deviceA,
        environmentAlias: environment,
        now: () => DateTime.utc(2026, 7, 21, 12, i, 1),
      ).completeSyncAttempt(
        id,
        resultCode: i == 24 ? 'sync-completed' : 'sync-unavailable',
        outcomeClass: i == 24 ? 'completed' : 'unavailable',
        phase: 'completed',
      );
    }
    await _insertEvent(
      db,
      accountId: accountB.value,
      deviceId: deviceB.value,
      index: 100,
      state: 'unknown',
    );

    final repository = DriftClosureDiagnosticsRepository(
      db,
      accountId: accountA,
      deviceId: deviceA,
      environmentAlias: environment,
      now: () => DateTime.utc(2026, 7, 21, 14),
    );
    final snapshot = await repository.snapshot(
      authenticationState: 'authenticated',
    );

    expect(snapshot.queueCounts.pending, 13);
    expect(snapshot.queueCounts.failed, 12);
    expect(snapshot.queueCounts.unknown, 0);
    expect(snapshot.recentAttempts, hasLength(20));
    expect(snapshot.actionableEvents, hasLength(20));
    expect(snapshot.recentAttempts.first.resultCode, 'sync-completed');
    expect(
      snapshot.lastSuccessfulSyncAt?.toUtc(),
      DateTime.utc(2026, 7, 21, 12, 24, 1),
    );
    expect(snapshot.devices.single.fingerprint, isNot(contains('-')));
    expect(snapshot.devices.single.fingerprint, isNot(deviceA.value));
    expect(snapshot.actionableEvents.first.fingerprint, isNot(contains('-')));
    expect(snapshot.syncReadiness, 'failed-work-needs-review');
  });

  test(
    'clear history preserves queue, Device, binding and cursor state',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      await _seedAccount(db, accountA.value, deviceA.value);
      await db
          .into(db.hostedAuthStates)
          .insert(
            HostedAuthStatesCompanion.insert(
              environmentAlias: environment,
              installationId: 'install-fixture',
              enrollmentState: 'device-enrolled',
              updatedAt: DateTime.utc(2026, 7, 21),
              accountId: Value(accountA.value),
              serverDeviceId: Value(deviceA.value),
              generation: const Value(1),
            ),
          );
      await _insertEvent(
        db,
        accountId: accountA.value,
        deviceId: deviceA.value,
        index: 1,
        state: 'pending',
      );
      final repository = DriftClosureDiagnosticsRepository(
        db,
        accountId: accountA,
        deviceId: deviceA,
        environmentAlias: environment,
      );
      final attempt = await repository.beginSyncAttempt();
      await repository.completeSyncAttempt(
        attempt,
        resultCode: 'sync-interrupted',
        outcomeClass: 'unknown',
        phase: 'transport-or-closure',
        recoveryCode: 'retry-after-local-review',
      );

      await repository.clearAttemptHistory();

      expect(await db.select(db.syncAttempts).get(), isEmpty);
      expect(await db.select(db.pendingEvents).get(), hasLength(1));
      expect((await db.select(db.devices).get()).single.nextSequence, 1);
      expect(await db.select(db.hostedAuthStates).get(), hasLength(1));
      expect((await db.select(db.syncState).get()).single.accountCursor, 'c1');
    },
  );

  test('records one terminal hosted connection diagnostic attempt', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    await _seedAccount(db, accountA.value, deviceA.value);
    final repository = DriftClosureDiagnosticsRepository(
      db,
      accountId: accountA,
      deviceId: deviceA,
      environmentAlias: environment,
      now: () => DateTime.utc(2026, 7, 21, 15),
    );

    final attempt = await repository.beginDiagnosticAttempt(
      operationKind: 'hosted-connection-check',
      latestStage: 'preflight-passed',
      resultCode: 'hosted-connection-check-started',
      outcomeClass: 'in-progress',
      correlationFingerprint: 'corr\r\nsecret',
    );
    await repository.completeDiagnosticAttempt(
      attempt,
      operationKind: 'hosted-connection-check',
      latestStage: 'response-parsed',
      resultCode: 'hosted-connection-ready',
      outcomeClass: 'completed',
      recoveryCode: 'ready-does-not-prove-sync',
      correlationFingerprint: 'corr\r\nsecret',
      elapsedBand: 'lt-1s',
      httpStatus: 200,
      responseHeadersReceived: true,
    );
    await repository.completeDiagnosticAttempt(
      attempt,
      operationKind: 'hosted-connection-check',
      latestStage: 'response-parsed',
      resultCode: 'duplicate-finalization',
      outcomeClass: 'completed',
      recoveryCode: 'ready-does-not-prove-sync',
      correlationFingerprint: 'other',
      elapsedBand: 'lt-1s',
      httpStatus: 200,
      responseHeadersReceived: true,
    );

    final rows = await db.select(db.syncAttempts).get();
    expect(rows, hasLength(1));
    expect(rows.single.operationKind, 'hosted-connection-check');
    expect(rows.single.latestStage, 'response-parsed');
    expect(rows.single.resultCode, 'hosted-connection-ready');
    expect(rows.single.correlationFingerprint, isNot(contains('\n')));
    expect(rows.single.elapsedBand, 'lt-1s');
    expect(rows.single.httpStatus, 200);
    expect(rows.single.responseHeadersReceived, isTrue);
  });

  test(
    'unknown retry preflight proves exact persisted submission shape',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      await _seedAccount(db, accountA.value, deviceA.value, nextSequence: 3);
      await _seedHostedBinding(db, accountA.value, deviceA.value, environment);
      final seq1 = _validEvent(1);
      final seq2 = _validEvent(2);
      await _insertValidEvent(db, seq2, state: 'unknown');
      await _insertValidEvent(db, seq1, state: 'unknown');
      final requestHash = await _insertUnknownSubmission(db, 'unknown-one', [
        seq1,
        seq2,
      ]);
      final repository = DriftClosureDiagnosticsRepository(
        db,
        accountId: accountA,
        deviceId: deviceA,
        environmentAlias: environment,
      );

      final preflight = await repository.unknownSubmissionRetryPreflight(
        authenticationState: 'authenticated',
      );
      final retry = await DriftSyncOutboxRepository.scoped(
        db,
        accountId: accountA,
        deviceId: deviceA,
      ).leasePending(limit: 25);

      expect(preflight.eligible, isTrue);
      expect(preflight.state, 'unknown-retry-eligible');
      expect(preflight.eventCount, 2);
      expect(preflight.firstDeviceSequence, 1);
      expect(preflight.lastDeviceSequence, 2);
      expect(preflight.nextLocalDeviceSequence, 3);
      expect(preflight.submissionFingerprint, hasLength(8));
      expect(preflight.submissionFingerprint, isNot(contains('unknown-one')));
      expect(retry!.id, 'unknown-one');
      expect(retry.requestHash, requestHash);
      expect(retry.events.map((event) => event['deviceSequence']), [1, 2]);
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

  test('unknown retry preflight blocks malformed persisted identity', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    await _seedAccount(db, accountA.value, deviceA.value, nextSequence: 3);
    await _seedHostedBinding(db, accountA.value, deviceA.value, environment);
    final seq1 = _validEvent(1);
    final seq2 = _validEvent(2);
    await _insertValidEvent(db, seq1, state: 'unknown');
    await _insertValidEvent(db, seq2, state: 'unknown');
    await _insertUnknownSubmission(db, 'unknown-one', [seq1, seq2]);
    await (db.update(db.syncSubmissions)
          ..where((table) => table.id.equals('unknown-one')))
        .write(const SyncSubmissionsCompanion(requestHash: Value('bad')));

    final preflight = await DriftClosureDiagnosticsRepository(
      db,
      accountId: accountA,
      deviceId: deviceA,
      environmentAlias: environment,
    ).unknownSubmissionRetryPreflight(authenticationState: 'authenticated');

    expect(preflight.eligible, isFalse);
    expect(preflight.state, 'unknown-retry-state-invalid');
    expect(
      (await db.select(db.pendingEvents).get()).map((row) => row.state),
      everyElement('unknown'),
    );
  });

  test(
    'unknown retry preflight fails closed for ambiguous candidates',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      await _seedAccount(db, accountA.value, deviceA.value, nextSequence: 3);
      await _seedHostedBinding(db, accountA.value, deviceA.value, environment);
      final seq1 = _validEvent(1);
      final seq2 = _validEvent(2);
      await _insertValidEvent(db, seq1, state: 'unknown');
      await _insertValidEvent(db, seq2, state: 'unknown');
      await _insertUnknownSubmission(db, 'unknown-one', [seq1]);
      await _insertUnknownSubmission(db, 'unknown-two', [seq2]);

      final preflight = await DriftClosureDiagnosticsRepository(
        db,
        accountId: accountA,
        deviceId: deviceA,
        environmentAlias: environment,
      ).unknownSubmissionRetryPreflight(authenticationState: 'authenticated');

      expect(preflight.eligible, isFalse);
      expect(preflight.state, 'unknown-retry-ambiguous-unresolved-submission');
      expect(
        (await db.select(db.syncSubmissions).get()).map((row) => row.state),
        everyElement('unknown'),
      );
    },
  );

  test(
    'unknown retry preflight blocks unauthenticated and non-isolated queues',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      await _seedAccount(db, accountA.value, deviceA.value, nextSequence: 3);
      await _seedHostedBinding(db, accountA.value, deviceA.value, environment);
      final seq1 = _validEvent(1);
      final seq2 = _validEvent(2);
      await _insertValidEvent(db, seq1, state: 'unknown');
      await _insertValidEvent(db, seq2, state: 'pending');
      await _insertUnknownSubmission(db, 'unknown-one', [seq1]);
      final repository = DriftClosureDiagnosticsRepository(
        db,
        accountId: accountA,
        deviceId: deviceA,
        environmentAlias: environment,
      );

      expect(
        (await repository.unknownSubmissionRetryPreflight(
          authenticationState: 'signed-out',
        )).state,
        'unknown-retry-authentication-required',
      );
      expect(
        (await repository.unknownSubmissionRetryPreflight(
          authenticationState: 'authenticated',
        )).state,
        'unknown-retry-queue-not-isolated',
      );
    },
  );
}

Future<void> _seedAccount(
  LocalDatabase db,
  String accountId,
  String deviceId, {
  int nextSequence = 1,
}) async {
  final now = DateTime.utc(2026, 7, 21);
  await db
      .into(db.localAccounts)
      .insert(
        LocalAccountsCompanion.insert(
          id: accountId,
          defaultCurrencyCode: 'BRL',
          createdAt: now,
        ),
      );
  await db
      .into(db.devices)
      .insert(
        DevicesCompanion.insert(
          id: deviceId,
          accountId: accountId,
          nextSequence: nextSequence,
          createdAt: now,
        ),
      );
  await db
      .into(db.syncState)
      .insert(
        SyncStateCompanion.insert(
          accountId: accountId,
          accountCursor: const Value('c1'),
          updatedAt: now,
        ),
      );
}

Future<void> _seedHostedBinding(
  LocalDatabase db,
  String accountId,
  String deviceId,
  String environment,
) async {
  await db
      .into(db.hostedAuthStates)
      .insert(
        HostedAuthStatesCompanion.insert(
          environmentAlias: environment,
          installationId: 'install-fixture',
          enrollmentState: 'device-enrolled',
          updatedAt: DateTime.utc(2026, 7, 21),
          accountId: Value(accountId),
          serverDeviceId: Value(deviceId),
          generation: const Value(1),
        ),
      );
}

Future<void> _insertEvent(
  LocalDatabase db, {
  required String accountId,
  required String deviceId,
  required int index,
  required String state,
}) async {
  final now = DateTime.utc(2026, 7, 21, 10, index % 60);
  final eventId = 'event-${accountId.substring(0, 4)}-$index';
  await db
      .into(db.syncEvents)
      .insert(
        SyncEventsCompanion.insert(
          id: eventId,
          accountId: accountId,
          deviceId: deviceId,
          deviceSequence: index + 1,
          eventType: 'purchase.registered.v3',
          payloadVersion: 3,
          occurrenceTime: now,
          payloadJson: '{}',
          contentHash: 'hash-$index',
          createdAt: now,
        ),
      );
  await db
      .into(db.pendingEvents)
      .insert(
        PendingEventsCompanion.insert(
          eventId: eventId,
          state: state,
          enqueuedAt: now,
        ),
      );
}

Future<void> _insertValidEvent(
  LocalDatabase db,
  Map<String, Object?> event, {
  required String state,
}) async {
  final sequence = event['deviceSequence']! as int;
  final now = DateTime.utc(2026, 7, 21, 11, sequence);
  await db
      .into(db.syncEvents)
      .insert(
        SyncEventsCompanion.insert(
          id: event['eventId']! as String,
          accountId: event['accountId']! as String,
          deviceId: event['deviceId']! as String,
          deviceSequence: sequence,
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
  final now = DateTime.utc(2026, 7, 21, 12);
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

Map<String, Object?> _validEvent(int sequence) {
  final content = <String, Object?>{
    'eventId': 'event-$sequence',
    'accountId': '11111111-1111-4111-8111-111111111111',
    'deviceId': '22222222-2222-4222-8222-222222222222',
    'deviceSequence': sequence,
    'eventType': 'purchase.registered.v3',
    'payloadVersion': 3,
    'occurrenceTime': DateTime.utc(2026, 7, 21, 10, sequence).toIso8601String(),
    'payload': <String, Object?>{
      'purchase': <String, Object?>{'fingerprint': 'purchase-$sequence'},
      'productSnapshots': <Object?>[],
    },
  };
  return {...content, 'contentHash': canonicalUtf8Sha256(content)};
}
