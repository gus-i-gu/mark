// ignore_for_file: prefer_initializing_formals

import '../application/hosted_auth_ports.dart';
import '../application/closure_diagnostics.dart';
import '../application/hosted_enrollment_coordinator.dart';
import '../application/hosted_sync_coordinator.dart';

final class NativeAuthClosureRunner {
  NativeAuthClosureRunner({
    required ExternalAuthenticationSession authenticationSession,
    required HostedEnrollmentCoordinator enrollmentCoordinator,
    required String environmentAlias,
    required Future<DeviceEnrollmentCommand> Function() commandFactory,
    required ClosureDiagnosticsQuery diagnosticsQuery,
    required SyncAttemptRecorder syncAttemptRecorder,
    required HostedSyncCoordinator hostedSyncCoordinator,
  }) : _authenticationSession = authenticationSession,
       _enrollmentCoordinator = enrollmentCoordinator,
       _environmentAlias = environmentAlias,
       _commandFactory = commandFactory,
       _diagnosticsQuery = diagnosticsQuery,
       _syncAttemptRecorder = syncAttemptRecorder,
       _hostedSyncCoordinator = hostedSyncCoordinator,
       _unavailable = false;

  const NativeAuthClosureRunner.unavailable()
    : _authenticationSession = null,
      _enrollmentCoordinator = null,
      _environmentAlias = '',
      _commandFactory = null,
      _diagnosticsQuery = null,
      _syncAttemptRecorder = null,
      _hostedSyncCoordinator = null,
      _unavailable = true;

  final ExternalAuthenticationSession? _authenticationSession;
  final HostedEnrollmentCoordinator? _enrollmentCoordinator;
  final String _environmentAlias;
  final Future<DeviceEnrollmentCommand> Function()? _commandFactory;
  final ClosureDiagnosticsQuery? _diagnosticsQuery;
  final SyncAttemptRecorder? _syncAttemptRecorder;
  final HostedSyncCoordinator? _hostedSyncCoordinator;
  final bool _unavailable;

  Future<NativeClosureStatus> status() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final state = await _authenticationSession!.currentState();
    return NativeClosureStatus(_stateName(state));
  }

  Future<NativeClosureStatus> signIn() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final state = await _authenticationSession!.signIn();
    return NativeClosureStatus(_stateName(state));
  }

  Future<NativeClosureStatus> enrollOrQueryDevice() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final outcome = await _enrollmentCoordinator!.enroll(
      environmentAlias: _environmentAlias,
      command: await _commandFactory!(),
    );
    return NativeClosureStatus(_outcomeName(outcome));
  }

  Future<NativeClosureStatus> queryEnrollment() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final outcome = await _enrollmentCoordinator!.replay(
      environmentAlias: _environmentAlias,
    );
    return NativeClosureStatus(_outcomeName(outcome));
  }

  Future<NativeClosureStatus> hostedSyncProbe() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final recorder = _syncAttemptRecorder!;
    final coordinator = _hostedSyncCoordinator!;
    final attemptId = await recorder.beginSyncAttempt();
    try {
      final outcome = await coordinator.run(_environmentAlias);
      await recorder.completeSyncAttempt(
        attemptId,
        resultCode: outcome.state,
        outcomeClass: _syncOutcomeClass(outcome.state),
        phase: _syncPhase(outcome.state),
        recoveryCode: _syncRecoveryCode(outcome.state),
      );
      return NativeClosureStatus(outcome.state);
    } on Object {
      await recorder.completeSyncAttempt(
        attemptId,
        resultCode: 'sync-unavailable',
        outcomeClass: 'unavailable',
        phase: 'unexpected-terminal',
        recoveryCode: 'local-exception-redacted',
      );
      return const NativeClosureStatus('sync-unavailable');
    }
  }

  Future<NativeClosureStatus> logout() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    await _authenticationSession!.logout();
    return const NativeClosureStatus('signed-out-cleared');
  }

  Future<ClosureDiagnosticsSnapshot?> diagnostics() async {
    if (_unavailable) return null;
    final auth = await _authenticationSession!.currentState();
    return _diagnosticsQuery!.snapshot(authenticationState: _stateName(auth));
  }

  Future<void> clearDiagnosticHistory() async {
    if (_unavailable) return;
    await _diagnosticsQuery!.clearAttemptHistory();
  }

  static String _stateName(ExternalAuthenticationState state) {
    return switch (state) {
      SignedOut() => 'signed-out',
      SigningIn() => 'signing-in',
      SignInCancelled() => 'sign-in-cancelled',
      SignedIn() => 'authenticated',
      TokenExpired() => 'token-expired',
      AuthenticationRejected(:final code) => code,
      ProviderUnavailable() => 'provider-unavailable',
    };
  }

  static String _outcomeName(HostedEnrollmentOutcome outcome) {
    return switch (outcome.status) {
      'hosted-restart-required' => 'hosted-restart-required',
      'applied' => 'device-enrolled',
      'duplicate-equivalent' => 'device-enrolled',
      'unknown' => 'sync-interrupted',
      _ => outcome.reason ?? 'sync-unavailable',
    };
  }

  static String _syncOutcomeClass(String state) {
    return switch (state) {
      'sync-completed' || 'sync-no-new-events' => 'completed',
      'sync-interrupted' => 'unknown',
      'authentication-required' => 'blocked',
      'device-enrollment-required' || 'device-revoked' => 'blocked',
      _ => 'unavailable',
    };
  }

  static String _syncPhase(String state) {
    return switch (state) {
      'sync-completed' || 'sync-no-new-events' => 'completed',
      'sync-interrupted' => 'transport-or-closure',
      'authentication-required' => 'authentication',
      'device-enrollment-required' || 'device-revoked' => 'enrollment',
      _ => 'sync',
    };
  }

  static String? _syncRecoveryCode(String state) {
    return switch (state) {
      'sync-completed' || 'sync-no-new-events' => null,
      'authentication-required' => 'sign-in-required',
      'device-enrollment-required' => 'enroll-or-query-device',
      'device-revoked' => 'device-not-allowed',
      'sync-interrupted' => 'retry-after-local-review',
      _ => 'provider-evidence-unavailable',
    };
  }
}

final class NativeClosureStatus {
  const NativeClosureStatus(this.state);

  final String state;
}
