import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/hosted_enrollment_coordinator.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/infrastructure/local/hosted_identity_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';

void main() {
  test(
    'stores hosted InstallationId and server Device binding by environment',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = DriftHostedIdentityRepository(db);
      final state = HostedIdentityState(
        environmentAlias: 'local-hosted',
        installationId: '33333333-3333-4333-8333-333333333333',
        enrollmentRequestId: '55555555-5555-4555-8555-555555555555',
        enrollmentState: 'device-enrolled',
        accountId: '11111111-1111-4111-8111-111111111111',
        serverDeviceId: '22222222-2222-4222-8222-222222222222',
        generation: 1,
        updatedAt: DateTime.utc(2026, 7, 15),
      );

      await repository.save(state);
      final loaded = await repository.load('local-hosted');

      expect(loaded?.installationId, state.installationId);
      expect(loaded?.serverDeviceId, state.serverDeviceId);
      expect(loaded?.enrollmentState, 'device-enrolled');
    },
  );

  test(
    'hosted sync guard blocks unenrolled and allows enrolled Device',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = DriftHostedIdentityRepository(db);
      final guard = DriftHostedSyncGuard(repository);

      expect(
        (await guard.evaluate('local-hosted')).blockedReason,
        'enrollment-required',
      );
      await repository.save(
        HostedIdentityState(
          environmentAlias: 'local-hosted',
          installationId: '33333333-3333-4333-8333-333333333333',
          enrollmentState: 'device-enrolled',
          accountId: '11111111-1111-4111-8111-111111111111',
          serverDeviceId: '22222222-2222-4222-8222-222222222222',
          generation: 1,
          updatedAt: DateTime.utc(2026, 7, 15),
        ),
      );

      expect(
        (await guard.evaluate('local-hosted')).deviceId,
        '22222222-2222-4222-8222-222222222222',
      );
    },
  );

  test(
    'coordinator persists progress and replays equivalent enrollment',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = DriftHostedIdentityRepository(db);
      final transport = _FakeEnrollmentTransport(
        result: const DeviceEnrollmentResult(
          installationId: '33333333-3333-4333-8333-333333333333',
          deviceId: '22222222-2222-4222-8222-222222222222',
          accountId: '11111111-1111-4111-8111-111111111111',
          generation: 1,
        ),
      );
      final coordinator = HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: LabAccessTokenSource.accepted('synthetic-token'),
        transport: transport,
        repository: repository,
        now: () => DateTime.utc(2026, 7, 15),
      );

      final applied = await coordinator.enroll(
        environmentAlias: 'local-hosted',
        command: _command(),
      );
      final loaded = await repository.load('local-hosted');
      final replayed = await coordinator.replay(
        environmentAlias: 'local-hosted',
      );

      expect(applied.status, 'applied');
      expect(replayed.status, 'duplicate-equivalent');
      expect(loaded?.serverDeviceId, '22222222-2222-4222-8222-222222222222');
      expect(loaded.toString().contains('synthetic-token'), isFalse);
    },
  );

  test(
    'coordinator preserves local state on cancellation, rejection and outage',
    () async {
      final cancelledDb = LocalDatabase.memory();
      final cancelledRepo = DriftHostedIdentityRepository(cancelledDb);
      final cancelled = HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(signedIn: false),
        tokenSource: LabAccessTokenSource.accepted('unused'),
        transport: _FakeEnrollmentTransport(),
        repository: cancelledRepo,
        now: () => DateTime.utc(2026, 7, 15),
      );
      expect(
        (await cancelled.enroll(
          environmentAlias: 'cancelled',
          command: _command(),
        )).reason,
        'authentication-cancelled',
      );
      await cancelledDb.close();

      final rejectedDb = LocalDatabase.memory();
      final rejectedRepo = DriftHostedIdentityRepository(rejectedDb);
      final rejected = HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: LabAccessTokenSource.rejected('token-rejected'),
        transport: _FakeEnrollmentTransport(),
        repository: rejectedRepo,
        now: () => DateTime.utc(2026, 7, 15),
      );
      expect(
        (await rejected.enroll(
          environmentAlias: 'rejected',
          command: _command(),
        )).reason,
        'token-rejected',
      );
      await rejectedDb.close();

      final outageDb = LocalDatabase.memory();
      final outageRepo = DriftHostedIdentityRepository(outageDb);
      final outage = HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: LabAccessTokenSource.accepted('synthetic-token'),
        transport: _FakeEnrollmentTransport(unavailable: true),
        repository: outageRepo,
        now: () => DateTime.utc(2026, 7, 15),
      );
      final outcome = await outage.enroll(
        environmentAlias: 'outage',
        command: _command(),
      );
      final state = await outageRepo.load('outage');
      expect(outcome.status, 'unknown');
      expect(state?.enrollmentState, 'service-unavailable');
      expect(state?.serverDeviceId, isNull);
      await outageDb.close();
    },
  );
}

DeviceEnrollmentCommand _command() => const DeviceEnrollmentCommand(
  contractVersion: 1,
  installationId: '33333333-3333-4333-8333-333333333333',
  enrollmentRequestId: '55555555-5555-4555-8555-555555555555',
  platform: 'test',
  applicationId: 'markei.hosted.local',
  applicationVersion: '1.0.0',
);

final class _FakeEnrollmentTransport implements DeviceEnrollmentTransport {
  _FakeEnrollmentTransport({this.result, this.unavailable = false});

  final DeviceEnrollmentResult? result;
  final bool unavailable;
  String? lastCredential;

  @override
  Future<DeviceEnrollmentTransportResult> enroll(
    DeviceEnrollmentCommand command,
    String bearerCredential,
  ) async {
    lastCredential = bearerCredential;
    if (unavailable) return const DeviceEnrollmentTransportUnavailable();
    return DeviceEnrollmentTransportSuccess(result!);
  }

  @override
  Future<DeviceEnrollmentTransportResult> query(
    String enrollmentRequestId,
    String bearerCredential,
  ) async {
    lastCredential = bearerCredential;
    if (unavailable) return const DeviceEnrollmentTransportUnavailable();
    final value = result;
    if (value == null) return const DeviceEnrollmentTransportUnknown();
    return DeviceEnrollmentTransportSuccess(value);
  }
}
