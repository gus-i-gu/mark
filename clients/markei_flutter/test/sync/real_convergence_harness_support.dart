import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:markei/application/register_purchase.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/domain/sync/canonical_json.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/remote/http_sync_transport.dart';

HttpSyncTransport labTransport(
  Uri uri,
  http.Client client, {
  String hostedDeviceId = '22222222-2222-4222-8222-222222222222',
}) => HttpSyncTransport(
  client: client,
  baseUri: uri,
  tokenSource: () => 'fixture-token',
  correlationSource: () => 'c10-s01b',
  hostedDeviceId: hostedDeviceId,
);

Future<void> seedLocalDevice(
  LocalDatabase db,
  AccountId account,
  DeviceId device,
) async {
  final now = DateTime.now().toUtc();
  await db
      .into(db.localAccounts)
      .insertOnConflictUpdate(
        LocalAccountsCompanion.insert(
          id: account.value,
          defaultCurrencyCode: 'BRL',
          createdAt: now,
        ),
      );
  await db
      .into(db.syncState)
      .insertOnConflictUpdate(
        SyncStateCompanion.insert(
          accountId: account.value,
          accountCursor: const Value(null),
          updatedAt: now,
        ),
      );
  await db
      .into(db.devices)
      .insert(
        DevicesCompanion.insert(
          id: device.value,
          accountId: account.value,
          nextSequence: 1,
          createdAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
}

RegisterPurchaseCommand fixturePurchaseCommand(DeviceId deviceId) =>
    RegisterPurchaseCommand(
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      deviceId: deviceId,
      storeName: 'test-store',
      occurrenceTime: DateTime.utc(2026, 7, 14, 12),
      currencyCode: 'BRL',
      items: [
        PurchaseItemDraft(
          productReference: NewProductReference(
            ProductDraft(
              userCode: 'RICE-001',
              name: 'Synthetic rice',
              brand: 'Fixture',
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
          lineTotal: const Money(currencyCode: 'BRL', minorUnits: 1299),
        ),
      ],
    );

Future<void> waitForPostgres(Directory lab) async {
  for (var i = 0; i < 30; i++) {
    final result = await Process.run('docker', [
      'compose',
      'exec',
      '-T',
      'postgres',
      'pg_isready',
      '-U',
      'markei_migrator',
      '-d',
      'markei_sync_lab',
    ], workingDirectory: lab.path);
    if (result.exitCode == 0) return;
    await Future<void>.delayed(const Duration(seconds: 1));
  }
  throw StateError('PostgreSQL lab did not become ready.');
}

Future<void> labPsql(Directory lab, String sql) async {
  final result = await Process.run('docker', [
    'compose',
    'exec',
    '-T',
    'postgres',
    'psql',
    '-U',
    'markei_migrator',
    '-d',
    'markei_sync_lab',
    '-v',
    'ON_ERROR_STOP=1',
    '-c',
    sql,
  ], workingDirectory: lab.path);
  if (result.exitCode != 0) throw StateError('psql failed: ${result.stderr}');
}

Future<int> labCount(Directory lab, String table) async {
  final result = await Process.run('docker', [
    'compose',
    'exec',
    '-T',
    'postgres',
    'psql',
    '-U',
    'markei_migrator',
    '-d',
    'markei_sync_lab',
    '-t',
    '-A',
    '-c',
    'select count(*) from $table',
  ], workingDirectory: lab.path);
  return int.parse((result.stdout as String).trim());
}

Future<int> labInt(Directory lab, String sql) async {
  final result = await Process.run('docker', [
    'compose',
    'exec',
    '-T',
    'postgres',
    'psql',
    '-U',
    'markei_migrator',
    '-d',
    'markei_sync_lab',
    '-t',
    '-A',
    '-c',
    sql,
  ], workingDirectory: lab.path);
  if (result.exitCode != 0) throw StateError('psql failed: ${result.stderr}');
  return int.parse((result.stdout as String).trim());
}

Future<void> labDocker(Directory lab, List<String> args) async {
  final result = await Process.run('docker', args, workingDirectory: lab.path);
  if (result.exitCode != 0) throw StateError('docker failed: ${result.stderr}');
}

Future<ApiProcess> startLabApi(
  Directory repo,
  String accountId,
  String deviceId,
  String runtimePassword,
) async {
  final npm = Platform.isWindows ? 'npm.cmd' : 'npm';
  final process = await Process.start(
    npm,
    ['run', 'lab'],
    workingDirectory: '${repo.path}/services/markei_sync_api',
    environment: {
      'MARKEI_SYNC_DATABASE_URL':
          'postgres://markei_runtime:$runtimePassword@127.0.0.1:55432/markei_sync_lab',
      'MARKEI_SYNC_LAB_ACCOUNT_ID': accountId,
      'MARKEI_SYNC_LAB_DEVICE_ID': deviceId,
      'HOST': '127.0.0.1',
      'PORT': '0',
    },
  );
  final lines = process.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter());
  final ready = await lines
      .firstWhere((line) => line.startsWith('MARKEI_SYNC_LAB_READY'))
      .timeout(const Duration(seconds: 20));
  return ApiProcess(
    process,
    Uri.parse('http://127.0.0.1:${ready.split(' ').last}'),
  );
}

Future<Map<String, Object?>> runRecoveryLab(
  Directory repo,
  String accountId,
  String deviceId,
  String runtimePassword,
  String action, {
  Map<String, String> environment = const {},
}) async {
  final npm = Platform.isWindows ? 'npm.cmd' : 'npm';
  final result = await Process.run(
    npm,
    ['run', 'lab:recovery', '--', action],
    workingDirectory: '${repo.path}/services/markei_sync_api',
    environment: {
      'MARKEI_SYNC_DATABASE_URL':
          'postgres://markei_migrator:$runtimePassword@127.0.0.1:55432/markei_sync_lab',
      'MARKEI_SYNC_LAB_ACCOUNT_ID': accountId,
      'MARKEI_SYNC_LAB_DEVICE_ID': deviceId,
      'MARKEI_SYNC_LAB_MIN_RETENTION_MS': '1',
      'MARKEI_SYNC_LAB_RECENT_CONTACT_MS': '60000',
      'MARKEI_SYNC_LAB_CHUNK_BYTES': '256',
      ...environment,
    },
  );
  if (result.exitCode != 0) {
    throw StateError('recovery lab failed: ${result.stderr}');
  }
  final lines = (result.stdout as String)
      .trim()
      .split('\n')
      .where((line) => line.trim().startsWith('{'))
      .toList(growable: false);
  if (lines.isEmpty) {
    throw StateError('recovery lab produced no JSON: ${result.stdout}');
  }
  return jsonDecode(lines.last) as Map<String, Object?>;
}

final class ApiProcess {
  const ApiProcess(this.process, this.uri);
  final Process process;
  final Uri uri;

  Future<void> close() async {
    process.kill();
    await process.exitCode.timeout(
      const Duration(seconds: 5),
      onTimeout: () => -1,
    );
  }
}

final class CommitDropClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  bool _dropped = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _inner.send(request);
    if (!_dropped &&
        request.method == 'POST' &&
        request.url.path.endsWith('/submissions')) {
      _dropped = true;
      await response.stream.drain<void>();
      throw http.ClientException('dropped after commit', request.url);
    }
    return response;
  }
}

String orderedProofEventId(int sequence) => switch (sequence) {
  1 => '00000000-0000-4000-8000-999999999999',
  2 => '00000000-0000-4000-8000-000000000002',
  _ => '00000000-0000-4000-8000-${sequence.toString().padLeft(12, '0')}',
};

Map<String, Object?> orderedProofEvent({
  required int sequence,
  required String accountId,
  required String deviceId,
}) {
  final content = <String, Object?>{
    'eventId': orderedProofEventId(sequence),
    'accountId': accountId,
    'deviceId': deviceId,
    'deviceSequence': sequence,
    'eventType': 'purchase.registered',
    'payloadVersion': 3,
    'occurrenceTime': DateTime.utc(2026, 7, 21, 12, sequence).toIso8601String(),
    'payload': <String, Object?>{
      'purchase': <String, Object?>{'id': 'ordered-proof-purchase-$sequence'},
      'productSnapshots': <Object?>[],
    },
  };
  return {...content, 'contentHash': canonicalUtf8Sha256(content)};
}

Future<void> insertOrderedProofEvent(
  LocalDatabase db,
  Map<String, Object?> event, {
  String state = 'pending',
}) async {
  final now = DateTime.utc(
    2026,
    7,
    21,
  ).add(Duration(milliseconds: event['deviceSequence']! as int));
  await db
      .into(db.syncEvents)
      .insert(
        SyncEventsCompanion.insert(
          id: event['eventId']! as String,
          accountId: event['accountId']! as String,
          deviceId: event['deviceId']! as String,
          deviceSequence: event['deviceSequence']! as int,
          eventType: event['eventType']! as String,
          payloadVersion: event['payloadVersion']! as int,
          occurrenceTime: DateTime.parse(event['occurrenceTime']! as String),
          payloadJson: jsonEncode(event),
          contentHash: event['contentHash']! as String,
          createdAt: now,
        ),
      );
  await db
      .into(db.pendingEvents)
      .insert(
        PendingEventsCompanion.insert(
          eventId: event['eventId']! as String,
          state: state,
          enqueuedAt: now,
        ),
      );
}

Future<void> insertLegacyFailedSubmission(
  LocalDatabase db,
  String submissionId,
  List<String> eventIds,
) async {
  final now = DateTime.utc(2026, 7, 21, 1);
  await db
      .into(db.syncSubmissions)
      .insert(
        SyncSubmissionsCompanion.insert(
          id: submissionId,
          accountId: '11111111-1111-4111-8111-111111111111',
          deviceId: '22222222-2222-4222-8222-222222222222',
          requestHash: 'legacy-failed-request-hash',
          state: 'failed',
          attemptCount: const Value(1),
          outcome: const Value('notApplied'),
          responseCode: const Value('conflict'),
          createdAt: now,
          updatedAt: now,
        ),
      );
  for (var i = 0; i < eventIds.length; i++) {
    await db
        .into(db.syncSubmissionEvents)
        .insert(
          SyncSubmissionEventsCompanion.insert(
            submissionId: submissionId,
            eventId: eventIds[i],
            position: i,
          ),
        );
  }
}
