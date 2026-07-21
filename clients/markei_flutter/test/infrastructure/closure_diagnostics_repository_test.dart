import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/closure_diagnostics_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';

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
}

Future<void> _seedAccount(
  LocalDatabase db,
  String accountId,
  String deviceId,
) async {
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
          nextSequence: 1,
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
