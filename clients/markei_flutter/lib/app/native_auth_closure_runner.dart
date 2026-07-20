// ignore_for_file: prefer_initializing_formals

import '../application/hosted_auth_ports.dart';
import '../application/hosted_enrollment_coordinator.dart';
import '../application/hosted_sync_coordinator.dart';

final class NativeAuthClosureRunner {
  NativeAuthClosureRunner({
    required ExternalAuthenticationSession authenticationSession,
    required HostedEnrollmentCoordinator enrollmentCoordinator,
    required String environmentAlias,
    required Future<DeviceEnrollmentCommand> Function() commandFactory,
    required HostedSyncCoordinator hostedSyncCoordinator,
  }) : _authenticationSession = authenticationSession,
       _enrollmentCoordinator = enrollmentCoordinator,
       _environmentAlias = environmentAlias,
       _commandFactory = commandFactory,
       _hostedSyncCoordinator = hostedSyncCoordinator,
       _unavailable = false;

  const NativeAuthClosureRunner.unavailable()
    : _authenticationSession = null,
      _enrollmentCoordinator = null,
      _environmentAlias = '',
      _commandFactory = null,
      _hostedSyncCoordinator = null,
      _unavailable = true;

  final ExternalAuthenticationSession? _authenticationSession;
  final HostedEnrollmentCoordinator? _enrollmentCoordinator;
  final String _environmentAlias;
  final Future<DeviceEnrollmentCommand> Function()? _commandFactory;
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
    final outcome = await _hostedSyncCoordinator!.run(_environmentAlias);
    return NativeClosureStatus(outcome.state);
  }

  Future<NativeClosureStatus> logout() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    await _authenticationSession!.logout();
    return const NativeClosureStatus('signed-out-cleared');
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
}

final class NativeClosureStatus {
  const NativeClosureStatus(this.state);

  final String state;
}
