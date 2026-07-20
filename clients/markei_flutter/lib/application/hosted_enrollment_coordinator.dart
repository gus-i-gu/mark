// ignore_for_file: prefer_initializing_formals

import 'package:markei/application/hosted_auth_ports.dart';

final class HostedEnrollmentCoordinator {
  HostedEnrollmentCoordinator({
    required ExternalAuthenticationSession authenticationSession,
    required AccessTokenSource tokenSource,
    required DeviceEnrollmentTransport transport,
    required HostedIdentityRepository repository,
    required DateTime Function() now,
  }) : _authenticationSession = authenticationSession,
       _tokenSource = tokenSource,
       _transport = transport,
       _repository = repository,
       _now = now;

  final ExternalAuthenticationSession _authenticationSession;
  final AccessTokenSource _tokenSource;
  final DeviceEnrollmentTransport _transport;
  final HostedIdentityRepository _repository;
  final DateTime Function() _now;

  Future<HostedEnrollmentOutcome> enroll({
    required String environmentAlias,
    required DeviceEnrollmentCommand command,
  }) async {
    final existing = await _repository.load(environmentAlias);
    if (existing?.serverDeviceId != null) {
      return HostedEnrollmentOutcome.restartRequired(existing!);
    }
    await _repository.save(
      HostedIdentityState(
        environmentAlias: environmentAlias,
        installationId: command.installationId,
        enrollmentRequestId: command.enrollmentRequestId,
        enrollmentState: 'authenticating',
        updatedAt: _now(),
      ),
    );
    final authState = await _authenticationSession.signIn();
    if (authState is! SignedIn) {
      await _mark(environmentAlias, command, 'authentication-cancelled');
      return const HostedEnrollmentOutcome.notApplied(
        'authentication-cancelled',
      );
    }
    final token = await _tokenSource.accessToken();
    if (token.accessToken == null) {
      await _mark(environmentAlias, command, 'token-rejected');
      return HostedEnrollmentOutcome.notApplied(
        token.errorCode ?? 'token-rejected',
      );
    }
    await _mark(environmentAlias, command, 'enrolling');
    final result = await _transport.enroll(command, token.accessToken!);
    if (result is DeviceEnrollmentTransportSuccess) {
      return _complete(
        environmentAlias,
        command.enrollmentRequestId,
        result.result,
      );
    }
    if (result is DeviceEnrollmentTransportConflict) {
      await _mark(environmentAlias, command, 'conflict');
      return const HostedEnrollmentOutcome.notApplied('conflict');
    }
    final state = result is DeviceEnrollmentTransportUnavailable
        ? 'service-unavailable'
        : 'unknown-outcome';
    await _mark(environmentAlias, command, state);
    return HostedEnrollmentOutcome.unknown(state);
  }

  Future<HostedEnrollmentOutcome> replay({
    required String environmentAlias,
  }) async {
    final state = await _repository.load(environmentAlias);
    if (state == null || state.enrollmentRequestId == null) {
      return const HostedEnrollmentOutcome.notApplied('enrollment-required');
    }
    if (state.serverDeviceId != null) {
      return HostedEnrollmentOutcome.duplicateEquivalent(state);
    }
    final token = await _tokenSource.accessToken();
    if (token.accessToken == null) {
      return HostedEnrollmentOutcome.notApplied(
        token.errorCode ?? 'token-rejected',
      );
    }
    final result = await _transport.query(
      state.enrollmentRequestId!,
      token.accessToken!,
    );
    if (result is DeviceEnrollmentTransportSuccess) {
      return _complete(
        environmentAlias,
        state.enrollmentRequestId,
        result.result,
      );
    }
    if (result is DeviceEnrollmentTransportConflict) {
      await _markExisting(state, 'conflict');
      return const HostedEnrollmentOutcome.notApplied('conflict');
    }
    if (result is DeviceEnrollmentTransportUnavailable) {
      await _markExisting(state, 'service-unavailable');
      return const HostedEnrollmentOutcome.unknown('service-unavailable');
    }
    await _markExisting(state, 'unknown-outcome');
    return const HostedEnrollmentOutcome.unknown('unknown-outcome');
  }

  Future<HostedEnrollmentOutcome> _complete(
    String environmentAlias,
    String? enrollmentRequestId,
    DeviceEnrollmentResult result,
  ) async {
    final completed = HostedIdentityState(
      environmentAlias: environmentAlias,
      installationId: result.installationId,
      enrollmentRequestId: enrollmentRequestId,
      enrollmentState: result.status,
      accountId: result.accountId,
      serverDeviceId: result.deviceId,
      generation: result.generation,
      updatedAt: _now(),
    );
    await _repository.save(completed);
    return result.status == 'duplicate-equivalent'
        ? HostedEnrollmentOutcome.duplicateEquivalent(completed)
        : HostedEnrollmentOutcome.restartRequired(completed);
  }

  Future<void> _mark(
    String environmentAlias,
    DeviceEnrollmentCommand command,
    String state,
  ) {
    return _repository.save(
      HostedIdentityState(
        environmentAlias: environmentAlias,
        installationId: command.installationId,
        enrollmentRequestId: command.enrollmentRequestId,
        enrollmentState: state,
        updatedAt: _now(),
      ),
    );
  }

  Future<void> _markExisting(HostedIdentityState state, String nextState) {
    return _repository.save(
      HostedIdentityState(
        environmentAlias: state.environmentAlias,
        installationId: state.installationId,
        enrollmentRequestId: state.enrollmentRequestId,
        enrollmentState: nextState,
        accountId: state.accountId,
        serverDeviceId: state.serverDeviceId,
        generation: state.generation,
        updatedAt: _now(),
      ),
    );
  }
}

final class HostedEnrollmentOutcome {
  const HostedEnrollmentOutcome._(this.status, this.reason, this.state);

  const HostedEnrollmentOutcome.notApplied(String reason)
    : this._('not-applied', reason, null);

  const HostedEnrollmentOutcome.unknown(String reason)
    : this._('unknown', reason, null);

  HostedEnrollmentOutcome.applied(HostedIdentityState state)
    : this._('applied', null, state);

  HostedEnrollmentOutcome.restartRequired(HostedIdentityState state)
    : this._('hosted-restart-required', null, state);

  HostedEnrollmentOutcome.duplicateEquivalent(HostedIdentityState state)
    : this._('duplicate-equivalent', null, state);

  final String status;
  final String? reason;
  final HostedIdentityState? state;
}

final class LabAuthenticationSession implements ExternalAuthenticationSession {
  LabAuthenticationSession({bool signedIn = true}) : _signedIn = signedIn;

  bool _signedIn;

  @override
  Future<ExternalAuthenticationState> currentState() async =>
      _signedIn ? const SignedIn() : const SignedOut();

  @override
  Future<ExternalAuthenticationState> signIn() async => currentState();

  @override
  Future<void> logout() async {
    _signedIn = false;
  }
}

final class LabAccessTokenSource implements AccessTokenSource {
  LabAccessTokenSource.accepted(String token)
    : _token = token,
      _errorCode = null;

  LabAccessTokenSource.rejected(String code) : _token = null, _errorCode = code;

  final String? _token;
  final String? _errorCode;

  @override
  Future<AccessTokenResult> accessToken() async {
    final token = _token;
    if (token == null) return AccessTokenResult.rejected(_errorCode);
    return AccessTokenResult.accepted(token);
  }
}
