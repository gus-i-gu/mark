import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../application/sync/sync_ports.dart';
import '../../domain/sync/sync_event.dart';
import '../../domain/sync/canonical_json.dart';

typedef SyncTokenSource = FutureOr<String> Function();
typedef SyncCorrelationSource = String Function();

final class HttpSyncTransport implements SyncTransport, RecoveryTransport {
  HttpSyncTransport({
    required this.client,
    required this.baseUri,
    required this.tokenSource,
    required this.correlationSource,
    required this.hostedDeviceId,
    this.timeout = const Duration(seconds: 5),
    this.maxResponseBytes = 262144,
  });

  final http.Client client;
  final Uri baseUri;
  final SyncTokenSource tokenSource;
  final SyncCorrelationSource correlationSource;
  final String hostedDeviceId;
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
    final request = await _protectedRequest('GET', uri);
    final response = await _request(request).timeout(timeout);
    final body = await _decodeResponse(response);
    if (body['code'] == 'cursor-expired') {
      throw StateError('cursor-expired');
    }
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

  @override
  Future<RecoverySession> startRecovery({
    required String recoverySessionId,
    required String requestHash,
  }) async {
    final response = await _sendJson('POST', '/v1/sync/rebootstrap', {
      'recoverySessionId': recoverySessionId,
      'requestHash': requestHash,
      'supportedSnapshotFormats': [1],
    });
    if (response == null) {
      throw StateError('recovery start outcome is unknown');
    }
    if (response['code'] != null) {
      throw StateError(response['code']! as String);
    }
    return _recoverySession(response, recoverySessionId);
  }

  @override
  Future<RecoverySession> queryRecovery(String recoverySessionId) async {
    final uri = baseUri.replace(
      path: _join('/v1/sync/rebootstrap/$recoverySessionId'),
    );
    final request = await _protectedRequest('GET', uri);
    final body = await _decodeResponse(
      await _request(request).timeout(timeout),
    );
    if (body['code'] != null) {
      throw StateError(body['code']! as String);
    }
    return _recoverySession(body, recoverySessionId);
  }

  @override
  Future<RecoveryChunk> downloadChunk(
    String recoverySessionId,
    int index,
  ) async {
    final uri = baseUri.replace(
      path: _join('/v1/sync/rebootstrap/$recoverySessionId/chunks/$index'),
    );
    final request = await _protectedRequest('GET', uri);
    final body = await _decodeResponse(
      await _request(request).timeout(timeout),
    );
    if (body['code'] != null) {
      throw StateError(body['code']! as String);
    }
    return RecoveryChunk(
      index: body['index']! as int,
      length: body['length']! as int,
      hash: body['hash']! as String,
      bytes: base64Decode(body['bytesBase64']! as String),
    );
  }

  @override
  Future<SyncResult> completeRecovery({
    required String recoverySessionId,
    required String snapshotId,
    required String manifestHash,
    required String committedCatchUpCursor,
  }) async {
    final response = await _sendJson(
      'POST',
      '/v1/sync/rebootstrap/$recoverySessionId/complete',
      {
        'snapshotId': snapshotId,
        'manifestHash': manifestHash,
        'committedCatchUpCursor': committedCatchUpCursor,
      },
    );
    if (response == null) {
      return _unknown();
    }
    if (response['status'] == 'recovery-completed') {
      return const SyncResult(
        code: SyncStatusCode.fullRebootstrapRequired,
        outcome: SyncOutcome.applied,
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
    final request = await _protectedRequest(
      method,
      baseUri.replace(path: _join(path)),
    );
    request.body = jsonEncode(body);
    request.headers['content-type'] = 'application/json';
    request.headers['accept'] = 'application/json';
    try {
      return _decodeResponse(await _request(request).timeout(timeout));
    } on TimeoutException {
      return null;
    } on http.ClientException {
      return null;
    }
  }

  Future<http.Request> _protectedRequest(String method, Uri uri) async {
    final request = http.Request(method, uri);
    request.headers['x-correlation-id'] = correlationSource();
    request.headers['authorization'] = 'Bearer ${await tokenSource()}';
    request.headers['x-markei-device-id'] = hostedDeviceId;
    return request;
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
      'device-enrollment-required' => SyncStatusCode.deviceEnrollmentRequired,
      'device-revoked' => SyncStatusCode.deviceRevoked,
      'device-expired' => SyncStatusCode.deviceExpired,
      'service-unavailable' => SyncStatusCode.serviceUnavailable,
      'sequence-gap' => SyncStatusCode.sequenceGap,
      'wrong-account' => SyncStatusCode.wrongAccount,
      'hash-mismatch' => SyncStatusCode.hashMismatch,
      'protocol-upgrade-required' => SyncStatusCode.protocolUpgradeRequired,
      'cursor-expired' => SyncStatusCode.cursorExpired,
      'recovery-unavailable' => SyncStatusCode.recoveryUnavailable,
      'full-rebootstrap-required' => SyncStatusCode.fullRebootstrapRequired,
      'local-changes-block-rebootstrap' =>
        SyncStatusCode.localChangesBlockRebootstrap,
      _ => SyncStatusCode.conflict,
    };
    return SyncResult(
      code: code,
      outcome: SyncOutcome.notApplied,
      retryable: body['retryable'] == true,
      protocolCode: body['code'] as String?,
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

  RecoverySession _recoverySession(
    Map<String, Object?> body,
    String fallbackId,
  ) {
    final manifest = _manifest(body['manifest']! as Map<String, Object?>);
    return RecoverySession(
      id: body['recoverySessionId'] as String? ?? fallbackId,
      phase: _phase(body['phase'] as String? ?? 'downloading'),
      manifest: manifest,
    );
  }

  RecoveryManifest _manifest(Map<String, Object?> value) {
    final chunks = (value['chunks']! as List<Object?>)
        .cast<Map<String, Object?>>()
        .map(
          (chunk) => RecoveryChunkDescriptor(
            index: chunk['index']! as int,
            length: chunk['length']! as int,
            hash: chunk['hash']! as String,
          ),
        )
        .toList(growable: false);
    return RecoveryManifest(
      accountId: value['accountId']! as String,
      snapshotId: value['snapshotId']! as String,
      formatVersion: value['formatVersion']! as int,
      coveredThroughCursor: value['coveredThroughCursor']! as String,
      chunks: chunks,
      totalBytes: value['totalBytes']! as int,
      totalHash: value['totalHash']! as String,
      manifestHash: canonicalUtf8Sha256(value),
    );
  }

  RecoveryPhase _phase(String value) => switch (value) {
    'full-rebootstrap-required' => RecoveryPhase.fullRebootstrapRequired,
    'preparing' => RecoveryPhase.preparing,
    'downloading' => RecoveryPhase.downloading,
    'downloaded' => RecoveryPhase.downloaded,
    'applying' => RecoveryPhase.applying,
    'catching-up' => RecoveryPhase.catchingUp,
    'recovery-completed' => RecoveryPhase.recoveryCompleted,
    _ => RecoveryPhase.recoveryInterrupted,
  };
}
