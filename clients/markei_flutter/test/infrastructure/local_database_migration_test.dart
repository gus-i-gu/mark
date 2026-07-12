import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/infrastructure/local/local_database.dart';

void main() {
  test('migrates v1 database to v2 product identity fields', () async {
    final temp = await Directory.systemTemp.createTemp('markei_migration_');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');

    final migratingDb = LocalDatabase(
      NativeDatabase.createInBackground(file, setup: _createV1Database),
    );
    addTearDown(migratingDb.close);

    expect(migratingDb.schemaVersion, 2);
    final products = await migratingDb.select(migratingDb.products).get();
    final ledger = await migratingDb.select(migratingDb.migrationLedger).get();

    expect(products, hasLength(1));
    expect(products.single.userProductCode, startsWith('legacy-'));
    expect(products.single.displayName, 'arroz branco');
    expect(ledger.last.fromVersion, 1);
    expect(ledger.last.toVersion, 2);
    expect(ledger.last.migrationId, 'v1-to-v2-product-code-display');
    await migratingDb.close();

    final reopened = LocalDatabase.file(file);
    addTearDown(reopened.close);
    expect(await reopened.select(reopened.products).get(), hasLength(1));
  });
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
