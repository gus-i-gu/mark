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
  TextColumn get userProductCode =>
      text().withLength(min: 1, max: 64).nullable()();
  TextColumn get normalizedUserProductCode =>
      text().withLength(min: 1, max: 64).nullable()();
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
    {accountId, normalizedNickname, active},
  ];
}

class PaymentMethods extends Table {
  TextColumn get id => text()();
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.restrict)();
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
    {accountId, normalizedNickname, active},
  ];
}

class AccountPreferences extends Table {
  TextColumn get accountId =>
      text().references(LocalAccounts, #id, onDelete: KeyAction.cascade)();
  IntColumn get shortageThresholdDays =>
      integer().withDefault(const Constant(5))();
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
  int get schemaVersion => 3;

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
          migrationId: const Value('create-v3'),
          appliedAt: DateTime.utc(2026, 7, 12),
        ),
      );
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(products, products.userProductCode);
        await migrator.addColumn(products, products.normalizedUserProductCode);
        await migrator.addColumn(products, products.displayName);
        await migrator.addColumn(products, products.displayBrand);
        await migrator.addColumn(migrationLedger, migrationLedger.fromVersion);
        await migrator.addColumn(migrationLedger, migrationLedger.toVersion);
        await migrator.addColumn(migrationLedger, migrationLedger.migrationId);
        final rows = await select(products).get();
        for (final row in rows) {
          final legacyCode =
              'legacy-${row.id.replaceAll('-', '').substring(0, 8)}';
          await (update(
            products,
          )..where((table) => table.id.equals(row.id))).write(
            ProductsCompanion(
              userProductCode: Value(legacyCode),
              normalizedUserProductCode: Value(legacyCode),
              displayName: Value(row.normalizedName),
              displayBrand: Value(row.normalizedBrand),
            ),
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
      if (from > 3) {
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
      final code =
          (data['user_product_code'] as String?) ??
          'legacy-${id.replaceAll('-', '').substring(0, 8)}';
      final normalizedCode =
          (data['normalized_user_product_code'] as String?) ??
          code.toLowerCase();
      await customStatement(
        'UPDATE products SET user_product_code = ?, normalized_user_product_code = ?, '
        'normalization_version = 3, exact_identity_key = ? WHERE id = ?',
        [code, normalizedCode, _v3IdentityKey(data), id],
      );
    }
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
