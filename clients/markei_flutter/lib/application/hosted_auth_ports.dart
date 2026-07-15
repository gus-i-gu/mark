abstract interface class ExternalAuthenticationSession {
  Future<ExternalAuthenticationState> currentState();
  Future<ExternalAuthenticationState> signIn();
  Future<void> logout();
}

abstract interface class AccessTokenSource {
  Future<AccessTokenResult> accessToken();
}

abstract interface class DeviceEnrollmentTransport {
  Future<DeviceEnrollmentResult> enroll(
    DeviceEnrollmentCommand command,
    String bearerCredential,
  );
  Future<DeviceEnrollmentResult?> query(
    String enrollmentRequestId,
    String bearerCredential,
  );
}

abstract interface class HostedIdentityRepository {
  Future<HostedIdentityState?> load(String environmentAlias);
  Future<void> save(HostedIdentityState state);
}

abstract interface class HostedSyncGuard {
  Future<HostedSyncDecision> evaluate(String environmentAlias);
}

sealed class ExternalAuthenticationState {
  const ExternalAuthenticationState();
}

final class SignedOut extends ExternalAuthenticationState {
  const SignedOut();
}

final class SignedIn extends ExternalAuthenticationState {
  const SignedIn();
}

final class AccessTokenResult {
  const AccessTokenResult.accepted(this.accessToken) : errorCode = null;
  const AccessTokenResult.rejected(this.errorCode) : accessToken = null;

  final String? accessToken;
  final String? errorCode;
}

final class DeviceEnrollmentCommand {
  const DeviceEnrollmentCommand({
    required this.contractVersion,
    required this.installationId,
    required this.enrollmentRequestId,
    required this.platform,
    required this.applicationId,
    required this.applicationVersion,
  });

  final int contractVersion;
  final String installationId;
  final String enrollmentRequestId;
  final String platform;
  final String applicationId;
  final String applicationVersion;
}

final class DeviceEnrollmentResult {
  const DeviceEnrollmentResult({
    required this.installationId,
    required this.deviceId,
    required this.accountId,
    required this.generation,
  });

  final String installationId;
  final String deviceId;
  final String accountId;
  final int generation;
}

final class HostedIdentityState {
  const HostedIdentityState({
    required this.environmentAlias,
    required this.installationId,
    required this.enrollmentState,
    required this.updatedAt,
    this.enrollmentRequestId,
    this.accountId,
    this.serverDeviceId,
    this.generation,
  });

  final String environmentAlias;
  final String installationId;
  final String enrollmentState;
  final DateTime updatedAt;
  final String? enrollmentRequestId;
  final String? accountId;
  final String? serverDeviceId;
  final int? generation;
}

final class HostedSyncDecision {
  const HostedSyncDecision.allowed(this.deviceId) : blockedReason = null;
  const HostedSyncDecision.blocked(this.blockedReason) : deviceId = null;

  final String? deviceId;
  final String? blockedReason;
}

final class DeviceEnrollmentConflict implements Exception {
  const DeviceEnrollmentConflict();
}

final class DeviceEnrollmentUnavailable implements Exception {
  const DeviceEnrollmentUnavailable();
}
