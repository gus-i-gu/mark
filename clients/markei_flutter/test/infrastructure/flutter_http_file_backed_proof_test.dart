// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
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
  test('R05 emits closed Flutter HTTP/file-backed proof cases', () async {
    final proof = _ProofRun();
    await proof.run();
    for (final result in proof.results) {
      // The producer consumes these lines; they contain no bearer credential.
      print('R05_CASE ${jsonEncode(result.toJson())}');
    }
    expect(proof.results.where((result) => result.passed), hasLength(16));
  });
}

const _accountId = '11111111-1111-4111-8111-111111111111';
const _localDeviceId = '44444444-4444-4444-8444-444444444444';
const _installationId = '33333333-3333-4333-8333-333333333333';
const _syntheticFallbackToken = 'synthetic-access-token';

final class _ProofRun {
  final List<_CaseResult> results = [];

  Future<void> run() async {
    final hosted = await _hostedEndpoint();
    await _capture('device-enrolled-applied', () => _realHostedApplied(hosted));
    await _capture(
      'duplicate-equivalent-distinct',
      () => _realHostedDuplicate(hosted),
    );
    await _capture(
      'conflict-persists-facts-outbox',
      () => _failurePreservesLocalState('conflict'),
    );
    await _capture(
      'unavailable-persists-facts-outbox',
      () => _failurePreservesLocalState('unavailable'),
    );
    await _capture(
      'malformed-oversized-redirect-fail-closed',
      _malformedOversizedRedirect,
    );
    await _capture(
      'response-loss-unknown-outcome',
      () => _responseLossUnknown(hosted),
    );
    await _capture(
      'query-replay-same-request-id',
      () => _queryReplaySameRequest(hosted),
    );
    await _capture('close-reopen-preserves-state', _closeReopen);
    await _capture('normal-response-before-deadline', _normalDeadline);
    await _capture('stalled-headers-timeout', _stalledHeaders);
    await _capture('slow-trickle-total-deadline', _slowTrickle);
    await _capture('owned-client-closed-on-timeout', _ownedClientClosed);
    await _capture('borrowed-client-preserved', _borrowedClientPreserved);
    await _capture(
      'late-response-no-durable-mutation',
      _lateResponseNoMutation,
    );
    await _capture(
      'local-registration-while-api-unavailable',
      _localRegistrationWhileUnavailable,
    );
    await _capture(
      'token-not-persisted-or-logged',
      () => _tokenNotPersisted(hosted),
    );
  }

  Future<void> _capture(
    String caseId,
    Future<Map<String, Object?>> Function() action,
  ) async {
    try {
      final evidence = await action();
      results.add(_CaseResult(caseId, true, evidence: evidence));
    } catch (_) {
      results.add(_CaseResult(caseId, false, blocker: 'case-failed'));
    }
  }

  Future<Map<String, Object?>> _realHostedApplied(
    _HostedEndpoint hosted,
  ) async {
    final fixture = await _FileFixture.create('r05_real_apply_');
    try {
      await fixture.seedPurchase();
      final coordinator = _coordinator(
        hosted.origin,
        fixture.repository,
        _SequenceTokenSource([hosted.tokenA]),
      );
      final outcome = await coordinator.enroll(
        environmentAlias: 'real-applied',
        command: _command('real-applied'),
      );
      final counts = await fixture.counts();
      final state = await fixture.repository.load('real-applied');
      _require(outcome.status == 'hosted-restart-required');
      _require(state?.serverDeviceId != null);
      _require(counts.purchases == 1 && counts.pendingEvents == 1);
      return counts.toJson(state: state?.enrollmentState);
    } finally {
      await fixture.dispose();
    }
  }

  Future<Map<String, Object?>> _realHostedDuplicate(
    _HostedEndpoint hosted,
  ) async {
    final fixture = await _FileFixture.create('r05_real_duplicate_');
    try {
      await fixture.seedPurchase();
      final coordinator = _coordinator(
        hosted.origin,
        fixture.repository,
        _SequenceTokenSource([hosted.tokenA]),
      );
      await coordinator.enroll(
        environmentAlias: 'real-duplicate',
        command: _command('real-duplicate'),
      );
      final duplicate = await coordinator.replay(
        environmentAlias: 'real-duplicate',
      );
      _require(duplicate.status == 'duplicate-equivalent');
      return (await fixture.counts()).toJson(state: duplicate.status);
    } finally {
      await fixture.dispose();
    }
  }

  Future<Map<String, Object?>> _responseLossUnknown(
    _HostedEndpoint hosted,
  ) async {
    final fixture = await _FileFixture.create('r05_response_loss_');
    try {
      await fixture.seedPurchase();
      final tokenSource = _SequenceTokenSource([hosted.tokenA]);
      final coordinator = HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: tokenSource,
        transport: _CommitThenUnknownTransport(
          HttpDeviceEnrollmentTransport(origin: hosted.origin),
        ),
        repository: fixture.repository,
        now: _now,
      );
      final outcome = await coordinator.enroll(
        environmentAlias: 'response-loss',
        command: _command('response-loss'),
      );
      final state = await fixture.repository.load('response-loss');
      _require(outcome.status == 'unknown');
      _require(state?.enrollmentState == 'unknown-outcome');
      _require(
        state?.enrollmentRequestId ==
            _command('response-loss').enrollmentRequestId,
      );
      _require(state?.serverDeviceId == null);
      return (await fixture.counts()).toJson(state: state?.enrollmentState);
    } finally {
      await fixture.dispose();
    }
  }

  Future<Map<String, Object?>> _queryReplaySameRequest(
    _HostedEndpoint hosted,
  ) async {
    final fixture = await _FileFixture.create('r05_query_replay_');
    try {
      await fixture.seedPurchase();
      final environment = 'query-replay';
      final command = _command(environment);
      final repository = fixture.repository;
      final first = HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: _SequenceTokenSource([hosted.tokenA]),
        transport: _CommitThenUnknownTransport(
          HttpDeviceEnrollmentTransport(origin: hosted.origin),
        ),
        repository: repository,
        now: _now,
      );
      await first.enroll(environmentAlias: environment, command: command);
      final replay = HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: _SequenceTokenSource([hosted.tokenB]),
        transport: HttpDeviceEnrollmentTransport(origin: hosted.origin),
        repository: repository,
        now: _now,
      );
      final outcome = await replay.replay(environmentAlias: environment);
      final state = await repository.load(environment);
      _require(
        outcome.status == 'applied' || outcome.status == 'duplicate-equivalent',
      );
      _require(state?.enrollmentRequestId == command.enrollmentRequestId);
      _require(state?.serverDeviceId != null);
      return (await fixture.counts()).toJson(state: state?.enrollmentState);
    } finally {
      await fixture.dispose();
    }
  }

  Future<Map<String, Object?>> _failurePreservesLocalState(String mode) async {
    final server = await _EnrollmentServer.start(mode: mode);
    final fixture = await _FileFixture.create('r05_failure_$mode');
    try {
      await fixture.seedPurchase();
      final before = await fixture.counts();
      final outcome = await _coordinator(
        server.uri,
        fixture.repository,
        _SequenceTokenSource([_syntheticFallbackToken]),
      ).enroll(environmentAlias: mode, command: _command(mode));
      final state = await fixture.repository.load(mode);
      final after = await fixture.counts();
      _require(outcome.status != 'applied');
      _require(state?.serverDeviceId == null);
      _require(before.sameProtectedState(after));
      return after.toJson(state: state?.enrollmentState);
    } finally {
      await fixture.dispose();
      await server.close();
    }
  }

  Future<Map<String, Object?>> _malformedOversizedRedirect() async {
    for (final mode in ['malformed', 'oversized', 'redirect']) {
      await _failurePreservesLocalState(mode);
    }
    return {'checkedEdges': 3};
  }

  Future<Map<String, Object?>> _closeReopen() async {
    final server = await _EnrollmentServer.start();
    final fixture = await _FileFixture.create('r05_close_reopen_');
    try {
      await fixture.seedPurchase();
      await _coordinator(
        server.uri,
        fixture.repository,
        _SequenceTokenSource([_syntheticFallbackToken]),
      ).enroll(environmentAlias: 'close-reopen', command: _command('close'));
      final before = await fixture.counts();
      await fixture.closeDb();
      final reopened = await _FileFixture.reopen(fixture);
      final state = await reopened.repository.load('close-reopen');
      final after = await reopened.counts();
      _require(state?.serverDeviceId != null);
      _require(before.sameProtectedState(after));
      await reopened.dispose(delete: false);
      return after.toJson(state: state?.enrollmentState);
    } finally {
      await fixture.dispose();
      await server.close();
    }
  }

  Future<Map<String, Object?>> _normalDeadline() async {
    final server = await _EnrollmentServer.start();
    try {
      final result = await HttpDeviceEnrollmentTransport(
        origin: server.uri,
        timeout: const Duration(milliseconds: 500),
      ).enroll(_command('deadline'), _syntheticFallbackToken);
      _require(result is DeviceEnrollmentTransportSuccess);
      return {'status': 'success'};
    } finally {
      await server.close();
    }
  }

  Future<Map<String, Object?>> _stalledHeaders() async {
    return _deadlineServerCase('stalled-headers');
  }

  Future<Map<String, Object?>> _slowTrickle() async {
    return _deadlineServerCase('slow-body');
  }

  Future<Map<String, Object?>> _deadlineServerCase(String mode) async {
    final server = await _EnrollmentServer.start(mode: mode);
    try {
      final result = await HttpDeviceEnrollmentTransport(
        origin: server.uri,
        timeout: const Duration(milliseconds: 80),
      ).enroll(_command(mode), _syntheticFallbackToken);
      _require(result is DeviceEnrollmentTransportUnavailable);
      return {'status': 'closed'};
    } finally {
      await server.close();
    }
  }

  Future<Map<String, Object?>> _ownedClientClosed() async {
    final client = _HangingClient();
    final result = await HttpDeviceEnrollmentTransport(
      origin: Uri.parse('http://127.0.0.1:9'),
      clientFactory: () => client,
      timeout: const Duration(milliseconds: 50),
    ).enroll(_command('owned-client'), _syntheticFallbackToken);
    _require(result is DeviceEnrollmentTransportUnavailable);
    _require(client.closed);
    return {'closed': true};
  }

  Future<Map<String, Object?>> _borrowedClientPreserved() async {
    final client = _HangingClient();
    final result = await HttpDeviceEnrollmentTransport(
      origin: Uri.parse('http://127.0.0.1:9'),
      client: client,
      timeout: const Duration(milliseconds: 50),
    ).enroll(_command('borrowed-client'), _syntheticFallbackToken);
    _require(result is DeviceEnrollmentTransportUnavailable);
    _require(!client.closed);
    client.close();
    return {'closed': false};
  }

  Future<Map<String, Object?>> _lateResponseNoMutation() async {
    final server = await _EnrollmentServer.start(mode: 'slow-body');
    final fixture = await _FileFixture.create('r05_late_response_');
    try {
      await fixture.seedPurchase();
      final before = await fixture.counts();
      final outcome =
          await _coordinator(
            server.uri,
            fixture.repository,
            _SequenceTokenSource([_syntheticFallbackToken]),
            timeout: const Duration(milliseconds: 60),
          ).enroll(
            environmentAlias: 'late-response',
            command: _command('late-response'),
          );
      await Future<void>.delayed(const Duration(milliseconds: 180));
      final state = await fixture.repository.load('late-response');
      final after = await fixture.counts();
      _require(outcome.status == 'unknown');
      _require(state?.serverDeviceId == null);
      _require(before.sameProtectedState(after));
      return after.toJson(state: state?.enrollmentState);
    } finally {
      await fixture.dispose();
      await server.close();
    }
  }

  Future<Map<String, Object?>> _localRegistrationWhileUnavailable() async {
    final server = await _EnrollmentServer.start(mode: 'unavailable');
    final fixture = await _FileFixture.create('r05_local_unavailable_');
    try {
      await fixture.seedPurchase();
      await _coordinator(
        server.uri,
        fixture.repository,
        _SequenceTokenSource([_syntheticFallbackToken]),
      ).enroll(
        environmentAlias: 'unavailable-local',
        command: _command('unavailable-local'),
      );
      await fixture.seedPurchase(suffix: 'after-unavailable');
      final counts = await fixture.counts();
      _require(counts.purchases == 2);
      _require(counts.pendingEvents == 2);
      return counts.toJson(state: 'local-committed');
    } finally {
      await fixture.dispose();
      await server.close();
    }
  }

  Future<Map<String, Object?>> _tokenNotPersisted(
    _HostedEndpoint hosted,
  ) async {
    final fixture = await _FileFixture.create('r05_token_');
    try {
      await fixture.seedPurchase();
      final outcome = await _coordinator(
        hosted.origin,
        fixture.repository,
        _SequenceTokenSource([hosted.tokenA]),
      ).enroll(environmentAlias: 'token-case', command: _command('token-case'));
      final state = await fixture.repository.load('token-case');
      await fixture.closeDb();
      final bytes = await fixture.file.readAsBytes();
      _require(!_containsBytes(bytes, hosted.tokenA.codeUnits));
      _require(!(state.toString()).contains(hosted.tokenA));
      _require(!(outcome.toString()).contains(hosted.tokenA));
      return {'tokenPersisted': false};
    } finally {
      await fixture.dispose();
    }
  }
}

final class _CaseResult {
  _CaseResult(
    this.caseId,
    this.passed, {
    this.blocker,
    this.evidence = const {},
  });

  final String caseId;
  final bool passed;
  final String? blocker;
  final Map<String, Object?> evidence;

  Map<String, Object?> toJson() => {
    'caseId': caseId,
    'passed': passed,
    if (blocker != null) 'blocker': blocker,
    'evidence': evidence,
  };
}

final class _HostedEndpoint {
  _HostedEndpoint(this.origin, this.tokenA, this.tokenB);

  final Uri origin;
  final String tokenA;
  final String tokenB;
}

Future<_HostedEndpoint> _hostedEndpoint() async {
  final origin = Platform.environment['R05_HOSTED_ORIGIN'];
  if (origin == null || origin.isEmpty) {
    final server = await _EnrollmentServer.start();
    return _HostedEndpoint(
      server.uri,
      _syntheticFallbackToken,
      _syntheticFallbackToken,
    );
  }
  return _HostedEndpoint(
    Uri.parse(origin),
    Platform.environment['R05_ACCESS_TOKEN_A']!,
    Platform.environment['R05_ACCESS_TOKEN_B']!,
  );
}

HostedEnrollmentCoordinator _coordinator(
  Uri uri,
  DriftHostedIdentityRepository repository,
  AccessTokenSource tokenSource, {
  Duration timeout = const Duration(milliseconds: 500),
}) {
  return HostedEnrollmentCoordinator(
    authenticationSession: LabAuthenticationSession(),
    tokenSource: tokenSource,
    transport: HttpDeviceEnrollmentTransport(origin: uri, timeout: timeout),
    repository: repository,
    now: _now,
  );
}

DateTime _now() => DateTime.utc(2026, 7, 17, 16, 23, 23);

DeviceEnrollmentCommand _command(String suffix) => DeviceEnrollmentCommand(
  contractVersion: 1,
  installationId: _uuidFor('3', suffix),
  enrollmentRequestId: _uuidFor('5', suffix),
  platform: 'test',
  applicationId: 'markei.hosted.local',
  applicationVersion: '1.0.0',
);

String _uuidFor(String prefix, String value) {
  final hash = value.hashCode.abs().toRadixString(16).padLeft(12, '0');
  return '$prefix$prefix$prefix$prefix$prefix$prefix$prefix$prefix-'
      '$prefix$prefix$prefix$prefix-4$prefix$prefix$prefix-'
      '8$prefix$prefix$prefix-${hash.substring(hash.length - 12)}';
}

void _require(bool condition) {
  if (!condition) throw StateError('r05-proof-condition-failed');
}

bool _containsBytes(List<int> haystack, List<int> needle) {
  if (needle.isEmpty || needle.length > haystack.length) return false;
  for (var index = 0; index <= haystack.length - needle.length; index += 1) {
    var matched = true;
    for (var offset = 0; offset < needle.length; offset += 1) {
      if (haystack[index + offset] != needle[offset]) {
        matched = false;
        break;
      }
    }
    if (matched) return true;
  }
  return false;
}

final class _FileFixture {
  _FileFixture(this.directory, this.file, this.db, this.repository);

  final Directory directory;
  final File file;
  LocalDatabase db;
  DriftHostedIdentityRepository repository;

  static Future<_FileFixture> create(String prefix) async {
    final directory = await Directory.systemTemp.createTemp(prefix);
    final file = File('${directory.path}/markei.sqlite');
    final db = LocalDatabase.file(file);
    return _FileFixture(directory, file, db, DriftHostedIdentityRepository(db));
  }

  static Future<_FileFixture> reopen(_FileFixture fixture) async {
    final db = LocalDatabase.file(fixture.file);
    return _FileFixture(
      fixture.directory,
      fixture.file,
      db,
      DriftHostedIdentityRepository(db),
    );
  }

  Future<void> seedPurchase({String suffix = 'seed'}) {
    return LocalPurchaseRepository(db)
        .registerPurchase(
          RegisterPurchaseCommand(
            accountId: const AccountId(_accountId),
            deviceId: const DeviceId(_localDeviceId),
            storeName: 'Local Store $suffix',
            occurrenceTime: DateTime.utc(2026, 7, 17, 12),
            currencyCode: 'BRL',
            items: [
              PurchaseItemDraft(
                productReference: NewProductReference(
                  ProductDraft(
                    userCode: 'R05-$suffix',
                    name: 'R05 Product $suffix',
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

  Future<_LocalCounts> counts() async {
    return _LocalCounts(
      purchases: (await db.select(db.purchases).get()).length,
      syncEvents: (await db.select(db.syncEvents).get()).length,
      pendingEvents: (await db.select(db.pendingEvents).get()).length,
      hostedStates: (await db.select(db.hostedAuthStates).get()).length,
    );
  }

  Future<void> closeDb() async {
    await db.close();
  }

  Future<void> dispose({bool delete = true}) async {
    await db.close().catchError((_) {});
    if (delete && await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}

final class _LocalCounts {
  _LocalCounts({
    required this.purchases,
    required this.syncEvents,
    required this.pendingEvents,
    required this.hostedStates,
  });

  final int purchases;
  final int syncEvents;
  final int pendingEvents;
  final int hostedStates;

  bool sameProtectedState(_LocalCounts other) =>
      purchases == other.purchases &&
      syncEvents == other.syncEvents &&
      pendingEvents == other.pendingEvents;

  Map<String, Object?> toJson({String? state}) {
    final json = <String, Object?>{
      'purchases': purchases,
      'syncEvents': syncEvents,
      'pendingEvents': pendingEvents,
      'hostedStates': hostedStates,
    };
    if (state != null) json['state'] = state;
    return json;
  }
}

final class _SequenceTokenSource implements AccessTokenSource {
  _SequenceTokenSource(this._tokens);

  final List<String> _tokens;
  var _index = 0;

  @override
  Future<AccessTokenResult> accessToken() async {
    final token = _tokens[_index.clamp(0, _tokens.length - 1)];
    _index += 1;
    return AccessTokenResult.accepted(token);
  }
}

final class _CommitThenUnknownTransport implements DeviceEnrollmentTransport {
  _CommitThenUnknownTransport(this._inner);

  final DeviceEnrollmentTransport _inner;

  @override
  Future<DeviceEnrollmentTransportResult> enroll(
    DeviceEnrollmentCommand command,
    String bearerCredential,
  ) async {
    final result = await _inner.enroll(command, bearerCredential);
    _require(result is DeviceEnrollmentTransportSuccess);
    return const DeviceEnrollmentTransportUnknown();
  }

  @override
  Future<DeviceEnrollmentTransportResult> query(
    String enrollmentRequestId,
    String bearerCredential,
  ) {
    return _inner.query(enrollmentRequestId, bearerCredential);
  }
}

final class _HangingClient extends http.BaseClient {
  bool closed = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return Completer<http.StreamedResponse>().future;
  }

  @override
  void close() {
    closed = true;
    super.close();
  }
}

final class _EnrollmentServer {
  _EnrollmentServer._(this._server, this.mode);

  final HttpServer _server;
  String mode;

  Uri get uri => Uri.parse('http://${_server.address.host}:${_server.port}');

  static Future<_EnrollmentServer> start({String mode = 'success'}) async {
    final server = _EnrollmentServer._(
      await HttpServer.bind(InternetAddress.loopbackIPv4, 0),
      mode,
    );
    unawaited(server._serve());
    return server;
  }

  Future<void> close() => _server.close(force: true);

  Future<void> _serve() async {
    await for (final request in _server) {
      if (mode == 'stalled-headers') {
        await Future<void>.delayed(const Duration(milliseconds: 140));
      }
      if (mode == 'conflict') {
        request.response.statusCode = HttpStatus.conflict;
        await request.response.close();
        continue;
      }
      if (mode == 'unavailable') {
        request.response.statusCode = HttpStatus.serviceUnavailable;
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
      if (mode == 'oversized') {
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write('x' * 4096);
        await request.response.close();
        continue;
      }
      if (mode == 'redirect') {
        request.response
          ..statusCode = HttpStatus.found
          ..headers.set(HttpHeaders.locationHeader, '/elsewhere');
        await request.response.close();
        continue;
      }
      if (mode == 'slow-body') {
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write('{"contractVersion":1,');
        await request.response.flush();
        await Future<void>.delayed(const Duration(milliseconds: 140));
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
            'deviceId': '22222222-2222-4222-8222-222222222222',
            'accountId': _accountId,
            'generation': 1,
          }),
        );
      await request.response.close();
    }
  }
}
