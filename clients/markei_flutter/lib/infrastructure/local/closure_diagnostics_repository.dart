// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import '../../application/closure_diagnostics.dart';
import '../../domain/shared/ids.dart';
import 'local_database.dart';

final class DriftClosureDiagnosticsRepository
    implements ClosureDiagnosticsQuery, SyncAttemptRecorder {
  DriftClosureDiagnosticsRepository(
    this._db, {
    required AccountId accountId,
    required DeviceId deviceId,
    required String environmentAlias,
    DateTime Function()? now,
  }) : _accountId = accountId.value,
       _deviceId = deviceId.value,
       _environmentAlias = environmentAlias,
       _now = now ?? (() => DateTime.now().toUtc());

  final LocalDatabase _db;
  final String _accountId;
  final String _deviceId;
  final String _environmentAlias;
  final DateTime Function() _now;

  @override
  Future<int> beginSyncAttempt() async {
    return _db
        .into(_db.syncAttempts)
        .insert(
          SyncAttemptsCompanion.insert(
            accountId: _accountId,
            environmentAlias: _environmentAlias,
            startedAt: _now(),
            phase: 'started',
            resultCode: 'sync-started',
            outcomeClass: 'in-progress',
          ),
        );
  }

  @override
  Future<void> completeSyncAttempt(
    int attemptId, {
    required String resultCode,
    required String outcomeClass,
    required String phase,
    String? recoveryCode,
  }) async {
    await (_db.update(_db.syncAttempts)..where(
          (table) =>
              table.id.equals(attemptId) &
              table.accountId.equals(_accountId) &
              table.environmentAlias.equals(_environmentAlias) &
              table.completedAt.isNull(),
        ))
        .write(
          SyncAttemptsCompanion(
            completedAt: Value(_now()),
            phase: Value(_sanitizeCode(phase)),
            resultCode: Value(_sanitizeCode(resultCode)),
            outcomeClass: Value(_sanitizeCode(outcomeClass)),
            recoveryCode: Value(
              recoveryCode == null ? null : _sanitizeCode(recoveryCode),
            ),
          ),
        );
  }

  @override
  Future<void> clearAttemptHistory() async {
    await (_db.delete(_db.syncAttempts)..where(
          (table) =>
              table.accountId.equals(_accountId) &
              table.environmentAlias.equals(_environmentAlias),
        ))
        .go();
  }

  @override
  Future<ClosureDiagnosticsSnapshot> snapshot({
    required String authenticationState,
  }) async {
    final hosted =
        await (_db.select(_db.hostedAuthStates)..where(
              (table) => table.environmentAlias.equals(_environmentAlias),
            ))
            .getSingleOrNull();
    final devices =
        await (_db.select(_db.devices)
              ..where((table) => table.accountId.equals(_accountId))
              ..orderBy([
                (table) => OrderingTerm.desc(table.id.equals(_deviceId)),
                (table) => OrderingTerm.asc(table.createdAt),
                (table) => OrderingTerm.asc(table.id),
              ]))
            .get();
    final currentDevice = devices
        .where((device) => device.id == _deviceId)
        .firstOrNull;
    final counts = await _queueCounts();
    final attempts = await _recentAttempts();
    final events = await _recentActionableEvents();
    final lastSuccess = await _lastSuccessfulSync();
    final enrollmentState = hosted?.enrollmentState ?? 'enrollment-required';
    final readiness = _readiness(authenticationState, enrollmentState, counts);
    final lastResult = attempts.isEmpty
        ? 'no-recorded-attempts'
        : attempts.first.resultCode;
    return ClosureDiagnosticsSnapshot(
      authenticationState: authenticationState,
      enrollmentState: enrollmentState,
      syncReadiness: readiness,
      lastResult: lastResult,
      queueCounts: counts,
      nextDeviceSequence: currentDevice?.nextSequence,
      lastSuccessfulSyncAt: lastSuccess,
      recoveryGuidance: _guidance(authenticationState, enrollmentState, counts),
      recentAttempts: attempts,
      devices: [
        for (final device in devices)
          ClosureDeviceSummary(
            fingerprint: _fingerprint(device.id),
            isCurrent: device.id == _deviceId,
            enrollmentState: device.id == hosted?.serverDeviceId
                ? enrollmentState
                : 'local-only',
            nextSequence: device.nextSequence,
          ),
      ],
      actionableEvents: events,
      refreshedAt: _now(),
    );
  }

  Future<ClosureQueueCounts> _queueCounts() async {
    final rows = await (_db.select(_db.pendingEvents).join([
      innerJoin(
        _db.syncEvents,
        _db.syncEvents.id.equalsExp(_db.pendingEvents.eventId),
      ),
    ])..where(_db.syncEvents.accountId.equals(_accountId))).get();
    var pending = 0;
    var uploading = 0;
    var failed = 0;
    var unknown = 0;
    for (final row in rows) {
      switch (row.readTable(_db.pendingEvents).state) {
        case 'pending':
          pending++;
        case 'uploading':
          uploading++;
        case 'failed':
          failed++;
        case 'unknown':
          unknown++;
      }
    }
    return ClosureQueueCounts(
      pending: pending,
      uploading: uploading,
      failed: failed,
      unknown: unknown,
    );
  }

  Future<List<ClosureSyncAttemptSummary>> _recentAttempts() async {
    final rows =
        await (_db.select(_db.syncAttempts)
              ..where(
                (table) =>
                    table.accountId.equals(_accountId) &
                    table.environmentAlias.equals(_environmentAlias),
              )
              ..orderBy([
                (table) => OrderingTerm.desc(table.startedAt),
                (table) => OrderingTerm.desc(table.id),
              ])
              ..limit(20))
            .get();
    return [
      for (final row in rows)
        ClosureSyncAttemptSummary(
          fingerprint: _fingerprint('attempt:${row.id}'),
          startedAt: row.startedAt,
          completedAt: row.completedAt,
          duration: row.completedAt?.difference(row.startedAt),
          phase: row.phase,
          resultCode: row.resultCode,
          outcomeClass: row.outcomeClass,
          recoveryCode: row.recoveryCode,
        ),
    ];
  }

  Future<List<ClosureActionableEventSummary>> _recentActionableEvents() async {
    final rows =
        await (_db.select(_db.pendingEvents).join([
                innerJoin(
                  _db.syncEvents,
                  _db.syncEvents.id.equalsExp(_db.pendingEvents.eventId),
                ),
              ])
              ..where(
                _db.syncEvents.accountId.equals(_accountId) &
                    _db.pendingEvents.state.isIn([
                      'pending',
                      'failed',
                      'unknown',
                    ]),
              )
              ..orderBy([
                OrderingTerm.desc(_db.pendingEvents.enqueuedAt),
                OrderingTerm.asc(_db.syncEvents.deviceSequence),
                OrderingTerm.asc(_db.syncEvents.id),
              ])
              ..limit(20))
            .get();
    return [
      for (final row in rows)
        ClosureActionableEventSummary(
          fingerprint: _fingerprint(row.readTable(_db.syncEvents).id),
          eventType: row.readTable(_db.syncEvents).eventType,
          deviceSequence: row.readTable(_db.syncEvents).deviceSequence,
          state: row.readTable(_db.pendingEvents).state,
          enqueuedAt: row.readTable(_db.pendingEvents).enqueuedAt,
          occurredAt: row.readTable(_db.syncEvents).occurrenceTime,
        ),
    ];
  }

  Future<DateTime?> _lastSuccessfulSync() async {
    final row =
        await (_db.select(_db.syncAttempts)
              ..where(
                (table) =>
                    table.accountId.equals(_accountId) &
                    table.environmentAlias.equals(_environmentAlias) &
                    table.outcomeClass.equals('completed') &
                    table.completedAt.isNotNull(),
              )
              ..orderBy([
                (table) => OrderingTerm.desc(table.completedAt),
                (table) => OrderingTerm.desc(table.id),
              ])
              ..limit(1))
            .getSingleOrNull();
    return row?.completedAt;
  }

  String _readiness(
    String authenticationState,
    String enrollmentState,
    ClosureQueueCounts counts,
  ) {
    if (authenticationState != 'authenticated') {
      return 'authentication-required';
    }
    if (!_activeEnrollmentStates.contains(enrollmentState)) {
      return 'device-enrollment-required';
    }
    if (counts.unknown > 0) return 'unknown-work-needs-review';
    if (counts.failed > 0) return 'failed-work-needs-review';
    if (counts.uploading > 0) return 'upload-in-progress-or-interrupted';
    if (counts.pending > 0) return 'ready-with-pending-work';
    return 'ready-no-local-work';
  }

  String _guidance(
    String authenticationState,
    String enrollmentState,
    ClosureQueueCounts counts,
  ) {
    if (authenticationState != 'authenticated') return 'sign-in-required';
    if (!_activeEnrollmentStates.contains(enrollmentState)) {
      return 'enroll-or-query-device';
    }
    if (counts.unknown > 0 || counts.failed > 0) {
      return 'review-local-sync-state-before-retry';
    }
    if (counts.pending > 0) return 'sync-can-upload-local-work';
    return 'no-local-sync-action-needed';
  }
}

const _activeEnrollmentStates = {'device-enrolled', 'duplicate-equivalent'};

String _fingerprint(String value) {
  final digest = sha256.convert(utf8.encode(value)).toString();
  return digest.substring(0, 8);
}

String _sanitizeCode(String value) {
  final sanitized = value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9._:-]+'), '-')
      .replaceAll(RegExp('-+'), '-')
      .replaceAll(RegExp('^-|-\$'), '');
  if (sanitized.isEmpty) {
    return 'unavailable';
  }
  return sanitized.length <= 64 ? sanitized : sanitized.substring(0, 64);
}
