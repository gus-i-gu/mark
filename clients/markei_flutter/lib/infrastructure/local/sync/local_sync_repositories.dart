import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../application/sync/sync_ports.dart';
import '../../../domain/shared/ids.dart';
import '../../../domain/sync/canonical_json.dart';
import '../../../domain/sync/sync_event.dart' show SyncOutcome, SyncStatusCode;
import '../local_database.dart';

final class DriftSyncOutboxRepository implements SyncOutboxRepository {
  DriftSyncOutboxRepository(this._db, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid(),
      _accountId = null,
      _deviceId = null;

  DriftSyncOutboxRepository.scoped(
    this._db, {
    required AccountId accountId,
    required DeviceId deviceId,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid(),
       _accountId = accountId.value,
       _deviceId = deviceId.value;

  final LocalDatabase _db;
  final Uuid _uuid;
  final String? _accountId;
  final String? _deviceId;

  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) {
    return _db.transaction(() async {
      final now = DateTime.now().toUtc();
      final accountId = _accountId;
      final deviceId = _deviceId;
      var pendingPredicate = _db.pendingEvents.state.equals('pending');
      if (accountId != null && deviceId != null) {
        pendingPredicate =
            pendingPredicate &
            _db.syncEvents.accountId.equals(accountId) &
            _db.syncEvents.deviceId.equals(deviceId);
      }
      final pendingQuery =
          _db.select(_db.pendingEvents).join([
              innerJoin(
                _db.syncEvents,
                _db.syncEvents.id.equalsExp(_db.pendingEvents.eventId),
              ),
            ])
            ..where(pendingPredicate)
            ..orderBy([
              OrderingTerm.asc(_db.syncEvents.deviceSequence),
              OrderingTerm.asc(_db.syncEvents.id),
            ])
            ..limit(limit);
      final events = (await pendingQuery.get())
          .map((row) => row.readTable(_db.syncEvents))
          .toList(growable: false);
      final unknowns = await _unknownSubmissions();
      if (events.isNotEmpty && unknowns.isNotEmpty) {
        _throwLocalBatchInvalid();
      }
      if (events.isEmpty) {
        if (unknowns.isEmpty) {
          return null;
        }
        if (unknowns.length != 1) {
          _throwLocalBatchInvalid();
        }
        final unknown = unknowns.single;
        final members =
            await (_db.select(_db.syncSubmissionEvents)
                  ..where((table) => table.submissionId.equals(unknown.id))
                  ..orderBy([(table) => OrderingTerm.asc(table.position)]))
                .get();
        if (!_positionsAreContiguous(members)) {
          _throwLocalBatchInvalid();
        }
        final rows =
            await (_db.select(_db.syncEvents)..where(
                  (table) =>
                      table.id.isIn(members.map((row) => row.eventId).toList()),
                ))
                .get();
        final rowsById = {for (final row in rows) row.id: row};
        final orderedRows = [
          for (final member in members) rowsById[member.eventId],
        ].nonNulls.toList(growable: false);
        if (orderedRows.length != members.length) {
          _throwLocalBatchInvalid();
        }
        _preflightOrThrow(orderedRows);
        final memberIds = orderedRows.map((row) => row.id).toList();
        final states = await (_db.select(
          _db.pendingEvents,
        )..where((table) => table.eventId.isIn(memberIds))).get();
        if (states.length != memberIds.length ||
            states.any((row) => row.state != 'unknown')) {
          _throwLocalBatchInvalid();
        }
        final eventJson = orderedRows
            .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
            .toList(growable: false);
        final requestHash = canonicalUtf8Sha256({
          'deviceId': unknown.deviceId,
          'events': eventJson,
          'submissionId': unknown.id,
        });
        if (requestHash != unknown.requestHash) {
          _throwLocalBatchInvalid();
        }
        final device =
            await (_db.select(_db.devices)..where(
                  (table) =>
                      table.id.equals(unknown.deviceId) &
                      table.accountId.equals(unknown.accountId),
                ))
                .getSingleOrNull();
        if (device == null ||
            device.nextSequence != orderedRows.last.deviceSequence + 1) {
          _throwLocalBatchInvalid();
        }
        return SyncUploadSubmission(
          id: unknown.id,
          deviceId: unknown.deviceId,
          requestHash: unknown.requestHash,
          events: eventJson,
        );
      }
      _preflightOrThrow(events);
      final eventIds = events.map((row) => row.id).toList(growable: false);
      final leaseDeviceId = events.first.deviceId;
      final submissionId = _uuid.v4();
      final eventJson = events
          .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
          .toList(growable: false);
      final requestHash = canonicalUtf8Sha256({
        'deviceId': leaseDeviceId,
        'events': eventJson,
        'submissionId': submissionId,
      });
      await _db
          .into(_db.syncSubmissions)
          .insert(
            SyncSubmissionsCompanion.insert(
              id: submissionId,
              accountId: events.first.accountId,
              deviceId: leaseDeviceId,
              requestHash: requestHash,
              state: 'uploading',
              attemptCount: const Value(1),
              leaseUntil: Value(now.add(const Duration(minutes: 5))),
              createdAt: now,
              updatedAt: now,
            ),
          );
      for (var i = 0; i < eventIds.length; i++) {
        await _db
            .into(_db.syncSubmissionEvents)
            .insert(
              SyncSubmissionEventsCompanion.insert(
                submissionId: submissionId,
                eventId: eventIds[i],
                position: i,
              ),
            );
        await (_db.update(_db.pendingEvents)
              ..where((table) => table.eventId.equals(eventIds[i])))
            .write(const PendingEventsCompanion(state: Value('uploading')));
      }
      return SyncUploadSubmission(
        id: submissionId,
        deviceId: leaseDeviceId,
        requestHash: requestHash,
        events: eventJson,
      );
    });
  }

  Future<List<SyncSubmission>> _unknownSubmissions() {
    Expression<bool> unknownPredicate = _db.syncSubmissions.state.equals(
      'unknown',
    );
    if (_accountId != null && _deviceId != null) {
      unknownPredicate =
          unknownPredicate &
          _db.syncSubmissions.accountId.equals(_accountId) &
          _db.syncSubmissions.deviceId.equals(_deviceId);
    }
    final query = _db.select(_db.syncSubmissions)
      ..where((table) => unknownPredicate)
      ..orderBy([
        (table) => OrderingTerm.asc(table.createdAt),
        (table) => OrderingTerm.asc(table.id),
      ]);
    return query.get();
  }

  @override
  Future<void> persistUploadResult(String submissionId, SyncResult result) {
    return _db.transaction(() async {
      if (_accountId != null && _deviceId != null) {
        final submission =
            await (_db.select(_db.syncSubmissions)..where(
                  (table) =>
                      table.id.equals(submissionId) &
                      table.accountId.equals(_accountId) &
                      table.deviceId.equals(_deviceId),
                ))
                .getSingleOrNull();
        if (submission == null) {
          return;
        }
      }
      final state = switch (result.code) {
        SyncStatusCode.serverAccepted ||
        SyncStatusCode.duplicateIgnored => 'accepted',
        SyncStatusCode.unknownOutcome => 'unknown',
        _ => 'failed',
      };
      await (_db.update(
        _db.syncSubmissions,
      )..where((table) => table.id.equals(submissionId))).write(
        SyncSubmissionsCompanion(
          state: Value(state),
          outcome: Value(result.outcome.name),
          responseCode: Value(result.code.name),
          errorCode: Value(result.protocolCode),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      final members = await (_db.select(
        _db.syncSubmissionEvents,
      )..where((table) => table.submissionId.equals(submissionId))).get();
      for (final member in members) {
        await (_db.update(_db.pendingEvents)
              ..where((table) => table.eventId.equals(member.eventId)))
            .write(PendingEventsCompanion(state: Value(state)));
      }
    });
  }

  @override
  Future<SyncResult> recoverFailedNotApplied(String submissionId) {
    return _db.transaction(() async {
      final submission = await (_db.select(
        _db.syncSubmissions,
      )..where((table) => table.id.equals(submissionId))).getSingleOrNull();
      if (submission == null ||
          submission.state != 'failed' ||
          submission.outcome != SyncOutcome.notApplied.name) {
        return _failedRecoveryBlocked();
      }
      if (_accountId != null &&
          (submission.accountId != _accountId ||
              submission.deviceId != _deviceId)) {
        return _failedRecoveryBlocked();
      }
      final candidate = await _recoverableCandidate(submission);
      if (candidate == null) return _failedRecoveryBlocked();
      return _recoverCandidate(candidate);
    });
  }

  @override
  Future<SyncResult> recoverOneFailedNotApplied() {
    return _db.transaction(() async {
      final accountId = _accountId;
      final deviceId = _deviceId;
      if (accountId == null || deviceId == null) {
        return _failedRecoveryBlocked();
      }
      final submissions =
          await (_db.select(_db.syncSubmissions)
                ..where(
                  (table) =>
                      table.accountId.equals(accountId) &
                      table.deviceId.equals(deviceId) &
                      table.state.equals('failed') &
                      table.outcome.equals(SyncOutcome.notApplied.name),
                )
                ..orderBy([
                  (table) => OrderingTerm.asc(table.createdAt),
                  (table) => OrderingTerm.asc(table.id),
                ]))
              .get();
      if (submissions.isEmpty) {
        return const SyncResult(
          code: SyncStatusCode.noRecoverableFailure,
          outcome: SyncOutcome.notApplied,
          retryable: false,
          protocolCode: 'no-recoverable-failure',
        );
      }
      final candidates = <_RecoverableFailedSubmission>[];
      for (final submission in submissions) {
        final candidate = await _recoverableCandidate(submission);
        if (candidate == null) return _failedRecoveryBlocked();
        candidates.add(candidate);
      }
      if (candidates.length != 1) return _failedRecoveryBlocked();
      return _recoverCandidate(candidates.single);
    });
  }

  bool _sameScopedIdentity(List<SyncEvent> events) {
    if (events.isEmpty) return false;
    final accountId = _accountId;
    final deviceId = _deviceId;
    if (accountId == null || deviceId == null) return true;
    return events.every(
      (event) => event.accountId == accountId && event.deviceId == deviceId,
    );
  }

  void _preflightOrThrow(List<SyncEvent> events) {
    if (!_preflightValid(events)) {
      _throwLocalBatchInvalid();
    }
  }

  Never _throwLocalBatchInvalid() {
    throw const SyncBatchPreflightException(
      SyncResult(
        code: SyncStatusCode.localBatchInvalid,
        outcome: SyncOutcome.notApplied,
        retryable: false,
        protocolCode: 'local-batch-invalid',
      ),
    );
  }

  bool _positionsAreContiguous(List<SyncSubmissionEvent> members) {
    final positions = <int>{};
    for (var i = 0; i < members.length; i++) {
      if (!positions.add(members[i].position) || members[i].position != i) {
        return false;
      }
    }
    return true;
  }

  bool _preflightValid(
    List<SyncEvent> events, {
    bool requireCanonicalOrder = true,
  }) {
    if (!_sameScopedIdentity(events)) return false;
    final eventIds = <String>{};
    final sequences = <int>{};
    final accountId = events.first.accountId;
    final deviceId = events.first.deviceId;
    var previousSequence = events.first.deviceSequence - 1;
    for (final event in events) {
      if (event.accountId != accountId || event.deviceId != deviceId) {
        return false;
      }
      if (!eventIds.add(event.id) || !sequences.add(event.deviceSequence)) {
        return false;
      }
      if (requireCanonicalOrder &&
          event.deviceSequence != previousSequence + 1) {
        return false;
      }
      final payload = jsonDecode(event.payloadJson) as Map<String, Object?>;
      final eventContent = Map<String, Object?>.from(payload)
        ..remove('contentHash');
      if (payload['eventId'] != event.id ||
          payload['accountId'] != event.accountId ||
          payload['deviceId'] != event.deviceId ||
          payload['deviceSequence'] != event.deviceSequence ||
          payload['contentHash'] != event.contentHash ||
          canonicalUtf8Sha256(eventContent) != event.contentHash) {
        return false;
      }
      previousSequence = event.deviceSequence;
    }
    return true;
  }

  Future<_RecoverableFailedSubmission?> _recoverableCandidate(
    SyncSubmission submission,
  ) async {
    final members =
        await (_db.select(_db.syncSubmissionEvents)
              ..where((table) => table.submissionId.equals(submission.id))
              ..orderBy([(table) => OrderingTerm.asc(table.position)]))
            .get();
    if (members.isEmpty) return null;
    final rows =
        await (_db.select(_db.syncEvents)..where(
              (table) => table.id.isIn(members.map((member) => member.eventId)),
            ))
            .get();
    final rowsById = {for (final row in rows) row.id: row};
    final orderedRows = [
      for (final member in members) rowsById[member.eventId],
    ].nonNulls.toList(growable: false);
    if (orderedRows.length != members.length ||
        !_preflightValid(orderedRows, requireCanonicalOrder: false)) {
      return null;
    }
    final canonicalRows = [...orderedRows]
      ..sort((a, b) {
        final sequence = a.deviceSequence.compareTo(b.deviceSequence);
        return sequence != 0 ? sequence : a.id.compareTo(b.id);
      });
    if (!_preflightValid(canonicalRows)) return null;
    final memberIds = canonicalRows.map((row) => row.id).toSet();
    final states = await (_db.select(
      _db.pendingEvents,
    )..where((table) => table.eventId.isIn(memberIds))).get();
    if (states.length != memberIds.length ||
        states.any((row) => row.state == 'accepted')) {
      return null;
    }
    final activeMembers =
        await (_db.select(_db.syncSubmissionEvents).join([
              innerJoin(
                _db.syncSubmissions,
                _db.syncSubmissions.id.equalsExp(
                  _db.syncSubmissionEvents.submissionId,
                ),
              ),
            ])..where(
              _db.syncSubmissionEvents.eventId.isIn(memberIds) &
                  _db.syncSubmissions.id.isNotValue(submission.id) &
                  (_db.syncSubmissions.state.equals('uploading') |
                      _db.syncSubmissions.state.equals('unknown')),
            ))
            .get();
    if (activeMembers.isNotEmpty) return null;
    return _RecoverableFailedSubmission(
      submission: submission,
      canonicalRows: canonicalRows,
      alreadyPending: states.any((row) => row.state == 'pending'),
    );
  }

  Future<SyncResult> _recoverCandidate(
    _RecoverableFailedSubmission candidate,
  ) async {
    final now = DateTime.now().toUtc();
    final retiredSubmission = SyncSubmissionsCompanion(
      state: const Value('superseded'),
      updatedAt: Value(now),
    );
    final changed =
        await (_db.update(_db.syncSubmissions)..where(
              (table) =>
                  table.id.equals(candidate.submission.id) &
                  table.state.equals('failed') &
                  table.outcome.equals(SyncOutcome.notApplied.name),
            ))
            .write(retiredSubmission);
    if (changed != 1) return _failedRecoveryBlocked();
    if (candidate.alreadyPending) return _failedRecoveryAvailable();
    for (final row in candidate.canonicalRows) {
      await (_db.update(
        _db.pendingEvents,
      )..where((table) => table.eventId.equals(row.id))).write(
        PendingEventsCompanion(
          state: const Value('pending'),
          enqueuedAt: Value(now),
        ),
      );
    }
    return _failedRecoveryAvailable();
  }

  SyncResult _failedRecoveryAvailable() => const SyncResult(
    code: SyncStatusCode.failedRecoveryAvailable,
    outcome: SyncOutcome.notApplied,
    retryable: true,
    protocolCode: 'failed-recovery-available',
  );

  SyncResult _failedRecoveryBlocked() => const SyncResult(
    code: SyncStatusCode.failedRecoveryBlocked,
    outcome: SyncOutcome.notApplied,
    retryable: false,
    protocolCode: 'failed-recovery-blocked',
  );
}

final class _RecoverableFailedSubmission {
  const _RecoverableFailedSubmission({
    required this.submission,
    required this.canonicalRows,
    required this.alreadyPending,
  });

  final SyncSubmission submission;
  final List<SyncEvent> canonicalRows;
  final bool alreadyPending;
}
