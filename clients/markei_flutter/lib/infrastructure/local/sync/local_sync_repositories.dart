import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../application/sync/sync_ports.dart';
import '../../../domain/sync/canonical_json.dart';
import '../../../domain/sync/sync_event.dart';
import '../local_database.dart';

final class DriftSyncOutboxRepository implements SyncOutboxRepository {
  DriftSyncOutboxRepository(this._db, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final LocalDatabase _db;
  final Uuid _uuid;

  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) {
    return _db.transaction(() async {
      final now = DateTime.now().toUtc();
      final pending =
          await (_db.select(_db.pendingEvents)
                ..where((table) => table.state.equals('pending'))
                ..limit(limit))
              .get();
      if (pending.isEmpty) {
        final unknown =
            await (_db.select(_db.syncSubmissions)
                  ..where((table) => table.state.equals('unknown'))
                  ..orderBy([(table) => OrderingTerm.asc(table.createdAt)])
                  ..limit(1))
                .getSingleOrNull();
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
        return SyncUploadSubmission(
          id: unknown.id,
          deviceId: unknown.deviceId,
          requestHash: unknown.requestHash,
          events: rows
              .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
              .toList(growable: false),
        );
      }
      final eventIds = pending.map((row) => row.eventId).toList();
      final events = await (_db.select(
        _db.syncEvents,
      )..where((table) => table.id.isIn(eventIds))).get();
      final deviceId = events.first.deviceId;
      final submissionId = _uuid.v4();
      final eventJson = events
          .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
          .toList(growable: false);
      final requestHash = canonicalUtf8Sha256({
        'deviceId': deviceId,
        'events': eventJson,
        'submissionId': submissionId,
      });
      await _db
          .into(_db.syncSubmissions)
          .insert(
            SyncSubmissionsCompanion.insert(
              id: submissionId,
              accountId: events.first.accountId,
              deviceId: deviceId,
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
        deviceId: deviceId,
        requestHash: requestHash,
        events: eventJson,
      );
    });
  }

  @override
  Future<void> persistUploadResult(String submissionId, SyncResult result) {
    return _db.transaction(() async {
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
}
