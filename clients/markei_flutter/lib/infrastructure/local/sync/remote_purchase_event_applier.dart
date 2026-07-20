import 'package:drift/drift.dart';

import '../../../application/sync/sync_ports.dart';
import '../../../domain/shared/ids.dart';
import '../../../domain/sync/canonical_json.dart';
import '../../../domain/sync/sync_event.dart';
import '../local_database.dart';
import 'remote_purchase_fact_writer.dart';

final class DriftRemoteEventApplier implements RemoteEventApplier {
  DriftRemoteEventApplier(this._db) : _accountId = null;

  DriftRemoteEventApplier.scoped(this._db, {required AccountId accountId})
    : _accountId = accountId.value;

  final LocalDatabase _db;
  final String? _accountId;
  late final RemotePurchaseFactWriter _facts = RemotePurchaseFactWriter(_db);

  @override
  Future<SyncResult> applyPage(DownloadPage page) {
    return _db.transaction(() async {
      if (page.events.isEmpty) {
        return const SyncResult(
          code: SyncStatusCode.downloadReceived,
          outcome: SyncOutcome.duplicateEquivalent,
          retryable: false,
        );
      }
      final validation = await _validatePage(page);
      if (validation != null) {
        return validation;
      }
      for (final item in page.events) {
        final eventId = item.event['eventId'] as String;
        final accountId = item.event['accountId'] as String;
        final hash = item.event['contentHash'] as String;
        if (await _isEquivalentInbox(accountId, eventId, hash)) {
          continue;
        }
        await _facts.applyPurchaseRegistered(item.event);
        await _db
            .into(_db.syncInbox)
            .insert(
              SyncInboxCompanion.insert(
                accountId: accountId,
                eventId: eventId,
                contentHash: hash,
                serverCursor: item.serverCursor,
                state: 'applied',
                appliedAt: Value(DateTime.now().toUtc()),
              ),
            );
      }
      final last = page.events.last;
      await _db
          .into(_db.syncState)
          .insertOnConflictUpdate(
            SyncStateCompanion.insert(
              accountId: _accountId ?? (last.event['accountId'] as String),
              accountCursor: Value(page.nextCursor ?? last.serverCursor),
              updatedAt: DateTime.now().toUtc(),
            ),
          );
      return const SyncResult(
        code: SyncStatusCode.downloadedApplied,
        outcome: SyncOutcome.applied,
        retryable: false,
      );
    });
  }

  @override
  Future<String?> greatestContiguousAppliedCursor() async {
    final accountId = _accountId;
    Expression<bool> predicate = _db.syncState.accountCursor.isNotNull();
    if (accountId != null) {
      predicate = predicate & _db.syncState.accountId.equals(accountId);
    }
    final query = _db.select(_db.syncState)
      ..where((table) => predicate)
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row?.accountCursor;
  }

  Future<SyncResult?> _validatePage(DownloadPage page) async {
    final accountId = page.events.first.event['accountId'] as String?;
    if (accountId == null) {
      return _conflict();
    }
    final scopedAccountId = _accountId;
    if (scopedAccountId != null && accountId != scopedAccountId) {
      return _conflict();
    }
    final state = await (_db.select(
      _db.syncState,
    )..where((table) => table.accountId.equals(accountId))).getSingleOrNull();
    final current = _cursorNumber(state?.accountCursor);
    var expected = current + 1;
    var duplicateOnly = true;
    for (final item in page.events) {
      final event = item.event;
      final eventId = event['eventId'] as String?;
      final hash = event['contentHash'] as String?;
      if (eventId == null ||
          hash == null ||
          event['accountId'] != accountId ||
          event['eventType'] != 'purchase.registered' ||
          event['payloadVersion'] != 3) {
        return _conflict();
      }
      final content = Map<String, Object?>.from(event)..remove('contentHash');
      if (canonicalUtf8Sha256(content) != hash) {
        return _conflict();
      }
      final cursor = _cursorNumber(item.serverCursor);
      final existing =
          await (_db.select(_db.syncInbox)..where(
                (table) =>
                    table.accountId.equals(accountId) &
                    table.eventId.equals(eventId),
              ))
              .getSingleOrNull();
      if (existing != null) {
        if (existing.contentHash != hash) {
          return _conflict();
        }
        continue;
      }
      duplicateOnly = false;
      if (cursor != expected) {
        return _conflict();
      }
      expected++;
    }
    if (duplicateOnly) {
      return const SyncResult(
        code: SyncStatusCode.duplicateIgnored,
        outcome: SyncOutcome.duplicateEquivalent,
        retryable: false,
      );
    }
    return null;
  }

  Future<bool> _isEquivalentInbox(
    String accountId,
    String eventId,
    String hash,
  ) async {
    final existing =
        await (_db.select(_db.syncInbox)..where(
              (table) =>
                  table.accountId.equals(accountId) &
                  table.eventId.equals(eventId),
            ))
            .getSingleOrNull();
    return existing != null && existing.contentHash == hash;
  }

  int _cursorNumber(String? cursor) {
    if (cursor == null || cursor == 'c10b:0') {
      return 0;
    }
    final parts = cursor.split(':');
    if (parts.length != 2 || parts.first != 'c10b') {
      throw StateError('Unsupported cursor token.');
    }
    return int.parse(parts.last);
  }

  SyncResult _conflict() => const SyncResult(
    code: SyncStatusCode.conflict,
    outcome: SyncOutcome.notApplied,
    retryable: false,
  );
}
