// ignore_for_file: prefer_initializing_formals

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../application/hosted_connection_check.dart';
import 'hosted_http_policy.dart';

final class HttpHostedConnectionCheck implements HostedConnectionCheckPort {
  HttpHostedConnectionCheck({
    required http.Client client,
    required HostedHttpPolicy policy,
    this.timeout = const Duration(seconds: 20),
    this.maxResponseBytes = 32768,
  }) : _client = client,
       _policy = policy;

  final http.Client _client;
  final HostedHttpPolicy _policy;
  final Duration timeout;
  final int maxResponseBytes;

  @override
  HostedConnectionCorrelation createCorrelation() {
    final value = _policy.nextCorrelationId();
    return HostedConnectionCorrelation(
      value: value,
      fingerprint: correlationFingerprint(value),
    );
  }

  @override
  Future<HostedConnectionCheckResult> check(
    HostedConnectionCorrelation correlation,
  ) async {
    final started = DateTime.now().toUtc();
    final correlationId = sanitizeCorrelation(correlation.value);
    final fingerprint = correlationFingerprint(correlationId);
    var latestStage = 'preflight-passed';
    var headersReceived = false;
    int? status;
    try {
      final liveUri = _policy.route('/health/live');
      latestStage = 'request-created';
      latestStage = 'transport-started';
      final live = await _send(liveUri, correlationId).timeout(timeout);
      latestStage = live.latestStage;
      headersReceived = live.headersReceived;
      status = live.statusCode;
      if (live.resultCode != 'response-parsed-live') {
        return _result(
          started,
          fingerprint,
          latestStage,
          live.resultCode,
          'not-applied',
          live.recoveryCode,
          false,
          false,
          headersReceived,
          status,
        );
      }
      latestStage = 'request-created';
      latestStage = 'transport-started';
      final ready = await _send(
        _policy.route('/health/ready'),
        correlationId,
      ).timeout(timeout);
      latestStage = ready.latestStage;
      headersReceived = ready.headersReceived;
      status = ready.statusCode;
      if (ready.resultCode == 'response-parsed-ready') {
        return _result(
          started,
          fingerprint,
          'response-parsed',
          'hosted-connection-ready',
          'completed',
          'ready-does-not-prove-sync',
          true,
          true,
          headersReceived,
          status,
        );
      }
      return _result(
        started,
        fingerprint,
        latestStage,
        ready.resultCode,
        'not-applied',
        ready.recoveryCode,
        true,
        false,
        headersReceived,
        status,
      );
    } on HostedOriginException {
      return _result(
        started,
        fingerprint,
        'request-not-started',
        'invalid-origin',
        'blocked',
        'configuration-required',
        false,
        false,
        false,
        null,
      );
    } on TimeoutException {
      return _result(
        started,
        fingerprint,
        latestStage,
        headersReceived ? 'timeout-during-response' : 'timeout-before-response',
        'unknown',
        'retry-after-connection-review',
        false,
        false,
        headersReceived,
        status,
      );
    } on SocketException catch (error) {
      final code = switch (error.osError?.errorCode) {
        11001 || 11002 || 11003 || 11004 => 'dns-failed',
        _ => 'connection-failed',
      };
      return _result(
        started,
        fingerprint,
        'transport-started',
        code,
        'unavailable',
        'retry-after-connection-review',
        false,
        false,
        false,
        null,
      );
    } on HandshakeException {
      return _result(
        started,
        fingerprint,
        'transport-started',
        'tls-failed',
        'unavailable',
        'retry-after-connection-review',
        false,
        false,
        false,
        null,
      );
    } on http.ClientException {
      return _result(
        started,
        fingerprint,
        'transport-started',
        'connection-failed',
        'unavailable',
        'retry-after-connection-review',
        false,
        false,
        false,
        null,
      );
    } on _HealthProtocolException catch (error) {
      return _result(
        started,
        fingerprint,
        error.headersReceived ? 'response-received' : 'transport-started',
        'protocol-failed',
        'not-applied',
        'hosted-response-contract-invalid',
        false,
        false,
        error.headersReceived,
        error.statusCode,
      );
    } on FormatException {
      return _result(
        started,
        fingerprint,
        'transport-started',
        'protocol-failed',
        'not-applied',
        'hosted-response-contract-invalid',
        false,
        false,
        false,
        null,
      );
    } on Object {
      return _result(
        started,
        fingerprint,
        latestStage,
        'closure-failed',
        'unavailable',
        'local-exception-redacted',
        false,
        false,
        headersReceived,
        status,
      );
    }
  }

  Future<_HealthResponse> _send(Uri uri, String correlationId) async {
    final request = http.Request('GET', uri)
      ..followRedirects = false
      ..headers['accept'] = 'application/json'
      ..headers['x-correlation-id'] = correlationId;
    final streamed = await _client.send(request);
    final status = streamed.statusCode;
    if (status == 401 || status == 403) {
      return _HealthResponse(
        latestStage: 'response-received',
        resultCode: 'authorization-rejected',
        recoveryCode: 'hosted-health-route-authorization-unexpected',
        headersReceived: true,
        statusCode: status,
      );
    }
    if (status < 200 || status >= 300) {
      return _HealthResponse(
        latestStage: 'response-received',
        resultCode: 'hosted-rejected',
        recoveryCode: 'hosted-health-status-not-success',
        headersReceived: true,
        statusCode: status,
      );
    }
    final contentType = streamed.headers['content-type'] ?? '';
    final bytes = await streamed.stream
        .take(maxResponseBytes + 1)
        .fold<List<int>>(<int>[], (bytes, chunk) {
          bytes.addAll(chunk);
          if (bytes.length > maxResponseBytes) {
            throw _HealthProtocolException(
              headersReceived: true,
              statusCode: status,
            );
          }
          return bytes;
        });
    if (!contentType.toLowerCase().contains('application/json')) {
      throw _HealthProtocolException(headersReceived: true, statusCode: status);
    }
    final Object? parsed;
    try {
      parsed = jsonDecode(utf8.decode(bytes));
    } on FormatException {
      throw _HealthProtocolException(headersReceived: true, statusCode: status);
    }
    if (parsed is! Map<String, Object?> || parsed['status'] is! String) {
      throw _HealthProtocolException(headersReceived: true, statusCode: status);
    }
    final statusValue = parsed['status'] as String;
    if (uri.path.endsWith('/health/live') && statusValue == 'live') {
      return _HealthResponse(
        latestStage: 'response-parsed',
        resultCode: 'response-parsed-live',
        recoveryCode: 'live-does-not-prove-sync',
        headersReceived: true,
        statusCode: status,
      );
    }
    if (uri.path.endsWith('/health/ready') && statusValue == 'ready') {
      return _HealthResponse(
        latestStage: 'response-parsed',
        resultCode: 'response-parsed-ready',
        recoveryCode: 'ready-does-not-prove-sync',
        headersReceived: true,
        statusCode: status,
      );
    }
    return _HealthResponse(
      latestStage: 'response-parsed',
      resultCode: uri.path.endsWith('/health/ready')
          ? 'hosted-live-not-ready'
          : 'protocol-failed',
      recoveryCode: uri.path.endsWith('/health/ready')
          ? 'database-readiness-not-passed'
          : 'hosted-response-contract-invalid',
      headersReceived: true,
      statusCode: status,
    );
  }

  HostedConnectionCheckResult _result(
    DateTime started,
    String fingerprint,
    String latestStage,
    String resultCode,
    String outcomeClass,
    String recoveryCode,
    bool liveReachable,
    bool ready,
    bool headersReceived,
    int? status,
  ) {
    return HostedConnectionCheckResult(
      correlationFingerprint: fingerprint,
      latestStage: latestStage,
      resultCode: resultCode,
      outcomeClass: outcomeClass,
      recoveryCode: recoveryCode,
      liveReachable: liveReachable,
      ready: ready,
      elapsedBand: elapsedBand(DateTime.now().toUtc().difference(started)),
      responseHeadersReceived: headersReceived,
      httpStatus: status,
    );
  }
}

final class _HealthProtocolException implements Exception {
  const _HealthProtocolException({
    required this.headersReceived,
    required this.statusCode,
  });

  final bool headersReceived;
  final int? statusCode;
}

final class _HealthResponse {
  const _HealthResponse({
    required this.latestStage,
    required this.resultCode,
    required this.recoveryCode,
    required this.headersReceived,
    required this.statusCode,
  });

  final String latestStage;
  final String resultCode;
  final String recoveryCode;
  final bool headersReceived;
  final int statusCode;
}
