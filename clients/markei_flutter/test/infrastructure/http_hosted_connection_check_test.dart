import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:markei/infrastructure/remote/hosted_http_policy.dart';
import 'package:markei/infrastructure/remote/http_hosted_connection_check.dart';

void main() {
  test(
    'hosted connection check calls live then ready without bearer auth',
    () async {
      final client = _ConnectionCheckClient((request) {
        if (request.url.path.endsWith('/health/live')) {
          return _json({'status': 'live'});
        }
        return _json({'status': 'ready'});
      });
      final check = _check(client);
      final correlation = check.createCorrelation();

      final result = await check.check(correlation);

      expect(result.resultCode, 'hosted-connection-ready');
      expect(result.latestStage, 'response-parsed');
      expect(result.liveReachable, isTrue);
      expect(result.ready, isTrue);
      expect(result.responseHeadersReceived, isTrue);
      expect(result.httpStatus, 200);
      expect(client.requests.map((request) => request.url.path), [
        '/base/health/live',
        '/base/health/ready',
      ]);
      for (final request in client.requests) {
        expect(request.headers.containsKey('authorization'), isFalse);
        expect(request.headers['accept'], 'application/json');
        expect(request.headers['x-correlation-id'], correlation.value);
      }
    },
  );

  test('ready not-ready is bounded and does not prove Sync success', () async {
    final check = _check(
      _ConnectionCheckClient((request) {
        if (request.url.path.endsWith('/health/live')) {
          return _json({'status': 'live'});
        }
        return _json({'status': 'not-ready'});
      }),
    );

    final result = await check.check(check.createCorrelation());

    expect(result.resultCode, 'hosted-live-not-ready');
    expect(result.recoveryCode, 'database-readiness-not-passed');
    expect(result.liveReachable, isTrue);
    expect(result.ready, isFalse);
  });

  test('live failure does not call ready', () async {
    final client = _ConnectionCheckClient((_) => _json({'status': 'not-live'}));
    final check = _check(client);

    final result = await check.check(check.createCorrelation());

    expect(result.resultCode, 'protocol-failed');
    expect(result.liveReachable, isFalse);
    expect(client.requests, hasLength(1));
  });

  test('invalid origin fails before transport', () async {
    final check = HttpHostedConnectionCheck(
      client: _ConnectionCheckClient((_) => _json({'status': 'live'})),
      policy: HostedHttpPolicy(
        origin: Uri.parse('http://api.example.invalid'),
        correlationSource: () => 'correlation-fixture',
      ),
    );

    final result = await check.check(check.createCorrelation());

    expect(result.resultCode, 'invalid-origin');
    expect(result.latestStage, 'request-not-started');
    expect(result.responseHeadersReceived, isFalse);
  });

  test(
    'timeout before response is classified without raw exception details',
    () async {
      final check = HttpHostedConnectionCheck(
        client: _NeverRespondingClient(),
        policy: _policy(),
        timeout: const Duration(milliseconds: 1),
      );

      final result = await check.check(check.createCorrelation());

      expect(result.resultCode, 'timeout-before-response');
      expect(result.latestStage, 'transport-started');
      expect(result.outcomeClass, 'unknown');
      expect(result.responseHeadersReceived, isFalse);
    },
  );

  test('malformed JSON response is protocol-failed after headers', () async {
    final check = _check(
      _ConnectionCheckClient(
        (_) => http.StreamedResponse(
          Stream.value(utf8.encode('not-json')),
          200,
          headers: {'content-type': 'application/json'},
        ),
      ),
    );

    final result = await check.check(check.createCorrelation());

    expect(result.resultCode, 'protocol-failed');
    expect(result.latestStage, 'response-received');
    expect(result.responseHeadersReceived, isTrue);
    expect(result.httpStatus, 200);
  });

  test('correlation fingerprint is short and sanitized against injection', () {
    final raw = 'abc\r\nx-secret: value/${List.filled(120, 'z').join()}';
    final sanitized = sanitizeCorrelation(raw);
    final fingerprint = correlationFingerprint(raw);

    expect(sanitized, isNot(contains('\r')));
    expect(sanitized, isNot(contains('\n')));
    expect(sanitized.length, lessThanOrEqualTo(96));
    expect(fingerprint, hasLength(8));
    expect(fingerprint, correlationFingerprint(sanitized));
  });
}

HttpHostedConnectionCheck _check(http.Client client) {
  return HttpHostedConnectionCheck(client: client, policy: _policy());
}

HostedHttpPolicy _policy() {
  return HostedHttpPolicy(
    origin: Uri.parse('https://api.example.invalid/base'),
    correlationSource: () => 'correlation-fixture',
  );
}

http.StreamedResponse _json(Map<String, Object?> body) {
  return http.StreamedResponse(
    Stream.value(utf8.encode(jsonEncode(body))),
    200,
    headers: {'content-type': 'application/json'},
  );
}

final class _ConnectionCheckClient extends http.BaseClient {
  _ConnectionCheckClient(this._handler);

  final http.StreamedResponse Function(http.BaseRequest request) _handler;
  final requests = <http.BaseRequest>[];

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    requests.add(request);
    return _handler(request);
  }
}

final class _NeverRespondingClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return Completer<http.StreamedResponse>().future;
  }
}
