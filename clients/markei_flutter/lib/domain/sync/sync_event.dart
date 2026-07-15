import '../purchase/purchase.dart';
import '../shared/ids.dart';
import 'canonical_json.dart';

enum PendingEventState { pending, uploading, accepted, failed, unknown }

enum SyncOutcome { applied, duplicateEquivalent, notApplied, unknown }

enum SyncStatusCode {
  savedLocal,
  waitingUpload,
  uploading,
  serverAccepted,
  waitingPeer,
  downloadReceived,
  downloadedApplied,
  duplicateIgnored,
  acknowledged,
  conflict,
  authRequired,
  deviceRevoked,
  cursorExpired,
  protocolUpgradeRequired,
  unknownOutcome,
}

final class SyncEvent {
  const SyncEvent({
    required this.id,
    required this.accountId,
    required this.deviceId,
    required this.deviceSequence,
    required this.eventType,
    required this.payloadVersion,
    required this.occurrenceTime,
    required this.purchase,
    required this.productSnapshots,
  });

  final EventId id;
  final AccountId accountId;
  final DeviceId deviceId;
  final int deviceSequence;
  final String eventType;
  final int payloadVersion;
  final DateTime occurrenceTime;
  final Purchase purchase;
  final List<Map<String, Object?>> productSnapshots;

  Map<String, Object?> contentJson() => {
    'eventId': id.value,
    'accountId': accountId.value,
    'deviceId': deviceId.value,
    'deviceSequence': deviceSequence,
    'eventType': eventType,
    'payloadVersion': payloadVersion,
    'occurrenceTime': occurrenceTime.toUtc().toIso8601String(),
    'payload': {
      'purchase': purchase.toJson(),
      'productSnapshots': productSnapshots,
    },
  };

  String get contentHash => canonicalUtf8Sha256(contentJson());

  Map<String, Object?> toJson() => {
    ...contentJson(),
    'contentHash': contentHash,
  };
}

final class ProtocolFailure {
  const ProtocolFailure({
    required this.code,
    required this.operation,
    required this.outcome,
    required this.retryable,
    required this.safeAction,
    required this.correlationId,
    this.field,
    this.eventId,
    this.submissionId,
  });

  final String code;
  final String operation;
  final SyncOutcome outcome;
  final bool retryable;
  final String safeAction;
  final String correlationId;
  final String? field;
  final String? eventId;
  final String? submissionId;
}
