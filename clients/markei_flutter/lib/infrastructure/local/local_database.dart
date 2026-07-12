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
  IntColumn get packageCount => integer()();
  TextColumn get measurementKind => text()();
  TextColumn get purchasedAmount => text()();
  TextColumn get purchasedUnit => text()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get lineTotalMinorUnits => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
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
  int get schemaVersion => 2;

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
          migrationId: const Value('create-v2'),
          appliedAt: DateTime.utc(2026, 7, 12),
        ),
      );
    },
    onUpgrade: (migrator, from, to) async {
      if (from == 1) {
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
            toVersion: Value(to),
            migrationId: const Value('v1-to-v2-product-code-display'),
            appliedAt: DateTime.now().toUtc(),
          ),
        );
      } else {
        throw UnsupportedError(
          'Unsupported local database migration $from to $to.',
        );
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
