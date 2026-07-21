import '../domain/shared/ids.dart';

abstract interface class ClosureDiagnosticsQuery {
  Future<ClosureDiagnosticsSnapshot> snapshot({
    required String authenticationState,
  });
  Future<UnknownSubmissionRetryPreflight> unknownSubmissionRetryPreflight({
    required String authenticationState,
  });
  Future<void> clearAttemptHistory();
}

abstract interface class SyncAttemptRecorder {
  Future<int> beginSyncAttempt();
  Future<void> completeSyncAttempt(
    int attemptId, {
    required String resultCode,
    required String outcomeClass,
    required String phase,
    String? recoveryCode,
  });
}

final class ClosureDiagnosticsSnapshot {
  const ClosureDiagnosticsSnapshot({
    required this.authenticationState,
    required this.enrollmentState,
    required this.syncReadiness,
    required this.lastResult,
    required this.queueCounts,
    required this.nextDeviceSequence,
    required this.lastSuccessfulSyncAt,
    required this.recoveryGuidance,
    required this.recentAttempts,
    required this.devices,
    required this.actionableEvents,
    required this.refreshedAt,
  });

  final String authenticationState;
  final String enrollmentState;
  final String syncReadiness;
  final String lastResult;
  final ClosureQueueCounts queueCounts;
  final int? nextDeviceSequence;
  final DateTime? lastSuccessfulSyncAt;
  final String recoveryGuidance;
  final List<ClosureSyncAttemptSummary> recentAttempts;
  final List<ClosureDeviceSummary> devices;
  final List<ClosureActionableEventSummary> actionableEvents;
  final DateTime refreshedAt;
}

final class ClosureQueueCounts {
  const ClosureQueueCounts({
    required this.pending,
    required this.uploading,
    required this.failed,
    required this.unknown,
  });

  final int pending;
  final int uploading;
  final int failed;
  final int unknown;

  int get blocked => failed + unknown;
}

final class ClosureSyncAttemptSummary {
  const ClosureSyncAttemptSummary({
    required this.fingerprint,
    required this.startedAt,
    required this.completedAt,
    required this.duration,
    required this.phase,
    required this.resultCode,
    required this.outcomeClass,
    required this.recoveryCode,
  });

  final String fingerprint;
  final DateTime startedAt;
  final DateTime? completedAt;
  final Duration? duration;
  final String phase;
  final String resultCode;
  final String outcomeClass;
  final String? recoveryCode;
}

final class ClosureDeviceSummary {
  const ClosureDeviceSummary({
    required this.fingerprint,
    required this.isCurrent,
    required this.enrollmentState,
    required this.nextSequence,
  });

  final String fingerprint;
  final bool isCurrent;
  final String enrollmentState;
  final int nextSequence;
}

final class ClosureActionableEventSummary {
  const ClosureActionableEventSummary({
    required this.fingerprint,
    required this.eventType,
    required this.deviceSequence,
    required this.state,
    required this.enqueuedAt,
    required this.occurredAt,
  });

  final String fingerprint;
  final String eventType;
  final int deviceSequence;
  final String state;
  final DateTime enqueuedAt;
  final DateTime occurredAt;
}

final class UnknownSubmissionRetryPreflight {
  const UnknownSubmissionRetryPreflight.eligible({
    required this.submissionFingerprint,
    required this.eventCount,
    required this.firstDeviceSequence,
    required this.lastDeviceSequence,
    required this.nextLocalDeviceSequence,
  }) : state = 'unknown-retry-eligible',
       guidance = 'confirm-exact-unknown-retry',
       eligible = true;

  const UnknownSubmissionRetryPreflight.blocked({
    required this.state,
    required this.guidance,
  }) : eligible = false,
       submissionFingerprint = null,
       eventCount = null,
       firstDeviceSequence = null,
       lastDeviceSequence = null,
       nextLocalDeviceSequence = null;

  final bool eligible;
  final String state;
  final String guidance;
  final String? submissionFingerprint;
  final int? eventCount;
  final int? firstDeviceSequence;
  final int? lastDeviceSequence;
  final int? nextLocalDeviceSequence;
}

final class ClosureDiagnosticsScope {
  const ClosureDiagnosticsScope({
    required this.accountId,
    required this.deviceId,
    required this.environmentAlias,
  });

  final AccountId accountId;
  final DeviceId deviceId;
  final String environmentAlias;
}
