import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/native_auth_closure_runner.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/hosted_enrollment_coordinator.dart';
import 'package:markei/infrastructure/auth/auth0_native_authentication.dart';
import 'package:markei/infrastructure/auth/native_auth_config.dart';
import 'package:markei/infrastructure/local/hosted_identity_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';

void main() {
  group('native auth configuration', () {
    test('accepts valid Android and Windows configuration', () {
      final android = NativeAuthConfiguration.validate(
        domain: 'tenant.example.auth0.com',
        clientId: 'android-public-client',
        audience: 'https://api.example.invalid',
        hostedOrigin: 'https://hosted.example.invalid',
        platform: NativeAuthPlatform.android,
      );
      final windows = NativeAuthConfiguration.validate(
        domain: 'tenant.example.auth0.com',
        clientId: 'windows-public-client',
        audience: 'https://api.example.invalid',
        hostedOrigin: 'https://hosted.example.invalid',
        platform: NativeAuthPlatform.windows,
      );

      expect(android, isA<NativeAuthConfigurationReady>());
      expect(windows, isA<NativeAuthConfigurationReady>());
      expect(
        (android as NativeAuthConfigurationReady)
            .configuration
            .androidCallbackUrl,
        'https://tenant.example.auth0.com/android/com.gusigu.markei/callback',
      );
      expect(
        (windows as NativeAuthConfigurationReady).configuration.windowsCallback,
        'auth0flutter://callback',
      );
    });

    test('fails closed when configuration is missing or malformed', () {
      final cases = [
        NativeAuthConfiguration.validate(
          domain: '',
          clientId: 'client',
          audience: 'https://api.example.invalid',
          hostedOrigin: 'https://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
        NativeAuthConfiguration.validate(
          domain: 'https://tenant.example.auth0.com',
          clientId: 'client',
          audience: 'https://api.example.invalid',
          hostedOrigin: 'https://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
        NativeAuthConfiguration.validate(
          domain: 'tenant.example.auth0.com',
          clientId: '',
          audience: 'https://api.example.invalid',
          hostedOrigin: 'https://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
        NativeAuthConfiguration.validate(
          domain: 'tenant.example.auth0.com',
          clientId: 'client',
          audience: 'not-https',
          hostedOrigin: 'https://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
        NativeAuthConfiguration.validate(
          domain: 'tenant.example.auth0.com',
          clientId: 'client',
          audience: 'https://api.example.invalid',
          hostedOrigin: 'http://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
      ];

      expect(cases, everyElement(isA<NativeAuthConfigurationUnavailable>()));
    });

    test('compile-time loader selects platform-specific client IDs', () {
      final android =
          NativeAuthConfiguration.fromEnvironment(
                targetPlatform: TargetPlatform.android,
                domain: 'tenant.example.auth0.com',
                androidClientId: 'android-client',
                windowsClientId: 'windows-client',
                audience: 'https://api.example.invalid',
                hostedOrigin: 'https://hosted.example.invalid',
              )
              as NativeAuthConfigurationReady;
      final windows =
          NativeAuthConfiguration.fromEnvironment(
                targetPlatform: TargetPlatform.windows,
                domain: 'tenant.example.auth0.com',
                androidClientId: 'android-client',
                windowsClientId: 'windows-client',
                audience: 'https://api.example.invalid',
                hostedOrigin: 'https://hosted.example.invalid',
              )
              as NativeAuthConfigurationReady;

      expect(android.configuration.clientId, 'android-client');
      expect(windows.configuration.clientId, 'windows-client');
    });
  });

  group('native Auth0 adapter', () {
    test(
      'requests the exact API audience and returns only access token',
      () async {
        final client = _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'api-token',
            idToken: 'id-token',
          ),
        );
        final auth = _auth(client);

        expect(await auth.signIn(), isA<SignedIn>());
        expect(client.loginAudiences, ['https://api.example.invalid']);
        expect((await auth.accessToken()).accessToken, 'api-token');
      },
    );

    test('rejects ID token substitution as an API credential', () async {
      final auth = _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'same-token',
            idToken: 'same-token',
          ),
        ),
      );

      expect(await auth.signIn(), isA<AuthenticationRejected>());
      expect((await auth.accessToken()).errorCode, 'signed-out');
    });

    test('maps cancellation, rejection, outage, expiry and logout', () async {
      expect(
        await _auth(_FakeNativeAuth0Client(cancel: true)).signIn(),
        isA<SignInCancelled>(),
      );
      expect(
        await _auth(
          _FakeNativeAuth0Client(rejectCode: 'access-denied'),
        ).signIn(),
        isA<AuthenticationRejected>(),
      );
      expect(
        await _auth(_FakeNativeAuth0Client(unavailable: true)).signIn(),
        isA<ProviderUnavailable>(),
      );

      final expired = _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'api-token',
            idToken: 'id-token',
            expiresAt: DateTime.utc(2026, 7, 18, 12),
          ),
        ),
        now: () => DateTime.utc(2026, 7, 18, 12, 1),
      );
      expect(await expired.signIn(), isA<TokenExpired>());

      final client = _FakeNativeAuth0Client(
        credentials: _credentials(
          accessToken: 'api-token',
          idToken: 'id-token',
        ),
      );
      final auth = _auth(client);
      await auth.signIn();
      await auth.logout();
      expect(client.logoutCount, 1);
      expect(await auth.currentState(), isA<SignedOut>());
    });

    test('cold restart cannot recover in-memory credentials', () async {
      final first = _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'api-token',
            idToken: 'id-token',
          ),
        ),
      );
      await first.signIn();
      expect((await first.accessToken()).accessToken, 'api-token');

      final restarted = _auth(_FakeNativeAuth0Client());
      expect(await restarted.currentState(), isA<SignedOut>());
      expect((await restarted.accessToken()).errorCode, 'signed-out');
    });
  });

  test('token is absent from Drift bytes and retained diagnostics', () async {
    final directory = await Directory.systemTemp.createTemp(
      'markei-native-auth-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final dbFile = File('${directory.path}/markei.sqlite');
    final db = LocalDatabase.file(dbFile);
    addTearDown(db.close);
    final token = 'native-proof-token-secret';
    final auth = _auth(
      _FakeNativeAuth0Client(
        credentials: _credentials(accessToken: token, idToken: 'id-token'),
      ),
    );

    await auth.signIn();
    final repository = DriftHostedIdentityRepository(db);
    await repository.save(
      HostedIdentityState(
        environmentAlias: 'native',
        installationId: '33333333-3333-4333-8333-333333333333',
        enrollmentState: 'signed-out',
        updatedAt: DateTime.utc(2026, 7, 18),
      ),
    );

    await db.close();
    expect(
      _containsBytes(await dbFile.readAsBytes(), token.codeUnits),
      isFalse,
    );
    expect((await auth.accessToken()).toString().contains(token), isFalse);
  });

  test('closure runner exposes semantic state only', () async {
    final runner = NativeAuthClosureRunner(
      authenticationSession: LabAuthenticationSession(),
      enrollmentCoordinator: HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: LabAccessTokenSource.accepted('synthetic-token'),
        transport: _FakeEnrollmentTransport(
          result: const DeviceEnrollmentResult(
            status: 'device-enrolled',
            installationId: '33333333-3333-4333-8333-333333333333',
            deviceId: '22222222-2222-4222-8222-222222222222',
            accountId: '11111111-1111-4111-8111-111111111111',
            generation: 1,
          ),
        ),
        repository: _MemoryHostedIdentityRepository(),
        now: () => DateTime.utc(2026, 7, 18),
      ),
      environmentAlias: 'native',
      commandFactory: _command,
    );

    expect((await runner.status()).state, 'authenticated');
    expect((await runner.enrollOrQueryDevice()).state, 'device-enrolled');
    expect((await runner.hostedSyncProbe()).state, 'hosted-sync-available');
    expect((await runner.logout()).state, 'signed-out-cleared');
  });

  test(
    'production composition is unavailable instead of lab-auth when unconfigured',
    () async {
      final runner = NativeAuthClosureRunner.unavailable();

      expect(
        NativeAuthConfiguration.fromEnvironment(),
        isA<NativeAuthConfigurationUnavailable>(),
      );
      expect((await runner.status()).state, 'configuration-missing');
    },
  );
}

bool _containsBytes(List<int> haystack, List<int> needle) {
  for (var index = 0; index <= haystack.length - needle.length; index++) {
    var matched = true;
    for (var offset = 0; offset < needle.length; offset++) {
      if (haystack[index + offset] != needle[offset]) {
        matched = false;
        break;
      }
    }
    if (matched) return true;
  }
  return false;
}

NativeAuth0Authentication _auth(
  _FakeNativeAuth0Client client, {
  DateTime Function()? now,
}) {
  final config =
      NativeAuthConfiguration.validate(
            domain: 'tenant.example.auth0.com',
            clientId: 'public-client',
            audience: 'https://api.example.invalid',
            hostedOrigin: 'https://hosted.example.invalid',
            platform: NativeAuthPlatform.windows,
          )
          as NativeAuthConfigurationReady;
  return NativeAuth0Authentication(
    configuration: config.configuration,
    clientFactory: (_) => client,
    now: now ?? () => DateTime.utc(2026, 7, 18),
  );
}

NativeAuthCredentials _credentials({
  required String accessToken,
  required String idToken,
  DateTime? expiresAt,
}) {
  return NativeAuthCredentials(
    accessToken: accessToken,
    idToken: idToken,
    expiresAt: expiresAt ?? DateTime.utc(2026, 7, 18, 13),
  );
}

DeviceEnrollmentCommand _command() => const DeviceEnrollmentCommand(
  contractVersion: 1,
  installationId: '33333333-3333-4333-8333-333333333333',
  enrollmentRequestId: '55555555-5555-4555-8555-555555555555',
  platform: 'windows',
  applicationId: 'markei.windows',
  applicationVersion: '1.0.0',
);

final class _FakeNativeAuth0Client implements NativeAuth0Client {
  _FakeNativeAuth0Client({
    this.credentials,
    this.cancel = false,
    this.unavailable = false,
    this.rejectCode,
  });

  final NativeAuthCredentials? credentials;
  final bool cancel;
  final bool unavailable;
  final String? rejectCode;
  final loginAudiences = <String>[];
  int logoutCount = 0;

  @override
  Future<NativeAuthCredentials> login({
    required String audience,
    required NativeAuthPlatform platform,
    required String windowsCallbackUrl,
  }) async {
    loginAudiences.add(audience);
    if (cancel) throw const NativeAuthCancelled();
    if (unavailable) throw const NativeAuthUnavailable();
    final code = rejectCode;
    if (code != null) throw NativeAuthRejected(code);
    return credentials ??
        _credentials(accessToken: 'api-token', idToken: 'id-token');
  }

  @override
  Future<void> logout({
    required NativeAuthPlatform platform,
    required String windowsCallbackUrl,
  }) async {
    logoutCount++;
  }
}

final class _FakeEnrollmentTransport implements DeviceEnrollmentTransport {
  _FakeEnrollmentTransport({required this.result});

  final DeviceEnrollmentResult result;

  @override
  Future<DeviceEnrollmentTransportResult> enroll(
    DeviceEnrollmentCommand command,
    String bearerCredential,
  ) async {
    return DeviceEnrollmentTransportSuccess(result);
  }

  @override
  Future<DeviceEnrollmentTransportResult> query(
    String enrollmentRequestId,
    String bearerCredential,
  ) async {
    return DeviceEnrollmentTransportSuccess(result);
  }
}

final class _MemoryHostedIdentityRepository
    implements HostedIdentityRepository {
  HostedIdentityState? _state;

  @override
  Future<HostedIdentityState?> load(String environmentAlias) async => _state;

  @override
  Future<void> save(HostedIdentityState state) async {
    _state = state;
  }
}
