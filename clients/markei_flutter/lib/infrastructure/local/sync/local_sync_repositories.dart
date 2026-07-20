import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../application/sync/sync_ports.dart';
import '../../../domain/shared/ids.dart';
import '../../../domain/sync/canonical_json.dart';
import '../../../domain/sync/sync_event.dart' show SyncStatusCode;
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
            ..limit(limit);
      final pending = (await pendingQuery.get())
          .map((row) => row.readTable(_db.pendingEvents))
          .toList(growable: false);
      if (pending.isEmpty) {
        Expression<bool> unknownPredicate = _db.syncSubmissions.state.equals(
          'unknown',
        );
        if (accountId != null && deviceId != null) {
          unknownPredicate =
              unknownPredicate &
              _db.syncSubmissions.accountId.equals(accountId) &
              _db.syncSubmissions.deviceId.equals(deviceId);
        }
        final unknownQuery = _db.select(_db.syncSubmissions)
          ..where((table) => unknownPredicate)
          ..orderBy([(table) => OrderingTerm.asc(table.createdAt)])
          ..limit(1);
        final unknown = await unknownQuery.getSingleOrNull();
        if (unknown == null) {
          return null;
        }
        final members =
            await (_db.select(_db.syncSubmissionEvents)
                  ..where((table) => table.submissionId.equals(unknown.id))
                  ..orderBy([(table) => OrderingTerm.asc(table.position)]))
                .get();
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
        if (!_sameScopedIdentity(orderedRows)) {
          return null;
        }
        return SyncUploadSubmission(
          id: unknown.id,
          deviceId: unknown.deviceId,
          requestHash: unknown.requestHash,
          events: orderedRows
              .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
              .toList(growable: false),
        );
      }
      final eventIds = pending.map((row) => row.eventId).toList();
      final events = await (_db.select(
        _db.syncEvents,
      )..where((table) => table.id.isIn(eventIds))).get();
      if (!_sameScopedIdentity(events)) {
        return null;
      }
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

  bool _sameScopedIdentity(List<SyncEvent> events) {
    if (events.isEmpty) return false;
    final accountId = _accountId;
    final deviceId = _deviceId;
    if (accountId == null || deviceId == null) return true;
    return events.every(
      (event) => event.accountId == accountId && event.deviceId == deviceId,
    );
  }
}
