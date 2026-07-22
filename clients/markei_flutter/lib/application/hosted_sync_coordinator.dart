import 'dart:async';

import 'hosted_auth_ports.dart';
import '../domain/sync/sync_event.dart';
import 'sync/sync_ports.dart';
import 'sync/sync_use_cases.dart';

final class HostedSyncCoordinator {
  const HostedSyncCoordinator({
    required this._authenticationSession,
    required this._syncGuard,
    required this._applier,
    required this.recoverFailedNotApplied,
    required this._uploadPendingEvents,
    required this._downloadAndApplyEvents,
    required this._acknowledgeAppliedCursor,
  });

  final ExternalAuthenticationSession _authenticationSession;
  final HostedSyncGuard _syncGuard;
  final RemoteEventApplier _applier;
  final RecoverFailedNotApplied recoverFailedNotApplied;
  final UploadPendingEvents _uploadPendingEvents;
  final DownloadAndApplyEvents _downloadAndApplyEvents;
  final AcknowledgeAppliedCursor _acknowledgeAppliedCursor;

  Future<HostedSyncOutcome> run(String environmentAlias) async {
    if (await _authenticationSession.currentState() is! SignedIn) {
      return const HostedSyncOutcome.authenticationRequired();
    }
    final decision = await _syncGuard.evaluate(environmentAlias);
    final deviceBlocker = decision.blockedReason;
    if (deviceBlocker != null) {
      if (deviceBlocker == 'device-revoked' ||
          deviceBlocker == 'device-expired') {
        return const HostedSyncOutcome.deviceRevoked();
      }
      return const HostedSyncOutcome.deviceEnrollmentRequired();
    }

    try {
      final recovery = await recoverFailedNotApplied();
      final recoveryBlocker = _blockedBy(recovery);
      if (recoveryBlocker != null) return recoveryBlocker;

      final upload = await _uploadPendingEvents();
      final uploadBlocker = _blockedBy(upload);
      if (uploadBlocker != null) return uploadBlocker;

      final cursor = await _applier.greatestContiguousAppliedCursor();
      final download = await _downloadAndApplyEvents(cursor);
      final downloadBlocker = _blockedBy(download);
      if (downloadBlocker != null) return downloadBlocker;

      final acknowledgement = await _acknowledgeAppliedCursor();
      final acknowledgementBlocker = _blockedBy(acknowledgement);
      if (acknowledgementBlocker != null) return acknowledgementBlocker;

      if (upload == null &&
          download.code == SyncStatusCode.downloadReceived &&
          acknowledgement == null) {
        return const HostedSyncOutcome.noNewEvents();
      }
      return const HostedSyncOutcome.completed();
    } on TimeoutException {
      return const HostedSyncOutcome.interrupted();
    } on StateError catch (error) {
      if (error.message == 'auth-required' ||
          error.message == 'token-expired' ||
          error.message == 'signed-out') {
        return const HostedSyncOutcome.authenticationRequired();
      }
      if (error.message == 'cursor-expired') {
        return const HostedSyncOutcome.interrupted();
      }
      return const HostedSyncOutcome.unavailable();
    }
  }

  HostedSyncOutcome? _blockedBy(SyncResult? result) {
    if (result == null) return null;
    return switch (result.code) {
      SyncStatusCode.authRequired =>
        const HostedSyncOutcome.authenticationRequired(),
      SyncStatusCode.deviceEnrollmentRequired =>
        const HostedSyncOutcome.deviceEnrollmentRequired(),
      SyncStatusCode.deviceRevoked ||
      SyncStatusCode.deviceExpired => const HostedSyncOutcome.deviceRevoked(),
      SyncStatusCode.unknownOutcome => const HostedSyncOutcome.interrupted(),
      SyncStatusCode.noRecoverableFailure ||
      SyncStatusCode.failedRecoveryAvailable => null,
      SyncStatusCode.conflict ||
      SyncStatusCode.sequenceGap ||
      SyncStatusCode.wrongAccount ||
      SyncStatusCode.hashMismatch ||
      SyncStatusCode.localBatchInvalid ||
      SyncStatusCode.failedRecoveryBlocked ||
      SyncStatusCode.serviceUnavailable ||
      SyncStatusCode.cursorExpired ||
      SyncStatusCode.recoveryUnavailable ||
      SyncStatusCode.fullRebootstrapRequired ||
      SyncStatusCode.localChangesBlockRebootstrap ||
      SyncStatusCode.protocolUpgradeRequired =>
        const HostedSyncOutcome.unavailable(),
      _ => null,
    };
  }
}

final class HostedSyncOutcome {
  const HostedSyncOutcome._(this.state);

  const HostedSyncOutcome.authenticationRequired()
    : this._('authentication-required');

  const HostedSyncOutcome.deviceEnrollmentRequired()
    : this._('device-enrollment-required');

  const HostedSyncOutcome.noNewEvents() : this._('sync-no-new-events');

  const HostedSyncOutcome.completed() : this._('sync-completed');

  const HostedSyncOutcome.interrupted() : this._('sync-interrupted');

  const HostedSyncOutcome.unavailable() : this._('sync-unavailable');

  const HostedSyncOutcome.deviceRevoked() : this._('device-revoked');

  final String state;
}
