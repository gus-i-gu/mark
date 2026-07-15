import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../application/sync/sync_ports.dart';
import '../../domain/sync/sync_event.dart';

typedef SyncTokenSource = FutureOr<String> Function();
typedef SyncCorrelationSource = String Function();

final class HttpSyncTransport implements SyncTransport {
  HttpSyncTransport({
    required this.client,
    required this.baseUri,
    required this.tokenSource,
    required this.correlationSource,
    this.timeout = const Duration(seconds: 5),
    this.maxResponseBytes = 262144,
  });

  final http.Client client;
  final Uri baseUri;
  final SyncTokenSource tokenSource;
  final SyncCorrelationSource correlationSource;
  final Duration timeout;
  final int maxResponseBytes;

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) async {
    final body = {
      'submissionId': submission.id,
      'deviceId': submission.deviceId,
      'requestHash': submission.requestHash,
      'events': submission.events,
    };
    final response = await _sendJson('POST', '/v1/sync/submissions', body);
    if (response == null) {
      return _unknown();
    }
    if (response['status'] == 'server-accepted') {
      return const SyncResult(
        code: SyncStatusCode.serverAccepted,
        outcome: SyncOutcome.applied,
        retryable: false,
      );
    }
    if (response['status'] == 'duplicate-ignored') {
      return const SyncResult(
        code: SyncStatusCode.duplicateIgnored,
        outcome: SyncOutcome.duplicateEquivalent,
        retryable: false,
      );
    }
    return _failure(response);
  }

  @override
  Future<DownloadPage> downloadAfter(
    String? cursor, {
    required int limit,
  }) async {
    final query = {'limit': limit.toString()};
    if (cursor != null) {
      query['after'] = cursor;
    }
    final uri = baseUri.replace(
      path: _join('/v1/sync/events'),
      queryParameters: query,
    );
    final response = await _request(http.Request('GET', uri)).timeout(timeout);
    final body = await _decodeResponse(response);
    final events = (body['events'] as List<Object?>? ?? [])
        .cast<Map<String, Object?>>()
        .map(
          (item) => DownloadedEvent(
            event: item['event'] as Map<String, Object?>,
            serverCursor: item['serverCursor'] as String,
          ),
        )
        .toList(growable: false);
    return DownloadPage(
      nextCursor: body['nextCursor'] as String?,
      events: events,
    );
  }

  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) async {
    final response = await _sendJson('POST', '/v1/sync/acknowledgements', {
      'greatestContiguousCursor': greatestContiguousCursor,
    });
    if (response == null) {
      return _unknown();
    }
    if (response['status'] == 'acknowledged') {
      return const SyncResult(
        code: SyncStatusCode.acknowledged,
        outcome: SyncOutcome.applied,
        retryable: false,
      );
    }
    if (response['status'] == 'duplicate-ignored') {
      return const SyncResult(
        code: SyncStatusCode.duplicateIgnored,
        outcome: SyncOutcome.duplicateEquivalent,
        retryable: false,
      );
    }
    return _failure(response);
  }

  Future<Map<String, Object?>?> _sendJson(
    String method,
    String path,
    Map<String, Object?> body,
  ) async {
    final request = http.Request(method, baseUri.replace(path: _join(path)))
      ..body = jsonEncode(body);
    request.headers['content-type'] = 'application/json';
    request.headers['accept'] = 'application/json';
    request.headers['x-correlation-id'] = correlationSource();
    request.headers['authorization'] = 'Bearer ${await tokenSource()}';
    try {
      return _decodeResponse(await _request(request).timeout(timeout));
    } on TimeoutException {
      return null;
    } on http.ClientException {
      return null;
    }
  }

  Future<http.StreamedResponse> _request(http.BaseRequest request) {
    request.headers.putIfAbsent('accept', () => 'application/json');
    return client.send(request);
  }

  Future<Map<String, Object?>> _decodeResponse(
    http.StreamedResponse response,
  ) async {
    final contentType = response.headers['content-type'] ?? '';
    if (!contentType.toLowerCase().contains('application/json')) {
      throw StateError('Sync response content type is not JSON.');
    }
    final bytes = await response.stream
        .take(maxResponseBytes + 1)
        .fold<List<int>>(<int>[], (bytes, chunk) {
          bytes.addAll(chunk);
          if (bytes.length > maxResponseBytes) {
            throw StateError('Sync response exceeded local response bound.');
          }
          return bytes;
        });
    return jsonDecode(utf8.decode(bytes)) as Map<String, Object?>;
  }

  SyncResult _failure(Map<String, Object?> body) {
    final code = switch (body['code']) {
      'auth-required' => SyncStatusCode.authRequired,
      'device-revoked' => SyncStatusCode.deviceRevoked,
      'protocol-upgrade-required' => SyncStatusCode.protocolUpgradeRequired,
      'cursor-expired' => SyncStatusCode.cursorExpired,
      _ => SyncStatusCode.conflict,
    };
    return SyncResult(
      code: code,
      outcome: SyncOutcome.notApplied,
      retryable: body['retryable'] == true,
    );
  }

  SyncResult _unknown() => const SyncResult(
    code: SyncStatusCode.unknownOutcome,
    outcome: SyncOutcome.unknown,
    retryable: true,
  );

  String _join(String path) {
    final prefix = baseUri.path.endsWith('/')
        ? baseUri.path.substring(0, baseUri.path.length - 1)
        : baseUri.path;
    return '$prefix$path';
  }
}
