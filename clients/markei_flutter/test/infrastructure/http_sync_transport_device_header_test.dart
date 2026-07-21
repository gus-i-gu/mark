import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/infrastructure/remote/http_sync_transport.dart';

void main() {
  test(
    'HTTP sync transport sends hosted Device header on protected routes',
    () async {
      final client = _RecordingClient();
      final transport = HttpSyncTransport(
        client: client,
        baseUri: Uri.parse('https://sync.example.invalid/base'),
        tokenSource: () => 'fixture-token',
        correlationSource: () => 'fixture-correlation',
        hostedDeviceId: '22222222-2222-4222-8222-222222222222',
      );

      await transport.uploadSubmission(
        const SyncUploadSubmission(
          id: 'submission-1',
          deviceId: '22222222-2222-4222-8222-222222222222',
          requestHash: 'request-hash',
          events: [],
        ),
      );
      await transport.downloadAfter('c10b:1', limit: 25);
      await transport.acknowledge('c10b:2');
      await transport.startRecovery(
        recoverySessionId: 'recovery-1',
        requestHash: 'recovery-request-hash',
      );
      await transport.queryRecovery('recovery-1');
      await transport.downloadChunk('recovery-1', 0);
      await transport.completeRecovery(
        recoverySessionId: 'recovery-1',
        snapshotId: 'snapshot-1',
        manifestHash: 'manifest-hash',
        committedCatchUpCursor: 'c10b:2',
      );

      expect(client.requests, hasLength(7));
      expect(client.requests.map((request) => request.method), [
        'POST',
        'GET',
        'POST',
        'POST',
        'GET',
        'GET',
        'POST',
      ]);
      expect(client.requests.map((request) => request.url.path), [
        '/base/v1/sync/submissions',
        '/base/v1/sync/events',
        '/base/v1/sync/acknowledgements',
        '/base/v1/sync/rebootstrap',
        '/base/v1/sync/rebootstrap/recovery-1',
        '/base/v1/sync/rebootstrap/recovery-1/chunks/0',
        '/base/v1/sync/rebootstrap/recovery-1/complete',
      ]);
      for (final request in client.requests) {
        expect(
          request.headers['x-markei-device-id'],
          '22222222-2222-4222-8222-222222222222',
        );
        expect(request.headers['authorization'], 'Bearer fixture-token');
        expect(request.headers['x-correlation-id'], 'fixture-correlation');
        expect(request.headers['accept'], 'application/json');
      }
      for (final request in client.requests.where(
        (request) => request.method == 'POST',
      )) {
        expect(request.headers['content-type'], 'application/json');
      }
      expect(client.requests[1].url.queryParameters, {
        'after': 'c10b:1',
        'limit': '25',
      });
    },
  );
}

final class _RecordingClient extends http.BaseClient {
  final requests = <http.BaseRequest>[];

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    requests.add(request);
    return http.StreamedResponse(
      Stream.value(utf8.encode(jsonEncode(_responseFor(request)))),
      200,
      headers: {'content-type': 'application/json'},
    );
  }

  Map<String, Object?> _responseFor(http.BaseRequest request) {
    final path = request.url.path;
    if (path.endsWith('/submissions')) {
      return {'status': 'server-accepted'};
    }
    if (path.endsWith('/events')) {
      return {'nextCursor': null, 'events': <Object?>[]};
    }
    if (path.endsWith('/acknowledgements')) {
      return {'status': 'acknowledged'};
    }
    if (path.endsWith('/chunks/0')) {
      return {'index': 0, 'length': 0, 'hash': 'empty-hash', 'bytesBase64': ''};
    }
    if (path.endsWith('/complete')) {
      return {'status': 'recovery-completed'};
    }
    if (path.contains('/rebootstrap')) {
      return {
        'recoverySessionId': 'recovery-1',
        'phase': 'downloading',
        'manifest': {
          'accountId': '11111111-1111-4111-8111-111111111111',
          'snapshotId': 'snapshot-1',
          'formatVersion': 1,
          'coveredThroughCursor': 'c10b:2',
          'chunks': <Object?>[],
          'totalBytes': 0,
          'totalHash': 'empty-hash',
        },
      };
    }
    return {'code': 'not-found'};
  }
}
