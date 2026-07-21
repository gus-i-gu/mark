import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/infrastructure/local/local_database.dart';

void main() {
  test('migrates v1 database to v9 with sync attempt ledger', () async {
    final temp = await Directory.systemTemp.createTemp('markei_migration_');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');

    final migratingDb = LocalDatabase(
      NativeDatabase.createInBackground(file, setup: _createV1Database),
    );
    addTearDown(migratingDb.close);

    expect(migratingDb.schemaVersion, 9);
    final products = await migratingDb.select(migratingDb.products).get();
    final ledger = await migratingDb.select(migratingDb.migrationLedger).get();

    expect(products, hasLength(1));
    expect(products.single.userProductCode, startsWith('legacy:'));
    expect(products.single.normalizedUserProductCode, isNotEmpty);
    expect(products.single.normalizationVersion, 3);
    expect(products.single.exactIdentityKey, contains('|v3|'));
    expect(products.single.displayName, 'arroz branco');
    expect(ledger.last.fromVersion, 1);
    expect(ledger.last.toVersion, 9);
    expect(ledger.last.migrationId, 'v8-to-v9-sync-attempt-ledger');
    expect(
      await migratingDb.select(migratingDb.installationMetadata).get(),
      isEmpty,
    );
    expect(await migratingDb.select(migratingDb.people).get(), isEmpty);
    expect(await migratingDb.select(migratingDb.paymentMethods).get(), isEmpty);
    expect(
      await migratingDb.select(migratingDb.recoverySessions).get(),
      isEmpty,
    );
    expect(await migratingDb.select(migratingDb.recoveryChunks).get(), isEmpty);
    expect(
      await migratingDb.select(migratingDb.hostedAuthStates).get(),
      isEmpty,
    );
    expect(await migratingDb.select(migratingDb.syncAttempts).get(), isEmpty);
    await migratingDb.close();

    final reopened = LocalDatabase.file(file);
    addTearDown(reopened.close);
    expect(await reopened.select(reopened.products).get(), hasLength(1));
  });

  test(
    'fresh v9 database creates local, recovery, hosted auth and attempt tables',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);

      expect(db.schemaVersion, 9);
      expect(await db.select(db.people).get(), isEmpty);
      expect(await db.select(db.paymentMethods).get(), isEmpty);
      expect(await db.select(db.accountPreferences).get(), isEmpty);
      expect(await db.select(db.syncSubmissions).get(), isEmpty);
      expect(await db.select(db.syncInbox).get(), isEmpty);
      expect(await db.select(db.recoverySessions).get(), isEmpty);
      expect(await db.select(db.recoveryChunks).get(), isEmpty);
      expect(await db.select(db.hostedAuthStates).get(), isEmpty);
      expect(await db.select(db.syncAttempts).get(), isEmpty);
    },
  );

  test('migrates file-backed v2 database to v9 and reopens', () async {
    final temp = await Directory.systemTemp.createTemp('markei_migration_v2_');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');

    final migratingDb = LocalDatabase(
      NativeDatabase.createInBackground(file, setup: _createV2Database),
    );

    final products = await migratingDb.select(migratingDb.products).get();
    final items = await migratingDb.select(migratingDb.purchaseItems).get();
    final ledger = await migratingDb.select(migratingDb.migrationLedger).get();

    expect(products.single.normalizationVersion, 3);
    expect(products.single.exactIdentityKey, contains('|v3|'));
    expect(items.single.packageCount, 1);
    expect(ledger.last.migrationId, 'v8-to-v9-sync-attempt-ledger');
    expect(
      await migratingDb.select(migratingDb.installationMetadata).get(),
      hasLength(1),
    );
    expect(await _schemaReferencesOldTables(migratingDb), isEmpty);
    expect(await _foreignKeyCheckRows(migratingDb), isEmpty);
    await migratingDb.close();

    final reopened = LocalDatabase.file(file);
    addTearDown(reopened.close);
    expect(await reopened.select(reopened.purchases).get(), hasLength(1));
    expect(await reopened.select(reopened.hostedAuthStates).get(), isEmpty);
    expect(await reopened.select(reopened.syncAttempts).get(), isEmpty);
    expect(await reopened.select(reopened.people).get(), isEmpty);
  });

  test('repairs malformed v7 purchase foreign keys and reopens', () async {
    final temp = await Directory.systemTemp.createTemp(
      'markei_migration_v7_repair_',
    );
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');

    final migratingDb = LocalDatabase(
      NativeDatabase.createInBackground(
        file,
        setup: _createMalformedV7Database,
      ),
    );

    expect(await _schemaReferencesOldTables(migratingDb), isEmpty);
    expect(await _foreignKeyCheckRows(migratingDb), isEmpty);
    expect(
      await _foreignKeyTargets(migratingDb, 'purchases'),
      containsPair('person_id', 'people'),
    );
    expect(
      await _foreignKeyTargets(migratingDb, 'purchases'),
      containsPair('payment_method_id', 'payment_methods'),
    );
    expect(
      await _foreignKeyTargets(migratingDb, 'purchase_items'),
      containsPair('product_id', 'products'),
    );
    expect(await migratingDb.select(migratingDb.purchases).get(), hasLength(1));
    expect(
      await migratingDb.select(migratingDb.purchaseItems).get(),
      hasLength(1),
    );
    final ledger = await migratingDb.select(migratingDb.migrationLedger).get();
    expect(ledger.last.migrationId, 'v8-to-v9-sync-attempt-ledger');
    await migratingDb.close();

    final reopened = LocalDatabase.file(file);
    addTearDown(reopened.close);
    expect(await reopened.select(reopened.purchases).get(), hasLength(1));
    expect(await _schemaReferencesOldTables(reopened), isEmpty);
    expect(await _foreignKeyCheckRows(reopened), isEmpty);
  });

  test('v8 repair failure rolls back and source remains reopenable', () async {
    final temp = await Directory.systemTemp.createTemp(
      'markei_migration_v8_rollback_',
    );
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');

    final failingDb = LocalDatabase(
      NativeDatabase.createInBackground(
        file,
        setup: _createMalformedV7Database,
      ),
      v8RepairHook: (phase) async {
        if (phase == 'before-validation') {
          throw StateError('injected v8 validation failure');
        }
      },
    );

    await expectLater(
      failingDb.select(failingDb.purchases).get(),
      throwsA(
        predicate(
          (Object error) =>
              error.toString().contains('injected v8 validation failure'),
        ),
      ),
    );
    await failingDb.close();

    final repairedDb = LocalDatabase.file(file);
    addTearDown(repairedDb.close);
    expect(await repairedDb.select(repairedDb.purchases).get(), hasLength(1));
    expect(await _schemaReferencesOldTables(repairedDb), isEmpty);
    expect(await _foreignKeyCheckRows(repairedDb), isEmpty);
  });

  test(
    'reopening an already migrated v9 database does not rewrite rows',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'markei_migration_v8_idempotent_',
      );
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/markei.sqlite');

      final firstDb = LocalDatabase(
        NativeDatabase.createInBackground(
          file,
          setup: _createMalformedV7Database,
        ),
      );
      final firstLedger = await firstDb.select(firstDb.migrationLedger).get();
      final firstDevice = (await firstDb.select(firstDb.devices).get()).single;
      await firstDb.close();

      final reopened = LocalDatabase.file(file);
      addTearDown(reopened.close);
      final reopenedLedger = await reopened
          .select(reopened.migrationLedger)
          .get();
      final reopenedDevice =
          (await reopened.select(reopened.devices).get()).single;

      expect(reopenedLedger, hasLength(firstLedger.length));
      expect(reopenedDevice.nextSequence, firstDevice.nextSequence);
      expect(await reopened.select(reopened.purchases).get(), hasLength(1));
      expect(await reopened.select(reopened.purchaseItems).get(), hasLength(1));
    },
  );

  test('migrates v8 database to v9 attempt ledger without reset', () async {
    final temp = await Directory.systemTemp.createTemp(
      'markei_migration_v8_to_v9_',
    );
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');

    final migratingDb = LocalDatabase(
      NativeDatabase.createInBackground(file, setup: _createV8Database),
    );

    expect(migratingDb.schemaVersion, 9);
    expect(await migratingDb.select(migratingDb.syncAttempts).get(), isEmpty);
    expect(await migratingDb.select(migratingDb.pendingEvents).get(), isEmpty);
    expect(
      (await migratingDb.select(migratingDb.devices).get()).single.nextSequence,
      1,
    );
    final ledger = await migratingDb.select(migratingDb.migrationLedger).get();
    expect(ledger.last.fromVersion, 8);
    expect(ledger.last.toVersion, 9);
    expect(ledger.last.migrationId, 'v8-to-v9-sync-attempt-ledger');
    await migratingDb.close();

    final reopened = LocalDatabase.file(file);
    addTearDown(reopened.close);
    expect(await reopened.select(reopened.syncAttempts).get(), isEmpty);
    expect(await reopened.select(reopened.hostedAuthStates).get(), isEmpty);
  });

  test('v5 migration stops on ambiguous current Device without reset', () async {
    final temp = await Directory.systemTemp.createTemp('markei_migration_bad_');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');

    final migratingDb = LocalDatabase(
      NativeDatabase.createInBackground(
        file,
        setup: (database) {
          _createV2Database(database);
          database.execute(
            "INSERT INTO devices VALUES ('99999999-9999-4999-8999-999999999999', '11111111-1111-4111-8111-111111111111', 1, 1783857600001)",
          );
        },
      ),
    );
    addTearDown(migratingDb.close);

    await expectLater(
      migratingDb.select(migratingDb.installationMetadata).get(),
      throwsA(
        predicate(
          (Object error) =>
              error.toString().contains('Ambiguous current Device'),
        ),
      ),
    );

    expect(file.existsSync(), isTrue);
  });
}

Future<List<Map<String, Object?>>> _schemaReferencesOldTables(
  LocalDatabase db,
) async {
  final rows = await db
      .customSelect(
        "SELECT type, name, sql FROM sqlite_schema WHERE instr(sql, '_old') > 0",
      )
      .get();
  return rows.map((row) => row.data).toList(growable: false);
}

Future<List<Map<String, Object?>>> _foreignKeyCheckRows(
  LocalDatabase db,
) async {
  final rows = await db.customSelect('PRAGMA foreign_key_check').get();
  return rows.map((row) => row.data).toList(growable: false);
}

Future<Map<String, String>> _foreignKeyTargets(
  LocalDatabase db,
  String table,
) async {
  final rows = await db.customSelect('PRAGMA foreign_key_list($table)').get();
  return {
    for (final row in rows)
      row.data['from'] as String: row.data['table'] as String,
  };
}

void _createV1Database(dynamic database) {
  database.execute('PRAGMA foreign_keys = OFF');
  database.execute('''
CREATE TABLE local_accounts (
  id TEXT NOT NULL PRIMARY KEY,
  default_currency_code TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE devices (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  next_sequence INTEGER NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE products (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  normalization_version INTEGER NOT NULL,
  normalized_name TEXT NOT NULL,
  normalized_brand TEXT NOT NULL,
  mode TEXT NOT NULL,
  measurement_kind TEXT NOT NULL,
  package_amount TEXT,
  package_unit TEXT,
  exact_identity_key TEXT NOT NULL UNIQUE,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE stores (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  display_name TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE purchases (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  store_id TEXT NOT NULL REFERENCES stores(id),
  occurrence_time INTEGER NOT NULL,
  currency_code TEXT NOT NULL,
  total_minor_units INTEGER NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE purchase_items (
  id TEXT NOT NULL PRIMARY KEY,
  purchase_id TEXT NOT NULL REFERENCES purchases(id),
  product_id TEXT NOT NULL REFERENCES products(id),
  package_count INTEGER NOT NULL,
  measurement_kind TEXT NOT NULL,
  purchased_amount TEXT NOT NULL,
  purchased_unit TEXT NOT NULL,
  currency_code TEXT NOT NULL,
  line_total_minor_units INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_events (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  device_id TEXT NOT NULL REFERENCES devices(id),
  device_sequence INTEGER NOT NULL,
  event_type TEXT NOT NULL,
  payload_version INTEGER NOT NULL,
  occurrence_time INTEGER NOT NULL,
  payload_json TEXT NOT NULL,
  content_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE pending_events (
  event_id TEXT NOT NULL PRIMARY KEY REFERENCES sync_events(id),
  state TEXT NOT NULL,
  enqueued_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_state (
  account_id TEXT NOT NULL PRIMARY KEY REFERENCES local_accounts(id),
  account_cursor TEXT,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE migration_ledger (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  schema_name TEXT NOT NULL,
  schema_version INTEGER NOT NULL,
  applied_at INTEGER NOT NULL
);
''');
  database.execute(
    "INSERT INTO local_accounts VALUES ('11111111-1111-4111-8111-111111111111', 'BRL', 1783857600000)",
  );
  database.execute(
    "INSERT INTO products VALUES ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', '11111111-1111-4111-8111-111111111111', 1, 'arroz branco', 'marca a', 'PACKAGED', 'MASS', '1.000000', 'KG', '11111111-1111-4111-8111-111111111111|v1|arroz branco|marca a|PACKAGED|MASS|1.000000|KG', 1783857600000)",
  );
  database.execute(
    "INSERT INTO migration_ledger (schema_name, schema_version, applied_at) VALUES ('shared_beta_local', 1, 1783857600000)",
  );
  database.execute('PRAGMA user_version = 1');
}

void _createV2Database(dynamic database) {
  database.execute('PRAGMA foreign_keys = OFF');
  database.execute('''
CREATE TABLE local_accounts (
  id TEXT NOT NULL PRIMARY KEY,
  default_currency_code TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE devices (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  next_sequence INTEGER NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, id)
);
''');
  database.execute('''
CREATE TABLE products (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  user_product_code TEXT,
  normalized_user_product_code TEXT,
  normalization_version INTEGER NOT NULL,
  display_name TEXT,
  display_brand TEXT,
  normalized_name TEXT NOT NULL,
  normalized_brand TEXT NOT NULL,
  mode TEXT NOT NULL,
  measurement_kind TEXT NOT NULL,
  package_amount TEXT,
  package_unit TEXT,
  exact_identity_key TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, normalized_user_product_code),
  UNIQUE(account_id, exact_identity_key)
);
''');
  database.execute('''
CREATE TABLE stores (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  display_name TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE purchases (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  store_id TEXT NOT NULL REFERENCES stores(id),
  occurrence_time INTEGER NOT NULL,
  currency_code TEXT NOT NULL,
  total_minor_units INTEGER NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE purchase_items (
  id TEXT NOT NULL PRIMARY KEY,
  purchase_id TEXT NOT NULL REFERENCES purchases(id),
  product_id TEXT NOT NULL REFERENCES products(id),
  package_count INTEGER NOT NULL,
  measurement_kind TEXT NOT NULL,
  purchased_amount TEXT NOT NULL,
  purchased_unit TEXT NOT NULL,
  currency_code TEXT NOT NULL,
  line_total_minor_units INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_events (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id),
  device_id TEXT NOT NULL REFERENCES devices(id),
  device_sequence INTEGER NOT NULL,
  event_type TEXT NOT NULL,
  payload_version INTEGER NOT NULL,
  occurrence_time INTEGER NOT NULL,
  payload_json TEXT NOT NULL,
  content_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, device_id, device_sequence)
);
''');
  database.execute('''
CREATE TABLE pending_events (
  event_id TEXT NOT NULL PRIMARY KEY REFERENCES sync_events(id),
  state TEXT NOT NULL,
  enqueued_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_state (
  account_id TEXT NOT NULL PRIMARY KEY REFERENCES local_accounts(id),
  account_cursor TEXT,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE migration_ledger (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  schema_name TEXT NOT NULL,
  schema_version INTEGER NOT NULL,
  from_version INTEGER,
  to_version INTEGER,
  migration_id TEXT,
  applied_at INTEGER NOT NULL
);
''');
  database.execute(
    "INSERT INTO local_accounts VALUES ('11111111-1111-4111-8111-111111111111', 'BRL', 1783857600000)",
  );
  database.execute(
    "INSERT INTO devices VALUES ('22222222-2222-4222-8222-222222222222', '11111111-1111-4111-8111-111111111111', 1, 1783857600000)",
  );
  database.execute(
    "INSERT INTO stores VALUES ('33333333-3333-4333-8333-333333333333', '11111111-1111-4111-8111-111111111111', 'Mercado Central', 1783857600000)",
  );
  database.execute(
    "INSERT INTO products VALUES ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', '11111111-1111-4111-8111-111111111111', 'ARROZ-001', 'arroz-001', 2, 'Arroz Branco', 'Marca A', 'arroz branco', 'marca a', 'PACKAGED', 'MASS', '1.000000', 'KG', '11111111-1111-4111-8111-111111111111|v2|arroz branco|marca a|PACKAGED|MASS|1.000000|KG', 1783857600000)",
  );
  database.execute(
    "INSERT INTO purchases VALUES ('44444444-4444-4444-8444-444444444444', '11111111-1111-4111-8111-111111111111', '33333333-3333-4333-8333-333333333333', 1783857600000, 'BRL', 1299, 1783857600000)",
  );
  database.execute(
    "INSERT INTO purchase_items VALUES ('55555555-5555-4555-8555-555555555555', '44444444-4444-4444-8444-444444444444', 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 1, 'MASS', '1.000000', 'KG', 'BRL', 1299)",
  );
  database.execute(
    "INSERT INTO migration_ledger (schema_name, schema_version, from_version, to_version, migration_id, applied_at) VALUES ('shared_beta_local', 2, 1, 2, 'v1-to-v2-product-code-display', 1783857600000)",
  );
  database.execute('PRAGMA user_version = 2');
}

void _createMalformedV7Database(dynamic database) {
  database.execute('PRAGMA foreign_keys = OFF');
  database.execute('''
CREATE TABLE local_accounts (
  id TEXT NOT NULL PRIMARY KEY,
  default_currency_code TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE devices (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  next_sequence INTEGER NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, id)
);
''');
  database.execute('''
CREATE TABLE products (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  user_product_code TEXT NOT NULL,
  normalized_user_product_code TEXT NOT NULL,
  normalization_version INTEGER NOT NULL,
  display_name TEXT,
  display_brand TEXT,
  normalized_name TEXT NOT NULL,
  normalized_brand TEXT NOT NULL,
  mode TEXT NOT NULL,
  measurement_kind TEXT NOT NULL,
  package_amount TEXT,
  package_unit TEXT,
  exact_identity_key TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, normalized_user_product_code),
  UNIQUE(account_id, exact_identity_key)
);
''');
  database.execute('''
CREATE TABLE stores (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  display_name TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE people (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  visible_code TEXT NOT NULL,
  nickname TEXT NOT NULL,
  normalized_nickname TEXT NOT NULL,
  active INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  archived_at INTEGER,
  UNIQUE(account_id, visible_code)
);
''');
  database.execute('''
CREATE TABLE payment_methods (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  visible_code TEXT NOT NULL,
  nickname TEXT NOT NULL,
  normalized_nickname TEXT NOT NULL,
  active INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  archived_at INTEGER,
  UNIQUE(account_id, visible_code)
);
''');
  database.execute('''
CREATE TABLE account_preferences (
  account_id TEXT NOT NULL PRIMARY KEY REFERENCES local_accounts(id) ON DELETE CASCADE,
  shortage_threshold_days INTEGER NOT NULL DEFAULT 5,
  next_person_code INTEGER NOT NULL DEFAULT 1,
  next_payment_method_code INTEGER NOT NULL DEFAULT 1,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE purchases (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  store_id TEXT NOT NULL REFERENCES stores(id) ON DELETE RESTRICT,
  person_id TEXT REFERENCES people_old(id) ON DELETE RESTRICT,
  payment_method_id TEXT REFERENCES payment_methods_old(id) ON DELETE RESTRICT,
  occurrence_time INTEGER NOT NULL,
  currency_code TEXT NOT NULL,
  total_minor_units INTEGER NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE purchase_items (
  id TEXT NOT NULL PRIMARY KEY,
  purchase_id TEXT NOT NULL REFERENCES purchases(id) ON DELETE CASCADE,
  product_id TEXT NOT NULL REFERENCES products_old(id) ON DELETE RESTRICT,
  package_count INTEGER,
  measurement_kind TEXT NOT NULL,
  purchased_amount TEXT NOT NULL,
  purchased_unit TEXT NOT NULL,
  currency_code TEXT NOT NULL,
  line_total_minor_units INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_events (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  device_id TEXT NOT NULL REFERENCES devices(id) ON DELETE RESTRICT,
  device_sequence INTEGER NOT NULL,
  event_type TEXT NOT NULL,
  payload_version INTEGER NOT NULL,
  occurrence_time INTEGER NOT NULL,
  payload_json TEXT NOT NULL,
  content_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, device_id, device_sequence)
);
''');
  database.execute('''
CREATE TABLE pending_events (
  event_id TEXT NOT NULL PRIMARY KEY REFERENCES sync_events(id) ON DELETE CASCADE,
  state TEXT NOT NULL,
  enqueued_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_state (
  account_id TEXT NOT NULL PRIMARY KEY REFERENCES local_accounts(id) ON DELETE CASCADE,
  account_cursor TEXT,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE installation_metadata (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  current_device_id TEXT NOT NULL REFERENCES devices(id) ON DELETE RESTRICT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_submissions (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  device_id TEXT NOT NULL REFERENCES devices(id) ON DELETE RESTRICT,
  request_hash TEXT NOT NULL,
  state TEXT NOT NULL,
  attempt_count INTEGER NOT NULL DEFAULT 0,
  next_attempt_at INTEGER,
  lease_until INTEGER,
  outcome TEXT,
  response_code TEXT,
  error_code TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_submission_events (
  submission_id TEXT NOT NULL REFERENCES sync_submissions(id) ON DELETE CASCADE,
  event_id TEXT NOT NULL REFERENCES sync_events(id) ON DELETE CASCADE,
  position INTEGER NOT NULL,
  PRIMARY KEY(submission_id, event_id)
);
''');
  database.execute('''
CREATE TABLE sync_inbox (
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE CASCADE,
  event_id TEXT NOT NULL,
  content_hash TEXT NOT NULL,
  server_cursor TEXT NOT NULL,
  state TEXT NOT NULL,
  applied_at INTEGER,
  PRIMARY KEY(account_id, event_id),
  UNIQUE(account_id, server_cursor)
);
''');
  database.execute('''
CREATE TABLE recovery_sessions (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL,
  snapshot_id TEXT NOT NULL,
  phase TEXT NOT NULL,
  format_version INTEGER NOT NULL,
  manifest_hash TEXT NOT NULL,
  covered_through_cursor TEXT NOT NULL,
  expires_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE recovery_chunks (
  session_id TEXT NOT NULL REFERENCES recovery_sessions(id) ON DELETE CASCADE,
  chunk_index INTEGER NOT NULL,
  byte_length INTEGER NOT NULL,
  content_hash TEXT NOT NULL,
  bytes BLOB NOT NULL,
  verified_at INTEGER NOT NULL,
  PRIMARY KEY(session_id, chunk_index)
);
''');
  database.execute('''
CREATE TABLE hosted_auth_states (
  environment_alias TEXT NOT NULL PRIMARY KEY,
  installation_id TEXT NOT NULL,
  enrollment_request_id TEXT,
  enrollment_state TEXT NOT NULL,
  account_id TEXT,
  server_device_id TEXT,
  generation INTEGER,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE migration_ledger (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  schema_name TEXT NOT NULL,
  schema_version INTEGER NOT NULL,
  from_version INTEGER,
  to_version INTEGER,
  migration_id TEXT,
  applied_at INTEGER NOT NULL
);
''');
  _insertCommonV7Rows(database);
  database.execute(
    "INSERT INTO people VALUES ('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb', '11111111-1111-4111-8111-111111111111', '@001', 'Gus', 'gus', 1, 1783857600000, 1783857600000, NULL)",
  );
  database.execute(
    "INSERT INTO payment_methods VALUES ('cccccccc-cccc-4ccc-8ccc-cccccccccccc', '11111111-1111-4111-8111-111111111111', '#001', 'Credit', 'credit', 1, 1783857600000, 1783857600000, NULL)",
  );
  database.execute(
    "INSERT INTO purchases VALUES ('44444444-4444-4444-8444-444444444444', '11111111-1111-4111-8111-111111111111', '33333333-3333-4333-8333-333333333333', 'bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb', 'cccccccc-cccc-4ccc-8ccc-cccccccccccc', 1783857600000, 'BRL', 1299, 1783857600000)",
  );
  database.execute(
    "INSERT INTO purchase_items VALUES ('55555555-5555-4555-8555-555555555555', '44444444-4444-4444-8444-444444444444', 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 1, 'MASS', '1.000000', 'KG', 'BRL', 1299)",
  );
  database.execute(
    "INSERT INTO migration_ledger (schema_name, schema_version, from_version, to_version, migration_id, applied_at) VALUES ('shared_beta_local', 7, 6, 7, 'v6-to-v7-hosted-auth-readiness', 1783857600000)",
  );
  database.execute('PRAGMA user_version = 7');
}

void _insertCommonV7Rows(dynamic database) {
  database.execute(
    "INSERT INTO local_accounts VALUES ('11111111-1111-4111-8111-111111111111', 'BRL', 1783857600000)",
  );
  database.execute(
    "INSERT INTO devices VALUES ('22222222-2222-4222-8222-222222222222', '11111111-1111-4111-8111-111111111111', 1, 1783857600000)",
  );
  database.execute(
    "INSERT INTO stores VALUES ('33333333-3333-4333-8333-333333333333', '11111111-1111-4111-8111-111111111111', 'Mercado Central', 1783857600000)",
  );
  database.execute(
    "INSERT INTO products VALUES ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', '11111111-1111-4111-8111-111111111111', 'ARROZ-001', 'arroz-001', 3, 'Arroz Branco', 'Marca A', 'arroz branco', 'marca a', 'PACKAGED', 'MASS', '1.000000', 'KG', '11111111-1111-4111-8111-111111111111|v3|arroz branco|marca a|PACKAGED|MASS|1.000000|KG', 1783857600000)",
  );
  database.execute(
    "INSERT INTO account_preferences VALUES ('11111111-1111-4111-8111-111111111111', 5, 2, 2, 1783857600000)",
  );
  database.execute(
    "INSERT INTO installation_metadata VALUES ('current', '11111111-1111-4111-8111-111111111111', '22222222-2222-4222-8222-222222222222', 1783857600000, 1783857600000)",
  );
  database.execute(
    "INSERT INTO sync_state VALUES ('11111111-1111-4111-8111-111111111111', 'cursor-before-repair', 1783857600000)",
  );
}

void _createV8Database(dynamic database) {
  database.execute('PRAGMA foreign_keys = OFF');
  database.execute('''
CREATE TABLE local_accounts (
  id TEXT NOT NULL PRIMARY KEY,
  default_currency_code TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE devices (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  next_sequence INTEGER NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, id)
);
''');
  database.execute('''
CREATE TABLE sync_events (
  id TEXT NOT NULL PRIMARY KEY,
  account_id TEXT NOT NULL REFERENCES local_accounts(id) ON DELETE RESTRICT,
  device_id TEXT NOT NULL REFERENCES devices(id) ON DELETE RESTRICT,
  device_sequence INTEGER NOT NULL,
  event_type TEXT NOT NULL,
  payload_version INTEGER NOT NULL,
  occurrence_time INTEGER NOT NULL,
  payload_json TEXT NOT NULL,
  content_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(account_id, device_id, device_sequence)
);
''');
  database.execute('''
CREATE TABLE pending_events (
  event_id TEXT NOT NULL PRIMARY KEY REFERENCES sync_events(id) ON DELETE CASCADE,
  state TEXT NOT NULL,
  enqueued_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE sync_state (
  account_id TEXT NOT NULL PRIMARY KEY REFERENCES local_accounts(id) ON DELETE CASCADE,
  account_cursor TEXT,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE hosted_auth_states (
  environment_alias TEXT NOT NULL PRIMARY KEY,
  installation_id TEXT NOT NULL,
  enrollment_request_id TEXT,
  enrollment_state TEXT NOT NULL,
  account_id TEXT,
  server_device_id TEXT,
  generation INTEGER,
  updated_at INTEGER NOT NULL
);
''');
  database.execute('''
CREATE TABLE migration_ledger (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  schema_name TEXT NOT NULL,
  schema_version INTEGER NOT NULL,
  from_version INTEGER,
  to_version INTEGER,
  migration_id TEXT,
  applied_at INTEGER NOT NULL
);
''');
  database.execute(
    "INSERT INTO local_accounts VALUES ('11111111-1111-4111-8111-111111111111', 'BRL', 1783857600000)",
  );
  database.execute(
    "INSERT INTO devices VALUES ('22222222-2222-4222-8222-222222222222', '11111111-1111-4111-8111-111111111111', 1, 1783857600000)",
  );
  database.execute(
    "INSERT INTO migration_ledger (schema_name, schema_version, from_version, to_version, migration_id, applied_at) VALUES ('shared_beta_local', 8, 7, 8, 'v7-to-v8-purchase-fk-repair', 1783857600000)",
  );
  database.execute('PRAGMA user_version = 8');
}
