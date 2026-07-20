import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/hosted_enrollment_coordinator.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/hosted_identity_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/remote/http_device_enrollment_transport.dart';

void main() {
  test(
    'real HTTP transport preserves file-backed enrollment and local outbox',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'markei_hosted_http_file_',
      );
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/markei.sqlite');
      final server = await _EnrollmentServer.start();
      addTearDown(server.close);

      final firstDb = LocalDatabase.file(file);
      await _seedPendingLocalEvent(firstDb);
      final firstRepository = DriftHostedIdentityRepository(firstDb);
      final firstCoordinator = _coordinator(server.uri, firstRepository);

      final applied = await firstCoordinator.enroll(
        environmentAlias: 'r3c-local',
        command: _enrollmentCommand(),
      );
      final duplicate = await firstCoordinator.replay(
        environmentAlias: 'r3c-local',
      );
      final state = await firstRepository.load('r3c-local');
      final pendingBeforeClose = await firstDb
          .select(firstDb.pendingEvents)
          .get();

      expect(applied.status, 'hosted-restart-required');
      expect(duplicate.status, 'duplicate-equivalent');
      expect(state?.enrollmentState, 'device-enrolled');
      expect(state?.enrollmentRequestId, _requestId);
      expect(server.seenCredentials, ['synthetic-access-token']);
      expect(pendingBeforeClose, hasLength(1));
      await firstDb.close();

      final reopenedDb = LocalDatabase.file(file);
      addTearDown(reopenedDb.close);
      final reopenedRepository = DriftHostedIdentityRepository(reopenedDb);
      final reopenedState = await reopenedRepository.load('r3c-local');

      expect(reopenedState?.enrollmentRequestId, _requestId);
      expect(reopenedState?.serverDeviceId, _deviceId);
      expect(
        await reopenedDb.select(reopenedDb.pendingEvents).get(),
        hasLength(1),
      );
      expect(await reopenedDb.select(reopenedDb.purchases).get(), hasLength(1));
    },
  );

  test(
    'real HTTP failures persist closed non-success outcomes without facts loss',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'markei_hosted_http_failure_',
      );
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/markei.sqlite');
      final server = await _EnrollmentServer.start();
      addTearDown(server.close);
      final db = LocalDatabase.file(file);
      addTearDown(db.close);
      await _seedPendingLocalEvent(db);
      final repository = DriftHostedIdentityRepository(db);

      for (final mode in ['conflict', 'malformed', 'unavailable']) {
        server.mode = mode;
        final outcome = await _coordinator(
          server.uri,
          repository,
        ).enroll(environmentAlias: mode, command: _enrollmentCommand(mode));
        final persisted = await repository.load(mode);

        expect(
          outcome.status,
          mode == 'malformed' ? 'unknown' : isNot('applied'),
        );
        expect(persisted?.enrollmentState, isNot('enrolling'));
        expect(persisted?.serverDeviceId, isNull);
        expect(await db.select(db.pendingEvents).get(), hasLength(1));
        expect(await db.select(db.purchases).get(), hasLength(1));
      }
    },
  );

  test(
    'absolute deadline closes an owned request against slow body trickle',
    () async {
      final server = await _EnrollmentServer.start();
      addTearDown(server.close);
      server.mode = 'slow-body';
      final transport = HttpDeviceEnrollmentTransport(
        origin: server.uri,
        timeout: const Duration(milliseconds: 80),
      );

      final result = await transport.enroll(
        _enrollmentCommand('slow-body'),
        'synthetic-access-token',
      );

      expect(result, isA<DeviceEnrollmentTransportUnavailable>());
    },
  );
}

const _accountId = '11111111-1111-4111-8111-111111111111';
const _deviceId = '22222222-2222-4222-8222-222222222222';
const _installationId = '33333333-3333-4333-8333-333333333333';
const _requestId = '55555555-5555-4555-8555-555555555555';

HostedEnrollmentCoordinator _coordinator(
  Uri uri,
  DriftHostedIdentityRepository repository,
) {
  return HostedEnrollmentCoordinator(
    authenticationSession: LabAuthenticationSession(),
    tokenSource: LabAccessTokenSource.accepted('synthetic-access-token'),
    transport: HttpDeviceEnrollmentTransport(
      origin: uri,
      timeout: const Duration(milliseconds: 500),
    ),
    repository: repository,
    now: () => DateTime.utc(2026, 7, 15),
  );
}

DeviceEnrollmentCommand _enrollmentCommand([String suffix = 'ok']) {
  return DeviceEnrollmentCommand(
    contractVersion: 1,
    installationId: _installationId,
    enrollmentRequestId: suffix == 'ok' ? _requestId : '$_requestId-$suffix',
    platform: 'test',
    applicationId: 'markei.hosted.local',
    applicationVersion: '1.0.0',
  );
}

Future<void> _seedPendingLocalEvent(LocalDatabase db) {
  return LocalPurchaseRepository(db)
      .registerPurchase(
        RegisterPurchaseCommand(
          accountId: const AccountId(_accountId),
          deviceId: const DeviceId('44444444-4444-4444-8444-444444444444'),
          storeName: 'Local Store',
          occurrenceTime: DateTime.utc(2026, 7, 15, 12),
          currencyCode: 'BRL',
          items: [
            PurchaseItemDraft(
              productReference: const NewProductReference(
                ProductDraft(
                  userCode: 'R3C-001',
                  name: 'R3C Product',
                  brand: 'Local',
                  mode: ProductMode.packaged,
                  measurementKind: MeasurementKind.mass,
                  packageAmount: '1',
                  packageUnit: 'kg',
                ),
              ),
              packageCount: 1,
              purchasedQuantity: NormalizedQuantity.fromDecimalString(
                kind: MeasurementKind.mass,
                unit: CanonicalUnit.kg,
                decimal: '1',
              ),
              lineTotal: const Money(currencyCode: 'BRL', minorUnits: 1000),
            ),
          ],
        ),
      )
      .then((_) {});
}

final class _EnrollmentServer {
  _EnrollmentServer._(this._server);

  final HttpServer _server;
  final seenCredentials = <String>[];
  String mode = 'success';

  Uri get uri => Uri.parse('http://${_server.address.host}:${_server.port}');

  static Future<_EnrollmentServer> start() async {
    final server = _EnrollmentServer._(
      await HttpServer.bind(InternetAddress.loopbackIPv4, 0),
    );
    unawaited(server._serve());
    return server;
  }

  Future<void> close() => _server.close(force: true);

  Future<void> _serve() async {
    await for (final request in _server) {
      final authorization = request.headers.value(
        HttpHeaders.authorizationHeader,
      );
      if (authorization?.startsWith('Bearer ') ?? false) {
        seenCredentials.add(authorization!.substring('Bearer '.length));
      }
      if (mode == 'conflict') {
        request.response.statusCode = HttpStatus.conflict;
        await request.response.close();
        continue;
      }
      if (mode == 'malformed') {
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write('{"contractVersion":1,"status":"device-enrolled"}');
        await request.response.close();
        continue;
      }
      if (mode == 'unavailable') {
        request.response.statusCode = HttpStatus.serviceUnavailable;
        await request.response.close();
        continue;
      }
      if (mode == 'slow-body') {
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write('{"contractVersion":1,');
        await request.response.flush();
        await Future<void>.delayed(const Duration(milliseconds: 120));
        request.response.write('"status":"device-enrolled"}');
        await request.response.close();
        continue;
      }
      final status = request.method == 'GET'
          ? 'duplicate-equivalent'
          : 'device-enrolled';
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write(
          jsonEncode({
            'contractVersion': 1,
            'status': status,
            'installationId': _installationId,
            'deviceId': _deviceId,
            'accountId': _accountId,
            'generation': 1,
          }),
        );
      await request.response.close();
    }
  }
}
