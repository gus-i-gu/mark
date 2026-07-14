import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

class LocalAccounts extends Table {
  TextColumn get id => text()();
  TextColumn get defaultCurrencyCode => text().withLength(min: 3, max: 3)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Devices extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.restrict)();
  IntColumn get nextSequence => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {accountId, id},
  ];
}

class Products extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.restrict)();
  TextColumn get userProductCode => text().withLength(min: 1, max: 64)();
  TextColumn get normalizedUserProductCode =>
      text().withLength(min: 1, max: 64)();
  IntColumn get normalizationVersion => integer()();
  TextColumn get displayName => text().nullable()();
  TextColumn get displayBrand => text().nullable()();
  TextColumn get normalizedName => text()();
  TextColumn get normalizedBrand => text()();
  TextColumn get mode => text()();
  TextColumn get measurementKind => text()();
  TextColumn get packageAmount => text().nullable()();
  TextColumn get packageUnit => text().nullable()();
  TextColumn get exactIdentityKey => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {accountId, normalizedUserProductCode},
    {accountId, exactIdentityKey},
  ];
}

class Stores extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.restrict)();
  TextColumn get displayName => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Purchases extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.restrict)();
  TextColumn get storeId =>
      text().references(Stores, #id, onDelete: KeyAction.restrict)();
  TextColumn get personId =>
      text().nullable().references(People, #id, onDelete: KeyAction.restrict)();
  TextColumn get paymentMethodId => text().nullable().references(
    PaymentMethods,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get occurrenceTime => dateTime()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get totalMinorUnits => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PurchaseItems extends Table {
  TextColumn get id => text()();
  TextColumn get purchaseId =>
      text().references(Purchases, #id, onDelete: KeyAction.cascade)();
  TextColumn get productId =>
      text().references(Products, #id, onDelete: KeyAction.restrict)();
  IntColumn get packageCount => integer().nullable()();
  TextColumn get measurementKind => text()();
  TextColumn get purchasedAmount => text()();
  TextColumn get purchasedUnit => text()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get lineTotalMinorUnits => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class People extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.restrict)();
  TextColumn get visibleCode => text().withLength(min: 4, max: 16)();
  TextColumn get nickname => text()();
  TextColumn get normalizedNickname => text()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {accountId, visibleCode},
  ];
}

class PaymentMethods extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.restrict)();
  TextColumn get visibleCode => text().withLength(min: 4, max: 16)();
  TextColumn get nickname => text()();
  TextColumn get normalizedNickname => text()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {accountId, visibleCode},
  ];
}

class AccountPreferences extends Table {
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.cascade)();
  IntColumn get shortageThresholdDays =>
      integer().withDefault(const Constant(5))();
  IntColumn get nextPersonCode => integer().withDefault(const Constant(1))();
  IntColumn get nextPaymentMethodCode =>
      integer().withDefault(const Constant(1))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class SyncEvents extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.restrict)();
  TextColumn get deviceId =>
      text().references(Devices, #id, onDelete: KeyAction.restrict)();
  IntColumn get deviceSequence => integer()();
  TextColumn get eventType => text()();
  IntColumn get payloadVersion => integer()();
  DateTimeColumn get occurrenceTime => dateTime()();
  TextColumn get payloadJson => text()();
  TextColumn get contentHash => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {accountId, deviceId, deviceSequence},
  ];
}

class PendingEvents extends Table {
  TextColumn get eventId =>
      text().references(SyncEvents, #id, onDelete: KeyAction.cascade)();
  TextColumn get state => text()();
  DateTimeColumn get enqueuedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {eventId};
}

class SyncState extends Table {
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get accountCursor => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class MigrationLedger extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get schemaName => text()();
  IntColumn get schemaVersion => integer()();
  IntColumn get fromVersion => integer().nullable()();
  IntColumn get toVersion => integer().nullable()();
  TextColumn get migrationId => text().nullable()();
  DateTimeColumn get appliedAt => dateTime()();
}

@DriftDatabase(
  tables: [
    LocalAccounts,
    Devices,
    Products,
    Stores,
    People,
    PaymentMethods,
    AccountPreferences,
    Purchases,
    PurchaseItems,
    SyncEvents,
    PendingEvents,
    SyncState,
    MigrationLedger,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase(super.e);

  factory LocalDatabase.appPrivate() {
    return LocalDatabase(
      LazyDatabase(() async {
        final directory = await getApplicationSupportDirectory();
        final file = File(p.join(directory.path, 'markei_shared_beta.sqlite'));
        return NativeDatabase.createInBackground(file);
      }),
    );
  }

  factory LocalDatabase.memory() => LocalDatabase(NativeDatabase.memory());

  factory LocalDatabase.file(File file) =>
      LocalDatabase(NativeDatabase.createInBackground(file));

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await into(migrationLedger).insert(
        MigrationLedgerCompanion.insert(
          schemaName: 'shared_beta_local',
          schemaVersion: schemaVersion,
          fromVersion: const Value(null),
          toVersion: Value(schemaVersion),
          migrationId: const Value('create-v4'),
          appliedAt: DateTime.utc(2026, 7, 12),
        ),
      );
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await customStatement(
          'ALTER TABLE products ADD COLUMN user_product_code TEXT',
        );
        await customStatement(
          'ALTER TABLE products ADD COLUMN normalized_user_product_code TEXT',
        );
        await migrator.addColumn(products, products.displayName);
        await migrator.addColumn(products, products.displayBrand);
        await migrator.addColumn(migrationLedger, migrationLedger.fromVersion);
        await migrator.addColumn(migrationLedger, migrationLedger.toVersion);
        await migrator.addColumn(migrationLedger, migrationLedger.migrationId);
        final rows = await customSelect(
          'SELECT id, normalized_name, normalized_brand FROM products',
          readsFrom: {products},
        ).get();
        for (final row in rows) {
          await customStatement(
            'UPDATE products SET display_name = ?, display_brand = ? WHERE id = ?',
            [
              row.data['normalized_name'],
              row.data['normalized_brand'],
              row.data['id'],
            ],
          );
        }
        await into(migrationLedger).insert(
          MigrationLedgerCompanion.insert(
            schemaName: 'shared_beta_local',
            schemaVersion: to,
            fromVersion: Value(from),
            toVersion: const Value(2),
            migrationId: const Value('v1-to-v2-product-code-display'),
            appliedAt: DateTime.now().toUtc(),
          ),
        );
      }
      if (from < 3) {
        await _preflightV3ProductIdentity();
        await migrator.createTable(people);
        await migrator.createTable(paymentMethods);
        await migrator.createTable(accountPreferences);
        await migrator.addColumn(purchases, purchases.personId);
        await migrator.addColumn(purchases, purchases.paymentMethodId);
        await _rebuildPurchaseItemsWithNullablePackageCount();
        await _migrateProductsToV3();
        await customStatement('''
INSERT OR IGNORE INTO account_preferences(account_id, shortage_threshold_days, updated_at)
SELECT id, 5, strftime('%s','now') * 1000 FROM local_accounts
''');
        await into(migrationLedger).insert(
          MigrationLedgerCompanion.insert(
            schemaName: 'shared_beta_local',
            schemaVersion: to,
            fromVersion: Value(from),
            toVersion: const Value(3),
            migrationId: const Value('v2-to-v3-local-products-references'),
            appliedAt: DateTime.now().toUtc(),
          ),
        );
      }
      if (from < 4) {
        await _migrateToV4();
        await into(migrationLedger).insert(
          MigrationLedgerCompanion.insert(
            schemaName: 'shared_beta_local',
            schemaVersion: to,
            fromVersion: Value(from),
            toVersion: const Value(4),
            migrationId: const Value('v3-to-v4-visible-codes-product-not-null'),
            appliedAt: DateTime.now().toUtc(),
          ),
        );
      }
      if (from > 4) {
        throw UnsupportedError(
          'Unsupported local database migration $from to $to.',
        );
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _preflightV3ProductIdentity() async {
    final rows = await customSelect(
      'SELECT id, account_id, normalized_name, normalized_brand, mode, '
      'measurement_kind, package_amount, package_unit FROM products',
      readsFrom: {products},
    ).get();
    final keys = <String, String>{};
    for (final row in rows) {
      final data = row.data;
      final key = _v3IdentityKey(data);
      final scoped = '${data['account_id']}|$key';
      final previous = keys[scoped];
      if (previous != null && previous != data['id']) {
        throw StateError(
          'v3 Product identity collision: $previous and ${data['id']}',
        );
      }
      keys[scoped] = data['id'] as String;
    }
  }

  Future<void> _migrateProductsToV3() async {
    final rows = await customSelect(
      'SELECT id, account_id, user_product_code, normalized_user_product_code, '
      'normalized_name, normalized_brand, mode, measurement_kind, package_amount, '
      'package_unit FROM products',
      readsFrom: {products},
    ).get();
    for (final row in rows) {
      final data = row.data;
      final id = data['id'] as String;
      final code = data['user_product_code'] as String?;
      final normalizedCode = data['normalized_user_product_code'] as String?;
      await customStatement(
        'UPDATE products SET user_product_code = ?, normalized_user_product_code = ?, '
        'normalization_version = 3, exact_identity_key = ? WHERE id = ?',
        [code, normalizedCode, _v3IdentityKey(data), id],
      );
    }
  }

  Future<void> _migrateToV4() async {
    await _rebuildPeopleWithVisibleCodes();
    await _rebuildPaymentMethodsWithVisibleCodes();
    await _rebuildProductsWithNotNullCodes();
    await _rebuildAccountPreferencesWithCodeCounters();
  }

  Future<void> _rebuildPeopleWithVisibleCodes() async {
    await customStatement('ALTER TABLE people RENAME TO people_old');
    await customStatement('''
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
)
''');
    final rows = await customSelect(
      'SELECT * FROM people_old ORDER BY account_id, created_at, id',
    ).get();
    final counters = <String, int>{};
    for (final row in rows) {
      final data = row.data;
      final accountId = data['account_id'] as String;
      final next = counters.update(
        accountId,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
      await customStatement(
        'INSERT INTO people(id, account_id, visible_code, nickname, '
        'normalized_nickname, active, created_at, updated_at, archived_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data['id'],
          accountId,
          '@${next.toString().padLeft(3, '0')}',
          data['nickname'],
          data['normalized_nickname'],
          data['active'],
          data['created_at'],
          data['updated_at'],
          data['archived_at'],
        ],
      );
    }
    await customStatement('DROP TABLE people_old');
  }

  Future<void> _rebuildPaymentMethodsWithVisibleCodes() async {
    await customStatement(
      'ALTER TABLE payment_methods RENAME TO payment_methods_old',
    );
    await customStatement('''
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
)
''');
    final rows = await customSelect(
      'SELECT * FROM payment_methods_old ORDER BY account_id, created_at, id',
    ).get();
    final counters = <String, int>{};
    for (final row in rows) {
      final data = row.data;
      final accountId = data['account_id'] as String;
      final next = counters.update(
        accountId,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
      await customStatement(
        'INSERT INTO payment_methods(id, account_id, visible_code, nickname, '
        'normalized_nickname, active, created_at, updated_at, archived_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data['id'],
          accountId,
          '#${next.toString().padLeft(3, '0')}',
          data['nickname'],
          data['normalized_nickname'],
          data['active'],
          data['created_at'],
          data['updated_at'],
          data['archived_at'],
        ],
      );
    }
    await customStatement('DROP TABLE payment_methods_old');
  }

  Future<void> _rebuildProductsWithNotNullCodes() async {
    await customStatement('ALTER TABLE products RENAME TO products_old');
    await customStatement('''
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
)
''');
    final rows = await customSelect('SELECT * FROM products_old').get();
    final usedByAccount = <String, Set<String>>{};
    for (final row in rows) {
      final accountId = row.data['account_id'] as String;
      final normalized = row.data['normalized_user_product_code'] as String?;
      if (normalized != null && normalized.trim().isNotEmpty) {
        usedByAccount.putIfAbsent(accountId, () => <String>{}).add(normalized);
      }
    }
    for (final row in rows) {
      final data = row.data;
      final accountId = data['account_id'] as String;
      final id = data['id'] as String;
      final display = (data['user_product_code'] as String?)?.trim();
      final normalized = (data['normalized_user_product_code'] as String?)
          ?.trim()
          .toLowerCase();
      var finalDisplay = display;
      var finalNormalized = normalized;
      if (finalDisplay == null ||
          finalDisplay.isEmpty ||
          finalNormalized == null ||
          finalNormalized.isEmpty) {
        final base = 'legacy:${id.replaceAll('-', '').substring(0, 8)}';
        var candidate = base;
        var suffix = 2;
        final used = usedByAccount.putIfAbsent(accountId, () => <String>{});
        while (used.contains(candidate)) {
          candidate = '$base-$suffix';
          suffix++;
        }
        finalDisplay = candidate;
        finalNormalized = candidate;
        used.add(finalNormalized);
      }
      await customStatement(
        'INSERT INTO products(id, account_id, user_product_code, '
        'normalized_user_product_code, normalization_version, display_name, '
        'display_brand, normalized_name, normalized_brand, mode, '
        'measurement_kind, package_amount, package_unit, exact_identity_key, '
        'created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          id,
          accountId,
          finalDisplay,
          finalNormalized,
          data['normalization_version'],
          data['display_name'],
          data['display_brand'],
          data['normalized_name'],
          data['normalized_brand'],
          data['mode'],
          data['measurement_kind'],
          data['package_amount'],
          data['package_unit'],
          data['exact_identity_key'],
          data['created_at'],
        ],
      );
    }
    await customStatement('DROP TABLE products_old');
  }

  Future<void> _rebuildAccountPreferencesWithCodeCounters() async {
    await customStatement(
      'ALTER TABLE account_preferences RENAME TO account_preferences_old',
    );
    await customStatement('''
CREATE TABLE account_preferences (
  account_id TEXT NOT NULL PRIMARY KEY REFERENCES local_accounts(id) ON DELETE CASCADE,
  shortage_threshold_days INTEGER NOT NULL DEFAULT 5,
  next_person_code INTEGER NOT NULL DEFAULT 1,
  next_payment_method_code INTEGER NOT NULL DEFAULT 1,
  updated_at INTEGER NOT NULL
)
''');
    await customStatement('''
INSERT INTO account_preferences(
  account_id,
  shortage_threshold_days,
  next_person_code,
  next_payment_method_code,
  updated_at
)
SELECT
  account_id,
  shortage_threshold_days,
  COALESCE((SELECT MAX(CAST(SUBSTR(visible_code, 2) AS INTEGER)) + 1
            FROM people WHERE people.account_id = account_preferences_old.account_id), 1),
  COALESCE((SELECT MAX(CAST(SUBSTR(visible_code, 2) AS INTEGER)) + 1
            FROM payment_methods WHERE payment_methods.account_id = account_preferences_old.account_id), 1),
  updated_at
FROM account_preferences_old
''');
    await customStatement('''
INSERT OR IGNORE INTO account_preferences(
  account_id,
  shortage_threshold_days,
  next_person_code,
  next_payment_method_code,
  updated_at
)
SELECT
  id,
  5,
  COALESCE((SELECT MAX(CAST(SUBSTR(visible_code, 2) AS INTEGER)) + 1
            FROM people WHERE people.account_id = local_accounts.id), 1),
  COALESCE((SELECT MAX(CAST(SUBSTR(visible_code, 2) AS INTEGER)) + 1
            FROM payment_methods WHERE payment_methods.account_id = local_accounts.id), 1),
  strftime('%s','now') * 1000
FROM local_accounts
''');
    await customStatement('DROP TABLE account_preferences_old');
  }

  Future<void> _rebuildPurchaseItemsWithNullablePackageCount() async {
    await customStatement(
      'ALTER TABLE purchase_items RENAME TO purchase_items_old',
    );
    await customStatement('''
CREATE TABLE purchase_items (
  id TEXT NOT NULL PRIMARY KEY,
  purchase_id TEXT NOT NULL REFERENCES purchases(id) ON DELETE CASCADE,
  product_id TEXT NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
  package_count INTEGER,
  measurement_kind TEXT NOT NULL,
  purchased_amount TEXT NOT NULL,
  purchased_unit TEXT NOT NULL,
  currency_code TEXT NOT NULL,
  line_total_minor_units INTEGER NOT NULL
)
''');
    await customStatement('''
INSERT INTO purchase_items
SELECT id, purchase_id, product_id, package_count, measurement_kind,
       purchased_amount, purchased_unit, currency_code, line_total_minor_units
FROM purchase_items_old
''');
    await customStatement('DROP TABLE purchase_items_old');
  }

  String _v3IdentityKey(Map<String, Object?> data) {
    final base = [
      data['account_id'],
      'v3',
      data['normalized_name'],
      data['normalized_brand'],
      data['mode'],
    ];
    if (data['mode'] == 'BULK') {
      return base.join('|');
    }
    return [
      ...base,
      data['measurement_kind'],
      data['package_amount'],
      data['package_unit'],
    ].join('|');
  }
}
