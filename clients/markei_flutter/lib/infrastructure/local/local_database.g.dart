// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $LocalAccountsTable extends LocalAccounts
    with TableInfo<$LocalAccountsTable, LocalAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultCurrencyCodeMeta =
      const VerificationMeta('defaultCurrencyCode');
  @override
  late final GeneratedColumn<String> defaultCurrencyCode =
      GeneratedColumn<String>(
        'default_currency_code',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 3,
          maxTextLength: 3,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, defaultCurrencyCode, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('default_currency_code')) {
      context.handle(
        _defaultCurrencyCodeMeta,
        defaultCurrencyCode.isAcceptableOrUnknown(
          data['default_currency_code']!,
          _defaultCurrencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultCurrencyCodeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      defaultCurrencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency_code'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalAccountsTable createAlias(String alias) {
    return $LocalAccountsTable(attachedDatabase, alias);
  }
}

class LocalAccount extends DataClass implements Insertable<LocalAccount> {
  final String id;
  final String defaultCurrencyCode;
  final DateTime createdAt;
  const LocalAccount({
    required this.id,
    required this.defaultCurrencyCode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['default_currency_code'] = Variable<String>(defaultCurrencyCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalAccountsCompanion toCompanion(bool nullToAbsent) {
    return LocalAccountsCompanion(
      id: Value(id),
      defaultCurrencyCode: Value(defaultCurrencyCode),
      createdAt: Value(createdAt),
    );
  }

  factory LocalAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAccount(
      id: serializer.fromJson<String>(json['id']),
      defaultCurrencyCode: serializer.fromJson<String>(
        json['defaultCurrencyCode'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'defaultCurrencyCode': serializer.toJson<String>(defaultCurrencyCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalAccount copyWith({
    String? id,
    String? defaultCurrencyCode,
    DateTime? createdAt,
  }) => LocalAccount(
    id: id ?? this.id,
    defaultCurrencyCode: defaultCurrencyCode ?? this.defaultCurrencyCode,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalAccount copyWithCompanion(LocalAccountsCompanion data) {
    return LocalAccount(
      id: data.id.present ? data.id.value : this.id,
      defaultCurrencyCode: data.defaultCurrencyCode.present
          ? data.defaultCurrencyCode.value
          : this.defaultCurrencyCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAccount(')
          ..write('id: $id, ')
          ..write('defaultCurrencyCode: $defaultCurrencyCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, defaultCurrencyCode, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAccount &&
          other.id == this.id &&
          other.defaultCurrencyCode == this.defaultCurrencyCode &&
          other.createdAt == this.createdAt);
}

class LocalAccountsCompanion extends UpdateCompanion<LocalAccount> {
  final Value<String> id;
  final Value<String> defaultCurrencyCode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalAccountsCompanion({
    this.id = const Value.absent(),
    this.defaultCurrencyCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalAccountsCompanion.insert({
    required String id,
    required String defaultCurrencyCode,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       defaultCurrencyCode = Value(defaultCurrencyCode),
       createdAt = Value(createdAt);
  static Insertable<LocalAccount> custom({
    Expression<String>? id,
    Expression<String>? defaultCurrencyCode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (defaultCurrencyCode != null)
        'default_currency_code': defaultCurrencyCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalAccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? defaultCurrencyCode,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalAccountsCompanion(
      id: id ?? this.id,
      defaultCurrencyCode: defaultCurrencyCode ?? this.defaultCurrencyCode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (defaultCurrencyCode.present) {
      map['default_currency_code'] = Variable<String>(
        defaultCurrencyCode.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAccountsCompanion(')
          ..write('id: $id, ')
          ..write('defaultCurrencyCode: $defaultCurrencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _nextSequenceMeta = const VerificationMeta(
    'nextSequence',
  );
  @override
  late final GeneratedColumn<int> nextSequence = GeneratedColumn<int>(
    'next_sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    nextSequence,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Device> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('next_sequence')) {
      context.handle(
        _nextSequenceMeta,
        nextSequence.isAcceptableOrUnknown(
          data['next_sequence']!,
          _nextSequenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextSequenceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {accountId, id},
  ];
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Device(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      nextSequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_sequence'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class Device extends DataClass implements Insertable<Device> {
  final String id;
  final String accountId;
  final int nextSequence;
  final DateTime createdAt;
  const Device({
    required this.id,
    required this.accountId,
    required this.nextSequence,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['next_sequence'] = Variable<int>(nextSequence);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      accountId: Value(accountId),
      nextSequence: Value(nextSequence),
      createdAt: Value(createdAt),
    );
  }

  factory Device.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      nextSequence: serializer.fromJson<int>(json['nextSequence']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'nextSequence': serializer.toJson<int>(nextSequence),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Device copyWith({
    String? id,
    String? accountId,
    int? nextSequence,
    DateTime? createdAt,
  }) => Device(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    nextSequence: nextSequence ?? this.nextSequence,
    createdAt: createdAt ?? this.createdAt,
  );
  Device copyWithCompanion(DevicesCompanion data) {
    return Device(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      nextSequence: data.nextSequence.present
          ? data.nextSequence.value
          : this.nextSequence,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('nextSequence: $nextSequence, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, nextSequence, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.nextSequence == this.nextSequence &&
          other.createdAt == this.createdAt);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<int> nextSequence;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.nextSequence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String id,
    required String accountId,
    required int nextSequence,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       nextSequence = Value(nextSequence),
       createdAt = Value(createdAt);
  static Insertable<Device> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<int>? nextSequence,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (nextSequence != null) 'next_sequence': nextSequence,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<int>? nextSequence,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DevicesCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      nextSequence: nextSequence ?? this.nextSequence,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (nextSequence.present) {
      map['next_sequence'] = Variable<int>(nextSequence.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('nextSequence: $nextSequence, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _userProductCodeMeta = const VerificationMeta(
    'userProductCode',
  );
  @override
  late final GeneratedColumn<String> userProductCode = GeneratedColumn<String>(
    'user_product_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedUserProductCodeMeta =
      const VerificationMeta('normalizedUserProductCode');
  @override
  late final GeneratedColumn<String> normalizedUserProductCode =
      GeneratedColumn<String>(
        'normalized_user_product_code',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 64,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _normalizationVersionMeta =
      const VerificationMeta('normalizationVersion');
  @override
  late final GeneratedColumn<int> normalizationVersion = GeneratedColumn<int>(
    'normalization_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayBrandMeta = const VerificationMeta(
    'displayBrand',
  );
  @override
  late final GeneratedColumn<String> displayBrand = GeneratedColumn<String>(
    'display_brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedBrandMeta = const VerificationMeta(
    'normalizedBrand',
  );
  @override
  late final GeneratedColumn<String> normalizedBrand = GeneratedColumn<String>(
    'normalized_brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _measurementKindMeta = const VerificationMeta(
    'measurementKind',
  );
  @override
  late final GeneratedColumn<String> measurementKind = GeneratedColumn<String>(
    'measurement_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packageAmountMeta = const VerificationMeta(
    'packageAmount',
  );
  @override
  late final GeneratedColumn<String> packageAmount = GeneratedColumn<String>(
    'package_amount',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packageUnitMeta = const VerificationMeta(
    'packageUnit',
  );
  @override
  late final GeneratedColumn<String> packageUnit = GeneratedColumn<String>(
    'package_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exactIdentityKeyMeta = const VerificationMeta(
    'exactIdentityKey',
  );
  @override
  late final GeneratedColumn<String> exactIdentityKey = GeneratedColumn<String>(
    'exact_identity_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    userProductCode,
    normalizedUserProductCode,
    normalizationVersion,
    displayName,
    displayBrand,
    normalizedName,
    normalizedBrand,
    mode,
    measurementKind,
    packageAmount,
    packageUnit,
    exactIdentityKey,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('user_product_code')) {
      context.handle(
        _userProductCodeMeta,
        userProductCode.isAcceptableOrUnknown(
          data['user_product_code']!,
          _userProductCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userProductCodeMeta);
    }
    if (data.containsKey('normalized_user_product_code')) {
      context.handle(
        _normalizedUserProductCodeMeta,
        normalizedUserProductCode.isAcceptableOrUnknown(
          data['normalized_user_product_code']!,
          _normalizedUserProductCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedUserProductCodeMeta);
    }
    if (data.containsKey('normalization_version')) {
      context.handle(
        _normalizationVersionMeta,
        normalizationVersion.isAcceptableOrUnknown(
          data['normalization_version']!,
          _normalizationVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizationVersionMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('display_brand')) {
      context.handle(
        _displayBrandMeta,
        displayBrand.isAcceptableOrUnknown(
          data['display_brand']!,
          _displayBrandMeta,
        ),
      );
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('normalized_brand')) {
      context.handle(
        _normalizedBrandMeta,
        normalizedBrand.isAcceptableOrUnknown(
          data['normalized_brand']!,
          _normalizedBrandMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedBrandMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('measurement_kind')) {
      context.handle(
        _measurementKindMeta,
        measurementKind.isAcceptableOrUnknown(
          data['measurement_kind']!,
          _measurementKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_measurementKindMeta);
    }
    if (data.containsKey('package_amount')) {
      context.handle(
        _packageAmountMeta,
        packageAmount.isAcceptableOrUnknown(
          data['package_amount']!,
          _packageAmountMeta,
        ),
      );
    }
    if (data.containsKey('package_unit')) {
      context.handle(
        _packageUnitMeta,
        packageUnit.isAcceptableOrUnknown(
          data['package_unit']!,
          _packageUnitMeta,
        ),
      );
    }
    if (data.containsKey('exact_identity_key')) {
      context.handle(
        _exactIdentityKeyMeta,
        exactIdentityKey.isAcceptableOrUnknown(
          data['exact_identity_key']!,
          _exactIdentityKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exactIdentityKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {accountId, normalizedUserProductCode},
    {accountId, exactIdentityKey},
  ];
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      userProductCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_product_code'],
      )!,
      normalizedUserProductCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_user_product_code'],
      )!,
      normalizationVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}normalization_version'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      displayBrand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_brand'],
      ),
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      normalizedBrand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_brand'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      measurementKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}measurement_kind'],
      )!,
      packageAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_amount'],
      ),
      packageUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_unit'],
      ),
      exactIdentityKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exact_identity_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String accountId;
  final String userProductCode;
  final String normalizedUserProductCode;
  final int normalizationVersion;
  final String? displayName;
  final String? displayBrand;
  final String normalizedName;
  final String normalizedBrand;
  final String mode;
  final String measurementKind;
  final String? packageAmount;
  final String? packageUnit;
  final String exactIdentityKey;
  final DateTime createdAt;
  const Product({
    required this.id,
    required this.accountId,
    required this.userProductCode,
    required this.normalizedUserProductCode,
    required this.normalizationVersion,
    this.displayName,
    this.displayBrand,
    required this.normalizedName,
    required this.normalizedBrand,
    required this.mode,
    required this.measurementKind,
    this.packageAmount,
    this.packageUnit,
    required this.exactIdentityKey,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['user_product_code'] = Variable<String>(userProductCode);
    map['normalized_user_product_code'] = Variable<String>(
      normalizedUserProductCode,
    );
    map['normalization_version'] = Variable<int>(normalizationVersion);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || displayBrand != null) {
      map['display_brand'] = Variable<String>(displayBrand);
    }
    map['normalized_name'] = Variable<String>(normalizedName);
    map['normalized_brand'] = Variable<String>(normalizedBrand);
    map['mode'] = Variable<String>(mode);
    map['measurement_kind'] = Variable<String>(measurementKind);
    if (!nullToAbsent || packageAmount != null) {
      map['package_amount'] = Variable<String>(packageAmount);
    }
    if (!nullToAbsent || packageUnit != null) {
      map['package_unit'] = Variable<String>(packageUnit);
    }
    map['exact_identity_key'] = Variable<String>(exactIdentityKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      userProductCode: Value(userProductCode),
      normalizedUserProductCode: Value(normalizedUserProductCode),
      normalizationVersion: Value(normalizationVersion),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      displayBrand: displayBrand == null && nullToAbsent
          ? const Value.absent()
          : Value(displayBrand),
      normalizedName: Value(normalizedName),
      normalizedBrand: Value(normalizedBrand),
      mode: Value(mode),
      measurementKind: Value(measurementKind),
      packageAmount: packageAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(packageAmount),
      packageUnit: packageUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(packageUnit),
      exactIdentityKey: Value(exactIdentityKey),
      createdAt: Value(createdAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      userProductCode: serializer.fromJson<String>(json['userProductCode']),
      normalizedUserProductCode: serializer.fromJson<String>(
        json['normalizedUserProductCode'],
      ),
      normalizationVersion: serializer.fromJson<int>(
        json['normalizationVersion'],
      ),
      displayName: serializer.fromJson<String?>(json['displayName']),
      displayBrand: serializer.fromJson<String?>(json['displayBrand']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      normalizedBrand: serializer.fromJson<String>(json['normalizedBrand']),
      mode: serializer.fromJson<String>(json['mode']),
      measurementKind: serializer.fromJson<String>(json['measurementKind']),
      packageAmount: serializer.fromJson<String?>(json['packageAmount']),
      packageUnit: serializer.fromJson<String?>(json['packageUnit']),
      exactIdentityKey: serializer.fromJson<String>(json['exactIdentityKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'userProductCode': serializer.toJson<String>(userProductCode),
      'normalizedUserProductCode': serializer.toJson<String>(
        normalizedUserProductCode,
      ),
      'normalizationVersion': serializer.toJson<int>(normalizationVersion),
      'displayName': serializer.toJson<String?>(displayName),
      'displayBrand': serializer.toJson<String?>(displayBrand),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'normalizedBrand': serializer.toJson<String>(normalizedBrand),
      'mode': serializer.toJson<String>(mode),
      'measurementKind': serializer.toJson<String>(measurementKind),
      'packageAmount': serializer.toJson<String?>(packageAmount),
      'packageUnit': serializer.toJson<String?>(packageUnit),
      'exactIdentityKey': serializer.toJson<String>(exactIdentityKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Product copyWith({
    String? id,
    String? accountId,
    String? userProductCode,
    String? normalizedUserProductCode,
    int? normalizationVersion,
    Value<String?> displayName = const Value.absent(),
    Value<String?> displayBrand = const Value.absent(),
    String? normalizedName,
    String? normalizedBrand,
    String? mode,
    String? measurementKind,
    Value<String?> packageAmount = const Value.absent(),
    Value<String?> packageUnit = const Value.absent(),
    String? exactIdentityKey,
    DateTime? createdAt,
  }) => Product(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    userProductCode: userProductCode ?? this.userProductCode,
    normalizedUserProductCode:
        normalizedUserProductCode ?? this.normalizedUserProductCode,
    normalizationVersion: normalizationVersion ?? this.normalizationVersion,
    displayName: displayName.present ? displayName.value : this.displayName,
    displayBrand: displayBrand.present ? displayBrand.value : this.displayBrand,
    normalizedName: normalizedName ?? this.normalizedName,
    normalizedBrand: normalizedBrand ?? this.normalizedBrand,
    mode: mode ?? this.mode,
    measurementKind: measurementKind ?? this.measurementKind,
    packageAmount: packageAmount.present
        ? packageAmount.value
        : this.packageAmount,
    packageUnit: packageUnit.present ? packageUnit.value : this.packageUnit,
    exactIdentityKey: exactIdentityKey ?? this.exactIdentityKey,
    createdAt: createdAt ?? this.createdAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      userProductCode: data.userProductCode.present
          ? data.userProductCode.value
          : this.userProductCode,
      normalizedUserProductCode: data.normalizedUserProductCode.present
          ? data.normalizedUserProductCode.value
          : this.normalizedUserProductCode,
      normalizationVersion: data.normalizationVersion.present
          ? data.normalizationVersion.value
          : this.normalizationVersion,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      displayBrand: data.displayBrand.present
          ? data.displayBrand.value
          : this.displayBrand,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      normalizedBrand: data.normalizedBrand.present
          ? data.normalizedBrand.value
          : this.normalizedBrand,
      mode: data.mode.present ? data.mode.value : this.mode,
      measurementKind: data.measurementKind.present
          ? data.measurementKind.value
          : this.measurementKind,
      packageAmount: data.packageAmount.present
          ? data.packageAmount.value
          : this.packageAmount,
      packageUnit: data.packageUnit.present
          ? data.packageUnit.value
          : this.packageUnit,
      exactIdentityKey: data.exactIdentityKey.present
          ? data.exactIdentityKey.value
          : this.exactIdentityKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('userProductCode: $userProductCode, ')
          ..write('normalizedUserProductCode: $normalizedUserProductCode, ')
          ..write('normalizationVersion: $normalizationVersion, ')
          ..write('displayName: $displayName, ')
          ..write('displayBrand: $displayBrand, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('normalizedBrand: $normalizedBrand, ')
          ..write('mode: $mode, ')
          ..write('measurementKind: $measurementKind, ')
          ..write('packageAmount: $packageAmount, ')
          ..write('packageUnit: $packageUnit, ')
          ..write('exactIdentityKey: $exactIdentityKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    userProductCode,
    normalizedUserProductCode,
    normalizationVersion,
    displayName,
    displayBrand,
    normalizedName,
    normalizedBrand,
    mode,
    measurementKind,
    packageAmount,
    packageUnit,
    exactIdentityKey,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.userProductCode == this.userProductCode &&
          other.normalizedUserProductCode == this.normalizedUserProductCode &&
          other.normalizationVersion == this.normalizationVersion &&
          other.displayName == this.displayName &&
          other.displayBrand == this.displayBrand &&
          other.normalizedName == this.normalizedName &&
          other.normalizedBrand == this.normalizedBrand &&
          other.mode == this.mode &&
          other.measurementKind == this.measurementKind &&
          other.packageAmount == this.packageAmount &&
          other.packageUnit == this.packageUnit &&
          other.exactIdentityKey == this.exactIdentityKey &&
          other.createdAt == this.createdAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> userProductCode;
  final Value<String> normalizedUserProductCode;
  final Value<int> normalizationVersion;
  final Value<String?> displayName;
  final Value<String?> displayBrand;
  final Value<String> normalizedName;
  final Value<String> normalizedBrand;
  final Value<String> mode;
  final Value<String> measurementKind;
  final Value<String?> packageAmount;
  final Value<String?> packageUnit;
  final Value<String> exactIdentityKey;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.userProductCode = const Value.absent(),
    this.normalizedUserProductCode = const Value.absent(),
    this.normalizationVersion = const Value.absent(),
    this.displayName = const Value.absent(),
    this.displayBrand = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.normalizedBrand = const Value.absent(),
    this.mode = const Value.absent(),
    this.measurementKind = const Value.absent(),
    this.packageAmount = const Value.absent(),
    this.packageUnit = const Value.absent(),
    this.exactIdentityKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String accountId,
    required String userProductCode,
    required String normalizedUserProductCode,
    required int normalizationVersion,
    this.displayName = const Value.absent(),
    this.displayBrand = const Value.absent(),
    required String normalizedName,
    required String normalizedBrand,
    required String mode,
    required String measurementKind,
    this.packageAmount = const Value.absent(),
    this.packageUnit = const Value.absent(),
    required String exactIdentityKey,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       userProductCode = Value(userProductCode),
       normalizedUserProductCode = Value(normalizedUserProductCode),
       normalizationVersion = Value(normalizationVersion),
       normalizedName = Value(normalizedName),
       normalizedBrand = Value(normalizedBrand),
       mode = Value(mode),
       measurementKind = Value(measurementKind),
       exactIdentityKey = Value(exactIdentityKey),
       createdAt = Value(createdAt);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? userProductCode,
    Expression<String>? normalizedUserProductCode,
    Expression<int>? normalizationVersion,
    Expression<String>? displayName,
    Expression<String>? displayBrand,
    Expression<String>? normalizedName,
    Expression<String>? normalizedBrand,
    Expression<String>? mode,
    Expression<String>? measurementKind,
    Expression<String>? packageAmount,
    Expression<String>? packageUnit,
    Expression<String>? exactIdentityKey,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (userProductCode != null) 'user_product_code': userProductCode,
      if (normalizedUserProductCode != null)
        'normalized_user_product_code': normalizedUserProductCode,
      if (normalizationVersion != null)
        'normalization_version': normalizationVersion,
      if (displayName != null) 'display_name': displayName,
      if (displayBrand != null) 'display_brand': displayBrand,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (normalizedBrand != null) 'normalized_brand': normalizedBrand,
      if (mode != null) 'mode': mode,
      if (measurementKind != null) 'measurement_kind': measurementKind,
      if (packageAmount != null) 'package_amount': packageAmount,
      if (packageUnit != null) 'package_unit': packageUnit,
      if (exactIdentityKey != null) 'exact_identity_key': exactIdentityKey,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? userProductCode,
    Value<String>? normalizedUserProductCode,
    Value<int>? normalizationVersion,
    Value<String?>? displayName,
    Value<String?>? displayBrand,
    Value<String>? normalizedName,
    Value<String>? normalizedBrand,
    Value<String>? mode,
    Value<String>? measurementKind,
    Value<String?>? packageAmount,
    Value<String?>? packageUnit,
    Value<String>? exactIdentityKey,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      userProductCode: userProductCode ?? this.userProductCode,
      normalizedUserProductCode:
          normalizedUserProductCode ?? this.normalizedUserProductCode,
      normalizationVersion: normalizationVersion ?? this.normalizationVersion,
      displayName: displayName ?? this.displayName,
      displayBrand: displayBrand ?? this.displayBrand,
      normalizedName: normalizedName ?? this.normalizedName,
      normalizedBrand: normalizedBrand ?? this.normalizedBrand,
      mode: mode ?? this.mode,
      measurementKind: measurementKind ?? this.measurementKind,
      packageAmount: packageAmount ?? this.packageAmount,
      packageUnit: packageUnit ?? this.packageUnit,
      exactIdentityKey: exactIdentityKey ?? this.exactIdentityKey,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (userProductCode.present) {
      map['user_product_code'] = Variable<String>(userProductCode.value);
    }
    if (normalizedUserProductCode.present) {
      map['normalized_user_product_code'] = Variable<String>(
        normalizedUserProductCode.value,
      );
    }
    if (normalizationVersion.present) {
      map['normalization_version'] = Variable<int>(normalizationVersion.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (displayBrand.present) {
      map['display_brand'] = Variable<String>(displayBrand.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (normalizedBrand.present) {
      map['normalized_brand'] = Variable<String>(normalizedBrand.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (measurementKind.present) {
      map['measurement_kind'] = Variable<String>(measurementKind.value);
    }
    if (packageAmount.present) {
      map['package_amount'] = Variable<String>(packageAmount.value);
    }
    if (packageUnit.present) {
      map['package_unit'] = Variable<String>(packageUnit.value);
    }
    if (exactIdentityKey.present) {
      map['exact_identity_key'] = Variable<String>(exactIdentityKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('userProductCode: $userProductCode, ')
          ..write('normalizedUserProductCode: $normalizedUserProductCode, ')
          ..write('normalizationVersion: $normalizationVersion, ')
          ..write('displayName: $displayName, ')
          ..write('displayBrand: $displayBrand, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('normalizedBrand: $normalizedBrand, ')
          ..write('mode: $mode, ')
          ..write('measurementKind: $measurementKind, ')
          ..write('packageAmount: $packageAmount, ')
          ..write('packageUnit: $packageUnit, ')
          ..write('exactIdentityKey: $exactIdentityKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoresTable extends Stores with TableInfo<$StoresTable, Store> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, accountId, displayName, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stores';
  @override
  VerificationContext validateIntegrity(
    Insertable<Store> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Store map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Store(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StoresTable createAlias(String alias) {
    return $StoresTable(attachedDatabase, alias);
  }
}

class Store extends DataClass implements Insertable<Store> {
  final String id;
  final String accountId;
  final String displayName;
  final DateTime createdAt;
  const Store({
    required this.id,
    required this.accountId,
    required this.displayName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['display_name'] = Variable<String>(displayName);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      id: Value(id),
      accountId: Value(accountId),
      displayName: Value(displayName),
      createdAt: Value(createdAt),
    );
  }

  factory Store.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Store(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'displayName': serializer.toJson<String>(displayName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Store copyWith({
    String? id,
    String? accountId,
    String? displayName,
    DateTime? createdAt,
  }) => Store(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    displayName: displayName ?? this.displayName,
    createdAt: createdAt ?? this.createdAt,
  );
  Store copyWithCompanion(StoresCompanion data) {
    return Store(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Store(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('displayName: $displayName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, displayName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Store &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.displayName == this.displayName &&
          other.createdAt == this.createdAt);
}

class StoresCompanion extends UpdateCompanion<Store> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> displayName;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoresCompanion.insert({
    required String id,
    required String accountId,
    required String displayName,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       displayName = Value(displayName),
       createdAt = Value(createdAt);
  static Insertable<Store> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? displayName,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (displayName != null) 'display_name': displayName,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoresCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? displayName,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StoresCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('displayName: $displayName, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PeopleTable extends People with TableInfo<$PeopleTable, PeopleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeopleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _visibleCodeMeta = const VerificationMeta(
    'visibleCode',
  );
  @override
  late final GeneratedColumn<String> visibleCode = GeneratedColumn<String>(
    'visible_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNicknameMeta =
      const VerificationMeta('normalizedNickname');
  @override
  late final GeneratedColumn<String> normalizedNickname =
      GeneratedColumn<String>(
        'normalized_nickname',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    visibleCode,
    nickname,
    normalizedNickname,
    active,
    createdAt,
    updatedAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'people';
  @override
  VerificationContext validateIntegrity(
    Insertable<PeopleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('visible_code')) {
      context.handle(
        _visibleCodeMeta,
        visibleCode.isAcceptableOrUnknown(
          data['visible_code']!,
          _visibleCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_visibleCodeMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('normalized_nickname')) {
      context.handle(
        _normalizedNicknameMeta,
        normalizedNickname.isAcceptableOrUnknown(
          data['normalized_nickname']!,
          _normalizedNicknameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNicknameMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {accountId, visibleCode},
  ];
  @override
  PeopleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeopleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      visibleCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visible_code'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      )!,
      normalizedNickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_nickname'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $PeopleTable createAlias(String alias) {
    return $PeopleTable(attachedDatabase, alias);
  }
}

class PeopleData extends DataClass implements Insertable<PeopleData> {
  final String id;
  final String accountId;
  final String visibleCode;
  final String nickname;
  final String normalizedNickname;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;
  const PeopleData({
    required this.id,
    required this.accountId,
    required this.visibleCode,
    required this.nickname,
    required this.normalizedNickname,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['visible_code'] = Variable<String>(visibleCode);
    map['nickname'] = Variable<String>(nickname);
    map['normalized_nickname'] = Variable<String>(normalizedNickname);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  PeopleCompanion toCompanion(bool nullToAbsent) {
    return PeopleCompanion(
      id: Value(id),
      accountId: Value(accountId),
      visibleCode: Value(visibleCode),
      nickname: Value(nickname),
      normalizedNickname: Value(normalizedNickname),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory PeopleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeopleData(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      visibleCode: serializer.fromJson<String>(json['visibleCode']),
      nickname: serializer.fromJson<String>(json['nickname']),
      normalizedNickname: serializer.fromJson<String>(
        json['normalizedNickname'],
      ),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'visibleCode': serializer.toJson<String>(visibleCode),
      'nickname': serializer.toJson<String>(nickname),
      'normalizedNickname': serializer.toJson<String>(normalizedNickname),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  PeopleData copyWith({
    String? id,
    String? accountId,
    String? visibleCode,
    String? nickname,
    String? normalizedNickname,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => PeopleData(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    visibleCode: visibleCode ?? this.visibleCode,
    nickname: nickname ?? this.nickname,
    normalizedNickname: normalizedNickname ?? this.normalizedNickname,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  PeopleData copyWithCompanion(PeopleCompanion data) {
    return PeopleData(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      visibleCode: data.visibleCode.present
          ? data.visibleCode.value
          : this.visibleCode,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      normalizedNickname: data.normalizedNickname.present
          ? data.normalizedNickname.value
          : this.normalizedNickname,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeopleData(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('visibleCode: $visibleCode, ')
          ..write('nickname: $nickname, ')
          ..write('normalizedNickname: $normalizedNickname, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    visibleCode,
    nickname,
    normalizedNickname,
    active,
    createdAt,
    updatedAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeopleData &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.visibleCode == this.visibleCode &&
          other.nickname == this.nickname &&
          other.normalizedNickname == this.normalizedNickname &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt);
}

class PeopleCompanion extends UpdateCompanion<PeopleData> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> visibleCode;
  final Value<String> nickname;
  final Value<String> normalizedNickname;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const PeopleCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.visibleCode = const Value.absent(),
    this.nickname = const Value.absent(),
    this.normalizedNickname = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PeopleCompanion.insert({
    required String id,
    required String accountId,
    required String visibleCode,
    required String nickname,
    required String normalizedNickname,
    this.active = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       visibleCode = Value(visibleCode),
       nickname = Value(nickname),
       normalizedNickname = Value(normalizedNickname),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PeopleData> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? visibleCode,
    Expression<String>? nickname,
    Expression<String>? normalizedNickname,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (visibleCode != null) 'visible_code': visibleCode,
      if (nickname != null) 'nickname': nickname,
      if (normalizedNickname != null) 'normalized_nickname': normalizedNickname,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PeopleCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? visibleCode,
    Value<String>? nickname,
    Value<String>? normalizedNickname,
    Value<bool>? active,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? archivedAt,
    Value<int>? rowid,
  }) {
    return PeopleCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      visibleCode: visibleCode ?? this.visibleCode,
      nickname: nickname ?? this.nickname,
      normalizedNickname: normalizedNickname ?? this.normalizedNickname,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (visibleCode.present) {
      map['visible_code'] = Variable<String>(visibleCode.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (normalizedNickname.present) {
      map['normalized_nickname'] = Variable<String>(normalizedNickname.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeopleCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('visibleCode: $visibleCode, ')
          ..write('nickname: $nickname, ')
          ..write('normalizedNickname: $normalizedNickname, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentMethodsTable extends PaymentMethods
    with TableInfo<$PaymentMethodsTable, PaymentMethod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentMethodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _visibleCodeMeta = const VerificationMeta(
    'visibleCode',
  );
  @override
  late final GeneratedColumn<String> visibleCode = GeneratedColumn<String>(
    'visible_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNicknameMeta =
      const VerificationMeta('normalizedNickname');
  @override
  late final GeneratedColumn<String> normalizedNickname =
      GeneratedColumn<String>(
        'normalized_nickname',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    visibleCode,
    nickname,
    normalizedNickname,
    active,
    createdAt,
    updatedAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentMethod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('visible_code')) {
      context.handle(
        _visibleCodeMeta,
        visibleCode.isAcceptableOrUnknown(
          data['visible_code']!,
          _visibleCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_visibleCodeMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('normalized_nickname')) {
      context.handle(
        _normalizedNicknameMeta,
        normalizedNickname.isAcceptableOrUnknown(
          data['normalized_nickname']!,
          _normalizedNicknameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNicknameMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {accountId, visibleCode},
  ];
  @override
  PaymentMethod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentMethod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      visibleCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visible_code'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      )!,
      normalizedNickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_nickname'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $PaymentMethodsTable createAlias(String alias) {
    return $PaymentMethodsTable(attachedDatabase, alias);
  }
}

class PaymentMethod extends DataClass implements Insertable<PaymentMethod> {
  final String id;
  final String accountId;
  final String visibleCode;
  final String nickname;
  final String normalizedNickname;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;
  const PaymentMethod({
    required this.id,
    required this.accountId,
    required this.visibleCode,
    required this.nickname,
    required this.normalizedNickname,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['visible_code'] = Variable<String>(visibleCode);
    map['nickname'] = Variable<String>(nickname);
    map['normalized_nickname'] = Variable<String>(normalizedNickname);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  PaymentMethodsCompanion toCompanion(bool nullToAbsent) {
    return PaymentMethodsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      visibleCode: Value(visibleCode),
      nickname: Value(nickname),
      normalizedNickname: Value(normalizedNickname),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory PaymentMethod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentMethod(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      visibleCode: serializer.fromJson<String>(json['visibleCode']),
      nickname: serializer.fromJson<String>(json['nickname']),
      normalizedNickname: serializer.fromJson<String>(
        json['normalizedNickname'],
      ),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'visibleCode': serializer.toJson<String>(visibleCode),
      'nickname': serializer.toJson<String>(nickname),
      'normalizedNickname': serializer.toJson<String>(normalizedNickname),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  PaymentMethod copyWith({
    String? id,
    String? accountId,
    String? visibleCode,
    String? nickname,
    String? normalizedNickname,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => PaymentMethod(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    visibleCode: visibleCode ?? this.visibleCode,
    nickname: nickname ?? this.nickname,
    normalizedNickname: normalizedNickname ?? this.normalizedNickname,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  PaymentMethod copyWithCompanion(PaymentMethodsCompanion data) {
    return PaymentMethod(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      visibleCode: data.visibleCode.present
          ? data.visibleCode.value
          : this.visibleCode,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      normalizedNickname: data.normalizedNickname.present
          ? data.normalizedNickname.value
          : this.normalizedNickname,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethod(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('visibleCode: $visibleCode, ')
          ..write('nickname: $nickname, ')
          ..write('normalizedNickname: $normalizedNickname, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    visibleCode,
    nickname,
    normalizedNickname,
    active,
    createdAt,
    updatedAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentMethod &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.visibleCode == this.visibleCode &&
          other.nickname == this.nickname &&
          other.normalizedNickname == this.normalizedNickname &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt);
}

class PaymentMethodsCompanion extends UpdateCompanion<PaymentMethod> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> visibleCode;
  final Value<String> nickname;
  final Value<String> normalizedNickname;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const PaymentMethodsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.visibleCode = const Value.absent(),
    this.nickname = const Value.absent(),
    this.normalizedNickname = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentMethodsCompanion.insert({
    required String id,
    required String accountId,
    required String visibleCode,
    required String nickname,
    required String normalizedNickname,
    this.active = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       visibleCode = Value(visibleCode),
       nickname = Value(nickname),
       normalizedNickname = Value(normalizedNickname),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PaymentMethod> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? visibleCode,
    Expression<String>? nickname,
    Expression<String>? normalizedNickname,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (visibleCode != null) 'visible_code': visibleCode,
      if (nickname != null) 'nickname': nickname,
      if (normalizedNickname != null) 'normalized_nickname': normalizedNickname,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentMethodsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? visibleCode,
    Value<String>? nickname,
    Value<String>? normalizedNickname,
    Value<bool>? active,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? archivedAt,
    Value<int>? rowid,
  }) {
    return PaymentMethodsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      visibleCode: visibleCode ?? this.visibleCode,
      nickname: nickname ?? this.nickname,
      normalizedNickname: normalizedNickname ?? this.normalizedNickname,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (visibleCode.present) {
      map['visible_code'] = Variable<String>(visibleCode.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (normalizedNickname.present) {
      map['normalized_nickname'] = Variable<String>(normalizedNickname.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethodsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('visibleCode: $visibleCode, ')
          ..write('nickname: $nickname, ')
          ..write('normalizedNickname: $normalizedNickname, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountPreferencesTable extends AccountPreferences
    with TableInfo<$AccountPreferencesTable, AccountPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _shortageThresholdDaysMeta =
      const VerificationMeta('shortageThresholdDays');
  @override
  late final GeneratedColumn<int> shortageThresholdDays = GeneratedColumn<int>(
    'shortage_threshold_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _nextPersonCodeMeta = const VerificationMeta(
    'nextPersonCode',
  );
  @override
  late final GeneratedColumn<int> nextPersonCode = GeneratedColumn<int>(
    'next_person_code',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _nextPaymentMethodCodeMeta =
      const VerificationMeta('nextPaymentMethodCode');
  @override
  late final GeneratedColumn<int> nextPaymentMethodCode = GeneratedColumn<int>(
    'next_payment_method_code',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    shortageThresholdDays,
    nextPersonCode,
    nextPaymentMethodCode,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('shortage_threshold_days')) {
      context.handle(
        _shortageThresholdDaysMeta,
        shortageThresholdDays.isAcceptableOrUnknown(
          data['shortage_threshold_days']!,
          _shortageThresholdDaysMeta,
        ),
      );
    }
    if (data.containsKey('next_person_code')) {
      context.handle(
        _nextPersonCodeMeta,
        nextPersonCode.isAcceptableOrUnknown(
          data['next_person_code']!,
          _nextPersonCodeMeta,
        ),
      );
    }
    if (data.containsKey('next_payment_method_code')) {
      context.handle(
        _nextPaymentMethodCodeMeta,
        nextPaymentMethodCode.isAcceptableOrUnknown(
          data['next_payment_method_code']!,
          _nextPaymentMethodCodeMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  AccountPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountPreference(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      shortageThresholdDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shortage_threshold_days'],
      )!,
      nextPersonCode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_person_code'],
      )!,
      nextPaymentMethodCode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_payment_method_code'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AccountPreferencesTable createAlias(String alias) {
    return $AccountPreferencesTable(attachedDatabase, alias);
  }
}

class AccountPreference extends DataClass
    implements Insertable<AccountPreference> {
  final String accountId;
  final int shortageThresholdDays;
  final int nextPersonCode;
  final int nextPaymentMethodCode;
  final DateTime updatedAt;
  const AccountPreference({
    required this.accountId,
    required this.shortageThresholdDays,
    required this.nextPersonCode,
    required this.nextPaymentMethodCode,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['shortage_threshold_days'] = Variable<int>(shortageThresholdDays);
    map['next_person_code'] = Variable<int>(nextPersonCode);
    map['next_payment_method_code'] = Variable<int>(nextPaymentMethodCode);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AccountPreferencesCompanion toCompanion(bool nullToAbsent) {
    return AccountPreferencesCompanion(
      accountId: Value(accountId),
      shortageThresholdDays: Value(shortageThresholdDays),
      nextPersonCode: Value(nextPersonCode),
      nextPaymentMethodCode: Value(nextPaymentMethodCode),
      updatedAt: Value(updatedAt),
    );
  }

  factory AccountPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountPreference(
      accountId: serializer.fromJson<String>(json['accountId']),
      shortageThresholdDays: serializer.fromJson<int>(
        json['shortageThresholdDays'],
      ),
      nextPersonCode: serializer.fromJson<int>(json['nextPersonCode']),
      nextPaymentMethodCode: serializer.fromJson<int>(
        json['nextPaymentMethodCode'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'shortageThresholdDays': serializer.toJson<int>(shortageThresholdDays),
      'nextPersonCode': serializer.toJson<int>(nextPersonCode),
      'nextPaymentMethodCode': serializer.toJson<int>(nextPaymentMethodCode),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AccountPreference copyWith({
    String? accountId,
    int? shortageThresholdDays,
    int? nextPersonCode,
    int? nextPaymentMethodCode,
    DateTime? updatedAt,
  }) => AccountPreference(
    accountId: accountId ?? this.accountId,
    shortageThresholdDays: shortageThresholdDays ?? this.shortageThresholdDays,
    nextPersonCode: nextPersonCode ?? this.nextPersonCode,
    nextPaymentMethodCode: nextPaymentMethodCode ?? this.nextPaymentMethodCode,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AccountPreference copyWithCompanion(AccountPreferencesCompanion data) {
    return AccountPreference(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      shortageThresholdDays: data.shortageThresholdDays.present
          ? data.shortageThresholdDays.value
          : this.shortageThresholdDays,
      nextPersonCode: data.nextPersonCode.present
          ? data.nextPersonCode.value
          : this.nextPersonCode,
      nextPaymentMethodCode: data.nextPaymentMethodCode.present
          ? data.nextPaymentMethodCode.value
          : this.nextPaymentMethodCode,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountPreference(')
          ..write('accountId: $accountId, ')
          ..write('shortageThresholdDays: $shortageThresholdDays, ')
          ..write('nextPersonCode: $nextPersonCode, ')
          ..write('nextPaymentMethodCode: $nextPaymentMethodCode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    shortageThresholdDays,
    nextPersonCode,
    nextPaymentMethodCode,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountPreference &&
          other.accountId == this.accountId &&
          other.shortageThresholdDays == this.shortageThresholdDays &&
          other.nextPersonCode == this.nextPersonCode &&
          other.nextPaymentMethodCode == this.nextPaymentMethodCode &&
          other.updatedAt == this.updatedAt);
}

class AccountPreferencesCompanion extends UpdateCompanion<AccountPreference> {
  final Value<String> accountId;
  final Value<int> shortageThresholdDays;
  final Value<int> nextPersonCode;
  final Value<int> nextPaymentMethodCode;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AccountPreferencesCompanion({
    this.accountId = const Value.absent(),
    this.shortageThresholdDays = const Value.absent(),
    this.nextPersonCode = const Value.absent(),
    this.nextPaymentMethodCode = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountPreferencesCompanion.insert({
    required String accountId,
    this.shortageThresholdDays = const Value.absent(),
    this.nextPersonCode = const Value.absent(),
    this.nextPaymentMethodCode = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       updatedAt = Value(updatedAt);
  static Insertable<AccountPreference> custom({
    Expression<String>? accountId,
    Expression<int>? shortageThresholdDays,
    Expression<int>? nextPersonCode,
    Expression<int>? nextPaymentMethodCode,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (shortageThresholdDays != null)
        'shortage_threshold_days': shortageThresholdDays,
      if (nextPersonCode != null) 'next_person_code': nextPersonCode,
      if (nextPaymentMethodCode != null)
        'next_payment_method_code': nextPaymentMethodCode,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountPreferencesCompanion copyWith({
    Value<String>? accountId,
    Value<int>? shortageThresholdDays,
    Value<int>? nextPersonCode,
    Value<int>? nextPaymentMethodCode,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AccountPreferencesCompanion(
      accountId: accountId ?? this.accountId,
      shortageThresholdDays:
          shortageThresholdDays ?? this.shortageThresholdDays,
      nextPersonCode: nextPersonCode ?? this.nextPersonCode,
      nextPaymentMethodCode:
          nextPaymentMethodCode ?? this.nextPaymentMethodCode,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (shortageThresholdDays.present) {
      map['shortage_threshold_days'] = Variable<int>(
        shortageThresholdDays.value,
      );
    }
    if (nextPersonCode.present) {
      map['next_person_code'] = Variable<int>(nextPersonCode.value);
    }
    if (nextPaymentMethodCode.present) {
      map['next_payment_method_code'] = Variable<int>(
        nextPaymentMethodCode.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountPreferencesCompanion(')
          ..write('accountId: $accountId, ')
          ..write('shortageThresholdDays: $shortageThresholdDays, ')
          ..write('nextPersonCode: $nextPersonCode, ')
          ..write('nextPaymentMethodCode: $nextPaymentMethodCode, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _storeIdMeta = const VerificationMeta(
    'storeId',
  );
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
    'store_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stores (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
    'person_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES people (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _paymentMethodIdMeta = const VerificationMeta(
    'paymentMethodId',
  );
  @override
  late final GeneratedColumn<String> paymentMethodId = GeneratedColumn<String>(
    'payment_method_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payment_methods (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _occurrenceTimeMeta = const VerificationMeta(
    'occurrenceTime',
  );
  @override
  late final GeneratedColumn<DateTime> occurrenceTime =
      GeneratedColumn<DateTime>(
        'occurrence_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMinorUnitsMeta = const VerificationMeta(
    'totalMinorUnits',
  );
  @override
  late final GeneratedColumn<int> totalMinorUnits = GeneratedColumn<int>(
    'total_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    storeId,
    personId,
    paymentMethodId,
    occurrenceTime,
    currencyCode,
    totalMinorUnits,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Purchase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('store_id')) {
      context.handle(
        _storeIdMeta,
        storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_storeIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    }
    if (data.containsKey('payment_method_id')) {
      context.handle(
        _paymentMethodIdMeta,
        paymentMethodId.isAcceptableOrUnknown(
          data['payment_method_id']!,
          _paymentMethodIdMeta,
        ),
      );
    }
    if (data.containsKey('occurrence_time')) {
      context.handle(
        _occurrenceTimeMeta,
        occurrenceTime.isAcceptableOrUnknown(
          data['occurrence_time']!,
          _occurrenceTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_occurrenceTimeMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('total_minor_units')) {
      context.handle(
        _totalMinorUnitsMeta,
        totalMinorUnits.isAcceptableOrUnknown(
          data['total_minor_units']!,
          _totalMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalMinorUnitsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Purchase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      storeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}store_id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person_id'],
      ),
      paymentMethodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method_id'],
      ),
      occurrenceTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurrence_time'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      totalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_minor_units'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final String id;
  final String accountId;
  final String storeId;
  final String? personId;
  final String? paymentMethodId;
  final DateTime occurrenceTime;
  final String currencyCode;
  final int totalMinorUnits;
  final DateTime createdAt;
  const Purchase({
    required this.id,
    required this.accountId,
    required this.storeId,
    this.personId,
    this.paymentMethodId,
    required this.occurrenceTime,
    required this.currencyCode,
    required this.totalMinorUnits,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['store_id'] = Variable<String>(storeId);
    if (!nullToAbsent || personId != null) {
      map['person_id'] = Variable<String>(personId);
    }
    if (!nullToAbsent || paymentMethodId != null) {
      map['payment_method_id'] = Variable<String>(paymentMethodId);
    }
    map['occurrence_time'] = Variable<DateTime>(occurrenceTime);
    map['currency_code'] = Variable<String>(currencyCode);
    map['total_minor_units'] = Variable<int>(totalMinorUnits);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      accountId: Value(accountId),
      storeId: Value(storeId),
      personId: personId == null && nullToAbsent
          ? const Value.absent()
          : Value(personId),
      paymentMethodId: paymentMethodId == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethodId),
      occurrenceTime: Value(occurrenceTime),
      currencyCode: Value(currencyCode),
      totalMinorUnits: Value(totalMinorUnits),
      createdAt: Value(createdAt),
    );
  }

  factory Purchase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      storeId: serializer.fromJson<String>(json['storeId']),
      personId: serializer.fromJson<String?>(json['personId']),
      paymentMethodId: serializer.fromJson<String?>(json['paymentMethodId']),
      occurrenceTime: serializer.fromJson<DateTime>(json['occurrenceTime']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      totalMinorUnits: serializer.fromJson<int>(json['totalMinorUnits']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'storeId': serializer.toJson<String>(storeId),
      'personId': serializer.toJson<String?>(personId),
      'paymentMethodId': serializer.toJson<String?>(paymentMethodId),
      'occurrenceTime': serializer.toJson<DateTime>(occurrenceTime),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'totalMinorUnits': serializer.toJson<int>(totalMinorUnits),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Purchase copyWith({
    String? id,
    String? accountId,
    String? storeId,
    Value<String?> personId = const Value.absent(),
    Value<String?> paymentMethodId = const Value.absent(),
    DateTime? occurrenceTime,
    String? currencyCode,
    int? totalMinorUnits,
    DateTime? createdAt,
  }) => Purchase(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    storeId: storeId ?? this.storeId,
    personId: personId.present ? personId.value : this.personId,
    paymentMethodId: paymentMethodId.present
        ? paymentMethodId.value
        : this.paymentMethodId,
    occurrenceTime: occurrenceTime ?? this.occurrenceTime,
    currencyCode: currencyCode ?? this.currencyCode,
    totalMinorUnits: totalMinorUnits ?? this.totalMinorUnits,
    createdAt: createdAt ?? this.createdAt,
  );
  Purchase copyWithCompanion(PurchasesCompanion data) {
    return Purchase(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      personId: data.personId.present ? data.personId.value : this.personId,
      paymentMethodId: data.paymentMethodId.present
          ? data.paymentMethodId.value
          : this.paymentMethodId,
      occurrenceTime: data.occurrenceTime.present
          ? data.occurrenceTime.value
          : this.occurrenceTime,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      totalMinorUnits: data.totalMinorUnits.present
          ? data.totalMinorUnits.value
          : this.totalMinorUnits,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('storeId: $storeId, ')
          ..write('personId: $personId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('occurrenceTime: $occurrenceTime, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('totalMinorUnits: $totalMinorUnits, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    storeId,
    personId,
    paymentMethodId,
    occurrenceTime,
    currencyCode,
    totalMinorUnits,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.storeId == this.storeId &&
          other.personId == this.personId &&
          other.paymentMethodId == this.paymentMethodId &&
          other.occurrenceTime == this.occurrenceTime &&
          other.currencyCode == this.currencyCode &&
          other.totalMinorUnits == this.totalMinorUnits &&
          other.createdAt == this.createdAt);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> storeId;
  final Value<String?> personId;
  final Value<String?> paymentMethodId;
  final Value<DateTime> occurrenceTime;
  final Value<String> currencyCode;
  final Value<int> totalMinorUnits;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.storeId = const Value.absent(),
    this.personId = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    this.occurrenceTime = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.totalMinorUnits = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchasesCompanion.insert({
    required String id,
    required String accountId,
    required String storeId,
    this.personId = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    required DateTime occurrenceTime,
    required String currencyCode,
    required int totalMinorUnits,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       storeId = Value(storeId),
       occurrenceTime = Value(occurrenceTime),
       currencyCode = Value(currencyCode),
       totalMinorUnits = Value(totalMinorUnits),
       createdAt = Value(createdAt);
  static Insertable<Purchase> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? storeId,
    Expression<String>? personId,
    Expression<String>? paymentMethodId,
    Expression<DateTime>? occurrenceTime,
    Expression<String>? currencyCode,
    Expression<int>? totalMinorUnits,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (storeId != null) 'store_id': storeId,
      if (personId != null) 'person_id': personId,
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      if (occurrenceTime != null) 'occurrence_time': occurrenceTime,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (totalMinorUnits != null) 'total_minor_units': totalMinorUnits,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchasesCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? storeId,
    Value<String?>? personId,
    Value<String?>? paymentMethodId,
    Value<DateTime>? occurrenceTime,
    Value<String>? currencyCode,
    Value<int>? totalMinorUnits,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PurchasesCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      storeId: storeId ?? this.storeId,
      personId: personId ?? this.personId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      occurrenceTime: occurrenceTime ?? this.occurrenceTime,
      currencyCode: currencyCode ?? this.currencyCode,
      totalMinorUnits: totalMinorUnits ?? this.totalMinorUnits,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (paymentMethodId.present) {
      map['payment_method_id'] = Variable<String>(paymentMethodId.value);
    }
    if (occurrenceTime.present) {
      map['occurrence_time'] = Variable<DateTime>(occurrenceTime.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (totalMinorUnits.present) {
      map['total_minor_units'] = Variable<int>(totalMinorUnits.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('storeId: $storeId, ')
          ..write('personId: $personId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('occurrenceTime: $occurrenceTime, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('totalMinorUnits: $totalMinorUnits, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseItemsTable extends PurchaseItems
    with TableInfo<$PurchaseItemsTable, PurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _packageCountMeta = const VerificationMeta(
    'packageCount',
  );
  @override
  late final GeneratedColumn<int> packageCount = GeneratedColumn<int>(
    'package_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _measurementKindMeta = const VerificationMeta(
    'measurementKind',
  );
  @override
  late final GeneratedColumn<String> measurementKind = GeneratedColumn<String>(
    'measurement_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasedAmountMeta = const VerificationMeta(
    'purchasedAmount',
  );
  @override
  late final GeneratedColumn<String> purchasedAmount = GeneratedColumn<String>(
    'purchased_amount',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasedUnitMeta = const VerificationMeta(
    'purchasedUnit',
  );
  @override
  late final GeneratedColumn<String> purchasedUnit = GeneratedColumn<String>(
    'purchased_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineTotalMinorUnitsMeta =
      const VerificationMeta('lineTotalMinorUnits');
  @override
  late final GeneratedColumn<int> lineTotalMinorUnits = GeneratedColumn<int>(
    'line_total_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    productId,
    packageCount,
    measurementKind,
    purchasedAmount,
    purchasedUnit,
    currencyCode,
    lineTotalMinorUnits,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('package_count')) {
      context.handle(
        _packageCountMeta,
        packageCount.isAcceptableOrUnknown(
          data['package_count']!,
          _packageCountMeta,
        ),
      );
    }
    if (data.containsKey('measurement_kind')) {
      context.handle(
        _measurementKindMeta,
        measurementKind.isAcceptableOrUnknown(
          data['measurement_kind']!,
          _measurementKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_measurementKindMeta);
    }
    if (data.containsKey('purchased_amount')) {
      context.handle(
        _purchasedAmountMeta,
        purchasedAmount.isAcceptableOrUnknown(
          data['purchased_amount']!,
          _purchasedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasedAmountMeta);
    }
    if (data.containsKey('purchased_unit')) {
      context.handle(
        _purchasedUnitMeta,
        purchasedUnit.isAcceptableOrUnknown(
          data['purchased_unit']!,
          _purchasedUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasedUnitMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('line_total_minor_units')) {
      context.handle(
        _lineTotalMinorUnitsMeta,
        lineTotalMinorUnits.isAcceptableOrUnknown(
          data['line_total_minor_units']!,
          _lineTotalMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineTotalMinorUnitsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      packageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}package_count'],
      ),
      measurementKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}measurement_kind'],
      )!,
      purchasedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchased_amount'],
      )!,
      purchasedUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchased_unit'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      lineTotalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_total_minor_units'],
      )!,
    );
  }

  @override
  $PurchaseItemsTable createAlias(String alias) {
    return $PurchaseItemsTable(attachedDatabase, alias);
  }
}

class PurchaseItem extends DataClass implements Insertable<PurchaseItem> {
  final String id;
  final String purchaseId;
  final String productId;
  final int? packageCount;
  final String measurementKind;
  final String purchasedAmount;
  final String purchasedUnit;
  final String currencyCode;
  final int lineTotalMinorUnits;
  const PurchaseItem({
    required this.id,
    required this.purchaseId,
    required this.productId,
    this.packageCount,
    required this.measurementKind,
    required this.purchasedAmount,
    required this.purchasedUnit,
    required this.currencyCode,
    required this.lineTotalMinorUnits,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['purchase_id'] = Variable<String>(purchaseId);
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || packageCount != null) {
      map['package_count'] = Variable<int>(packageCount);
    }
    map['measurement_kind'] = Variable<String>(measurementKind);
    map['purchased_amount'] = Variable<String>(purchasedAmount);
    map['purchased_unit'] = Variable<String>(purchasedUnit);
    map['currency_code'] = Variable<String>(currencyCode);
    map['line_total_minor_units'] = Variable<int>(lineTotalMinorUnits);
    return map;
  }

  PurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseItemsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      productId: Value(productId),
      packageCount: packageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(packageCount),
      measurementKind: Value(measurementKind),
      purchasedAmount: Value(purchasedAmount),
      purchasedUnit: Value(purchasedUnit),
      currencyCode: Value(currencyCode),
      lineTotalMinorUnits: Value(lineTotalMinorUnits),
    );
  }

  factory PurchaseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseItem(
      id: serializer.fromJson<String>(json['id']),
      purchaseId: serializer.fromJson<String>(json['purchaseId']),
      productId: serializer.fromJson<String>(json['productId']),
      packageCount: serializer.fromJson<int?>(json['packageCount']),
      measurementKind: serializer.fromJson<String>(json['measurementKind']),
      purchasedAmount: serializer.fromJson<String>(json['purchasedAmount']),
      purchasedUnit: serializer.fromJson<String>(json['purchasedUnit']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      lineTotalMinorUnits: serializer.fromJson<int>(
        json['lineTotalMinorUnits'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'purchaseId': serializer.toJson<String>(purchaseId),
      'productId': serializer.toJson<String>(productId),
      'packageCount': serializer.toJson<int?>(packageCount),
      'measurementKind': serializer.toJson<String>(measurementKind),
      'purchasedAmount': serializer.toJson<String>(purchasedAmount),
      'purchasedUnit': serializer.toJson<String>(purchasedUnit),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'lineTotalMinorUnits': serializer.toJson<int>(lineTotalMinorUnits),
    };
  }

  PurchaseItem copyWith({
    String? id,
    String? purchaseId,
    String? productId,
    Value<int?> packageCount = const Value.absent(),
    String? measurementKind,
    String? purchasedAmount,
    String? purchasedUnit,
    String? currencyCode,
    int? lineTotalMinorUnits,
  }) => PurchaseItem(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    productId: productId ?? this.productId,
    packageCount: packageCount.present ? packageCount.value : this.packageCount,
    measurementKind: measurementKind ?? this.measurementKind,
    purchasedAmount: purchasedAmount ?? this.purchasedAmount,
    purchasedUnit: purchasedUnit ?? this.purchasedUnit,
    currencyCode: currencyCode ?? this.currencyCode,
    lineTotalMinorUnits: lineTotalMinorUnits ?? this.lineTotalMinorUnits,
  );
  PurchaseItem copyWithCompanion(PurchaseItemsCompanion data) {
    return PurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      productId: data.productId.present ? data.productId.value : this.productId,
      packageCount: data.packageCount.present
          ? data.packageCount.value
          : this.packageCount,
      measurementKind: data.measurementKind.present
          ? data.measurementKind.value
          : this.measurementKind,
      purchasedAmount: data.purchasedAmount.present
          ? data.purchasedAmount.value
          : this.purchasedAmount,
      purchasedUnit: data.purchasedUnit.present
          ? data.purchasedUnit.value
          : this.purchasedUnit,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      lineTotalMinorUnits: data.lineTotalMinorUnits.present
          ? data.lineTotalMinorUnits.value
          : this.lineTotalMinorUnits,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItem(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('packageCount: $packageCount, ')
          ..write('measurementKind: $measurementKind, ')
          ..write('purchasedAmount: $purchasedAmount, ')
          ..write('purchasedUnit: $purchasedUnit, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('lineTotalMinorUnits: $lineTotalMinorUnits')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseId,
    productId,
    packageCount,
    measurementKind,
    purchasedAmount,
    purchasedUnit,
    currencyCode,
    lineTotalMinorUnits,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItem &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.productId == this.productId &&
          other.packageCount == this.packageCount &&
          other.measurementKind == this.measurementKind &&
          other.purchasedAmount == this.purchasedAmount &&
          other.purchasedUnit == this.purchasedUnit &&
          other.currencyCode == this.currencyCode &&
          other.lineTotalMinorUnits == this.lineTotalMinorUnits);
}

class PurchaseItemsCompanion extends UpdateCompanion<PurchaseItem> {
  final Value<String> id;
  final Value<String> purchaseId;
  final Value<String> productId;
  final Value<int?> packageCount;
  final Value<String> measurementKind;
  final Value<String> purchasedAmount;
  final Value<String> purchasedUnit;
  final Value<String> currencyCode;
  final Value<int> lineTotalMinorUnits;
  final Value<int> rowid;
  const PurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.productId = const Value.absent(),
    this.packageCount = const Value.absent(),
    this.measurementKind = const Value.absent(),
    this.purchasedAmount = const Value.absent(),
    this.purchasedUnit = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.lineTotalMinorUnits = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseItemsCompanion.insert({
    required String id,
    required String purchaseId,
    required String productId,
    this.packageCount = const Value.absent(),
    required String measurementKind,
    required String purchasedAmount,
    required String purchasedUnit,
    required String currencyCode,
    required int lineTotalMinorUnits,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       purchaseId = Value(purchaseId),
       productId = Value(productId),
       measurementKind = Value(measurementKind),
       purchasedAmount = Value(purchasedAmount),
       purchasedUnit = Value(purchasedUnit),
       currencyCode = Value(currencyCode),
       lineTotalMinorUnits = Value(lineTotalMinorUnits);
  static Insertable<PurchaseItem> custom({
    Expression<String>? id,
    Expression<String>? purchaseId,
    Expression<String>? productId,
    Expression<int>? packageCount,
    Expression<String>? measurementKind,
    Expression<String>? purchasedAmount,
    Expression<String>? purchasedUnit,
    Expression<String>? currencyCode,
    Expression<int>? lineTotalMinorUnits,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (productId != null) 'product_id': productId,
      if (packageCount != null) 'package_count': packageCount,
      if (measurementKind != null) 'measurement_kind': measurementKind,
      if (purchasedAmount != null) 'purchased_amount': purchasedAmount,
      if (purchasedUnit != null) 'purchased_unit': purchasedUnit,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (lineTotalMinorUnits != null)
        'line_total_minor_units': lineTotalMinorUnits,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? purchaseId,
    Value<String>? productId,
    Value<int?>? packageCount,
    Value<String>? measurementKind,
    Value<String>? purchasedAmount,
    Value<String>? purchasedUnit,
    Value<String>? currencyCode,
    Value<int>? lineTotalMinorUnits,
    Value<int>? rowid,
  }) {
    return PurchaseItemsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      packageCount: packageCount ?? this.packageCount,
      measurementKind: measurementKind ?? this.measurementKind,
      purchasedAmount: purchasedAmount ?? this.purchasedAmount,
      purchasedUnit: purchasedUnit ?? this.purchasedUnit,
      currencyCode: currencyCode ?? this.currencyCode,
      lineTotalMinorUnits: lineTotalMinorUnits ?? this.lineTotalMinorUnits,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (packageCount.present) {
      map['package_count'] = Variable<int>(packageCount.value);
    }
    if (measurementKind.present) {
      map['measurement_kind'] = Variable<String>(measurementKind.value);
    }
    if (purchasedAmount.present) {
      map['purchased_amount'] = Variable<String>(purchasedAmount.value);
    }
    if (purchasedUnit.present) {
      map['purchased_unit'] = Variable<String>(purchasedUnit.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (lineTotalMinorUnits.present) {
      map['line_total_minor_units'] = Variable<int>(lineTotalMinorUnits.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('packageCount: $packageCount, ')
          ..write('measurementKind: $measurementKind, ')
          ..write('purchasedAmount: $purchasedAmount, ')
          ..write('purchasedUnit: $purchasedUnit, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('lineTotalMinorUnits: $lineTotalMinorUnits, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncEventsTable extends SyncEvents
    with TableInfo<$SyncEventsTable, SyncEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES devices (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _deviceSequenceMeta = const VerificationMeta(
    'deviceSequence',
  );
  @override
  late final GeneratedColumn<int> deviceSequence = GeneratedColumn<int>(
    'device_sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadVersionMeta = const VerificationMeta(
    'payloadVersion',
  );
  @override
  late final GeneratedColumn<int> payloadVersion = GeneratedColumn<int>(
    'payload_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurrenceTimeMeta = const VerificationMeta(
    'occurrenceTime',
  );
  @override
  late final GeneratedColumn<DateTime> occurrenceTime =
      GeneratedColumn<DateTime>(
        'occurrence_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    deviceId,
    deviceSequence,
    eventType,
    payloadVersion,
    occurrenceTime,
    payloadJson,
    contentHash,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('device_sequence')) {
      context.handle(
        _deviceSequenceMeta,
        deviceSequence.isAcceptableOrUnknown(
          data['device_sequence']!,
          _deviceSequenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceSequenceMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('payload_version')) {
      context.handle(
        _payloadVersionMeta,
        payloadVersion.isAcceptableOrUnknown(
          data['payload_version']!,
          _payloadVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadVersionMeta);
    }
    if (data.containsKey('occurrence_time')) {
      context.handle(
        _occurrenceTimeMeta,
        occurrenceTime.isAcceptableOrUnknown(
          data['occurrence_time']!,
          _occurrenceTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_occurrenceTimeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {accountId, deviceId, deviceSequence},
  ];
  @override
  SyncEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      deviceSequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}device_sequence'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      payloadVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payload_version'],
      )!,
      occurrenceTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurrence_time'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncEventsTable createAlias(String alias) {
    return $SyncEventsTable(attachedDatabase, alias);
  }
}

class SyncEvent extends DataClass implements Insertable<SyncEvent> {
  final String id;
  final String accountId;
  final String deviceId;
  final int deviceSequence;
  final String eventType;
  final int payloadVersion;
  final DateTime occurrenceTime;
  final String payloadJson;
  final String contentHash;
  final DateTime createdAt;
  const SyncEvent({
    required this.id,
    required this.accountId,
    required this.deviceId,
    required this.deviceSequence,
    required this.eventType,
    required this.payloadVersion,
    required this.occurrenceTime,
    required this.payloadJson,
    required this.contentHash,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['device_id'] = Variable<String>(deviceId);
    map['device_sequence'] = Variable<int>(deviceSequence);
    map['event_type'] = Variable<String>(eventType);
    map['payload_version'] = Variable<int>(payloadVersion);
    map['occurrence_time'] = Variable<DateTime>(occurrenceTime);
    map['payload_json'] = Variable<String>(payloadJson);
    map['content_hash'] = Variable<String>(contentHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncEventsCompanion toCompanion(bool nullToAbsent) {
    return SyncEventsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      deviceId: Value(deviceId),
      deviceSequence: Value(deviceSequence),
      eventType: Value(eventType),
      payloadVersion: Value(payloadVersion),
      occurrenceTime: Value(occurrenceTime),
      payloadJson: Value(payloadJson),
      contentHash: Value(contentHash),
      createdAt: Value(createdAt),
    );
  }

  factory SyncEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncEvent(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      deviceSequence: serializer.fromJson<int>(json['deviceSequence']),
      eventType: serializer.fromJson<String>(json['eventType']),
      payloadVersion: serializer.fromJson<int>(json['payloadVersion']),
      occurrenceTime: serializer.fromJson<DateTime>(json['occurrenceTime']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      contentHash: serializer.fromJson<String>(json['contentHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'deviceId': serializer.toJson<String>(deviceId),
      'deviceSequence': serializer.toJson<int>(deviceSequence),
      'eventType': serializer.toJson<String>(eventType),
      'payloadVersion': serializer.toJson<int>(payloadVersion),
      'occurrenceTime': serializer.toJson<DateTime>(occurrenceTime),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'contentHash': serializer.toJson<String>(contentHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncEvent copyWith({
    String? id,
    String? accountId,
    String? deviceId,
    int? deviceSequence,
    String? eventType,
    int? payloadVersion,
    DateTime? occurrenceTime,
    String? payloadJson,
    String? contentHash,
    DateTime? createdAt,
  }) => SyncEvent(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    deviceId: deviceId ?? this.deviceId,
    deviceSequence: deviceSequence ?? this.deviceSequence,
    eventType: eventType ?? this.eventType,
    payloadVersion: payloadVersion ?? this.payloadVersion,
    occurrenceTime: occurrenceTime ?? this.occurrenceTime,
    payloadJson: payloadJson ?? this.payloadJson,
    contentHash: contentHash ?? this.contentHash,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncEvent copyWithCompanion(SyncEventsCompanion data) {
    return SyncEvent(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      deviceSequence: data.deviceSequence.present
          ? data.deviceSequence.value
          : this.deviceSequence,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      payloadVersion: data.payloadVersion.present
          ? data.payloadVersion.value
          : this.payloadVersion,
      occurrenceTime: data.occurrenceTime.present
          ? data.occurrenceTime.value
          : this.occurrenceTime,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncEvent(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('deviceId: $deviceId, ')
          ..write('deviceSequence: $deviceSequence, ')
          ..write('eventType: $eventType, ')
          ..write('payloadVersion: $payloadVersion, ')
          ..write('occurrenceTime: $occurrenceTime, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('contentHash: $contentHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    deviceId,
    deviceSequence,
    eventType,
    payloadVersion,
    occurrenceTime,
    payloadJson,
    contentHash,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncEvent &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.deviceId == this.deviceId &&
          other.deviceSequence == this.deviceSequence &&
          other.eventType == this.eventType &&
          other.payloadVersion == this.payloadVersion &&
          other.occurrenceTime == this.occurrenceTime &&
          other.payloadJson == this.payloadJson &&
          other.contentHash == this.contentHash &&
          other.createdAt == this.createdAt);
}

class SyncEventsCompanion extends UpdateCompanion<SyncEvent> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> deviceId;
  final Value<int> deviceSequence;
  final Value<String> eventType;
  final Value<int> payloadVersion;
  final Value<DateTime> occurrenceTime;
  final Value<String> payloadJson;
  final Value<String> contentHash;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncEventsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.deviceSequence = const Value.absent(),
    this.eventType = const Value.absent(),
    this.payloadVersion = const Value.absent(),
    this.occurrenceTime = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncEventsCompanion.insert({
    required String id,
    required String accountId,
    required String deviceId,
    required int deviceSequence,
    required String eventType,
    required int payloadVersion,
    required DateTime occurrenceTime,
    required String payloadJson,
    required String contentHash,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       deviceId = Value(deviceId),
       deviceSequence = Value(deviceSequence),
       eventType = Value(eventType),
       payloadVersion = Value(payloadVersion),
       occurrenceTime = Value(occurrenceTime),
       payloadJson = Value(payloadJson),
       contentHash = Value(contentHash),
       createdAt = Value(createdAt);
  static Insertable<SyncEvent> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? deviceId,
    Expression<int>? deviceSequence,
    Expression<String>? eventType,
    Expression<int>? payloadVersion,
    Expression<DateTime>? occurrenceTime,
    Expression<String>? payloadJson,
    Expression<String>? contentHash,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (deviceId != null) 'device_id': deviceId,
      if (deviceSequence != null) 'device_sequence': deviceSequence,
      if (eventType != null) 'event_type': eventType,
      if (payloadVersion != null) 'payload_version': payloadVersion,
      if (occurrenceTime != null) 'occurrence_time': occurrenceTime,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (contentHash != null) 'content_hash': contentHash,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? deviceId,
    Value<int>? deviceSequence,
    Value<String>? eventType,
    Value<int>? payloadVersion,
    Value<DateTime>? occurrenceTime,
    Value<String>? payloadJson,
    Value<String>? contentHash,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SyncEventsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      deviceId: deviceId ?? this.deviceId,
      deviceSequence: deviceSequence ?? this.deviceSequence,
      eventType: eventType ?? this.eventType,
      payloadVersion: payloadVersion ?? this.payloadVersion,
      occurrenceTime: occurrenceTime ?? this.occurrenceTime,
      payloadJson: payloadJson ?? this.payloadJson,
      contentHash: contentHash ?? this.contentHash,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (deviceSequence.present) {
      map['device_sequence'] = Variable<int>(deviceSequence.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (payloadVersion.present) {
      map['payload_version'] = Variable<int>(payloadVersion.value);
    }
    if (occurrenceTime.present) {
      map['occurrence_time'] = Variable<DateTime>(occurrenceTime.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncEventsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('deviceId: $deviceId, ')
          ..write('deviceSequence: $deviceSequence, ')
          ..write('eventType: $eventType, ')
          ..write('payloadVersion: $payloadVersion, ')
          ..write('occurrenceTime: $occurrenceTime, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('contentHash: $contentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingEventsTable extends PendingEvents
    with TableInfo<$PendingEventsTable, PendingEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sync_events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enqueuedAtMeta = const VerificationMeta(
    'enqueuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> enqueuedAt = GeneratedColumn<DateTime>(
    'enqueued_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [eventId, state, enqueuedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('enqueued_at')) {
      context.handle(
        _enqueuedAtMeta,
        enqueuedAt.isAcceptableOrUnknown(data['enqueued_at']!, _enqueuedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_enqueuedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId};
  @override
  PendingEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingEvent(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      enqueuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}enqueued_at'],
      )!,
    );
  }

  @override
  $PendingEventsTable createAlias(String alias) {
    return $PendingEventsTable(attachedDatabase, alias);
  }
}

class PendingEvent extends DataClass implements Insertable<PendingEvent> {
  final String eventId;
  final String state;
  final DateTime enqueuedAt;
  const PendingEvent({
    required this.eventId,
    required this.state,
    required this.enqueuedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['state'] = Variable<String>(state);
    map['enqueued_at'] = Variable<DateTime>(enqueuedAt);
    return map;
  }

  PendingEventsCompanion toCompanion(bool nullToAbsent) {
    return PendingEventsCompanion(
      eventId: Value(eventId),
      state: Value(state),
      enqueuedAt: Value(enqueuedAt),
    );
  }

  factory PendingEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingEvent(
      eventId: serializer.fromJson<String>(json['eventId']),
      state: serializer.fromJson<String>(json['state']),
      enqueuedAt: serializer.fromJson<DateTime>(json['enqueuedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'state': serializer.toJson<String>(state),
      'enqueuedAt': serializer.toJson<DateTime>(enqueuedAt),
    };
  }

  PendingEvent copyWith({
    String? eventId,
    String? state,
    DateTime? enqueuedAt,
  }) => PendingEvent(
    eventId: eventId ?? this.eventId,
    state: state ?? this.state,
    enqueuedAt: enqueuedAt ?? this.enqueuedAt,
  );
  PendingEvent copyWithCompanion(PendingEventsCompanion data) {
    return PendingEvent(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      state: data.state.present ? data.state.value : this.state,
      enqueuedAt: data.enqueuedAt.present
          ? data.enqueuedAt.value
          : this.enqueuedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingEvent(')
          ..write('eventId: $eventId, ')
          ..write('state: $state, ')
          ..write('enqueuedAt: $enqueuedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(eventId, state, enqueuedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingEvent &&
          other.eventId == this.eventId &&
          other.state == this.state &&
          other.enqueuedAt == this.enqueuedAt);
}

class PendingEventsCompanion extends UpdateCompanion<PendingEvent> {
  final Value<String> eventId;
  final Value<String> state;
  final Value<DateTime> enqueuedAt;
  final Value<int> rowid;
  const PendingEventsCompanion({
    this.eventId = const Value.absent(),
    this.state = const Value.absent(),
    this.enqueuedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingEventsCompanion.insert({
    required String eventId,
    required String state,
    required DateTime enqueuedAt,
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       state = Value(state),
       enqueuedAt = Value(enqueuedAt);
  static Insertable<PendingEvent> custom({
    Expression<String>? eventId,
    Expression<String>? state,
    Expression<DateTime>? enqueuedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (state != null) 'state': state,
      if (enqueuedAt != null) 'enqueued_at': enqueuedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingEventsCompanion copyWith({
    Value<String>? eventId,
    Value<String>? state,
    Value<DateTime>? enqueuedAt,
    Value<int>? rowid,
  }) {
    return PendingEventsCompanion(
      eventId: eventId ?? this.eventId,
      state: state ?? this.state,
      enqueuedAt: enqueuedAt ?? this.enqueuedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (enqueuedAt.present) {
      map['enqueued_at'] = Variable<DateTime>(enqueuedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingEventsCompanion(')
          ..write('eventId: $eventId, ')
          ..write('state: $state, ')
          ..write('enqueuedAt: $enqueuedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTable extends SyncState
    with TableInfo<$SyncStateTable, SyncStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _accountCursorMeta = const VerificationMeta(
    'accountCursor',
  );
  @override
  late final GeneratedColumn<String> accountCursor = GeneratedColumn<String>(
    'account_cursor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [accountId, accountCursor, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('account_cursor')) {
      context.handle(
        _accountCursorMeta,
        accountCursor.isAcceptableOrUnknown(
          data['account_cursor']!,
          _accountCursorMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  SyncStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateData(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      accountCursor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_cursor'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncStateTable createAlias(String alias) {
    return $SyncStateTable(attachedDatabase, alias);
  }
}

class SyncStateData extends DataClass implements Insertable<SyncStateData> {
  final String accountId;
  final String? accountCursor;
  final DateTime updatedAt;
  const SyncStateData({
    required this.accountId,
    this.accountCursor,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || accountCursor != null) {
      map['account_cursor'] = Variable<String>(accountCursor);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncStateCompanion toCompanion(bool nullToAbsent) {
    return SyncStateCompanion(
      accountId: Value(accountId),
      accountCursor: accountCursor == null && nullToAbsent
          ? const Value.absent()
          : Value(accountCursor),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateData(
      accountId: serializer.fromJson<String>(json['accountId']),
      accountCursor: serializer.fromJson<String?>(json['accountCursor']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'accountCursor': serializer.toJson<String?>(accountCursor),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncStateData copyWith({
    String? accountId,
    Value<String?> accountCursor = const Value.absent(),
    DateTime? updatedAt,
  }) => SyncStateData(
    accountId: accountId ?? this.accountId,
    accountCursor: accountCursor.present
        ? accountCursor.value
        : this.accountCursor,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncStateData copyWithCompanion(SyncStateCompanion data) {
    return SyncStateData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      accountCursor: data.accountCursor.present
          ? data.accountCursor.value
          : this.accountCursor,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateData(')
          ..write('accountId: $accountId, ')
          ..write('accountCursor: $accountCursor, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, accountCursor, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateData &&
          other.accountId == this.accountId &&
          other.accountCursor == this.accountCursor &&
          other.updatedAt == this.updatedAt);
}

class SyncStateCompanion extends UpdateCompanion<SyncStateData> {
  final Value<String> accountId;
  final Value<String?> accountCursor;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SyncStateCompanion({
    this.accountId = const Value.absent(),
    this.accountCursor = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateCompanion.insert({
    required String accountId,
    this.accountCursor = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       updatedAt = Value(updatedAt);
  static Insertable<SyncStateData> custom({
    Expression<String>? accountId,
    Expression<String>? accountCursor,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (accountCursor != null) 'account_cursor': accountCursor,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateCompanion copyWith({
    Value<String>? accountId,
    Value<String?>? accountCursor,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncStateCompanion(
      accountId: accountId ?? this.accountId,
      accountCursor: accountCursor ?? this.accountCursor,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (accountCursor.present) {
      map['account_cursor'] = Variable<String>(accountCursor.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateCompanion(')
          ..write('accountId: $accountId, ')
          ..write('accountCursor: $accountCursor, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InstallationMetadataTable extends InstallationMetadata
    with TableInfo<$InstallationMetadataTable, InstallationMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallationMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _currentDeviceIdMeta = const VerificationMeta(
    'currentDeviceId',
  );
  @override
  late final GeneratedColumn<String> currentDeviceId = GeneratedColumn<String>(
    'current_device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES devices (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    currentDeviceId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installation_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallationMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('current_device_id')) {
      context.handle(
        _currentDeviceIdMeta,
        currentDeviceId.isAcceptableOrUnknown(
          data['current_device_id']!,
          _currentDeviceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentDeviceIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallationMetadataData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallationMetadataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      currentDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_device_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InstallationMetadataTable createAlias(String alias) {
    return $InstallationMetadataTable(attachedDatabase, alias);
  }
}

class InstallationMetadataData extends DataClass
    implements Insertable<InstallationMetadataData> {
  final String id;
  final String accountId;
  final String currentDeviceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const InstallationMetadataData({
    required this.id,
    required this.accountId,
    required this.currentDeviceId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['current_device_id'] = Variable<String>(currentDeviceId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InstallationMetadataCompanion toCompanion(bool nullToAbsent) {
    return InstallationMetadataCompanion(
      id: Value(id),
      accountId: Value(accountId),
      currentDeviceId: Value(currentDeviceId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InstallationMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallationMetadataData(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      currentDeviceId: serializer.fromJson<String>(json['currentDeviceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'currentDeviceId': serializer.toJson<String>(currentDeviceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InstallationMetadataData copyWith({
    String? id,
    String? accountId,
    String? currentDeviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallationMetadataData(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    currentDeviceId: currentDeviceId ?? this.currentDeviceId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InstallationMetadataData copyWithCompanion(
    InstallationMetadataCompanion data,
  ) {
    return InstallationMetadataData(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      currentDeviceId: data.currentDeviceId.present
          ? data.currentDeviceId.value
          : this.currentDeviceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallationMetadataData(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('currentDeviceId: $currentDeviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, accountId, currentDeviceId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallationMetadataData &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.currentDeviceId == this.currentDeviceId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InstallationMetadataCompanion
    extends UpdateCompanion<InstallationMetadataData> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> currentDeviceId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const InstallationMetadataCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.currentDeviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InstallationMetadataCompanion.insert({
    required String id,
    required String accountId,
    required String currentDeviceId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       currentDeviceId = Value(currentDeviceId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<InstallationMetadataData> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? currentDeviceId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (currentDeviceId != null) 'current_device_id': currentDeviceId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InstallationMetadataCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? currentDeviceId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return InstallationMetadataCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      currentDeviceId: currentDeviceId ?? this.currentDeviceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (currentDeviceId.present) {
      map['current_device_id'] = Variable<String>(currentDeviceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallationMetadataCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('currentDeviceId: $currentDeviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncSubmissionsTable extends SyncSubmissions
    with TableInfo<$SyncSubmissionsTable, SyncSubmission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncSubmissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES devices (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _requestHashMeta = const VerificationMeta(
    'requestHash',
  );
  @override
  late final GeneratedColumn<String> requestHash = GeneratedColumn<String>(
    'request_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>(
        'next_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _leaseUntilMeta = const VerificationMeta(
    'leaseUntil',
  );
  @override
  late final GeneratedColumn<DateTime> leaseUntil = GeneratedColumn<DateTime>(
    'lease_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _responseCodeMeta = const VerificationMeta(
    'responseCode',
  );
  @override
  late final GeneratedColumn<String> responseCode = GeneratedColumn<String>(
    'response_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    deviceId,
    requestHash,
    state,
    attemptCount,
    nextAttemptAt,
    leaseUntil,
    outcome,
    responseCode,
    errorCode,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_submissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncSubmission> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('request_hash')) {
      context.handle(
        _requestHashMeta,
        requestHash.isAcceptableOrUnknown(
          data['request_hash']!,
          _requestHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requestHashMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('lease_until')) {
      context.handle(
        _leaseUntilMeta,
        leaseUntil.isAcceptableOrUnknown(data['lease_until']!, _leaseUntilMeta),
      );
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    }
    if (data.containsKey('response_code')) {
      context.handle(
        _responseCodeMeta,
        responseCode.isAcceptableOrUnknown(
          data['response_code']!,
          _responseCodeMeta,
        ),
      );
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncSubmission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncSubmission(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      requestHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}request_hash'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_attempt_at'],
      ),
      leaseUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}lease_until'],
      ),
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      ),
      responseCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_code'],
      ),
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncSubmissionsTable createAlias(String alias) {
    return $SyncSubmissionsTable(attachedDatabase, alias);
  }
}

class SyncSubmission extends DataClass implements Insertable<SyncSubmission> {
  final String id;
  final String accountId;
  final String deviceId;
  final String requestHash;
  final String state;
  final int attemptCount;
  final DateTime? nextAttemptAt;
  final DateTime? leaseUntil;
  final String? outcome;
  final String? responseCode;
  final String? errorCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SyncSubmission({
    required this.id,
    required this.accountId,
    required this.deviceId,
    required this.requestHash,
    required this.state,
    required this.attemptCount,
    this.nextAttemptAt,
    this.leaseUntil,
    this.outcome,
    this.responseCode,
    this.errorCode,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['device_id'] = Variable<String>(deviceId);
    map['request_hash'] = Variable<String>(requestHash);
    map['state'] = Variable<String>(state);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    if (!nullToAbsent || leaseUntil != null) {
      map['lease_until'] = Variable<DateTime>(leaseUntil);
    }
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<String>(outcome);
    }
    if (!nullToAbsent || responseCode != null) {
      map['response_code'] = Variable<String>(responseCode);
    }
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncSubmissionsCompanion toCompanion(bool nullToAbsent) {
    return SyncSubmissionsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      deviceId: Value(deviceId),
      requestHash: Value(requestHash),
      state: Value(state),
      attemptCount: Value(attemptCount),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
      leaseUntil: leaseUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(leaseUntil),
      outcome: outcome == null && nullToAbsent
          ? const Value.absent()
          : Value(outcome),
      responseCode: responseCode == null && nullToAbsent
          ? const Value.absent()
          : Value(responseCode),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncSubmission.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncSubmission(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      requestHash: serializer.fromJson<String>(json['requestHash']),
      state: serializer.fromJson<String>(json['state']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
      leaseUntil: serializer.fromJson<DateTime?>(json['leaseUntil']),
      outcome: serializer.fromJson<String?>(json['outcome']),
      responseCode: serializer.fromJson<String?>(json['responseCode']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'deviceId': serializer.toJson<String>(deviceId),
      'requestHash': serializer.toJson<String>(requestHash),
      'state': serializer.toJson<String>(state),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
      'leaseUntil': serializer.toJson<DateTime?>(leaseUntil),
      'outcome': serializer.toJson<String?>(outcome),
      'responseCode': serializer.toJson<String?>(responseCode),
      'errorCode': serializer.toJson<String?>(errorCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncSubmission copyWith({
    String? id,
    String? accountId,
    String? deviceId,
    String? requestHash,
    String? state,
    int? attemptCount,
    Value<DateTime?> nextAttemptAt = const Value.absent(),
    Value<DateTime?> leaseUntil = const Value.absent(),
    Value<String?> outcome = const Value.absent(),
    Value<String?> responseCode = const Value.absent(),
    Value<String?> errorCode = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SyncSubmission(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    deviceId: deviceId ?? this.deviceId,
    requestHash: requestHash ?? this.requestHash,
    state: state ?? this.state,
    attemptCount: attemptCount ?? this.attemptCount,
    nextAttemptAt: nextAttemptAt.present
        ? nextAttemptAt.value
        : this.nextAttemptAt,
    leaseUntil: leaseUntil.present ? leaseUntil.value : this.leaseUntil,
    outcome: outcome.present ? outcome.value : this.outcome,
    responseCode: responseCode.present ? responseCode.value : this.responseCode,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncSubmission copyWithCompanion(SyncSubmissionsCompanion data) {
    return SyncSubmission(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      requestHash: data.requestHash.present
          ? data.requestHash.value
          : this.requestHash,
      state: data.state.present ? data.state.value : this.state,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      leaseUntil: data.leaseUntil.present
          ? data.leaseUntil.value
          : this.leaseUntil,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      responseCode: data.responseCode.present
          ? data.responseCode.value
          : this.responseCode,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncSubmission(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('deviceId: $deviceId, ')
          ..write('requestHash: $requestHash, ')
          ..write('state: $state, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('leaseUntil: $leaseUntil, ')
          ..write('outcome: $outcome, ')
          ..write('responseCode: $responseCode, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    deviceId,
    requestHash,
    state,
    attemptCount,
    nextAttemptAt,
    leaseUntil,
    outcome,
    responseCode,
    errorCode,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncSubmission &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.deviceId == this.deviceId &&
          other.requestHash == this.requestHash &&
          other.state == this.state &&
          other.attemptCount == this.attemptCount &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.leaseUntil == this.leaseUntil &&
          other.outcome == this.outcome &&
          other.responseCode == this.responseCode &&
          other.errorCode == this.errorCode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyncSubmissionsCompanion extends UpdateCompanion<SyncSubmission> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> deviceId;
  final Value<String> requestHash;
  final Value<String> state;
  final Value<int> attemptCount;
  final Value<DateTime?> nextAttemptAt;
  final Value<DateTime?> leaseUntil;
  final Value<String?> outcome;
  final Value<String?> responseCode;
  final Value<String?> errorCode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SyncSubmissionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.requestHash = const Value.absent(),
    this.state = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.leaseUntil = const Value.absent(),
    this.outcome = const Value.absent(),
    this.responseCode = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncSubmissionsCompanion.insert({
    required String id,
    required String accountId,
    required String deviceId,
    required String requestHash,
    required String state,
    this.attemptCount = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.leaseUntil = const Value.absent(),
    this.outcome = const Value.absent(),
    this.responseCode = const Value.absent(),
    this.errorCode = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       deviceId = Value(deviceId),
       requestHash = Value(requestHash),
       state = Value(state),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SyncSubmission> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? deviceId,
    Expression<String>? requestHash,
    Expression<String>? state,
    Expression<int>? attemptCount,
    Expression<DateTime>? nextAttemptAt,
    Expression<DateTime>? leaseUntil,
    Expression<String>? outcome,
    Expression<String>? responseCode,
    Expression<String>? errorCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (deviceId != null) 'device_id': deviceId,
      if (requestHash != null) 'request_hash': requestHash,
      if (state != null) 'state': state,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (leaseUntil != null) 'lease_until': leaseUntil,
      if (outcome != null) 'outcome': outcome,
      if (responseCode != null) 'response_code': responseCode,
      if (errorCode != null) 'error_code': errorCode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncSubmissionsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? deviceId,
    Value<String>? requestHash,
    Value<String>? state,
    Value<int>? attemptCount,
    Value<DateTime?>? nextAttemptAt,
    Value<DateTime?>? leaseUntil,
    Value<String?>? outcome,
    Value<String?>? responseCode,
    Value<String?>? errorCode,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncSubmissionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      deviceId: deviceId ?? this.deviceId,
      requestHash: requestHash ?? this.requestHash,
      state: state ?? this.state,
      attemptCount: attemptCount ?? this.attemptCount,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      leaseUntil: leaseUntil ?? this.leaseUntil,
      outcome: outcome ?? this.outcome,
      responseCode: responseCode ?? this.responseCode,
      errorCode: errorCode ?? this.errorCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (requestHash.present) {
      map['request_hash'] = Variable<String>(requestHash.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (leaseUntil.present) {
      map['lease_until'] = Variable<DateTime>(leaseUntil.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (responseCode.present) {
      map['response_code'] = Variable<String>(responseCode.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncSubmissionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('deviceId: $deviceId, ')
          ..write('requestHash: $requestHash, ')
          ..write('state: $state, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('leaseUntil: $leaseUntil, ')
          ..write('outcome: $outcome, ')
          ..write('responseCode: $responseCode, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncSubmissionEventsTable extends SyncSubmissionEvents
    with TableInfo<$SyncSubmissionEventsTable, SyncSubmissionEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncSubmissionEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _submissionIdMeta = const VerificationMeta(
    'submissionId',
  );
  @override
  late final GeneratedColumn<String> submissionId = GeneratedColumn<String>(
    'submission_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sync_submissions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sync_events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [submissionId, eventId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_submission_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncSubmissionEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('submission_id')) {
      context.handle(
        _submissionIdMeta,
        submissionId.isAcceptableOrUnknown(
          data['submission_id']!,
          _submissionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_submissionIdMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {submissionId, eventId};
  @override
  SyncSubmissionEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncSubmissionEvent(
      submissionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}submission_id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $SyncSubmissionEventsTable createAlias(String alias) {
    return $SyncSubmissionEventsTable(attachedDatabase, alias);
  }
}

class SyncSubmissionEvent extends DataClass
    implements Insertable<SyncSubmissionEvent> {
  final String submissionId;
  final String eventId;
  final int position;
  const SyncSubmissionEvent({
    required this.submissionId,
    required this.eventId,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['submission_id'] = Variable<String>(submissionId);
    map['event_id'] = Variable<String>(eventId);
    map['position'] = Variable<int>(position);
    return map;
  }

  SyncSubmissionEventsCompanion toCompanion(bool nullToAbsent) {
    return SyncSubmissionEventsCompanion(
      submissionId: Value(submissionId),
      eventId: Value(eventId),
      position: Value(position),
    );
  }

  factory SyncSubmissionEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncSubmissionEvent(
      submissionId: serializer.fromJson<String>(json['submissionId']),
      eventId: serializer.fromJson<String>(json['eventId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'submissionId': serializer.toJson<String>(submissionId),
      'eventId': serializer.toJson<String>(eventId),
      'position': serializer.toJson<int>(position),
    };
  }

  SyncSubmissionEvent copyWith({
    String? submissionId,
    String? eventId,
    int? position,
  }) => SyncSubmissionEvent(
    submissionId: submissionId ?? this.submissionId,
    eventId: eventId ?? this.eventId,
    position: position ?? this.position,
  );
  SyncSubmissionEvent copyWithCompanion(SyncSubmissionEventsCompanion data) {
    return SyncSubmissionEvent(
      submissionId: data.submissionId.present
          ? data.submissionId.value
          : this.submissionId,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncSubmissionEvent(')
          ..write('submissionId: $submissionId, ')
          ..write('eventId: $eventId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(submissionId, eventId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncSubmissionEvent &&
          other.submissionId == this.submissionId &&
          other.eventId == this.eventId &&
          other.position == this.position);
}

class SyncSubmissionEventsCompanion
    extends UpdateCompanion<SyncSubmissionEvent> {
  final Value<String> submissionId;
  final Value<String> eventId;
  final Value<int> position;
  final Value<int> rowid;
  const SyncSubmissionEventsCompanion({
    this.submissionId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncSubmissionEventsCompanion.insert({
    required String submissionId,
    required String eventId,
    required int position,
    this.rowid = const Value.absent(),
  }) : submissionId = Value(submissionId),
       eventId = Value(eventId),
       position = Value(position);
  static Insertable<SyncSubmissionEvent> custom({
    Expression<String>? submissionId,
    Expression<String>? eventId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (submissionId != null) 'submission_id': submissionId,
      if (eventId != null) 'event_id': eventId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncSubmissionEventsCompanion copyWith({
    Value<String>? submissionId,
    Value<String>? eventId,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return SyncSubmissionEventsCompanion(
      submissionId: submissionId ?? this.submissionId,
      eventId: eventId ?? this.eventId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (submissionId.present) {
      map['submission_id'] = Variable<String>(submissionId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncSubmissionEventsCompanion(')
          ..write('submissionId: $submissionId, ')
          ..write('eventId: $eventId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncInboxTable extends SyncInbox
    with TableInfo<$SyncInboxTable, SyncInboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncInboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverCursorMeta = const VerificationMeta(
    'serverCursor',
  );
  @override
  late final GeneratedColumn<String> serverCursor = GeneratedColumn<String>(
    'server_cursor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appliedAtMeta = const VerificationMeta(
    'appliedAt',
  );
  @override
  late final GeneratedColumn<DateTime> appliedAt = GeneratedColumn<DateTime>(
    'applied_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    eventId,
    contentHash,
    serverCursor,
    state,
    appliedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_inbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncInboxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentHashMeta);
    }
    if (data.containsKey('server_cursor')) {
      context.handle(
        _serverCursorMeta,
        serverCursor.isAcceptableOrUnknown(
          data['server_cursor']!,
          _serverCursorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serverCursorMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('applied_at')) {
      context.handle(
        _appliedAtMeta,
        appliedAt.isAcceptableOrUnknown(data['applied_at']!, _appliedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId, eventId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {accountId, serverCursor},
  ];
  @override
  SyncInboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncInboxData(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      )!,
      serverCursor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_cursor'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      appliedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}applied_at'],
      ),
    );
  }

  @override
  $SyncInboxTable createAlias(String alias) {
    return $SyncInboxTable(attachedDatabase, alias);
  }
}

class SyncInboxData extends DataClass implements Insertable<SyncInboxData> {
  final String accountId;
  final String eventId;
  final String contentHash;
  final String serverCursor;
  final String state;
  final DateTime? appliedAt;
  const SyncInboxData({
    required this.accountId,
    required this.eventId,
    required this.contentHash,
    required this.serverCursor,
    required this.state,
    this.appliedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['event_id'] = Variable<String>(eventId);
    map['content_hash'] = Variable<String>(contentHash);
    map['server_cursor'] = Variable<String>(serverCursor);
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || appliedAt != null) {
      map['applied_at'] = Variable<DateTime>(appliedAt);
    }
    return map;
  }

  SyncInboxCompanion toCompanion(bool nullToAbsent) {
    return SyncInboxCompanion(
      accountId: Value(accountId),
      eventId: Value(eventId),
      contentHash: Value(contentHash),
      serverCursor: Value(serverCursor),
      state: Value(state),
      appliedAt: appliedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(appliedAt),
    );
  }

  factory SyncInboxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncInboxData(
      accountId: serializer.fromJson<String>(json['accountId']),
      eventId: serializer.fromJson<String>(json['eventId']),
      contentHash: serializer.fromJson<String>(json['contentHash']),
      serverCursor: serializer.fromJson<String>(json['serverCursor']),
      state: serializer.fromJson<String>(json['state']),
      appliedAt: serializer.fromJson<DateTime?>(json['appliedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'eventId': serializer.toJson<String>(eventId),
      'contentHash': serializer.toJson<String>(contentHash),
      'serverCursor': serializer.toJson<String>(serverCursor),
      'state': serializer.toJson<String>(state),
      'appliedAt': serializer.toJson<DateTime?>(appliedAt),
    };
  }

  SyncInboxData copyWith({
    String? accountId,
    String? eventId,
    String? contentHash,
    String? serverCursor,
    String? state,
    Value<DateTime?> appliedAt = const Value.absent(),
  }) => SyncInboxData(
    accountId: accountId ?? this.accountId,
    eventId: eventId ?? this.eventId,
    contentHash: contentHash ?? this.contentHash,
    serverCursor: serverCursor ?? this.serverCursor,
    state: state ?? this.state,
    appliedAt: appliedAt.present ? appliedAt.value : this.appliedAt,
  );
  SyncInboxData copyWithCompanion(SyncInboxCompanion data) {
    return SyncInboxData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      serverCursor: data.serverCursor.present
          ? data.serverCursor.value
          : this.serverCursor,
      state: data.state.present ? data.state.value : this.state,
      appliedAt: data.appliedAt.present ? data.appliedAt.value : this.appliedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncInboxData(')
          ..write('accountId: $accountId, ')
          ..write('eventId: $eventId, ')
          ..write('contentHash: $contentHash, ')
          ..write('serverCursor: $serverCursor, ')
          ..write('state: $state, ')
          ..write('appliedAt: $appliedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    eventId,
    contentHash,
    serverCursor,
    state,
    appliedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncInboxData &&
          other.accountId == this.accountId &&
          other.eventId == this.eventId &&
          other.contentHash == this.contentHash &&
          other.serverCursor == this.serverCursor &&
          other.state == this.state &&
          other.appliedAt == this.appliedAt);
}

class SyncInboxCompanion extends UpdateCompanion<SyncInboxData> {
  final Value<String> accountId;
  final Value<String> eventId;
  final Value<String> contentHash;
  final Value<String> serverCursor;
  final Value<String> state;
  final Value<DateTime?> appliedAt;
  final Value<int> rowid;
  const SyncInboxCompanion({
    this.accountId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.serverCursor = const Value.absent(),
    this.state = const Value.absent(),
    this.appliedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncInboxCompanion.insert({
    required String accountId,
    required String eventId,
    required String contentHash,
    required String serverCursor,
    required String state,
    this.appliedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       eventId = Value(eventId),
       contentHash = Value(contentHash),
       serverCursor = Value(serverCursor),
       state = Value(state);
  static Insertable<SyncInboxData> custom({
    Expression<String>? accountId,
    Expression<String>? eventId,
    Expression<String>? contentHash,
    Expression<String>? serverCursor,
    Expression<String>? state,
    Expression<DateTime>? appliedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (eventId != null) 'event_id': eventId,
      if (contentHash != null) 'content_hash': contentHash,
      if (serverCursor != null) 'server_cursor': serverCursor,
      if (state != null) 'state': state,
      if (appliedAt != null) 'applied_at': appliedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncInboxCompanion copyWith({
    Value<String>? accountId,
    Value<String>? eventId,
    Value<String>? contentHash,
    Value<String>? serverCursor,
    Value<String>? state,
    Value<DateTime?>? appliedAt,
    Value<int>? rowid,
  }) {
    return SyncInboxCompanion(
      accountId: accountId ?? this.accountId,
      eventId: eventId ?? this.eventId,
      contentHash: contentHash ?? this.contentHash,
      serverCursor: serverCursor ?? this.serverCursor,
      state: state ?? this.state,
      appliedAt: appliedAt ?? this.appliedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (serverCursor.present) {
      map['server_cursor'] = Variable<String>(serverCursor.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (appliedAt.present) {
      map['applied_at'] = Variable<DateTime>(appliedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncInboxCompanion(')
          ..write('accountId: $accountId, ')
          ..write('eventId: $eventId, ')
          ..write('contentHash: $contentHash, ')
          ..write('serverCursor: $serverCursor, ')
          ..write('state: $state, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecoverySessionsTable extends RecoverySessions
    with TableInfo<$RecoverySessionsTable, RecoverySession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecoverySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotIdMeta = const VerificationMeta(
    'snapshotId',
  );
  @override
  late final GeneratedColumn<String> snapshotId = GeneratedColumn<String>(
    'snapshot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phaseMeta = const VerificationMeta('phase');
  @override
  late final GeneratedColumn<String> phase = GeneratedColumn<String>(
    'phase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formatVersionMeta = const VerificationMeta(
    'formatVersion',
  );
  @override
  late final GeneratedColumn<int> formatVersion = GeneratedColumn<int>(
    'format_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _manifestHashMeta = const VerificationMeta(
    'manifestHash',
  );
  @override
  late final GeneratedColumn<String> manifestHash = GeneratedColumn<String>(
    'manifest_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coveredThroughCursorMeta =
      const VerificationMeta('coveredThroughCursor');
  @override
  late final GeneratedColumn<String> coveredThroughCursor =
      GeneratedColumn<String>(
        'covered_through_cursor',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    snapshotId,
    phase,
    formatVersion,
    manifestHash,
    coveredThroughCursor,
    expiresAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recovery_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecoverySession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('snapshot_id')) {
      context.handle(
        _snapshotIdMeta,
        snapshotId.isAcceptableOrUnknown(data['snapshot_id']!, _snapshotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_snapshotIdMeta);
    }
    if (data.containsKey('phase')) {
      context.handle(
        _phaseMeta,
        phase.isAcceptableOrUnknown(data['phase']!, _phaseMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseMeta);
    }
    if (data.containsKey('format_version')) {
      context.handle(
        _formatVersionMeta,
        formatVersion.isAcceptableOrUnknown(
          data['format_version']!,
          _formatVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_formatVersionMeta);
    }
    if (data.containsKey('manifest_hash')) {
      context.handle(
        _manifestHashMeta,
        manifestHash.isAcceptableOrUnknown(
          data['manifest_hash']!,
          _manifestHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_manifestHashMeta);
    }
    if (data.containsKey('covered_through_cursor')) {
      context.handle(
        _coveredThroughCursorMeta,
        coveredThroughCursor.isAcceptableOrUnknown(
          data['covered_through_cursor']!,
          _coveredThroughCursorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coveredThroughCursorMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecoverySession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecoverySession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      snapshotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot_id'],
      )!,
      phase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phase'],
      )!,
      formatVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}format_version'],
      )!,
      manifestHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manifest_hash'],
      )!,
      coveredThroughCursor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}covered_through_cursor'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RecoverySessionsTable createAlias(String alias) {
    return $RecoverySessionsTable(attachedDatabase, alias);
  }
}

class RecoverySession extends DataClass implements Insertable<RecoverySession> {
  final String id;
  final String accountId;
  final String snapshotId;
  final String phase;
  final int formatVersion;
  final String manifestHash;
  final String coveredThroughCursor;
  final DateTime expiresAt;
  final DateTime updatedAt;
  const RecoverySession({
    required this.id,
    required this.accountId,
    required this.snapshotId,
    required this.phase,
    required this.formatVersion,
    required this.manifestHash,
    required this.coveredThroughCursor,
    required this.expiresAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['snapshot_id'] = Variable<String>(snapshotId);
    map['phase'] = Variable<String>(phase);
    map['format_version'] = Variable<int>(formatVersion);
    map['manifest_hash'] = Variable<String>(manifestHash);
    map['covered_through_cursor'] = Variable<String>(coveredThroughCursor);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecoverySessionsCompanion toCompanion(bool nullToAbsent) {
    return RecoverySessionsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      snapshotId: Value(snapshotId),
      phase: Value(phase),
      formatVersion: Value(formatVersion),
      manifestHash: Value(manifestHash),
      coveredThroughCursor: Value(coveredThroughCursor),
      expiresAt: Value(expiresAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecoverySession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecoverySession(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      snapshotId: serializer.fromJson<String>(json['snapshotId']),
      phase: serializer.fromJson<String>(json['phase']),
      formatVersion: serializer.fromJson<int>(json['formatVersion']),
      manifestHash: serializer.fromJson<String>(json['manifestHash']),
      coveredThroughCursor: serializer.fromJson<String>(
        json['coveredThroughCursor'],
      ),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'snapshotId': serializer.toJson<String>(snapshotId),
      'phase': serializer.toJson<String>(phase),
      'formatVersion': serializer.toJson<int>(formatVersion),
      'manifestHash': serializer.toJson<String>(manifestHash),
      'coveredThroughCursor': serializer.toJson<String>(coveredThroughCursor),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecoverySession copyWith({
    String? id,
    String? accountId,
    String? snapshotId,
    String? phase,
    int? formatVersion,
    String? manifestHash,
    String? coveredThroughCursor,
    DateTime? expiresAt,
    DateTime? updatedAt,
  }) => RecoverySession(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    snapshotId: snapshotId ?? this.snapshotId,
    phase: phase ?? this.phase,
    formatVersion: formatVersion ?? this.formatVersion,
    manifestHash: manifestHash ?? this.manifestHash,
    coveredThroughCursor: coveredThroughCursor ?? this.coveredThroughCursor,
    expiresAt: expiresAt ?? this.expiresAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RecoverySession copyWithCompanion(RecoverySessionsCompanion data) {
    return RecoverySession(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      snapshotId: data.snapshotId.present
          ? data.snapshotId.value
          : this.snapshotId,
      phase: data.phase.present ? data.phase.value : this.phase,
      formatVersion: data.formatVersion.present
          ? data.formatVersion.value
          : this.formatVersion,
      manifestHash: data.manifestHash.present
          ? data.manifestHash.value
          : this.manifestHash,
      coveredThroughCursor: data.coveredThroughCursor.present
          ? data.coveredThroughCursor.value
          : this.coveredThroughCursor,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecoverySession(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('snapshotId: $snapshotId, ')
          ..write('phase: $phase, ')
          ..write('formatVersion: $formatVersion, ')
          ..write('manifestHash: $manifestHash, ')
          ..write('coveredThroughCursor: $coveredThroughCursor, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    snapshotId,
    phase,
    formatVersion,
    manifestHash,
    coveredThroughCursor,
    expiresAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecoverySession &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.snapshotId == this.snapshotId &&
          other.phase == this.phase &&
          other.formatVersion == this.formatVersion &&
          other.manifestHash == this.manifestHash &&
          other.coveredThroughCursor == this.coveredThroughCursor &&
          other.expiresAt == this.expiresAt &&
          other.updatedAt == this.updatedAt);
}

class RecoverySessionsCompanion extends UpdateCompanion<RecoverySession> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> snapshotId;
  final Value<String> phase;
  final Value<int> formatVersion;
  final Value<String> manifestHash;
  final Value<String> coveredThroughCursor;
  final Value<DateTime> expiresAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RecoverySessionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.snapshotId = const Value.absent(),
    this.phase = const Value.absent(),
    this.formatVersion = const Value.absent(),
    this.manifestHash = const Value.absent(),
    this.coveredThroughCursor = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecoverySessionsCompanion.insert({
    required String id,
    required String accountId,
    required String snapshotId,
    required String phase,
    required int formatVersion,
    required String manifestHash,
    required String coveredThroughCursor,
    required DateTime expiresAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       snapshotId = Value(snapshotId),
       phase = Value(phase),
       formatVersion = Value(formatVersion),
       manifestHash = Value(manifestHash),
       coveredThroughCursor = Value(coveredThroughCursor),
       expiresAt = Value(expiresAt),
       updatedAt = Value(updatedAt);
  static Insertable<RecoverySession> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? snapshotId,
    Expression<String>? phase,
    Expression<int>? formatVersion,
    Expression<String>? manifestHash,
    Expression<String>? coveredThroughCursor,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (snapshotId != null) 'snapshot_id': snapshotId,
      if (phase != null) 'phase': phase,
      if (formatVersion != null) 'format_version': formatVersion,
      if (manifestHash != null) 'manifest_hash': manifestHash,
      if (coveredThroughCursor != null)
        'covered_through_cursor': coveredThroughCursor,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecoverySessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? snapshotId,
    Value<String>? phase,
    Value<int>? formatVersion,
    Value<String>? manifestHash,
    Value<String>? coveredThroughCursor,
    Value<DateTime>? expiresAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RecoverySessionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      snapshotId: snapshotId ?? this.snapshotId,
      phase: phase ?? this.phase,
      formatVersion: formatVersion ?? this.formatVersion,
      manifestHash: manifestHash ?? this.manifestHash,
      coveredThroughCursor: coveredThroughCursor ?? this.coveredThroughCursor,
      expiresAt: expiresAt ?? this.expiresAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (snapshotId.present) {
      map['snapshot_id'] = Variable<String>(snapshotId.value);
    }
    if (phase.present) {
      map['phase'] = Variable<String>(phase.value);
    }
    if (formatVersion.present) {
      map['format_version'] = Variable<int>(formatVersion.value);
    }
    if (manifestHash.present) {
      map['manifest_hash'] = Variable<String>(manifestHash.value);
    }
    if (coveredThroughCursor.present) {
      map['covered_through_cursor'] = Variable<String>(
        coveredThroughCursor.value,
      );
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecoverySessionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('snapshotId: $snapshotId, ')
          ..write('phase: $phase, ')
          ..write('formatVersion: $formatVersion, ')
          ..write('manifestHash: $manifestHash, ')
          ..write('coveredThroughCursor: $coveredThroughCursor, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecoveryChunksTable extends RecoveryChunks
    with TableInfo<$RecoveryChunksTable, RecoveryChunk> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecoveryChunksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recovery_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _chunkIndexMeta = const VerificationMeta(
    'chunkIndex',
  );
  @override
  late final GeneratedColumn<int> chunkIndex = GeneratedColumn<int>(
    'chunk_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _byteLengthMeta = const VerificationMeta(
    'byteLength',
  );
  @override
  late final GeneratedColumn<int> byteLength = GeneratedColumn<int>(
    'byte_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bytesMeta = const VerificationMeta('bytes');
  @override
  late final GeneratedColumn<Uint8List> bytes = GeneratedColumn<Uint8List>(
    'bytes',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verifiedAtMeta = const VerificationMeta(
    'verifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> verifiedAt = GeneratedColumn<DateTime>(
    'verified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sessionId,
    chunkIndex,
    byteLength,
    contentHash,
    bytes,
    verifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recovery_chunks';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecoveryChunk> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('chunk_index')) {
      context.handle(
        _chunkIndexMeta,
        chunkIndex.isAcceptableOrUnknown(data['chunk_index']!, _chunkIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_chunkIndexMeta);
    }
    if (data.containsKey('byte_length')) {
      context.handle(
        _byteLengthMeta,
        byteLength.isAcceptableOrUnknown(data['byte_length']!, _byteLengthMeta),
      );
    } else if (isInserting) {
      context.missing(_byteLengthMeta);
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentHashMeta);
    }
    if (data.containsKey('bytes')) {
      context.handle(
        _bytesMeta,
        bytes.isAcceptableOrUnknown(data['bytes']!, _bytesMeta),
      );
    } else if (isInserting) {
      context.missing(_bytesMeta);
    }
    if (data.containsKey('verified_at')) {
      context.handle(
        _verifiedAtMeta,
        verifiedAt.isAcceptableOrUnknown(data['verified_at']!, _verifiedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_verifiedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId, chunkIndex};
  @override
  RecoveryChunk map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecoveryChunk(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      chunkIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chunk_index'],
      )!,
      byteLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}byte_length'],
      )!,
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      )!,
      bytes: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}bytes'],
      )!,
      verifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}verified_at'],
      )!,
    );
  }

  @override
  $RecoveryChunksTable createAlias(String alias) {
    return $RecoveryChunksTable(attachedDatabase, alias);
  }
}

class RecoveryChunk extends DataClass implements Insertable<RecoveryChunk> {
  final String sessionId;
  final int chunkIndex;
  final int byteLength;
  final String contentHash;
  final Uint8List bytes;
  final DateTime verifiedAt;
  const RecoveryChunk({
    required this.sessionId,
    required this.chunkIndex,
    required this.byteLength,
    required this.contentHash,
    required this.bytes,
    required this.verifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['chunk_index'] = Variable<int>(chunkIndex);
    map['byte_length'] = Variable<int>(byteLength);
    map['content_hash'] = Variable<String>(contentHash);
    map['bytes'] = Variable<Uint8List>(bytes);
    map['verified_at'] = Variable<DateTime>(verifiedAt);
    return map;
  }

  RecoveryChunksCompanion toCompanion(bool nullToAbsent) {
    return RecoveryChunksCompanion(
      sessionId: Value(sessionId),
      chunkIndex: Value(chunkIndex),
      byteLength: Value(byteLength),
      contentHash: Value(contentHash),
      bytes: Value(bytes),
      verifiedAt: Value(verifiedAt),
    );
  }

  factory RecoveryChunk.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecoveryChunk(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      chunkIndex: serializer.fromJson<int>(json['chunkIndex']),
      byteLength: serializer.fromJson<int>(json['byteLength']),
      contentHash: serializer.fromJson<String>(json['contentHash']),
      bytes: serializer.fromJson<Uint8List>(json['bytes']),
      verifiedAt: serializer.fromJson<DateTime>(json['verifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'chunkIndex': serializer.toJson<int>(chunkIndex),
      'byteLength': serializer.toJson<int>(byteLength),
      'contentHash': serializer.toJson<String>(contentHash),
      'bytes': serializer.toJson<Uint8List>(bytes),
      'verifiedAt': serializer.toJson<DateTime>(verifiedAt),
    };
  }

  RecoveryChunk copyWith({
    String? sessionId,
    int? chunkIndex,
    int? byteLength,
    String? contentHash,
    Uint8List? bytes,
    DateTime? verifiedAt,
  }) => RecoveryChunk(
    sessionId: sessionId ?? this.sessionId,
    chunkIndex: chunkIndex ?? this.chunkIndex,
    byteLength: byteLength ?? this.byteLength,
    contentHash: contentHash ?? this.contentHash,
    bytes: bytes ?? this.bytes,
    verifiedAt: verifiedAt ?? this.verifiedAt,
  );
  RecoveryChunk copyWithCompanion(RecoveryChunksCompanion data) {
    return RecoveryChunk(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      chunkIndex: data.chunkIndex.present
          ? data.chunkIndex.value
          : this.chunkIndex,
      byteLength: data.byteLength.present
          ? data.byteLength.value
          : this.byteLength,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      bytes: data.bytes.present ? data.bytes.value : this.bytes,
      verifiedAt: data.verifiedAt.present
          ? data.verifiedAt.value
          : this.verifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryChunk(')
          ..write('sessionId: $sessionId, ')
          ..write('chunkIndex: $chunkIndex, ')
          ..write('byteLength: $byteLength, ')
          ..write('contentHash: $contentHash, ')
          ..write('bytes: $bytes, ')
          ..write('verifiedAt: $verifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    sessionId,
    chunkIndex,
    byteLength,
    contentHash,
    $driftBlobEquality.hash(bytes),
    verifiedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecoveryChunk &&
          other.sessionId == this.sessionId &&
          other.chunkIndex == this.chunkIndex &&
          other.byteLength == this.byteLength &&
          other.contentHash == this.contentHash &&
          $driftBlobEquality.equals(other.bytes, this.bytes) &&
          other.verifiedAt == this.verifiedAt);
}

class RecoveryChunksCompanion extends UpdateCompanion<RecoveryChunk> {
  final Value<String> sessionId;
  final Value<int> chunkIndex;
  final Value<int> byteLength;
  final Value<String> contentHash;
  final Value<Uint8List> bytes;
  final Value<DateTime> verifiedAt;
  final Value<int> rowid;
  const RecoveryChunksCompanion({
    this.sessionId = const Value.absent(),
    this.chunkIndex = const Value.absent(),
    this.byteLength = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.bytes = const Value.absent(),
    this.verifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecoveryChunksCompanion.insert({
    required String sessionId,
    required int chunkIndex,
    required int byteLength,
    required String contentHash,
    required Uint8List bytes,
    required DateTime verifiedAt,
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       chunkIndex = Value(chunkIndex),
       byteLength = Value(byteLength),
       contentHash = Value(contentHash),
       bytes = Value(bytes),
       verifiedAt = Value(verifiedAt);
  static Insertable<RecoveryChunk> custom({
    Expression<String>? sessionId,
    Expression<int>? chunkIndex,
    Expression<int>? byteLength,
    Expression<String>? contentHash,
    Expression<Uint8List>? bytes,
    Expression<DateTime>? verifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (chunkIndex != null) 'chunk_index': chunkIndex,
      if (byteLength != null) 'byte_length': byteLength,
      if (contentHash != null) 'content_hash': contentHash,
      if (bytes != null) 'bytes': bytes,
      if (verifiedAt != null) 'verified_at': verifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecoveryChunksCompanion copyWith({
    Value<String>? sessionId,
    Value<int>? chunkIndex,
    Value<int>? byteLength,
    Value<String>? contentHash,
    Value<Uint8List>? bytes,
    Value<DateTime>? verifiedAt,
    Value<int>? rowid,
  }) {
    return RecoveryChunksCompanion(
      sessionId: sessionId ?? this.sessionId,
      chunkIndex: chunkIndex ?? this.chunkIndex,
      byteLength: byteLength ?? this.byteLength,
      contentHash: contentHash ?? this.contentHash,
      bytes: bytes ?? this.bytes,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (chunkIndex.present) {
      map['chunk_index'] = Variable<int>(chunkIndex.value);
    }
    if (byteLength.present) {
      map['byte_length'] = Variable<int>(byteLength.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (bytes.present) {
      map['bytes'] = Variable<Uint8List>(bytes.value);
    }
    if (verifiedAt.present) {
      map['verified_at'] = Variable<DateTime>(verifiedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryChunksCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('chunkIndex: $chunkIndex, ')
          ..write('byteLength: $byteLength, ')
          ..write('contentHash: $contentHash, ')
          ..write('bytes: $bytes, ')
          ..write('verifiedAt: $verifiedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HostedAuthStatesTable extends HostedAuthStates
    with TableInfo<$HostedAuthStatesTable, HostedAuthState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HostedAuthStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _environmentAliasMeta = const VerificationMeta(
    'environmentAlias',
  );
  @override
  late final GeneratedColumn<String> environmentAlias = GeneratedColumn<String>(
    'environment_alias',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installationIdMeta = const VerificationMeta(
    'installationId',
  );
  @override
  late final GeneratedColumn<String> installationId = GeneratedColumn<String>(
    'installation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enrollmentRequestIdMeta =
      const VerificationMeta('enrollmentRequestId');
  @override
  late final GeneratedColumn<String> enrollmentRequestId =
      GeneratedColumn<String>(
        'enrollment_request_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _enrollmentStateMeta = const VerificationMeta(
    'enrollmentState',
  );
  @override
  late final GeneratedColumn<String> enrollmentState = GeneratedColumn<String>(
    'enrollment_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverDeviceIdMeta = const VerificationMeta(
    'serverDeviceId',
  );
  @override
  late final GeneratedColumn<String> serverDeviceId = GeneratedColumn<String>(
    'server_device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generationMeta = const VerificationMeta(
    'generation',
  );
  @override
  late final GeneratedColumn<int> generation = GeneratedColumn<int>(
    'generation',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    environmentAlias,
    installationId,
    enrollmentRequestId,
    enrollmentState,
    accountId,
    serverDeviceId,
    generation,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hosted_auth_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<HostedAuthState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('environment_alias')) {
      context.handle(
        _environmentAliasMeta,
        environmentAlias.isAcceptableOrUnknown(
          data['environment_alias']!,
          _environmentAliasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_environmentAliasMeta);
    }
    if (data.containsKey('installation_id')) {
      context.handle(
        _installationIdMeta,
        installationId.isAcceptableOrUnknown(
          data['installation_id']!,
          _installationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installationIdMeta);
    }
    if (data.containsKey('enrollment_request_id')) {
      context.handle(
        _enrollmentRequestIdMeta,
        enrollmentRequestId.isAcceptableOrUnknown(
          data['enrollment_request_id']!,
          _enrollmentRequestIdMeta,
        ),
      );
    }
    if (data.containsKey('enrollment_state')) {
      context.handle(
        _enrollmentStateMeta,
        enrollmentState.isAcceptableOrUnknown(
          data['enrollment_state']!,
          _enrollmentStateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enrollmentStateMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('server_device_id')) {
      context.handle(
        _serverDeviceIdMeta,
        serverDeviceId.isAcceptableOrUnknown(
          data['server_device_id']!,
          _serverDeviceIdMeta,
        ),
      );
    }
    if (data.containsKey('generation')) {
      context.handle(
        _generationMeta,
        generation.isAcceptableOrUnknown(data['generation']!, _generationMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {environmentAlias};
  @override
  HostedAuthState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HostedAuthState(
      environmentAlias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}environment_alias'],
      )!,
      installationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installation_id'],
      )!,
      enrollmentRequestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enrollment_request_id'],
      ),
      enrollmentState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enrollment_state'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      serverDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_device_id'],
      ),
      generation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HostedAuthStatesTable createAlias(String alias) {
    return $HostedAuthStatesTable(attachedDatabase, alias);
  }
}

class HostedAuthState extends DataClass implements Insertable<HostedAuthState> {
  final String environmentAlias;
  final String installationId;
  final String? enrollmentRequestId;
  final String enrollmentState;
  final String? accountId;
  final String? serverDeviceId;
  final int? generation;
  final DateTime updatedAt;
  const HostedAuthState({
    required this.environmentAlias,
    required this.installationId,
    this.enrollmentRequestId,
    required this.enrollmentState,
    this.accountId,
    this.serverDeviceId,
    this.generation,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['environment_alias'] = Variable<String>(environmentAlias);
    map['installation_id'] = Variable<String>(installationId);
    if (!nullToAbsent || enrollmentRequestId != null) {
      map['enrollment_request_id'] = Variable<String>(enrollmentRequestId);
    }
    map['enrollment_state'] = Variable<String>(enrollmentState);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || serverDeviceId != null) {
      map['server_device_id'] = Variable<String>(serverDeviceId);
    }
    if (!nullToAbsent || generation != null) {
      map['generation'] = Variable<int>(generation);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HostedAuthStatesCompanion toCompanion(bool nullToAbsent) {
    return HostedAuthStatesCompanion(
      environmentAlias: Value(environmentAlias),
      installationId: Value(installationId),
      enrollmentRequestId: enrollmentRequestId == null && nullToAbsent
          ? const Value.absent()
          : Value(enrollmentRequestId),
      enrollmentState: Value(enrollmentState),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      serverDeviceId: serverDeviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverDeviceId),
      generation: generation == null && nullToAbsent
          ? const Value.absent()
          : Value(generation),
      updatedAt: Value(updatedAt),
    );
  }

  factory HostedAuthState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HostedAuthState(
      environmentAlias: serializer.fromJson<String>(json['environmentAlias']),
      installationId: serializer.fromJson<String>(json['installationId']),
      enrollmentRequestId: serializer.fromJson<String?>(
        json['enrollmentRequestId'],
      ),
      enrollmentState: serializer.fromJson<String>(json['enrollmentState']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      serverDeviceId: serializer.fromJson<String?>(json['serverDeviceId']),
      generation: serializer.fromJson<int?>(json['generation']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'environmentAlias': serializer.toJson<String>(environmentAlias),
      'installationId': serializer.toJson<String>(installationId),
      'enrollmentRequestId': serializer.toJson<String?>(enrollmentRequestId),
      'enrollmentState': serializer.toJson<String>(enrollmentState),
      'accountId': serializer.toJson<String?>(accountId),
      'serverDeviceId': serializer.toJson<String?>(serverDeviceId),
      'generation': serializer.toJson<int?>(generation),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HostedAuthState copyWith({
    String? environmentAlias,
    String? installationId,
    Value<String?> enrollmentRequestId = const Value.absent(),
    String? enrollmentState,
    Value<String?> accountId = const Value.absent(),
    Value<String?> serverDeviceId = const Value.absent(),
    Value<int?> generation = const Value.absent(),
    DateTime? updatedAt,
  }) => HostedAuthState(
    environmentAlias: environmentAlias ?? this.environmentAlias,
    installationId: installationId ?? this.installationId,
    enrollmentRequestId: enrollmentRequestId.present
        ? enrollmentRequestId.value
        : this.enrollmentRequestId,
    enrollmentState: enrollmentState ?? this.enrollmentState,
    accountId: accountId.present ? accountId.value : this.accountId,
    serverDeviceId: serverDeviceId.present
        ? serverDeviceId.value
        : this.serverDeviceId,
    generation: generation.present ? generation.value : this.generation,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HostedAuthState copyWithCompanion(HostedAuthStatesCompanion data) {
    return HostedAuthState(
      environmentAlias: data.environmentAlias.present
          ? data.environmentAlias.value
          : this.environmentAlias,
      installationId: data.installationId.present
          ? data.installationId.value
          : this.installationId,
      enrollmentRequestId: data.enrollmentRequestId.present
          ? data.enrollmentRequestId.value
          : this.enrollmentRequestId,
      enrollmentState: data.enrollmentState.present
          ? data.enrollmentState.value
          : this.enrollmentState,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      serverDeviceId: data.serverDeviceId.present
          ? data.serverDeviceId.value
          : this.serverDeviceId,
      generation: data.generation.present
          ? data.generation.value
          : this.generation,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HostedAuthState(')
          ..write('environmentAlias: $environmentAlias, ')
          ..write('installationId: $installationId, ')
          ..write('enrollmentRequestId: $enrollmentRequestId, ')
          ..write('enrollmentState: $enrollmentState, ')
          ..write('accountId: $accountId, ')
          ..write('serverDeviceId: $serverDeviceId, ')
          ..write('generation: $generation, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    environmentAlias,
    installationId,
    enrollmentRequestId,
    enrollmentState,
    accountId,
    serverDeviceId,
    generation,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HostedAuthState &&
          other.environmentAlias == this.environmentAlias &&
          other.installationId == this.installationId &&
          other.enrollmentRequestId == this.enrollmentRequestId &&
          other.enrollmentState == this.enrollmentState &&
          other.accountId == this.accountId &&
          other.serverDeviceId == this.serverDeviceId &&
          other.generation == this.generation &&
          other.updatedAt == this.updatedAt);
}

class HostedAuthStatesCompanion extends UpdateCompanion<HostedAuthState> {
  final Value<String> environmentAlias;
  final Value<String> installationId;
  final Value<String?> enrollmentRequestId;
  final Value<String> enrollmentState;
  final Value<String?> accountId;
  final Value<String?> serverDeviceId;
  final Value<int?> generation;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HostedAuthStatesCompanion({
    this.environmentAlias = const Value.absent(),
    this.installationId = const Value.absent(),
    this.enrollmentRequestId = const Value.absent(),
    this.enrollmentState = const Value.absent(),
    this.accountId = const Value.absent(),
    this.serverDeviceId = const Value.absent(),
    this.generation = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HostedAuthStatesCompanion.insert({
    required String environmentAlias,
    required String installationId,
    this.enrollmentRequestId = const Value.absent(),
    required String enrollmentState,
    this.accountId = const Value.absent(),
    this.serverDeviceId = const Value.absent(),
    this.generation = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : environmentAlias = Value(environmentAlias),
       installationId = Value(installationId),
       enrollmentState = Value(enrollmentState),
       updatedAt = Value(updatedAt);
  static Insertable<HostedAuthState> custom({
    Expression<String>? environmentAlias,
    Expression<String>? installationId,
    Expression<String>? enrollmentRequestId,
    Expression<String>? enrollmentState,
    Expression<String>? accountId,
    Expression<String>? serverDeviceId,
    Expression<int>? generation,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (environmentAlias != null) 'environment_alias': environmentAlias,
      if (installationId != null) 'installation_id': installationId,
      if (enrollmentRequestId != null)
        'enrollment_request_id': enrollmentRequestId,
      if (enrollmentState != null) 'enrollment_state': enrollmentState,
      if (accountId != null) 'account_id': accountId,
      if (serverDeviceId != null) 'server_device_id': serverDeviceId,
      if (generation != null) 'generation': generation,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HostedAuthStatesCompanion copyWith({
    Value<String>? environmentAlias,
    Value<String>? installationId,
    Value<String?>? enrollmentRequestId,
    Value<String>? enrollmentState,
    Value<String?>? accountId,
    Value<String?>? serverDeviceId,
    Value<int?>? generation,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HostedAuthStatesCompanion(
      environmentAlias: environmentAlias ?? this.environmentAlias,
      installationId: installationId ?? this.installationId,
      enrollmentRequestId: enrollmentRequestId ?? this.enrollmentRequestId,
      enrollmentState: enrollmentState ?? this.enrollmentState,
      accountId: accountId ?? this.accountId,
      serverDeviceId: serverDeviceId ?? this.serverDeviceId,
      generation: generation ?? this.generation,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (environmentAlias.present) {
      map['environment_alias'] = Variable<String>(environmentAlias.value);
    }
    if (installationId.present) {
      map['installation_id'] = Variable<String>(installationId.value);
    }
    if (enrollmentRequestId.present) {
      map['enrollment_request_id'] = Variable<String>(
        enrollmentRequestId.value,
      );
    }
    if (enrollmentState.present) {
      map['enrollment_state'] = Variable<String>(enrollmentState.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (serverDeviceId.present) {
      map['server_device_id'] = Variable<String>(serverDeviceId.value);
    }
    if (generation.present) {
      map['generation'] = Variable<int>(generation.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HostedAuthStatesCompanion(')
          ..write('environmentAlias: $environmentAlias, ')
          ..write('installationId: $installationId, ')
          ..write('enrollmentRequestId: $enrollmentRequestId, ')
          ..write('enrollmentState: $enrollmentState, ')
          ..write('accountId: $accountId, ')
          ..write('serverDeviceId: $serverDeviceId, ')
          ..write('generation: $generation, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MigrationLedgerTable extends MigrationLedger
    with TableInfo<$MigrationLedgerTable, MigrationLedgerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MigrationLedgerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _schemaNameMeta = const VerificationMeta(
    'schemaName',
  );
  @override
  late final GeneratedColumn<String> schemaName = GeneratedColumn<String>(
    'schema_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schemaVersionMeta = const VerificationMeta(
    'schemaVersion',
  );
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
    'schema_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromVersionMeta = const VerificationMeta(
    'fromVersion',
  );
  @override
  late final GeneratedColumn<int> fromVersion = GeneratedColumn<int>(
    'from_version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toVersionMeta = const VerificationMeta(
    'toVersion',
  );
  @override
  late final GeneratedColumn<int> toVersion = GeneratedColumn<int>(
    'to_version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _migrationIdMeta = const VerificationMeta(
    'migrationId',
  );
  @override
  late final GeneratedColumn<String> migrationId = GeneratedColumn<String>(
    'migration_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appliedAtMeta = const VerificationMeta(
    'appliedAt',
  );
  @override
  late final GeneratedColumn<DateTime> appliedAt = GeneratedColumn<DateTime>(
    'applied_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    schemaName,
    schemaVersion,
    fromVersion,
    toVersion,
    migrationId,
    appliedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'migration_ledger';
  @override
  VerificationContext validateIntegrity(
    Insertable<MigrationLedgerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schema_name')) {
      context.handle(
        _schemaNameMeta,
        schemaName.isAcceptableOrUnknown(data['schema_name']!, _schemaNameMeta),
      );
    } else if (isInserting) {
      context.missing(_schemaNameMeta);
    }
    if (data.containsKey('schema_version')) {
      context.handle(
        _schemaVersionMeta,
        schemaVersion.isAcceptableOrUnknown(
          data['schema_version']!,
          _schemaVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('from_version')) {
      context.handle(
        _fromVersionMeta,
        fromVersion.isAcceptableOrUnknown(
          data['from_version']!,
          _fromVersionMeta,
        ),
      );
    }
    if (data.containsKey('to_version')) {
      context.handle(
        _toVersionMeta,
        toVersion.isAcceptableOrUnknown(data['to_version']!, _toVersionMeta),
      );
    }
    if (data.containsKey('migration_id')) {
      context.handle(
        _migrationIdMeta,
        migrationId.isAcceptableOrUnknown(
          data['migration_id']!,
          _migrationIdMeta,
        ),
      );
    }
    if (data.containsKey('applied_at')) {
      context.handle(
        _appliedAtMeta,
        appliedAt.isAcceptableOrUnknown(data['applied_at']!, _appliedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_appliedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MigrationLedgerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MigrationLedgerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      schemaName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schema_name'],
      )!,
      schemaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schema_version'],
      )!,
      fromVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_version'],
      ),
      toVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_version'],
      ),
      migrationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}migration_id'],
      ),
      appliedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}applied_at'],
      )!,
    );
  }

  @override
  $MigrationLedgerTable createAlias(String alias) {
    return $MigrationLedgerTable(attachedDatabase, alias);
  }
}

class MigrationLedgerData extends DataClass
    implements Insertable<MigrationLedgerData> {
  final int id;
  final String schemaName;
  final int schemaVersion;
  final int? fromVersion;
  final int? toVersion;
  final String? migrationId;
  final DateTime appliedAt;
  const MigrationLedgerData({
    required this.id,
    required this.schemaName,
    required this.schemaVersion,
    this.fromVersion,
    this.toVersion,
    this.migrationId,
    required this.appliedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['schema_name'] = Variable<String>(schemaName);
    map['schema_version'] = Variable<int>(schemaVersion);
    if (!nullToAbsent || fromVersion != null) {
      map['from_version'] = Variable<int>(fromVersion);
    }
    if (!nullToAbsent || toVersion != null) {
      map['to_version'] = Variable<int>(toVersion);
    }
    if (!nullToAbsent || migrationId != null) {
      map['migration_id'] = Variable<String>(migrationId);
    }
    map['applied_at'] = Variable<DateTime>(appliedAt);
    return map;
  }

  MigrationLedgerCompanion toCompanion(bool nullToAbsent) {
    return MigrationLedgerCompanion(
      id: Value(id),
      schemaName: Value(schemaName),
      schemaVersion: Value(schemaVersion),
      fromVersion: fromVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(fromVersion),
      toVersion: toVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(toVersion),
      migrationId: migrationId == null && nullToAbsent
          ? const Value.absent()
          : Value(migrationId),
      appliedAt: Value(appliedAt),
    );
  }

  factory MigrationLedgerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MigrationLedgerData(
      id: serializer.fromJson<int>(json['id']),
      schemaName: serializer.fromJson<String>(json['schemaName']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      fromVersion: serializer.fromJson<int?>(json['fromVersion']),
      toVersion: serializer.fromJson<int?>(json['toVersion']),
      migrationId: serializer.fromJson<String?>(json['migrationId']),
      appliedAt: serializer.fromJson<DateTime>(json['appliedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'schemaName': serializer.toJson<String>(schemaName),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'fromVersion': serializer.toJson<int?>(fromVersion),
      'toVersion': serializer.toJson<int?>(toVersion),
      'migrationId': serializer.toJson<String?>(migrationId),
      'appliedAt': serializer.toJson<DateTime>(appliedAt),
    };
  }

  MigrationLedgerData copyWith({
    int? id,
    String? schemaName,
    int? schemaVersion,
    Value<int?> fromVersion = const Value.absent(),
    Value<int?> toVersion = const Value.absent(),
    Value<String?> migrationId = const Value.absent(),
    DateTime? appliedAt,
  }) => MigrationLedgerData(
    id: id ?? this.id,
    schemaName: schemaName ?? this.schemaName,
    schemaVersion: schemaVersion ?? this.schemaVersion,
    fromVersion: fromVersion.present ? fromVersion.value : this.fromVersion,
    toVersion: toVersion.present ? toVersion.value : this.toVersion,
    migrationId: migrationId.present ? migrationId.value : this.migrationId,
    appliedAt: appliedAt ?? this.appliedAt,
  );
  MigrationLedgerData copyWithCompanion(MigrationLedgerCompanion data) {
    return MigrationLedgerData(
      id: data.id.present ? data.id.value : this.id,
      schemaName: data.schemaName.present
          ? data.schemaName.value
          : this.schemaName,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      fromVersion: data.fromVersion.present
          ? data.fromVersion.value
          : this.fromVersion,
      toVersion: data.toVersion.present ? data.toVersion.value : this.toVersion,
      migrationId: data.migrationId.present
          ? data.migrationId.value
          : this.migrationId,
      appliedAt: data.appliedAt.present ? data.appliedAt.value : this.appliedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MigrationLedgerData(')
          ..write('id: $id, ')
          ..write('schemaName: $schemaName, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('fromVersion: $fromVersion, ')
          ..write('toVersion: $toVersion, ')
          ..write('migrationId: $migrationId, ')
          ..write('appliedAt: $appliedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    schemaName,
    schemaVersion,
    fromVersion,
    toVersion,
    migrationId,
    appliedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MigrationLedgerData &&
          other.id == this.id &&
          other.schemaName == this.schemaName &&
          other.schemaVersion == this.schemaVersion &&
          other.fromVersion == this.fromVersion &&
          other.toVersion == this.toVersion &&
          other.migrationId == this.migrationId &&
          other.appliedAt == this.appliedAt);
}

class MigrationLedgerCompanion extends UpdateCompanion<MigrationLedgerData> {
  final Value<int> id;
  final Value<String> schemaName;
  final Value<int> schemaVersion;
  final Value<int?> fromVersion;
  final Value<int?> toVersion;
  final Value<String?> migrationId;
  final Value<DateTime> appliedAt;
  const MigrationLedgerCompanion({
    this.id = const Value.absent(),
    this.schemaName = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.fromVersion = const Value.absent(),
    this.toVersion = const Value.absent(),
    this.migrationId = const Value.absent(),
    this.appliedAt = const Value.absent(),
  });
  MigrationLedgerCompanion.insert({
    this.id = const Value.absent(),
    required String schemaName,
    required int schemaVersion,
    this.fromVersion = const Value.absent(),
    this.toVersion = const Value.absent(),
    this.migrationId = const Value.absent(),
    required DateTime appliedAt,
  }) : schemaName = Value(schemaName),
       schemaVersion = Value(schemaVersion),
       appliedAt = Value(appliedAt);
  static Insertable<MigrationLedgerData> custom({
    Expression<int>? id,
    Expression<String>? schemaName,
    Expression<int>? schemaVersion,
    Expression<int>? fromVersion,
    Expression<int>? toVersion,
    Expression<String>? migrationId,
    Expression<DateTime>? appliedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (schemaName != null) 'schema_name': schemaName,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (fromVersion != null) 'from_version': fromVersion,
      if (toVersion != null) 'to_version': toVersion,
      if (migrationId != null) 'migration_id': migrationId,
      if (appliedAt != null) 'applied_at': appliedAt,
    });
  }

  MigrationLedgerCompanion copyWith({
    Value<int>? id,
    Value<String>? schemaName,
    Value<int>? schemaVersion,
    Value<int?>? fromVersion,
    Value<int?>? toVersion,
    Value<String?>? migrationId,
    Value<DateTime>? appliedAt,
  }) {
    return MigrationLedgerCompanion(
      id: id ?? this.id,
      schemaName: schemaName ?? this.schemaName,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      fromVersion: fromVersion ?? this.fromVersion,
      toVersion: toVersion ?? this.toVersion,
      migrationId: migrationId ?? this.migrationId,
      appliedAt: appliedAt ?? this.appliedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (schemaName.present) {
      map['schema_name'] = Variable<String>(schemaName.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (fromVersion.present) {
      map['from_version'] = Variable<int>(fromVersion.value);
    }
    if (toVersion.present) {
      map['to_version'] = Variable<int>(toVersion.value);
    }
    if (migrationId.present) {
      map['migration_id'] = Variable<String>(migrationId.value);
    }
    if (appliedAt.present) {
      map['applied_at'] = Variable<DateTime>(appliedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MigrationLedgerCompanion(')
          ..write('id: $id, ')
          ..write('schemaName: $schemaName, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('fromVersion: $fromVersion, ')
          ..write('toVersion: $toVersion, ')
          ..write('migrationId: $migrationId, ')
          ..write('appliedAt: $appliedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $LocalAccountsTable localAccounts = $LocalAccountsTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $StoresTable stores = $StoresTable(this);
  late final $PeopleTable people = $PeopleTable(this);
  late final $PaymentMethodsTable paymentMethods = $PaymentMethodsTable(this);
  late final $AccountPreferencesTable accountPreferences =
      $AccountPreferencesTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $PurchaseItemsTable purchaseItems = $PurchaseItemsTable(this);
  late final $SyncEventsTable syncEvents = $SyncEventsTable(this);
  late final $PendingEventsTable pendingEvents = $PendingEventsTable(this);
  late final $SyncStateTable syncState = $SyncStateTable(this);
  late final $InstallationMetadataTable installationMetadata =
      $InstallationMetadataTable(this);
  late final $SyncSubmissionsTable syncSubmissions = $SyncSubmissionsTable(
    this,
  );
  late final $SyncSubmissionEventsTable syncSubmissionEvents =
      $SyncSubmissionEventsTable(this);
  late final $SyncInboxTable syncInbox = $SyncInboxTable(this);
  late final $RecoverySessionsTable recoverySessions = $RecoverySessionsTable(
    this,
  );
  late final $RecoveryChunksTable recoveryChunks = $RecoveryChunksTable(this);
  late final $HostedAuthStatesTable hostedAuthStates = $HostedAuthStatesTable(
    this,
  );
  late final $MigrationLedgerTable migrationLedger = $MigrationLedgerTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localAccounts,
    devices,
    products,
    stores,
    people,
    paymentMethods,
    accountPreferences,
    purchases,
    purchaseItems,
    syncEvents,
    pendingEvents,
    syncState,
    installationMetadata,
    syncSubmissions,
    syncSubmissionEvents,
    syncInbox,
    recoverySessions,
    recoveryChunks,
    hostedAuthStates,
    migrationLedger,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('account_preferences', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'purchases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sync_events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pending_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_state', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sync_submissions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_submission_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sync_events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_submission_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_inbox', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recovery_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recovery_chunks', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$LocalAccountsTableCreateCompanionBuilder =
    LocalAccountsCompanion Function({
      required String id,
      required String defaultCurrencyCode,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$LocalAccountsTableUpdateCompanionBuilder =
    LocalAccountsCompanion Function({
      Value<String> id,
      Value<String> defaultCurrencyCode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$LocalAccountsTableReferences
    extends BaseReferences<_$LocalDatabase, $LocalAccountsTable, LocalAccount> {
  $$LocalAccountsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DevicesTable, List<Device>> _devicesRefsTable(
    _$LocalDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.devices,
    aliasName: 'local_accounts__id__devices__account_id',
  );

  $$DevicesTableProcessedTableManager get devicesRefs {
    final manager = $$DevicesTableTableManager(
      $_db,
      $_db.devices,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_devicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$LocalDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: 'local_accounts__id__products__account_id',
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StoresTable, List<Store>> _storesRefsTable(
    _$LocalDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.stores,
    aliasName: 'local_accounts__id__stores__account_id',
  );

  $$StoresTableProcessedTableManager get storesRefs {
    final manager = $$StoresTableTableManager(
      $_db,
      $_db.stores,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_storesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PeopleTable, List<PeopleData>> _peopleRefsTable(
    _$LocalDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.people,
    aliasName: 'local_accounts__id__people__account_id',
  );

  $$PeopleTableProcessedTableManager get peopleRefs {
    final manager = $$PeopleTableTableManager(
      $_db,
      $_db.people,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_peopleRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentMethodsTable, List<PaymentMethod>>
  _paymentMethodsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentMethods,
    aliasName: 'local_accounts__id__payment_methods__account_id',
  );

  $$PaymentMethodsTableProcessedTableManager get paymentMethodsRefs {
    final manager = $$PaymentMethodsTableTableManager(
      $_db,
      $_db.paymentMethods,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentMethodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AccountPreferencesTable, List<AccountPreference>>
  _accountPreferencesRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.accountPreferences,
        aliasName: 'local_accounts__id__account_preferences__account_id',
      );

  $$AccountPreferencesTableProcessedTableManager get accountPreferencesRefs {
    final manager = $$AccountPreferencesTableTableManager(
      $_db,
      $_db.accountPreferences,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _accountPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchasesTable, List<Purchase>>
  _purchasesRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.purchases,
    aliasName: 'local_accounts__id__purchases__account_id',
  );

  $$PurchasesTableProcessedTableManager get purchasesRefs {
    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncEventsTable, List<SyncEvent>>
  _syncEventsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.syncEvents,
    aliasName: 'local_accounts__id__sync_events__account_id',
  );

  $$SyncEventsTableProcessedTableManager get syncEventsRefs {
    final manager = $$SyncEventsTableTableManager(
      $_db,
      $_db.syncEvents,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncStateTable, List<SyncStateData>>
  _syncStateRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.syncState,
    aliasName: 'local_accounts__id__sync_state__account_id',
  );

  $$SyncStateTableProcessedTableManager get syncStateRefs {
    final manager = $$SyncStateTableTableManager(
      $_db,
      $_db.syncState,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncStateRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationMetadataTable,
    List<InstallationMetadataData>
  >
  _installationMetadataRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.installationMetadata,
        aliasName: 'local_accounts__id__installation_metadata__account_id',
      );

  $$InstallationMetadataTableProcessedTableManager
  get installationMetadataRefs {
    final manager = $$InstallationMetadataTableTableManager(
      $_db,
      $_db.installationMetadata,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installationMetadataRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncSubmissionsTable, List<SyncSubmission>>
  _syncSubmissionsRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.syncSubmissions,
        aliasName: 'local_accounts__id__sync_submissions__account_id',
      );

  $$SyncSubmissionsTableProcessedTableManager get syncSubmissionsRefs {
    final manager = $$SyncSubmissionsTableTableManager(
      $_db,
      $_db.syncSubmissions,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _syncSubmissionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncInboxTable, List<SyncInboxData>>
  _syncInboxRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.syncInbox,
    aliasName: 'local_accounts__id__sync_inbox__account_id',
  );

  $$SyncInboxTableProcessedTableManager get syncInboxRefs {
    final manager = $$SyncInboxTableTableManager(
      $_db,
      $_db.syncInbox,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncInboxRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalAccountsTableFilterComposer
    extends Composer<_$LocalDatabase, $LocalAccountsTable> {
  $$LocalAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrencyCode => $composableBuilder(
    column: $table.defaultCurrencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> devicesRefs(
    Expression<bool> Function($$DevicesTableFilterComposer f) f,
  ) {
    final $$DevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableFilterComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> storesRefs(
    Expression<bool> Function($$StoresTableFilterComposer f) f,
  ) {
    final $$StoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableFilterComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> peopleRefs(
    Expression<bool> Function($$PeopleTableFilterComposer f) f,
  ) {
    final $$PeopleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.people,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleTableFilterComposer(
            $db: $db,
            $table: $db.people,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentMethodsRefs(
    Expression<bool> Function($$PaymentMethodsTableFilterComposer f) f,
  ) {
    final $$PaymentMethodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableFilterComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accountPreferencesRefs(
    Expression<bool> Function($$AccountPreferencesTableFilterComposer f) f,
  ) {
    final $$AccountPreferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accountPreferences,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountPreferencesTableFilterComposer(
            $db: $db,
            $table: $db.accountPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchasesRefs(
    Expression<bool> Function($$PurchasesTableFilterComposer f) f,
  ) {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncEventsRefs(
    Expression<bool> Function($$SyncEventsTableFilterComposer f) f,
  ) {
    final $$SyncEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableFilterComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncStateRefs(
    Expression<bool> Function($$SyncStateTableFilterComposer f) f,
  ) {
    final $$SyncStateTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncState,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncStateTableFilterComposer(
            $db: $db,
            $table: $db.syncState,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installationMetadataRefs(
    Expression<bool> Function($$InstallationMetadataTableFilterComposer f) f,
  ) {
    final $$InstallationMetadataTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installationMetadata,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationMetadataTableFilterComposer(
            $db: $db,
            $table: $db.installationMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncSubmissionsRefs(
    Expression<bool> Function($$SyncSubmissionsTableFilterComposer f) f,
  ) {
    final $$SyncSubmissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncSubmissions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionsTableFilterComposer(
            $db: $db,
            $table: $db.syncSubmissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncInboxRefs(
    Expression<bool> Function($$SyncInboxTableFilterComposer f) f,
  ) {
    final $$SyncInboxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncInbox,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncInboxTableFilterComposer(
            $db: $db,
            $table: $db.syncInbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalAccountsTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocalAccountsTable> {
  $$LocalAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrencyCode => $composableBuilder(
    column: $table.defaultCurrencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalAccountsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocalAccountsTable> {
  $$LocalAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get defaultCurrencyCode => $composableBuilder(
    column: $table.defaultCurrencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> devicesRefs<T extends Object>(
    Expression<T> Function($$DevicesTableAnnotationComposer a) f,
  ) {
    final $$DevicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableAnnotationComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> storesRefs<T extends Object>(
    Expression<T> Function($$StoresTableAnnotationComposer a) f,
  ) {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableAnnotationComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> peopleRefs<T extends Object>(
    Expression<T> Function($$PeopleTableAnnotationComposer a) f,
  ) {
    final $$PeopleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.people,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleTableAnnotationComposer(
            $db: $db,
            $table: $db.people,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentMethodsRefs<T extends Object>(
    Expression<T> Function($$PaymentMethodsTableAnnotationComposer a) f,
  ) {
    final $$PaymentMethodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> accountPreferencesRefs<T extends Object>(
    Expression<T> Function($$AccountPreferencesTableAnnotationComposer a) f,
  ) {
    final $$AccountPreferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.accountPreferences,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AccountPreferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.accountPreferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> purchasesRefs<T extends Object>(
    Expression<T> Function($$PurchasesTableAnnotationComposer a) f,
  ) {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syncEventsRefs<T extends Object>(
    Expression<T> Function($$SyncEventsTableAnnotationComposer a) f,
  ) {
    final $$SyncEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syncStateRefs<T extends Object>(
    Expression<T> Function($$SyncStateTableAnnotationComposer a) f,
  ) {
    final $$SyncStateTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncState,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncStateTableAnnotationComposer(
            $db: $db,
            $table: $db.syncState,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> installationMetadataRefs<T extends Object>(
    Expression<T> Function($$InstallationMetadataTableAnnotationComposer a) f,
  ) {
    final $$InstallationMetadataTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationMetadata,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationMetadataTableAnnotationComposer(
                $db: $db,
                $table: $db.installationMetadata,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> syncSubmissionsRefs<T extends Object>(
    Expression<T> Function($$SyncSubmissionsTableAnnotationComposer a) f,
  ) {
    final $$SyncSubmissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncSubmissions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncSubmissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syncInboxRefs<T extends Object>(
    Expression<T> Function($$SyncInboxTableAnnotationComposer a) f,
  ) {
    final $$SyncInboxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncInbox,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncInboxTableAnnotationComposer(
            $db: $db,
            $table: $db.syncInbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalAccountsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $LocalAccountsTable,
          LocalAccount,
          $$LocalAccountsTableFilterComposer,
          $$LocalAccountsTableOrderingComposer,
          $$LocalAccountsTableAnnotationComposer,
          $$LocalAccountsTableCreateCompanionBuilder,
          $$LocalAccountsTableUpdateCompanionBuilder,
          (LocalAccount, $$LocalAccountsTableReferences),
          LocalAccount,
          PrefetchHooks Function({
            bool devicesRefs,
            bool productsRefs,
            bool storesRefs,
            bool peopleRefs,
            bool paymentMethodsRefs,
            bool accountPreferencesRefs,
            bool purchasesRefs,
            bool syncEventsRefs,
            bool syncStateRefs,
            bool installationMetadataRefs,
            bool syncSubmissionsRefs,
            bool syncInboxRefs,
          })
        > {
  $$LocalAccountsTableTableManager(
    _$LocalDatabase db,
    $LocalAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> defaultCurrencyCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalAccountsCompanion(
                id: id,
                defaultCurrencyCode: defaultCurrencyCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String defaultCurrencyCode,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalAccountsCompanion.insert(
                id: id,
                defaultCurrencyCode: defaultCurrencyCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                devicesRefs = false,
                productsRefs = false,
                storesRefs = false,
                peopleRefs = false,
                paymentMethodsRefs = false,
                accountPreferencesRefs = false,
                purchasesRefs = false,
                syncEventsRefs = false,
                syncStateRefs = false,
                installationMetadataRefs = false,
                syncSubmissionsRefs = false,
                syncInboxRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (devicesRefs) db.devices,
                    if (productsRefs) db.products,
                    if (storesRefs) db.stores,
                    if (peopleRefs) db.people,
                    if (paymentMethodsRefs) db.paymentMethods,
                    if (accountPreferencesRefs) db.accountPreferences,
                    if (purchasesRefs) db.purchases,
                    if (syncEventsRefs) db.syncEvents,
                    if (syncStateRefs) db.syncState,
                    if (installationMetadataRefs) db.installationMetadata,
                    if (syncSubmissionsRefs) db.syncSubmissions,
                    if (syncInboxRefs) db.syncInbox,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (devicesRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          Device
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._devicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).devicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productsRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          Product
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._productsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).productsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (storesRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          Store
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._storesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).storesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (peopleRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          PeopleData
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._peopleRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).peopleRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentMethodsRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          PaymentMethod
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._paymentMethodsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentMethodsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (accountPreferencesRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          AccountPreference
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._accountPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).accountPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchasesRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          Purchase
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._purchasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchasesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncEventsRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          SyncEvent
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._syncEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).syncEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncStateRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          SyncStateData
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._syncStateRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).syncStateRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationMetadataRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          InstallationMetadataData
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._installationMetadataRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).installationMetadataRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncSubmissionsRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          SyncSubmission
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._syncSubmissionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).syncSubmissionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncInboxRefs)
                        await $_getPrefetchedData<
                          LocalAccount,
                          $LocalAccountsTable,
                          SyncInboxData
                        >(
                          currentTable: table,
                          referencedTable: $$LocalAccountsTableReferences
                              ._syncInboxRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).syncInboxRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $LocalAccountsTable,
      LocalAccount,
      $$LocalAccountsTableFilterComposer,
      $$LocalAccountsTableOrderingComposer,
      $$LocalAccountsTableAnnotationComposer,
      $$LocalAccountsTableCreateCompanionBuilder,
      $$LocalAccountsTableUpdateCompanionBuilder,
      (LocalAccount, $$LocalAccountsTableReferences),
      LocalAccount,
      PrefetchHooks Function({
        bool devicesRefs,
        bool productsRefs,
        bool storesRefs,
        bool peopleRefs,
        bool paymentMethodsRefs,
        bool accountPreferencesRefs,
        bool purchasesRefs,
        bool syncEventsRefs,
        bool syncStateRefs,
        bool installationMetadataRefs,
        bool syncSubmissionsRefs,
        bool syncInboxRefs,
      })
    >;
typedef $$DevicesTableCreateCompanionBuilder =
    DevicesCompanion Function({
      required String id,
      required String accountId,
      required int nextSequence,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$DevicesTableUpdateCompanionBuilder =
    DevicesCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<int> nextSequence,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$DevicesTableReferences
    extends BaseReferences<_$LocalDatabase, $DevicesTable, Device> {
  $$DevicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) =>
      db.localAccounts.createAlias('devices__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SyncEventsTable, List<SyncEvent>>
  _syncEventsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.syncEvents,
    aliasName: 'devices__id__sync_events__device_id',
  );

  $$SyncEventsTableProcessedTableManager get syncEventsRefs {
    final manager = $$SyncEventsTableTableManager(
      $_db,
      $_db.syncEvents,
    ).filter((f) => f.deviceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallationMetadataTable,
    List<InstallationMetadataData>
  >
  _installationMetadataRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.installationMetadata,
        aliasName: 'devices__id__installation_metadata__current_device_id',
      );

  $$InstallationMetadataTableProcessedTableManager
  get installationMetadataRefs {
    final manager =
        $$InstallationMetadataTableTableManager(
          $_db,
          $_db.installationMetadata,
        ).filter(
          (f) => f.currentDeviceId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _installationMetadataRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncSubmissionsTable, List<SyncSubmission>>
  _syncSubmissionsRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.syncSubmissions,
        aliasName: 'devices__id__sync_submissions__device_id',
      );

  $$SyncSubmissionsTableProcessedTableManager get syncSubmissionsRefs {
    final manager = $$SyncSubmissionsTableTableManager(
      $_db,
      $_db.syncSubmissions,
    ).filter((f) => f.deviceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _syncSubmissionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DevicesTableFilterComposer
    extends Composer<_$LocalDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextSequence => $composableBuilder(
    column: $table.nextSequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> syncEventsRefs(
    Expression<bool> Function($$SyncEventsTableFilterComposer f) f,
  ) {
    final $$SyncEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.deviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableFilterComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installationMetadataRefs(
    Expression<bool> Function($$InstallationMetadataTableFilterComposer f) f,
  ) {
    final $$InstallationMetadataTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installationMetadata,
      getReferencedColumn: (t) => t.currentDeviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationMetadataTableFilterComposer(
            $db: $db,
            $table: $db.installationMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncSubmissionsRefs(
    Expression<bool> Function($$SyncSubmissionsTableFilterComposer f) f,
  ) {
    final $$SyncSubmissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncSubmissions,
      getReferencedColumn: (t) => t.deviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionsTableFilterComposer(
            $db: $db,
            $table: $db.syncSubmissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DevicesTableOrderingComposer
    extends Composer<_$LocalDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextSequence => $composableBuilder(
    column: $table.nextSequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get nextSequence => $composableBuilder(
    column: $table.nextSequence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> syncEventsRefs<T extends Object>(
    Expression<T> Function($$SyncEventsTableAnnotationComposer a) f,
  ) {
    final $$SyncEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.deviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> installationMetadataRefs<T extends Object>(
    Expression<T> Function($$InstallationMetadataTableAnnotationComposer a) f,
  ) {
    final $$InstallationMetadataTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installationMetadata,
          getReferencedColumn: (t) => t.currentDeviceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallationMetadataTableAnnotationComposer(
                $db: $db,
                $table: $db.installationMetadata,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> syncSubmissionsRefs<T extends Object>(
    Expression<T> Function($$SyncSubmissionsTableAnnotationComposer a) f,
  ) {
    final $$SyncSubmissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncSubmissions,
      getReferencedColumn: (t) => t.deviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncSubmissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DevicesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $DevicesTable,
          Device,
          $$DevicesTableFilterComposer,
          $$DevicesTableOrderingComposer,
          $$DevicesTableAnnotationComposer,
          $$DevicesTableCreateCompanionBuilder,
          $$DevicesTableUpdateCompanionBuilder,
          (Device, $$DevicesTableReferences),
          Device,
          PrefetchHooks Function({
            bool accountId,
            bool syncEventsRefs,
            bool installationMetadataRefs,
            bool syncSubmissionsRefs,
          })
        > {
  $$DevicesTableTableManager(_$LocalDatabase db, $DevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> nextSequence = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion(
                id: id,
                accountId: accountId,
                nextSequence: nextSequence,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required int nextSequence,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion.insert(
                id: id,
                accountId: accountId,
                nextSequence: nextSequence,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DevicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                syncEventsRefs = false,
                installationMetadataRefs = false,
                syncSubmissionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (syncEventsRefs) db.syncEvents,
                    if (installationMetadataRefs) db.installationMetadata,
                    if (syncSubmissionsRefs) db.syncSubmissions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable: $$DevicesTableReferences
                                        ._accountIdTable(db),
                                    referencedColumn: $$DevicesTableReferences
                                        ._accountIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (syncEventsRefs)
                        await $_getPrefetchedData<
                          Device,
                          $DevicesTable,
                          SyncEvent
                        >(
                          currentTable: table,
                          referencedTable: $$DevicesTableReferences
                              ._syncEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DevicesTableReferences(
                                db,
                                table,
                                p0,
                              ).syncEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installationMetadataRefs)
                        await $_getPrefetchedData<
                          Device,
                          $DevicesTable,
                          InstallationMetadataData
                        >(
                          currentTable: table,
                          referencedTable: $$DevicesTableReferences
                              ._installationMetadataRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DevicesTableReferences(
                                db,
                                table,
                                p0,
                              ).installationMetadataRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currentDeviceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncSubmissionsRefs)
                        await $_getPrefetchedData<
                          Device,
                          $DevicesTable,
                          SyncSubmission
                        >(
                          currentTable: table,
                          referencedTable: $$DevicesTableReferences
                              ._syncSubmissionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DevicesTableReferences(
                                db,
                                table,
                                p0,
                              ).syncSubmissionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $DevicesTable,
      Device,
      $$DevicesTableFilterComposer,
      $$DevicesTableOrderingComposer,
      $$DevicesTableAnnotationComposer,
      $$DevicesTableCreateCompanionBuilder,
      $$DevicesTableUpdateCompanionBuilder,
      (Device, $$DevicesTableReferences),
      Device,
      PrefetchHooks Function({
        bool accountId,
        bool syncEventsRefs,
        bool installationMetadataRefs,
        bool syncSubmissionsRefs,
      })
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      required String accountId,
      required String userProductCode,
      required String normalizedUserProductCode,
      required int normalizationVersion,
      Value<String?> displayName,
      Value<String?> displayBrand,
      required String normalizedName,
      required String normalizedBrand,
      required String mode,
      required String measurementKind,
      Value<String?> packageAmount,
      Value<String?> packageUnit,
      required String exactIdentityKey,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> userProductCode,
      Value<String> normalizedUserProductCode,
      Value<int> normalizationVersion,
      Value<String?> displayName,
      Value<String?> displayBrand,
      Value<String> normalizedName,
      Value<String> normalizedBrand,
      Value<String> mode,
      Value<String> measurementKind,
      Value<String?> packageAmount,
      Value<String?> packageUnit,
      Value<String> exactIdentityKey,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$LocalDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) =>
      db.localAccounts.createAlias('products__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>>
  _purchaseItemsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseItems,
    aliasName: 'products__id__purchase_items__product_id',
  );

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager(
      $_db,
      $_db.purchaseItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$LocalDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userProductCode => $composableBuilder(
    column: $table.userProductCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedUserProductCode => $composableBuilder(
    column: $table.normalizedUserProductCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get normalizationVersion => $composableBuilder(
    column: $table.normalizationVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayBrand => $composableBuilder(
    column: $table.displayBrand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedBrand => $composableBuilder(
    column: $table.normalizedBrand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get measurementKind => $composableBuilder(
    column: $table.measurementKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageAmount => $composableBuilder(
    column: $table.packageAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageUnit => $composableBuilder(
    column: $table.packageUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exactIdentityKey => $composableBuilder(
    column: $table.exactIdentityKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseItemsRefs(
    Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$LocalDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userProductCode => $composableBuilder(
    column: $table.userProductCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedUserProductCode => $composableBuilder(
    column: $table.normalizedUserProductCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get normalizationVersion => $composableBuilder(
    column: $table.normalizationVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayBrand => $composableBuilder(
    column: $table.displayBrand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedBrand => $composableBuilder(
    column: $table.normalizedBrand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get measurementKind => $composableBuilder(
    column: $table.measurementKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageAmount => $composableBuilder(
    column: $table.packageAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageUnit => $composableBuilder(
    column: $table.packageUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exactIdentityKey => $composableBuilder(
    column: $table.exactIdentityKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userProductCode => $composableBuilder(
    column: $table.userProductCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedUserProductCode => $composableBuilder(
    column: $table.normalizedUserProductCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get normalizationVersion => $composableBuilder(
    column: $table.normalizationVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayBrand => $composableBuilder(
    column: $table.displayBrand,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedBrand => $composableBuilder(
    column: $table.normalizedBrand,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get measurementKind => $composableBuilder(
    column: $table.measurementKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get packageAmount => $composableBuilder(
    column: $table.packageAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get packageUnit => $composableBuilder(
    column: $table.packageUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exactIdentityKey => $composableBuilder(
    column: $table.exactIdentityKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({bool accountId, bool purchaseItemsRefs})
        > {
  $$ProductsTableTableManager(_$LocalDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> userProductCode = const Value.absent(),
                Value<String> normalizedUserProductCode = const Value.absent(),
                Value<int> normalizationVersion = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> displayBrand = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String> normalizedBrand = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String> measurementKind = const Value.absent(),
                Value<String?> packageAmount = const Value.absent(),
                Value<String?> packageUnit = const Value.absent(),
                Value<String> exactIdentityKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                accountId: accountId,
                userProductCode: userProductCode,
                normalizedUserProductCode: normalizedUserProductCode,
                normalizationVersion: normalizationVersion,
                displayName: displayName,
                displayBrand: displayBrand,
                normalizedName: normalizedName,
                normalizedBrand: normalizedBrand,
                mode: mode,
                measurementKind: measurementKind,
                packageAmount: packageAmount,
                packageUnit: packageUnit,
                exactIdentityKey: exactIdentityKey,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String userProductCode,
                required String normalizedUserProductCode,
                required int normalizationVersion,
                Value<String?> displayName = const Value.absent(),
                Value<String?> displayBrand = const Value.absent(),
                required String normalizedName,
                required String normalizedBrand,
                required String mode,
                required String measurementKind,
                Value<String?> packageAmount = const Value.absent(),
                Value<String?> packageUnit = const Value.absent(),
                required String exactIdentityKey,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                accountId: accountId,
                userProductCode: userProductCode,
                normalizedUserProductCode: normalizedUserProductCode,
                normalizationVersion: normalizationVersion,
                displayName: displayName,
                displayBrand: displayBrand,
                normalizedName: normalizedName,
                normalizedBrand: normalizedBrand,
                mode: mode,
                measurementKind: measurementKind,
                packageAmount: packageAmount,
                packageUnit: packageUnit,
                exactIdentityKey: exactIdentityKey,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({accountId = false, purchaseItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseItemsRefs) db.purchaseItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable: $$ProductsTableReferences
                                        ._accountIdTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._accountIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          PurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._purchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({bool accountId, bool purchaseItemsRefs})
    >;
typedef $$StoresTableCreateCompanionBuilder =
    StoresCompanion Function({
      required String id,
      required String accountId,
      required String displayName,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$StoresTableUpdateCompanionBuilder =
    StoresCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> displayName,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$StoresTableReferences
    extends BaseReferences<_$LocalDatabase, $StoresTable, Store> {
  $$StoresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) =>
      db.localAccounts.createAlias('stores__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchasesTable, List<Purchase>>
  _purchasesRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.purchases,
    aliasName: 'stores__id__purchases__store_id',
  );

  $$PurchasesTableProcessedTableManager get purchasesRefs {
    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.storeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StoresTableFilterComposer
    extends Composer<_$LocalDatabase, $StoresTable> {
  $$StoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchasesRefs(
    Expression<bool> Function($$PurchasesTableFilterComposer f) f,
  ) {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StoresTableOrderingComposer
    extends Composer<_$LocalDatabase, $StoresTable> {
  $$StoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StoresTableAnnotationComposer
    extends Composer<_$LocalDatabase, $StoresTable> {
  $$StoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchasesRefs<T extends Object>(
    Expression<T> Function($$PurchasesTableAnnotationComposer a) f,
  ) {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.storeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StoresTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $StoresTable,
          Store,
          $$StoresTableFilterComposer,
          $$StoresTableOrderingComposer,
          $$StoresTableAnnotationComposer,
          $$StoresTableCreateCompanionBuilder,
          $$StoresTableUpdateCompanionBuilder,
          (Store, $$StoresTableReferences),
          Store,
          PrefetchHooks Function({bool accountId, bool purchasesRefs})
        > {
  $$StoresTableTableManager(_$LocalDatabase db, $StoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoresCompanion(
                id: id,
                accountId: accountId,
                displayName: displayName,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String displayName,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => StoresCompanion.insert(
                id: id,
                accountId: accountId,
                displayName: displayName,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$StoresTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false, purchasesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (purchasesRefs) db.purchases],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable: $$StoresTableReferences
                                    ._accountIdTable(db),
                                referencedColumn: $$StoresTableReferences
                                    ._accountIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchasesRefs)
                    await $_getPrefetchedData<Store, $StoresTable, Purchase>(
                      currentTable: table,
                      referencedTable: $$StoresTableReferences
                          ._purchasesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$StoresTableReferences(db, table, p0).purchasesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.storeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StoresTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $StoresTable,
      Store,
      $$StoresTableFilterComposer,
      $$StoresTableOrderingComposer,
      $$StoresTableAnnotationComposer,
      $$StoresTableCreateCompanionBuilder,
      $$StoresTableUpdateCompanionBuilder,
      (Store, $$StoresTableReferences),
      Store,
      PrefetchHooks Function({bool accountId, bool purchasesRefs})
    >;
typedef $$PeopleTableCreateCompanionBuilder =
    PeopleCompanion Function({
      required String id,
      required String accountId,
      required String visibleCode,
      required String nickname,
      required String normalizedNickname,
      Value<bool> active,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });
typedef $$PeopleTableUpdateCompanionBuilder =
    PeopleCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> visibleCode,
      Value<String> nickname,
      Value<String> normalizedNickname,
      Value<bool> active,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });

final class $$PeopleTableReferences
    extends BaseReferences<_$LocalDatabase, $PeopleTable, PeopleData> {
  $$PeopleTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) =>
      db.localAccounts.createAlias('people__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchasesTable, List<Purchase>>
  _purchasesRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.purchases,
    aliasName: 'people__id__purchases__person_id',
  );

  $$PurchasesTableProcessedTableManager get purchasesRefs {
    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.personId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PeopleTableFilterComposer
    extends Composer<_$LocalDatabase, $PeopleTable> {
  $$PeopleTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibleCode => $composableBuilder(
    column: $table.visibleCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedNickname => $composableBuilder(
    column: $table.normalizedNickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchasesRefs(
    Expression<bool> Function($$PurchasesTableFilterComposer f) f,
  ) {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PeopleTableOrderingComposer
    extends Composer<_$LocalDatabase, $PeopleTable> {
  $$PeopleTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibleCode => $composableBuilder(
    column: $table.visibleCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedNickname => $composableBuilder(
    column: $table.normalizedNickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PeopleTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PeopleTable> {
  $$PeopleTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get visibleCode => $composableBuilder(
    column: $table.visibleCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get normalizedNickname => $composableBuilder(
    column: $table.normalizedNickname,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchasesRefs<T extends Object>(
    Expression<T> Function($$PurchasesTableAnnotationComposer a) f,
  ) {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PeopleTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PeopleTable,
          PeopleData,
          $$PeopleTableFilterComposer,
          $$PeopleTableOrderingComposer,
          $$PeopleTableAnnotationComposer,
          $$PeopleTableCreateCompanionBuilder,
          $$PeopleTableUpdateCompanionBuilder,
          (PeopleData, $$PeopleTableReferences),
          PeopleData,
          PrefetchHooks Function({bool accountId, bool purchasesRefs})
        > {
  $$PeopleTableTableManager(_$LocalDatabase db, $PeopleTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeopleTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeopleTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeopleTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> visibleCode = const Value.absent(),
                Value<String> nickname = const Value.absent(),
                Value<String> normalizedNickname = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PeopleCompanion(
                id: id,
                accountId: accountId,
                visibleCode: visibleCode,
                nickname: nickname,
                normalizedNickname: normalizedNickname,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String visibleCode,
                required String nickname,
                required String normalizedNickname,
                Value<bool> active = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PeopleCompanion.insert(
                id: id,
                accountId: accountId,
                visibleCode: visibleCode,
                nickname: nickname,
                normalizedNickname: normalizedNickname,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PeopleTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false, purchasesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (purchasesRefs) db.purchases],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable: $$PeopleTableReferences
                                    ._accountIdTable(db),
                                referencedColumn: $$PeopleTableReferences
                                    ._accountIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchasesRefs)
                    await $_getPrefetchedData<
                      PeopleData,
                      $PeopleTable,
                      Purchase
                    >(
                      currentTable: table,
                      referencedTable: $$PeopleTableReferences
                          ._purchasesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PeopleTableReferences(db, table, p0).purchasesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.personId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PeopleTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PeopleTable,
      PeopleData,
      $$PeopleTableFilterComposer,
      $$PeopleTableOrderingComposer,
      $$PeopleTableAnnotationComposer,
      $$PeopleTableCreateCompanionBuilder,
      $$PeopleTableUpdateCompanionBuilder,
      (PeopleData, $$PeopleTableReferences),
      PeopleData,
      PrefetchHooks Function({bool accountId, bool purchasesRefs})
    >;
typedef $$PaymentMethodsTableCreateCompanionBuilder =
    PaymentMethodsCompanion Function({
      required String id,
      required String accountId,
      required String visibleCode,
      required String nickname,
      required String normalizedNickname,
      Value<bool> active,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });
typedef $$PaymentMethodsTableUpdateCompanionBuilder =
    PaymentMethodsCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> visibleCode,
      Value<String> nickname,
      Value<String> normalizedNickname,
      Value<bool> active,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });

final class $$PaymentMethodsTableReferences
    extends
        BaseReferences<_$LocalDatabase, $PaymentMethodsTable, PaymentMethod> {
  $$PaymentMethodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) => db
      .localAccounts
      .createAlias('payment_methods__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchasesTable, List<Purchase>>
  _purchasesRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.purchases,
    aliasName: 'payment_methods__id__purchases__payment_method_id',
  );

  $$PurchasesTableProcessedTableManager get purchasesRefs {
    final manager = $$PurchasesTableTableManager($_db, $_db.purchases).filter(
      (f) => f.paymentMethodId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_purchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaymentMethodsTableFilterComposer
    extends Composer<_$LocalDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibleCode => $composableBuilder(
    column: $table.visibleCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedNickname => $composableBuilder(
    column: $table.normalizedNickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchasesRefs(
    Expression<bool> Function($$PurchasesTableFilterComposer f) f,
  ) {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.paymentMethodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentMethodsTableOrderingComposer
    extends Composer<_$LocalDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibleCode => $composableBuilder(
    column: $table.visibleCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedNickname => $composableBuilder(
    column: $table.normalizedNickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentMethodsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get visibleCode => $composableBuilder(
    column: $table.visibleCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get normalizedNickname => $composableBuilder(
    column: $table.normalizedNickname,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchasesRefs<T extends Object>(
    Expression<T> Function($$PurchasesTableAnnotationComposer a) f,
  ) {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.paymentMethodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentMethodsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PaymentMethodsTable,
          PaymentMethod,
          $$PaymentMethodsTableFilterComposer,
          $$PaymentMethodsTableOrderingComposer,
          $$PaymentMethodsTableAnnotationComposer,
          $$PaymentMethodsTableCreateCompanionBuilder,
          $$PaymentMethodsTableUpdateCompanionBuilder,
          (PaymentMethod, $$PaymentMethodsTableReferences),
          PaymentMethod,
          PrefetchHooks Function({bool accountId, bool purchasesRefs})
        > {
  $$PaymentMethodsTableTableManager(
    _$LocalDatabase db,
    $PaymentMethodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentMethodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentMethodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentMethodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> visibleCode = const Value.absent(),
                Value<String> nickname = const Value.absent(),
                Value<String> normalizedNickname = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentMethodsCompanion(
                id: id,
                accountId: accountId,
                visibleCode: visibleCode,
                nickname: nickname,
                normalizedNickname: normalizedNickname,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String visibleCode,
                required String nickname,
                required String normalizedNickname,
                Value<bool> active = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentMethodsCompanion.insert(
                id: id,
                accountId: accountId,
                visibleCode: visibleCode,
                nickname: nickname,
                normalizedNickname: normalizedNickname,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentMethodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false, purchasesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (purchasesRefs) db.purchases],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable: $$PaymentMethodsTableReferences
                                    ._accountIdTable(db),
                                referencedColumn:
                                    $$PaymentMethodsTableReferences
                                        ._accountIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchasesRefs)
                    await $_getPrefetchedData<
                      PaymentMethod,
                      $PaymentMethodsTable,
                      Purchase
                    >(
                      currentTable: table,
                      referencedTable: $$PaymentMethodsTableReferences
                          ._purchasesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PaymentMethodsTableReferences(
                            db,
                            table,
                            p0,
                          ).purchasesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.paymentMethodId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PaymentMethodsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PaymentMethodsTable,
      PaymentMethod,
      $$PaymentMethodsTableFilterComposer,
      $$PaymentMethodsTableOrderingComposer,
      $$PaymentMethodsTableAnnotationComposer,
      $$PaymentMethodsTableCreateCompanionBuilder,
      $$PaymentMethodsTableUpdateCompanionBuilder,
      (PaymentMethod, $$PaymentMethodsTableReferences),
      PaymentMethod,
      PrefetchHooks Function({bool accountId, bool purchasesRefs})
    >;
typedef $$AccountPreferencesTableCreateCompanionBuilder =
    AccountPreferencesCompanion Function({
      required String accountId,
      Value<int> shortageThresholdDays,
      Value<int> nextPersonCode,
      Value<int> nextPaymentMethodCode,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AccountPreferencesTableUpdateCompanionBuilder =
    AccountPreferencesCompanion Function({
      Value<String> accountId,
      Value<int> shortageThresholdDays,
      Value<int> nextPersonCode,
      Value<int> nextPaymentMethodCode,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AccountPreferencesTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $AccountPreferencesTable,
          AccountPreference
        > {
  $$AccountPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) => db
      .localAccounts
      .createAlias('account_preferences__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AccountPreferencesTableFilterComposer
    extends Composer<_$LocalDatabase, $AccountPreferencesTable> {
  $$AccountPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get shortageThresholdDays => $composableBuilder(
    column: $table.shortageThresholdDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextPersonCode => $composableBuilder(
    column: $table.nextPersonCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextPaymentMethodCode => $composableBuilder(
    column: $table.nextPaymentMethodCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountPreferencesTableOrderingComposer
    extends Composer<_$LocalDatabase, $AccountPreferencesTable> {
  $$AccountPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get shortageThresholdDays => $composableBuilder(
    column: $table.shortageThresholdDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextPersonCode => $composableBuilder(
    column: $table.nextPersonCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextPaymentMethodCode => $composableBuilder(
    column: $table.nextPaymentMethodCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountPreferencesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $AccountPreferencesTable> {
  $$AccountPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get shortageThresholdDays => $composableBuilder(
    column: $table.shortageThresholdDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextPersonCode => $composableBuilder(
    column: $table.nextPersonCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextPaymentMethodCode => $composableBuilder(
    column: $table.nextPaymentMethodCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountPreferencesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $AccountPreferencesTable,
          AccountPreference,
          $$AccountPreferencesTableFilterComposer,
          $$AccountPreferencesTableOrderingComposer,
          $$AccountPreferencesTableAnnotationComposer,
          $$AccountPreferencesTableCreateCompanionBuilder,
          $$AccountPreferencesTableUpdateCompanionBuilder,
          (AccountPreference, $$AccountPreferencesTableReferences),
          AccountPreference,
          PrefetchHooks Function({bool accountId})
        > {
  $$AccountPreferencesTableTableManager(
    _$LocalDatabase db,
    $AccountPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<int> shortageThresholdDays = const Value.absent(),
                Value<int> nextPersonCode = const Value.absent(),
                Value<int> nextPaymentMethodCode = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountPreferencesCompanion(
                accountId: accountId,
                shortageThresholdDays: shortageThresholdDays,
                nextPersonCode: nextPersonCode,
                nextPaymentMethodCode: nextPaymentMethodCode,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                Value<int> shortageThresholdDays = const Value.absent(),
                Value<int> nextPersonCode = const Value.absent(),
                Value<int> nextPaymentMethodCode = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AccountPreferencesCompanion.insert(
                accountId: accountId,
                shortageThresholdDays: shortageThresholdDays,
                nextPersonCode: nextPersonCode,
                nextPaymentMethodCode: nextPaymentMethodCode,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable:
                                    $$AccountPreferencesTableReferences
                                        ._accountIdTable(db),
                                referencedColumn:
                                    $$AccountPreferencesTableReferences
                                        ._accountIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AccountPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $AccountPreferencesTable,
      AccountPreference,
      $$AccountPreferencesTableFilterComposer,
      $$AccountPreferencesTableOrderingComposer,
      $$AccountPreferencesTableAnnotationComposer,
      $$AccountPreferencesTableCreateCompanionBuilder,
      $$AccountPreferencesTableUpdateCompanionBuilder,
      (AccountPreference, $$AccountPreferencesTableReferences),
      AccountPreference,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$PurchasesTableCreateCompanionBuilder =
    PurchasesCompanion Function({
      required String id,
      required String accountId,
      required String storeId,
      Value<String?> personId,
      Value<String?> paymentMethodId,
      required DateTime occurrenceTime,
      required String currencyCode,
      required int totalMinorUnits,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PurchasesTableUpdateCompanionBuilder =
    PurchasesCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> storeId,
      Value<String?> personId,
      Value<String?> paymentMethodId,
      Value<DateTime> occurrenceTime,
      Value<String> currencyCode,
      Value<int> totalMinorUnits,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PurchasesTableReferences
    extends BaseReferences<_$LocalDatabase, $PurchasesTable, Purchase> {
  $$PurchasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) =>
      db.localAccounts.createAlias('purchases__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StoresTable _storeIdTable(_$LocalDatabase db) =>
      db.stores.createAlias('purchases__store_id__stores__id');

  $$StoresTableProcessedTableManager get storeId {
    final $_column = $_itemColumn<String>('store_id')!;

    final manager = $$StoresTableTableManager(
      $_db,
      $_db.stores,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_storeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PeopleTable _personIdTable(_$LocalDatabase db) =>
      db.people.createAlias('purchases__person_id__people__id');

  $$PeopleTableProcessedTableManager? get personId {
    final $_column = $_itemColumn<String>('person_id');
    if ($_column == null) return null;
    final manager = $$PeopleTableTableManager(
      $_db,
      $_db.people,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PaymentMethodsTable _paymentMethodIdTable(_$LocalDatabase db) => db
      .paymentMethods
      .createAlias('purchases__payment_method_id__payment_methods__id');

  $$PaymentMethodsTableProcessedTableManager? get paymentMethodId {
    final $_column = $_itemColumn<String>('payment_method_id');
    if ($_column == null) return null;
    final manager = $$PaymentMethodsTableTableManager(
      $_db,
      $_db.paymentMethods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentMethodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>>
  _purchaseItemsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseItems,
    aliasName: 'purchases__id__purchase_items__purchase_id',
  );

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager(
      $_db,
      $_db.purchaseItems,
    ).filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchasesTableFilterComposer
    extends Composer<_$LocalDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurrenceTime => $composableBuilder(
    column: $table.occurrenceTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMinorUnits => $composableBuilder(
    column: $table.totalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableFilterComposer get storeId {
    final $$StoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableFilterComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PeopleTableFilterComposer get personId {
    final $$PeopleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.people,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleTableFilterComposer(
            $db: $db,
            $table: $db.people,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableFilterComposer get paymentMethodId {
    final $$PaymentMethodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableFilterComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseItemsRefs(
    Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableOrderingComposer
    extends Composer<_$LocalDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurrenceTime => $composableBuilder(
    column: $table.occurrenceTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMinorUnits => $composableBuilder(
    column: $table.totalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableOrderingComposer get storeId {
    final $$StoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableOrderingComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PeopleTableOrderingComposer get personId {
    final $$PeopleTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.people,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleTableOrderingComposer(
            $db: $db,
            $table: $db.people,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableOrderingComposer get paymentMethodId {
    final $$PaymentMethodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableOrderingComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchasesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurrenceTime => $composableBuilder(
    column: $table.occurrenceTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalMinorUnits => $composableBuilder(
    column: $table.totalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StoresTableAnnotationComposer get storeId {
    final $$StoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.storeId,
      referencedTable: $db.stores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoresTableAnnotationComposer(
            $db: $db,
            $table: $db.stores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PeopleTableAnnotationComposer get personId {
    final $$PeopleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.people,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleTableAnnotationComposer(
            $db: $db,
            $table: $db.people,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentMethodsTableAnnotationComposer get paymentMethodId {
    final $$PaymentMethodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentMethodId,
      referencedTable: $db.paymentMethods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentMethodsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentMethods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PurchasesTable,
          Purchase,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (Purchase, $$PurchasesTableReferences),
          Purchase,
          PrefetchHooks Function({
            bool accountId,
            bool storeId,
            bool personId,
            bool paymentMethodId,
            bool purchaseItemsRefs,
          })
        > {
  $$PurchasesTableTableManager(_$LocalDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> storeId = const Value.absent(),
                Value<String?> personId = const Value.absent(),
                Value<String?> paymentMethodId = const Value.absent(),
                Value<DateTime> occurrenceTime = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> totalMinorUnits = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchasesCompanion(
                id: id,
                accountId: accountId,
                storeId: storeId,
                personId: personId,
                paymentMethodId: paymentMethodId,
                occurrenceTime: occurrenceTime,
                currencyCode: currencyCode,
                totalMinorUnits: totalMinorUnits,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String storeId,
                Value<String?> personId = const Value.absent(),
                Value<String?> paymentMethodId = const Value.absent(),
                required DateTime occurrenceTime,
                required String currencyCode,
                required int totalMinorUnits,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PurchasesCompanion.insert(
                id: id,
                accountId: accountId,
                storeId: storeId,
                personId: personId,
                paymentMethodId: paymentMethodId,
                occurrenceTime: occurrenceTime,
                currencyCode: currencyCode,
                totalMinorUnits: totalMinorUnits,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                storeId = false,
                personId = false,
                paymentMethodId = false,
                purchaseItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseItemsRefs) db.purchaseItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable: $$PurchasesTableReferences
                                        ._accountIdTable(db),
                                    referencedColumn: $$PurchasesTableReferences
                                        ._accountIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (storeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.storeId,
                                    referencedTable: $$PurchasesTableReferences
                                        ._storeIdTable(db),
                                    referencedColumn: $$PurchasesTableReferences
                                        ._storeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (personId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.personId,
                                    referencedTable: $$PurchasesTableReferences
                                        ._personIdTable(db),
                                    referencedColumn: $$PurchasesTableReferences
                                        ._personIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (paymentMethodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.paymentMethodId,
                                    referencedTable: $$PurchasesTableReferences
                                        ._paymentMethodIdTable(db),
                                    referencedColumn: $$PurchasesTableReferences
                                        ._paymentMethodIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseItemsRefs)
                        await $_getPrefetchedData<
                          Purchase,
                          $PurchasesTable,
                          PurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$PurchasesTableReferences
                              ._purchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchasesTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PurchasesTable,
      Purchase,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (Purchase, $$PurchasesTableReferences),
      Purchase,
      PrefetchHooks Function({
        bool accountId,
        bool storeId,
        bool personId,
        bool paymentMethodId,
        bool purchaseItemsRefs,
      })
    >;
typedef $$PurchaseItemsTableCreateCompanionBuilder =
    PurchaseItemsCompanion Function({
      required String id,
      required String purchaseId,
      required String productId,
      Value<int?> packageCount,
      required String measurementKind,
      required String purchasedAmount,
      required String purchasedUnit,
      required String currencyCode,
      required int lineTotalMinorUnits,
      Value<int> rowid,
    });
typedef $$PurchaseItemsTableUpdateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<String> id,
      Value<String> purchaseId,
      Value<String> productId,
      Value<int?> packageCount,
      Value<String> measurementKind,
      Value<String> purchasedAmount,
      Value<String> purchasedUnit,
      Value<String> currencyCode,
      Value<int> lineTotalMinorUnits,
      Value<int> rowid,
    });

final class $$PurchaseItemsTableReferences
    extends BaseReferences<_$LocalDatabase, $PurchaseItemsTable, PurchaseItem> {
  $$PurchaseItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchasesTable _purchaseIdTable(_$LocalDatabase db) =>
      db.purchases.createAlias('purchase_items__purchase_id__purchases__id');

  $$PurchasesTableProcessedTableManager get purchaseId {
    final $_column = $_itemColumn<String>('purchase_id')!;

    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$LocalDatabase db) =>
      db.products.createAlias('purchase_items__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchaseItemsTableFilterComposer
    extends Composer<_$LocalDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get packageCount => $composableBuilder(
    column: $table.packageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get measurementKind => $composableBuilder(
    column: $table.measurementKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchasedAmount => $composableBuilder(
    column: $table.purchasedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchasedUnit => $composableBuilder(
    column: $table.purchasedUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineTotalMinorUnits => $composableBuilder(
    column: $table.lineTotalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchasesTableFilterComposer get purchaseId {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableOrderingComposer
    extends Composer<_$LocalDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get packageCount => $composableBuilder(
    column: $table.packageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get measurementKind => $composableBuilder(
    column: $table.measurementKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchasedAmount => $composableBuilder(
    column: $table.purchasedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchasedUnit => $composableBuilder(
    column: $table.purchasedUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineTotalMinorUnits => $composableBuilder(
    column: $table.lineTotalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchasesTableOrderingComposer get purchaseId {
    final $$PurchasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableOrderingComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get packageCount => $composableBuilder(
    column: $table.packageCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get measurementKind => $composableBuilder(
    column: $table.measurementKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get purchasedAmount => $composableBuilder(
    column: $table.purchasedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get purchasedUnit => $composableBuilder(
    column: $table.purchasedUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineTotalMinorUnits => $composableBuilder(
    column: $table.lineTotalMinorUnits,
    builder: (column) => column,
  );

  $$PurchasesTableAnnotationComposer get purchaseId {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PurchaseItemsTable,
          PurchaseItem,
          $$PurchaseItemsTableFilterComposer,
          $$PurchaseItemsTableOrderingComposer,
          $$PurchaseItemsTableAnnotationComposer,
          $$PurchaseItemsTableCreateCompanionBuilder,
          $$PurchaseItemsTableUpdateCompanionBuilder,
          (PurchaseItem, $$PurchaseItemsTableReferences),
          PurchaseItem,
          PrefetchHooks Function({bool purchaseId, bool productId})
        > {
  $$PurchaseItemsTableTableManager(
    _$LocalDatabase db,
    $PurchaseItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> purchaseId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int?> packageCount = const Value.absent(),
                Value<String> measurementKind = const Value.absent(),
                Value<String> purchasedAmount = const Value.absent(),
                Value<String> purchasedUnit = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> lineTotalMinorUnits = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseItemsCompanion(
                id: id,
                purchaseId: purchaseId,
                productId: productId,
                packageCount: packageCount,
                measurementKind: measurementKind,
                purchasedAmount: purchasedAmount,
                purchasedUnit: purchasedUnit,
                currencyCode: currencyCode,
                lineTotalMinorUnits: lineTotalMinorUnits,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String purchaseId,
                required String productId,
                Value<int?> packageCount = const Value.absent(),
                required String measurementKind,
                required String purchasedAmount,
                required String purchasedUnit,
                required String currencyCode,
                required int lineTotalMinorUnits,
                Value<int> rowid = const Value.absent(),
              }) => PurchaseItemsCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                productId: productId,
                packageCount: packageCount,
                measurementKind: measurementKind,
                purchasedAmount: purchasedAmount,
                purchasedUnit: purchasedUnit,
                currencyCode: currencyCode,
                lineTotalMinorUnits: lineTotalMinorUnits,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (purchaseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.purchaseId,
                                referencedTable: $$PurchaseItemsTableReferences
                                    ._purchaseIdTable(db),
                                referencedColumn: $$PurchaseItemsTableReferences
                                    ._purchaseIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$PurchaseItemsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$PurchaseItemsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PurchaseItemsTable,
      PurchaseItem,
      $$PurchaseItemsTableFilterComposer,
      $$PurchaseItemsTableOrderingComposer,
      $$PurchaseItemsTableAnnotationComposer,
      $$PurchaseItemsTableCreateCompanionBuilder,
      $$PurchaseItemsTableUpdateCompanionBuilder,
      (PurchaseItem, $$PurchaseItemsTableReferences),
      PurchaseItem,
      PrefetchHooks Function({bool purchaseId, bool productId})
    >;
typedef $$SyncEventsTableCreateCompanionBuilder =
    SyncEventsCompanion Function({
      required String id,
      required String accountId,
      required String deviceId,
      required int deviceSequence,
      required String eventType,
      required int payloadVersion,
      required DateTime occurrenceTime,
      required String payloadJson,
      required String contentHash,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SyncEventsTableUpdateCompanionBuilder =
    SyncEventsCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> deviceId,
      Value<int> deviceSequence,
      Value<String> eventType,
      Value<int> payloadVersion,
      Value<DateTime> occurrenceTime,
      Value<String> payloadJson,
      Value<String> contentHash,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SyncEventsTableReferences
    extends BaseReferences<_$LocalDatabase, $SyncEventsTable, SyncEvent> {
  $$SyncEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) => db
      .localAccounts
      .createAlias('sync_events__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DevicesTable _deviceIdTable(_$LocalDatabase db) =>
      db.devices.createAlias('sync_events__device_id__devices__id');

  $$DevicesTableProcessedTableManager get deviceId {
    final $_column = $_itemColumn<String>('device_id')!;

    final manager = $$DevicesTableTableManager(
      $_db,
      $_db.devices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PendingEventsTable, List<PendingEvent>>
  _pendingEventsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.pendingEvents,
    aliasName: 'sync_events__id__pending_events__event_id',
  );

  $$PendingEventsTableProcessedTableManager get pendingEventsRefs {
    final manager = $$PendingEventsTableTableManager(
      $_db,
      $_db.pendingEvents,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pendingEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SyncSubmissionEventsTable,
    List<SyncSubmissionEvent>
  >
  _syncSubmissionEventsRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.syncSubmissionEvents,
        aliasName: 'sync_events__id__sync_submission_events__event_id',
      );

  $$SyncSubmissionEventsTableProcessedTableManager
  get syncSubmissionEventsRefs {
    final manager = $$SyncSubmissionEventsTableTableManager(
      $_db,
      $_db.syncSubmissionEvents,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _syncSubmissionEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SyncEventsTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncEventsTable> {
  $$SyncEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deviceSequence => $composableBuilder(
    column: $table.deviceSequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurrenceTime => $composableBuilder(
    column: $table.occurrenceTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableFilterComposer get deviceId {
    final $$DevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableFilterComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pendingEventsRefs(
    Expression<bool> Function($$PendingEventsTableFilterComposer f) f,
  ) {
    final $$PendingEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pendingEvents,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PendingEventsTableFilterComposer(
            $db: $db,
            $table: $db.pendingEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncSubmissionEventsRefs(
    Expression<bool> Function($$SyncSubmissionEventsTableFilterComposer f) f,
  ) {
    final $$SyncSubmissionEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncSubmissionEvents,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionEventsTableFilterComposer(
            $db: $db,
            $table: $db.syncSubmissionEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SyncEventsTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncEventsTable> {
  $$SyncEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deviceSequence => $composableBuilder(
    column: $table.deviceSequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurrenceTime => $composableBuilder(
    column: $table.occurrenceTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableOrderingComposer get deviceId {
    final $$DevicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableOrderingComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncEventsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncEventsTable> {
  $$SyncEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get deviceSequence => $composableBuilder(
    column: $table.deviceSequence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurrenceTime => $composableBuilder(
    column: $table.occurrenceTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableAnnotationComposer get deviceId {
    final $$DevicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableAnnotationComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pendingEventsRefs<T extends Object>(
    Expression<T> Function($$PendingEventsTableAnnotationComposer a) f,
  ) {
    final $$PendingEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pendingEvents,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PendingEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.pendingEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syncSubmissionEventsRefs<T extends Object>(
    Expression<T> Function($$SyncSubmissionEventsTableAnnotationComposer a) f,
  ) {
    final $$SyncSubmissionEventsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.syncSubmissionEvents,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SyncSubmissionEventsTableAnnotationComposer(
                $db: $db,
                $table: $db.syncSubmissionEvents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SyncEventsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SyncEventsTable,
          SyncEvent,
          $$SyncEventsTableFilterComposer,
          $$SyncEventsTableOrderingComposer,
          $$SyncEventsTableAnnotationComposer,
          $$SyncEventsTableCreateCompanionBuilder,
          $$SyncEventsTableUpdateCompanionBuilder,
          (SyncEvent, $$SyncEventsTableReferences),
          SyncEvent,
          PrefetchHooks Function({
            bool accountId,
            bool deviceId,
            bool pendingEventsRefs,
            bool syncSubmissionEventsRefs,
          })
        > {
  $$SyncEventsTableTableManager(_$LocalDatabase db, $SyncEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int> deviceSequence = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<int> payloadVersion = const Value.absent(),
                Value<DateTime> occurrenceTime = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<String> contentHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncEventsCompanion(
                id: id,
                accountId: accountId,
                deviceId: deviceId,
                deviceSequence: deviceSequence,
                eventType: eventType,
                payloadVersion: payloadVersion,
                occurrenceTime: occurrenceTime,
                payloadJson: payloadJson,
                contentHash: contentHash,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String deviceId,
                required int deviceSequence,
                required String eventType,
                required int payloadVersion,
                required DateTime occurrenceTime,
                required String payloadJson,
                required String contentHash,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncEventsCompanion.insert(
                id: id,
                accountId: accountId,
                deviceId: deviceId,
                deviceSequence: deviceSequence,
                eventType: eventType,
                payloadVersion: payloadVersion,
                occurrenceTime: occurrenceTime,
                payloadJson: payloadJson,
                contentHash: contentHash,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                deviceId = false,
                pendingEventsRefs = false,
                syncSubmissionEventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pendingEventsRefs) db.pendingEvents,
                    if (syncSubmissionEventsRefs) db.syncSubmissionEvents,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable: $$SyncEventsTableReferences
                                        ._accountIdTable(db),
                                    referencedColumn:
                                        $$SyncEventsTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (deviceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.deviceId,
                                    referencedTable: $$SyncEventsTableReferences
                                        ._deviceIdTable(db),
                                    referencedColumn:
                                        $$SyncEventsTableReferences
                                            ._deviceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pendingEventsRefs)
                        await $_getPrefetchedData<
                          SyncEvent,
                          $SyncEventsTable,
                          PendingEvent
                        >(
                          currentTable: table,
                          referencedTable: $$SyncEventsTableReferences
                              ._pendingEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SyncEventsTableReferences(
                                db,
                                table,
                                p0,
                              ).pendingEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncSubmissionEventsRefs)
                        await $_getPrefetchedData<
                          SyncEvent,
                          $SyncEventsTable,
                          SyncSubmissionEvent
                        >(
                          currentTable: table,
                          referencedTable: $$SyncEventsTableReferences
                              ._syncSubmissionEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SyncEventsTableReferences(
                                db,
                                table,
                                p0,
                              ).syncSubmissionEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SyncEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SyncEventsTable,
      SyncEvent,
      $$SyncEventsTableFilterComposer,
      $$SyncEventsTableOrderingComposer,
      $$SyncEventsTableAnnotationComposer,
      $$SyncEventsTableCreateCompanionBuilder,
      $$SyncEventsTableUpdateCompanionBuilder,
      (SyncEvent, $$SyncEventsTableReferences),
      SyncEvent,
      PrefetchHooks Function({
        bool accountId,
        bool deviceId,
        bool pendingEventsRefs,
        bool syncSubmissionEventsRefs,
      })
    >;
typedef $$PendingEventsTableCreateCompanionBuilder =
    PendingEventsCompanion Function({
      required String eventId,
      required String state,
      required DateTime enqueuedAt,
      Value<int> rowid,
    });
typedef $$PendingEventsTableUpdateCompanionBuilder =
    PendingEventsCompanion Function({
      Value<String> eventId,
      Value<String> state,
      Value<DateTime> enqueuedAt,
      Value<int> rowid,
    });

final class $$PendingEventsTableReferences
    extends BaseReferences<_$LocalDatabase, $PendingEventsTable, PendingEvent> {
  $$PendingEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SyncEventsTable _eventIdTable(_$LocalDatabase db) =>
      db.syncEvents.createAlias('pending_events__event_id__sync_events__id');

  $$SyncEventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$SyncEventsTableTableManager(
      $_db,
      $_db.syncEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PendingEventsTableFilterComposer
    extends Composer<_$LocalDatabase, $PendingEventsTable> {
  $$PendingEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get enqueuedAt => $composableBuilder(
    column: $table.enqueuedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SyncEventsTableFilterComposer get eventId {
    final $$SyncEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableFilterComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PendingEventsTableOrderingComposer
    extends Composer<_$LocalDatabase, $PendingEventsTable> {
  $$PendingEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get enqueuedAt => $composableBuilder(
    column: $table.enqueuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SyncEventsTableOrderingComposer get eventId {
    final $$SyncEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableOrderingComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PendingEventsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PendingEventsTable> {
  $$PendingEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<DateTime> get enqueuedAt => $composableBuilder(
    column: $table.enqueuedAt,
    builder: (column) => column,
  );

  $$SyncEventsTableAnnotationComposer get eventId {
    final $$SyncEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PendingEventsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PendingEventsTable,
          PendingEvent,
          $$PendingEventsTableFilterComposer,
          $$PendingEventsTableOrderingComposer,
          $$PendingEventsTableAnnotationComposer,
          $$PendingEventsTableCreateCompanionBuilder,
          $$PendingEventsTableUpdateCompanionBuilder,
          (PendingEvent, $$PendingEventsTableReferences),
          PendingEvent,
          PrefetchHooks Function({bool eventId})
        > {
  $$PendingEventsTableTableManager(
    _$LocalDatabase db,
    $PendingEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<DateTime> enqueuedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingEventsCompanion(
                eventId: eventId,
                state: state,
                enqueuedAt: enqueuedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required String state,
                required DateTime enqueuedAt,
                Value<int> rowid = const Value.absent(),
              }) => PendingEventsCompanion.insert(
                eventId: eventId,
                state: state,
                enqueuedAt: enqueuedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PendingEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$PendingEventsTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$PendingEventsTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PendingEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PendingEventsTable,
      PendingEvent,
      $$PendingEventsTableFilterComposer,
      $$PendingEventsTableOrderingComposer,
      $$PendingEventsTableAnnotationComposer,
      $$PendingEventsTableCreateCompanionBuilder,
      $$PendingEventsTableUpdateCompanionBuilder,
      (PendingEvent, $$PendingEventsTableReferences),
      PendingEvent,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$SyncStateTableCreateCompanionBuilder =
    SyncStateCompanion Function({
      required String accountId,
      Value<String?> accountCursor,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SyncStateTableUpdateCompanionBuilder =
    SyncStateCompanion Function({
      Value<String> accountId,
      Value<String?> accountCursor,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SyncStateTableReferences
    extends BaseReferences<_$LocalDatabase, $SyncStateTable, SyncStateData> {
  $$SyncStateTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) => db
      .localAccounts
      .createAlias('sync_state__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncStateTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncStateTable> {
  $$SyncStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get accountCursor => $composableBuilder(
    column: $table.accountCursor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStateTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncStateTable> {
  $$SyncStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get accountCursor => $composableBuilder(
    column: $table.accountCursor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStateTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncStateTable> {
  $$SyncStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get accountCursor => $composableBuilder(
    column: $table.accountCursor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStateTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SyncStateTable,
          SyncStateData,
          $$SyncStateTableFilterComposer,
          $$SyncStateTableOrderingComposer,
          $$SyncStateTableAnnotationComposer,
          $$SyncStateTableCreateCompanionBuilder,
          $$SyncStateTableUpdateCompanionBuilder,
          (SyncStateData, $$SyncStateTableReferences),
          SyncStateData,
          PrefetchHooks Function({bool accountId})
        > {
  $$SyncStateTableTableManager(_$LocalDatabase db, $SyncStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<String?> accountCursor = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion(
                accountId: accountId,
                accountCursor: accountCursor,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                Value<String?> accountCursor = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion.insert(
                accountId: accountId,
                accountCursor: accountCursor,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncStateTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable: $$SyncStateTableReferences
                                    ._accountIdTable(db),
                                referencedColumn: $$SyncStateTableReferences
                                    ._accountIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncStateTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SyncStateTable,
      SyncStateData,
      $$SyncStateTableFilterComposer,
      $$SyncStateTableOrderingComposer,
      $$SyncStateTableAnnotationComposer,
      $$SyncStateTableCreateCompanionBuilder,
      $$SyncStateTableUpdateCompanionBuilder,
      (SyncStateData, $$SyncStateTableReferences),
      SyncStateData,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$InstallationMetadataTableCreateCompanionBuilder =
    InstallationMetadataCompanion Function({
      required String id,
      required String accountId,
      required String currentDeviceId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$InstallationMetadataTableUpdateCompanionBuilder =
    InstallationMetadataCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> currentDeviceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$InstallationMetadataTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $InstallationMetadataTable,
          InstallationMetadataData
        > {
  $$InstallationMetadataTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) => db
      .localAccounts
      .createAlias('installation_metadata__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DevicesTable _currentDeviceIdTable(_$LocalDatabase db) => db.devices
      .createAlias('installation_metadata__current_device_id__devices__id');

  $$DevicesTableProcessedTableManager get currentDeviceId {
    final $_column = $_itemColumn<String>('current_device_id')!;

    final manager = $$DevicesTableTableManager(
      $_db,
      $_db.devices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currentDeviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InstallationMetadataTableFilterComposer
    extends Composer<_$LocalDatabase, $InstallationMetadataTable> {
  $$InstallationMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableFilterComposer get currentDeviceId {
    final $$DevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableFilterComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstallationMetadataTableOrderingComposer
    extends Composer<_$LocalDatabase, $InstallationMetadataTable> {
  $$InstallationMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableOrderingComposer get currentDeviceId {
    final $$DevicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableOrderingComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstallationMetadataTableAnnotationComposer
    extends Composer<_$LocalDatabase, $InstallationMetadataTable> {
  $$InstallationMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableAnnotationComposer get currentDeviceId {
    final $$DevicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentDeviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableAnnotationComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstallationMetadataTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $InstallationMetadataTable,
          InstallationMetadataData,
          $$InstallationMetadataTableFilterComposer,
          $$InstallationMetadataTableOrderingComposer,
          $$InstallationMetadataTableAnnotationComposer,
          $$InstallationMetadataTableCreateCompanionBuilder,
          $$InstallationMetadataTableUpdateCompanionBuilder,
          (InstallationMetadataData, $$InstallationMetadataTableReferences),
          InstallationMetadataData,
          PrefetchHooks Function({bool accountId, bool currentDeviceId})
        > {
  $$InstallationMetadataTableTableManager(
    _$LocalDatabase db,
    $InstallationMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallationMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstallationMetadataTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstallationMetadataTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> currentDeviceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallationMetadataCompanion(
                id: id,
                accountId: accountId,
                currentDeviceId: currentDeviceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String currentDeviceId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => InstallationMetadataCompanion.insert(
                id: id,
                accountId: accountId,
                currentDeviceId: currentDeviceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallationMetadataTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({accountId = false, currentDeviceId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$InstallationMetadataTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$InstallationMetadataTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (currentDeviceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.currentDeviceId,
                                    referencedTable:
                                        $$InstallationMetadataTableReferences
                                            ._currentDeviceIdTable(db),
                                    referencedColumn:
                                        $$InstallationMetadataTableReferences
                                            ._currentDeviceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$InstallationMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $InstallationMetadataTable,
      InstallationMetadataData,
      $$InstallationMetadataTableFilterComposer,
      $$InstallationMetadataTableOrderingComposer,
      $$InstallationMetadataTableAnnotationComposer,
      $$InstallationMetadataTableCreateCompanionBuilder,
      $$InstallationMetadataTableUpdateCompanionBuilder,
      (InstallationMetadataData, $$InstallationMetadataTableReferences),
      InstallationMetadataData,
      PrefetchHooks Function({bool accountId, bool currentDeviceId})
    >;
typedef $$SyncSubmissionsTableCreateCompanionBuilder =
    SyncSubmissionsCompanion Function({
      required String id,
      required String accountId,
      required String deviceId,
      required String requestHash,
      required String state,
      Value<int> attemptCount,
      Value<DateTime?> nextAttemptAt,
      Value<DateTime?> leaseUntil,
      Value<String?> outcome,
      Value<String?> responseCode,
      Value<String?> errorCode,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SyncSubmissionsTableUpdateCompanionBuilder =
    SyncSubmissionsCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> deviceId,
      Value<String> requestHash,
      Value<String> state,
      Value<int> attemptCount,
      Value<DateTime?> nextAttemptAt,
      Value<DateTime?> leaseUntil,
      Value<String?> outcome,
      Value<String?> responseCode,
      Value<String?> errorCode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SyncSubmissionsTableReferences
    extends
        BaseReferences<_$LocalDatabase, $SyncSubmissionsTable, SyncSubmission> {
  $$SyncSubmissionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) => db
      .localAccounts
      .createAlias('sync_submissions__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DevicesTable _deviceIdTable(_$LocalDatabase db) =>
      db.devices.createAlias('sync_submissions__device_id__devices__id');

  $$DevicesTableProcessedTableManager get deviceId {
    final $_column = $_itemColumn<String>('device_id')!;

    final manager = $$DevicesTableTableManager(
      $_db,
      $_db.devices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SyncSubmissionEventsTable,
    List<SyncSubmissionEvent>
  >
  _syncSubmissionEventsRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.syncSubmissionEvents,
        aliasName:
            'sync_submissions__id__sync_submission_events__submission_id',
      );

  $$SyncSubmissionEventsTableProcessedTableManager
  get syncSubmissionEventsRefs {
    final manager = $$SyncSubmissionEventsTableTableManager(
      $_db,
      $_db.syncSubmissionEvents,
    ).filter((f) => f.submissionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _syncSubmissionEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SyncSubmissionsTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncSubmissionsTable> {
  $$SyncSubmissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requestHash => $composableBuilder(
    column: $table.requestHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get leaseUntil => $composableBuilder(
    column: $table.leaseUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseCode => $composableBuilder(
    column: $table.responseCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableFilterComposer get deviceId {
    final $$DevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableFilterComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> syncSubmissionEventsRefs(
    Expression<bool> Function($$SyncSubmissionEventsTableFilterComposer f) f,
  ) {
    final $$SyncSubmissionEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncSubmissionEvents,
      getReferencedColumn: (t) => t.submissionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionEventsTableFilterComposer(
            $db: $db,
            $table: $db.syncSubmissionEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SyncSubmissionsTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncSubmissionsTable> {
  $$SyncSubmissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requestHash => $composableBuilder(
    column: $table.requestHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get leaseUntil => $composableBuilder(
    column: $table.leaseUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseCode => $composableBuilder(
    column: $table.responseCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableOrderingComposer get deviceId {
    final $$DevicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableOrderingComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncSubmissionsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncSubmissionsTable> {
  $$SyncSubmissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get requestHash => $composableBuilder(
    column: $table.requestHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get leaseUntil => $composableBuilder(
    column: $table.leaseUntil,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get responseCode => $composableBuilder(
    column: $table.responseCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DevicesTableAnnotationComposer get deviceId {
    final $$DevicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceId,
      referencedTable: $db.devices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevicesTableAnnotationComposer(
            $db: $db,
            $table: $db.devices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> syncSubmissionEventsRefs<T extends Object>(
    Expression<T> Function($$SyncSubmissionEventsTableAnnotationComposer a) f,
  ) {
    final $$SyncSubmissionEventsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.syncSubmissionEvents,
          getReferencedColumn: (t) => t.submissionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SyncSubmissionEventsTableAnnotationComposer(
                $db: $db,
                $table: $db.syncSubmissionEvents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SyncSubmissionsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SyncSubmissionsTable,
          SyncSubmission,
          $$SyncSubmissionsTableFilterComposer,
          $$SyncSubmissionsTableOrderingComposer,
          $$SyncSubmissionsTableAnnotationComposer,
          $$SyncSubmissionsTableCreateCompanionBuilder,
          $$SyncSubmissionsTableUpdateCompanionBuilder,
          (SyncSubmission, $$SyncSubmissionsTableReferences),
          SyncSubmission,
          PrefetchHooks Function({
            bool accountId,
            bool deviceId,
            bool syncSubmissionEventsRefs,
          })
        > {
  $$SyncSubmissionsTableTableManager(
    _$LocalDatabase db,
    $SyncSubmissionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncSubmissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncSubmissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncSubmissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> requestHash = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<DateTime?> leaseUntil = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<String?> responseCode = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncSubmissionsCompanion(
                id: id,
                accountId: accountId,
                deviceId: deviceId,
                requestHash: requestHash,
                state: state,
                attemptCount: attemptCount,
                nextAttemptAt: nextAttemptAt,
                leaseUntil: leaseUntil,
                outcome: outcome,
                responseCode: responseCode,
                errorCode: errorCode,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String deviceId,
                required String requestHash,
                required String state,
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<DateTime?> leaseUntil = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<String?> responseCode = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncSubmissionsCompanion.insert(
                id: id,
                accountId: accountId,
                deviceId: deviceId,
                requestHash: requestHash,
                state: state,
                attemptCount: attemptCount,
                nextAttemptAt: nextAttemptAt,
                leaseUntil: leaseUntil,
                outcome: outcome,
                responseCode: responseCode,
                errorCode: errorCode,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncSubmissionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                deviceId = false,
                syncSubmissionEventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (syncSubmissionEventsRefs) db.syncSubmissionEvents,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$SyncSubmissionsTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$SyncSubmissionsTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (deviceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.deviceId,
                                    referencedTable:
                                        $$SyncSubmissionsTableReferences
                                            ._deviceIdTable(db),
                                    referencedColumn:
                                        $$SyncSubmissionsTableReferences
                                            ._deviceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (syncSubmissionEventsRefs)
                        await $_getPrefetchedData<
                          SyncSubmission,
                          $SyncSubmissionsTable,
                          SyncSubmissionEvent
                        >(
                          currentTable: table,
                          referencedTable: $$SyncSubmissionsTableReferences
                              ._syncSubmissionEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SyncSubmissionsTableReferences(
                                db,
                                table,
                                p0,
                              ).syncSubmissionEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.submissionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SyncSubmissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SyncSubmissionsTable,
      SyncSubmission,
      $$SyncSubmissionsTableFilterComposer,
      $$SyncSubmissionsTableOrderingComposer,
      $$SyncSubmissionsTableAnnotationComposer,
      $$SyncSubmissionsTableCreateCompanionBuilder,
      $$SyncSubmissionsTableUpdateCompanionBuilder,
      (SyncSubmission, $$SyncSubmissionsTableReferences),
      SyncSubmission,
      PrefetchHooks Function({
        bool accountId,
        bool deviceId,
        bool syncSubmissionEventsRefs,
      })
    >;
typedef $$SyncSubmissionEventsTableCreateCompanionBuilder =
    SyncSubmissionEventsCompanion Function({
      required String submissionId,
      required String eventId,
      required int position,
      Value<int> rowid,
    });
typedef $$SyncSubmissionEventsTableUpdateCompanionBuilder =
    SyncSubmissionEventsCompanion Function({
      Value<String> submissionId,
      Value<String> eventId,
      Value<int> position,
      Value<int> rowid,
    });

final class $$SyncSubmissionEventsTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $SyncSubmissionEventsTable,
          SyncSubmissionEvent
        > {
  $$SyncSubmissionEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SyncSubmissionsTable _submissionIdTable(_$LocalDatabase db) =>
      db.syncSubmissions.createAlias(
        'sync_submission_events__submission_id__sync_submissions__id',
      );

  $$SyncSubmissionsTableProcessedTableManager get submissionId {
    final $_column = $_itemColumn<String>('submission_id')!;

    final manager = $$SyncSubmissionsTableTableManager(
      $_db,
      $_db.syncSubmissions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_submissionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SyncEventsTable _eventIdTable(_$LocalDatabase db) => db.syncEvents
      .createAlias('sync_submission_events__event_id__sync_events__id');

  $$SyncEventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$SyncEventsTableTableManager(
      $_db,
      $_db.syncEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncSubmissionEventsTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncSubmissionEventsTable> {
  $$SyncSubmissionEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$SyncSubmissionsTableFilterComposer get submissionId {
    final $$SyncSubmissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.submissionId,
      referencedTable: $db.syncSubmissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionsTableFilterComposer(
            $db: $db,
            $table: $db.syncSubmissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SyncEventsTableFilterComposer get eventId {
    final $$SyncEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableFilterComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncSubmissionEventsTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncSubmissionEventsTable> {
  $$SyncSubmissionEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$SyncSubmissionsTableOrderingComposer get submissionId {
    final $$SyncSubmissionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.submissionId,
      referencedTable: $db.syncSubmissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionsTableOrderingComposer(
            $db: $db,
            $table: $db.syncSubmissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SyncEventsTableOrderingComposer get eventId {
    final $$SyncEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableOrderingComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncSubmissionEventsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncSubmissionEventsTable> {
  $$SyncSubmissionEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$SyncSubmissionsTableAnnotationComposer get submissionId {
    final $$SyncSubmissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.submissionId,
      referencedTable: $db.syncSubmissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncSubmissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncSubmissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SyncEventsTableAnnotationComposer get eventId {
    final $$SyncEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.syncEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncSubmissionEventsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SyncSubmissionEventsTable,
          SyncSubmissionEvent,
          $$SyncSubmissionEventsTableFilterComposer,
          $$SyncSubmissionEventsTableOrderingComposer,
          $$SyncSubmissionEventsTableAnnotationComposer,
          $$SyncSubmissionEventsTableCreateCompanionBuilder,
          $$SyncSubmissionEventsTableUpdateCompanionBuilder,
          (SyncSubmissionEvent, $$SyncSubmissionEventsTableReferences),
          SyncSubmissionEvent,
          PrefetchHooks Function({bool submissionId, bool eventId})
        > {
  $$SyncSubmissionEventsTableTableManager(
    _$LocalDatabase db,
    $SyncSubmissionEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncSubmissionEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncSubmissionEventsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SyncSubmissionEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> submissionId = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncSubmissionEventsCompanion(
                submissionId: submissionId,
                eventId: eventId,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String submissionId,
                required String eventId,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => SyncSubmissionEventsCompanion.insert(
                submissionId: submissionId,
                eventId: eventId,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncSubmissionEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({submissionId = false, eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (submissionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.submissionId,
                                referencedTable:
                                    $$SyncSubmissionEventsTableReferences
                                        ._submissionIdTable(db),
                                referencedColumn:
                                    $$SyncSubmissionEventsTableReferences
                                        ._submissionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable:
                                    $$SyncSubmissionEventsTableReferences
                                        ._eventIdTable(db),
                                referencedColumn:
                                    $$SyncSubmissionEventsTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncSubmissionEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SyncSubmissionEventsTable,
      SyncSubmissionEvent,
      $$SyncSubmissionEventsTableFilterComposer,
      $$SyncSubmissionEventsTableOrderingComposer,
      $$SyncSubmissionEventsTableAnnotationComposer,
      $$SyncSubmissionEventsTableCreateCompanionBuilder,
      $$SyncSubmissionEventsTableUpdateCompanionBuilder,
      (SyncSubmissionEvent, $$SyncSubmissionEventsTableReferences),
      SyncSubmissionEvent,
      PrefetchHooks Function({bool submissionId, bool eventId})
    >;
typedef $$SyncInboxTableCreateCompanionBuilder =
    SyncInboxCompanion Function({
      required String accountId,
      required String eventId,
      required String contentHash,
      required String serverCursor,
      required String state,
      Value<DateTime?> appliedAt,
      Value<int> rowid,
    });
typedef $$SyncInboxTableUpdateCompanionBuilder =
    SyncInboxCompanion Function({
      Value<String> accountId,
      Value<String> eventId,
      Value<String> contentHash,
      Value<String> serverCursor,
      Value<String> state,
      Value<DateTime?> appliedAt,
      Value<int> rowid,
    });

final class $$SyncInboxTableReferences
    extends BaseReferences<_$LocalDatabase, $SyncInboxTable, SyncInboxData> {
  $$SyncInboxTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalAccountsTable _accountIdTable(_$LocalDatabase db) => db
      .localAccounts
      .createAlias('sync_inbox__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncInboxTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncInboxTable> {
  $$SyncInboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverCursor => $composableBuilder(
    column: $table.serverCursor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncInboxTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncInboxTable> {
  $$SyncInboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverCursor => $composableBuilder(
    column: $table.serverCursor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncInboxTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncInboxTable> {
  $$SyncInboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverCursor => $composableBuilder(
    column: $table.serverCursor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<DateTime> get appliedAt =>
      $composableBuilder(column: $table.appliedAt, builder: (column) => column);

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncInboxTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SyncInboxTable,
          SyncInboxData,
          $$SyncInboxTableFilterComposer,
          $$SyncInboxTableOrderingComposer,
          $$SyncInboxTableAnnotationComposer,
          $$SyncInboxTableCreateCompanionBuilder,
          $$SyncInboxTableUpdateCompanionBuilder,
          (SyncInboxData, $$SyncInboxTableReferences),
          SyncInboxData,
          PrefetchHooks Function({bool accountId})
        > {
  $$SyncInboxTableTableManager(_$LocalDatabase db, $SyncInboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncInboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncInboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncInboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> contentHash = const Value.absent(),
                Value<String> serverCursor = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<DateTime?> appliedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncInboxCompanion(
                accountId: accountId,
                eventId: eventId,
                contentHash: contentHash,
                serverCursor: serverCursor,
                state: state,
                appliedAt: appliedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                required String eventId,
                required String contentHash,
                required String serverCursor,
                required String state,
                Value<DateTime?> appliedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncInboxCompanion.insert(
                accountId: accountId,
                eventId: eventId,
                contentHash: contentHash,
                serverCursor: serverCursor,
                state: state,
                appliedAt: appliedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncInboxTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable: $$SyncInboxTableReferences
                                    ._accountIdTable(db),
                                referencedColumn: $$SyncInboxTableReferences
                                    ._accountIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncInboxTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SyncInboxTable,
      SyncInboxData,
      $$SyncInboxTableFilterComposer,
      $$SyncInboxTableOrderingComposer,
      $$SyncInboxTableAnnotationComposer,
      $$SyncInboxTableCreateCompanionBuilder,
      $$SyncInboxTableUpdateCompanionBuilder,
      (SyncInboxData, $$SyncInboxTableReferences),
      SyncInboxData,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$RecoverySessionsTableCreateCompanionBuilder =
    RecoverySessionsCompanion Function({
      required String id,
      required String accountId,
      required String snapshotId,
      required String phase,
      required int formatVersion,
      required String manifestHash,
      required String coveredThroughCursor,
      required DateTime expiresAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RecoverySessionsTableUpdateCompanionBuilder =
    RecoverySessionsCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String> snapshotId,
      Value<String> phase,
      Value<int> formatVersion,
      Value<String> manifestHash,
      Value<String> coveredThroughCursor,
      Value<DateTime> expiresAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$RecoverySessionsTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $RecoverySessionsTable,
          RecoverySession
        > {
  $$RecoverySessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$RecoveryChunksTable, List<RecoveryChunk>>
  _recoveryChunksRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.recoveryChunks,
    aliasName: 'recovery_sessions__id__recovery_chunks__session_id',
  );

  $$RecoveryChunksTableProcessedTableManager get recoveryChunksRefs {
    final manager = $$RecoveryChunksTableTableManager(
      $_db,
      $_db.recoveryChunks,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_recoveryChunksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecoverySessionsTableFilterComposer
    extends Composer<_$LocalDatabase, $RecoverySessionsTable> {
  $$RecoverySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snapshotId => $composableBuilder(
    column: $table.snapshotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manifestHash => $composableBuilder(
    column: $table.manifestHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coveredThroughCursor => $composableBuilder(
    column: $table.coveredThroughCursor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recoveryChunksRefs(
    Expression<bool> Function($$RecoveryChunksTableFilterComposer f) f,
  ) {
    final $$RecoveryChunksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recoveryChunks,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecoveryChunksTableFilterComposer(
            $db: $db,
            $table: $db.recoveryChunks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecoverySessionsTableOrderingComposer
    extends Composer<_$LocalDatabase, $RecoverySessionsTable> {
  $$RecoverySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snapshotId => $composableBuilder(
    column: $table.snapshotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manifestHash => $composableBuilder(
    column: $table.manifestHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coveredThroughCursor => $composableBuilder(
    column: $table.coveredThroughCursor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecoverySessionsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $RecoverySessionsTable> {
  $$RecoverySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get snapshotId => $composableBuilder(
    column: $table.snapshotId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phase =>
      $composableBuilder(column: $table.phase, builder: (column) => column);

  GeneratedColumn<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get manifestHash => $composableBuilder(
    column: $table.manifestHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coveredThroughCursor => $composableBuilder(
    column: $table.coveredThroughCursor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> recoveryChunksRefs<T extends Object>(
    Expression<T> Function($$RecoveryChunksTableAnnotationComposer a) f,
  ) {
    final $$RecoveryChunksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recoveryChunks,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecoveryChunksTableAnnotationComposer(
            $db: $db,
            $table: $db.recoveryChunks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecoverySessionsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $RecoverySessionsTable,
          RecoverySession,
          $$RecoverySessionsTableFilterComposer,
          $$RecoverySessionsTableOrderingComposer,
          $$RecoverySessionsTableAnnotationComposer,
          $$RecoverySessionsTableCreateCompanionBuilder,
          $$RecoverySessionsTableUpdateCompanionBuilder,
          (RecoverySession, $$RecoverySessionsTableReferences),
          RecoverySession,
          PrefetchHooks Function({bool recoveryChunksRefs})
        > {
  $$RecoverySessionsTableTableManager(
    _$LocalDatabase db,
    $RecoverySessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecoverySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecoverySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecoverySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> snapshotId = const Value.absent(),
                Value<String> phase = const Value.absent(),
                Value<int> formatVersion = const Value.absent(),
                Value<String> manifestHash = const Value.absent(),
                Value<String> coveredThroughCursor = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoverySessionsCompanion(
                id: id,
                accountId: accountId,
                snapshotId: snapshotId,
                phase: phase,
                formatVersion: formatVersion,
                manifestHash: manifestHash,
                coveredThroughCursor: coveredThroughCursor,
                expiresAt: expiresAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String snapshotId,
                required String phase,
                required int formatVersion,
                required String manifestHash,
                required String coveredThroughCursor,
                required DateTime expiresAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RecoverySessionsCompanion.insert(
                id: id,
                accountId: accountId,
                snapshotId: snapshotId,
                phase: phase,
                formatVersion: formatVersion,
                manifestHash: manifestHash,
                coveredThroughCursor: coveredThroughCursor,
                expiresAt: expiresAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecoverySessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recoveryChunksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (recoveryChunksRefs) db.recoveryChunks,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recoveryChunksRefs)
                    await $_getPrefetchedData<
                      RecoverySession,
                      $RecoverySessionsTable,
                      RecoveryChunk
                    >(
                      currentTable: table,
                      referencedTable: $$RecoverySessionsTableReferences
                          ._recoveryChunksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RecoverySessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).recoveryChunksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RecoverySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $RecoverySessionsTable,
      RecoverySession,
      $$RecoverySessionsTableFilterComposer,
      $$RecoverySessionsTableOrderingComposer,
      $$RecoverySessionsTableAnnotationComposer,
      $$RecoverySessionsTableCreateCompanionBuilder,
      $$RecoverySessionsTableUpdateCompanionBuilder,
      (RecoverySession, $$RecoverySessionsTableReferences),
      RecoverySession,
      PrefetchHooks Function({bool recoveryChunksRefs})
    >;
typedef $$RecoveryChunksTableCreateCompanionBuilder =
    RecoveryChunksCompanion Function({
      required String sessionId,
      required int chunkIndex,
      required int byteLength,
      required String contentHash,
      required Uint8List bytes,
      required DateTime verifiedAt,
      Value<int> rowid,
    });
typedef $$RecoveryChunksTableUpdateCompanionBuilder =
    RecoveryChunksCompanion Function({
      Value<String> sessionId,
      Value<int> chunkIndex,
      Value<int> byteLength,
      Value<String> contentHash,
      Value<Uint8List> bytes,
      Value<DateTime> verifiedAt,
      Value<int> rowid,
    });

final class $$RecoveryChunksTableReferences
    extends
        BaseReferences<_$LocalDatabase, $RecoveryChunksTable, RecoveryChunk> {
  $$RecoveryChunksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecoverySessionsTable _sessionIdTable(_$LocalDatabase db) => db
      .recoverySessions
      .createAlias('recovery_chunks__session_id__recovery_sessions__id');

  $$RecoverySessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$RecoverySessionsTableTableManager(
      $_db,
      $_db.recoverySessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecoveryChunksTableFilterComposer
    extends Composer<_$LocalDatabase, $RecoveryChunksTable> {
  $$RecoveryChunksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get chunkIndex => $composableBuilder(
    column: $table.chunkIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RecoverySessionsTableFilterComposer get sessionId {
    final $$RecoverySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.recoverySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecoverySessionsTableFilterComposer(
            $db: $db,
            $table: $db.recoverySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecoveryChunksTableOrderingComposer
    extends Composer<_$LocalDatabase, $RecoveryChunksTable> {
  $$RecoveryChunksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get chunkIndex => $composableBuilder(
    column: $table.chunkIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecoverySessionsTableOrderingComposer get sessionId {
    final $$RecoverySessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.recoverySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecoverySessionsTableOrderingComposer(
            $db: $db,
            $table: $db.recoverySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecoveryChunksTableAnnotationComposer
    extends Composer<_$LocalDatabase, $RecoveryChunksTable> {
  $$RecoveryChunksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get chunkIndex => $composableBuilder(
    column: $table.chunkIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get bytes =>
      $composableBuilder(column: $table.bytes, builder: (column) => column);

  GeneratedColumn<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => column,
  );

  $$RecoverySessionsTableAnnotationComposer get sessionId {
    final $$RecoverySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.recoverySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecoverySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.recoverySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecoveryChunksTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $RecoveryChunksTable,
          RecoveryChunk,
          $$RecoveryChunksTableFilterComposer,
          $$RecoveryChunksTableOrderingComposer,
          $$RecoveryChunksTableAnnotationComposer,
          $$RecoveryChunksTableCreateCompanionBuilder,
          $$RecoveryChunksTableUpdateCompanionBuilder,
          (RecoveryChunk, $$RecoveryChunksTableReferences),
          RecoveryChunk,
          PrefetchHooks Function({bool sessionId})
        > {
  $$RecoveryChunksTableTableManager(
    _$LocalDatabase db,
    $RecoveryChunksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecoveryChunksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecoveryChunksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecoveryChunksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<int> chunkIndex = const Value.absent(),
                Value<int> byteLength = const Value.absent(),
                Value<String> contentHash = const Value.absent(),
                Value<Uint8List> bytes = const Value.absent(),
                Value<DateTime> verifiedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoveryChunksCompanion(
                sessionId: sessionId,
                chunkIndex: chunkIndex,
                byteLength: byteLength,
                contentHash: contentHash,
                bytes: bytes,
                verifiedAt: verifiedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                required int chunkIndex,
                required int byteLength,
                required String contentHash,
                required Uint8List bytes,
                required DateTime verifiedAt,
                Value<int> rowid = const Value.absent(),
              }) => RecoveryChunksCompanion.insert(
                sessionId: sessionId,
                chunkIndex: chunkIndex,
                byteLength: byteLength,
                contentHash: contentHash,
                bytes: bytes,
                verifiedAt: verifiedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecoveryChunksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$RecoveryChunksTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn:
                                    $$RecoveryChunksTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecoveryChunksTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $RecoveryChunksTable,
      RecoveryChunk,
      $$RecoveryChunksTableFilterComposer,
      $$RecoveryChunksTableOrderingComposer,
      $$RecoveryChunksTableAnnotationComposer,
      $$RecoveryChunksTableCreateCompanionBuilder,
      $$RecoveryChunksTableUpdateCompanionBuilder,
      (RecoveryChunk, $$RecoveryChunksTableReferences),
      RecoveryChunk,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$HostedAuthStatesTableCreateCompanionBuilder =
    HostedAuthStatesCompanion Function({
      required String environmentAlias,
      required String installationId,
      Value<String?> enrollmentRequestId,
      required String enrollmentState,
      Value<String?> accountId,
      Value<String?> serverDeviceId,
      Value<int?> generation,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$HostedAuthStatesTableUpdateCompanionBuilder =
    HostedAuthStatesCompanion Function({
      Value<String> environmentAlias,
      Value<String> installationId,
      Value<String?> enrollmentRequestId,
      Value<String> enrollmentState,
      Value<String?> accountId,
      Value<String?> serverDeviceId,
      Value<int?> generation,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$HostedAuthStatesTableFilterComposer
    extends Composer<_$LocalDatabase, $HostedAuthStatesTable> {
  $$HostedAuthStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get environmentAlias => $composableBuilder(
    column: $table.environmentAlias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enrollmentRequestId => $composableBuilder(
    column: $table.enrollmentRequestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enrollmentState => $composableBuilder(
    column: $table.enrollmentState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverDeviceId => $composableBuilder(
    column: $table.serverDeviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generation => $composableBuilder(
    column: $table.generation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HostedAuthStatesTableOrderingComposer
    extends Composer<_$LocalDatabase, $HostedAuthStatesTable> {
  $$HostedAuthStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get environmentAlias => $composableBuilder(
    column: $table.environmentAlias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enrollmentRequestId => $composableBuilder(
    column: $table.enrollmentRequestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enrollmentState => $composableBuilder(
    column: $table.enrollmentState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverDeviceId => $composableBuilder(
    column: $table.serverDeviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generation => $composableBuilder(
    column: $table.generation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HostedAuthStatesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $HostedAuthStatesTable> {
  $$HostedAuthStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get environmentAlias => $composableBuilder(
    column: $table.environmentAlias,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enrollmentRequestId => $composableBuilder(
    column: $table.enrollmentRequestId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enrollmentState => $composableBuilder(
    column: $table.enrollmentState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get serverDeviceId => $composableBuilder(
    column: $table.serverDeviceId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get generation => $composableBuilder(
    column: $table.generation,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HostedAuthStatesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $HostedAuthStatesTable,
          HostedAuthState,
          $$HostedAuthStatesTableFilterComposer,
          $$HostedAuthStatesTableOrderingComposer,
          $$HostedAuthStatesTableAnnotationComposer,
          $$HostedAuthStatesTableCreateCompanionBuilder,
          $$HostedAuthStatesTableUpdateCompanionBuilder,
          (
            HostedAuthState,
            BaseReferences<
              _$LocalDatabase,
              $HostedAuthStatesTable,
              HostedAuthState
            >,
          ),
          HostedAuthState,
          PrefetchHooks Function()
        > {
  $$HostedAuthStatesTableTableManager(
    _$LocalDatabase db,
    $HostedAuthStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HostedAuthStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HostedAuthStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HostedAuthStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> environmentAlias = const Value.absent(),
                Value<String> installationId = const Value.absent(),
                Value<String?> enrollmentRequestId = const Value.absent(),
                Value<String> enrollmentState = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> serverDeviceId = const Value.absent(),
                Value<int?> generation = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HostedAuthStatesCompanion(
                environmentAlias: environmentAlias,
                installationId: installationId,
                enrollmentRequestId: enrollmentRequestId,
                enrollmentState: enrollmentState,
                accountId: accountId,
                serverDeviceId: serverDeviceId,
                generation: generation,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String environmentAlias,
                required String installationId,
                Value<String?> enrollmentRequestId = const Value.absent(),
                required String enrollmentState,
                Value<String?> accountId = const Value.absent(),
                Value<String?> serverDeviceId = const Value.absent(),
                Value<int?> generation = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HostedAuthStatesCompanion.insert(
                environmentAlias: environmentAlias,
                installationId: installationId,
                enrollmentRequestId: enrollmentRequestId,
                enrollmentState: enrollmentState,
                accountId: accountId,
                serverDeviceId: serverDeviceId,
                generation: generation,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HostedAuthStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $HostedAuthStatesTable,
      HostedAuthState,
      $$HostedAuthStatesTableFilterComposer,
      $$HostedAuthStatesTableOrderingComposer,
      $$HostedAuthStatesTableAnnotationComposer,
      $$HostedAuthStatesTableCreateCompanionBuilder,
      $$HostedAuthStatesTableUpdateCompanionBuilder,
      (
        HostedAuthState,
        BaseReferences<
          _$LocalDatabase,
          $HostedAuthStatesTable,
          HostedAuthState
        >,
      ),
      HostedAuthState,
      PrefetchHooks Function()
    >;
typedef $$MigrationLedgerTableCreateCompanionBuilder =
    MigrationLedgerCompanion Function({
      Value<int> id,
      required String schemaName,
      required int schemaVersion,
      Value<int?> fromVersion,
      Value<int?> toVersion,
      Value<String?> migrationId,
      required DateTime appliedAt,
    });
typedef $$MigrationLedgerTableUpdateCompanionBuilder =
    MigrationLedgerCompanion Function({
      Value<int> id,
      Value<String> schemaName,
      Value<int> schemaVersion,
      Value<int?> fromVersion,
      Value<int?> toVersion,
      Value<String?> migrationId,
      Value<DateTime> appliedAt,
    });

class $$MigrationLedgerTableFilterComposer
    extends Composer<_$LocalDatabase, $MigrationLedgerTable> {
  $$MigrationLedgerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schemaName => $composableBuilder(
    column: $table.schemaName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fromVersion => $composableBuilder(
    column: $table.fromVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toVersion => $composableBuilder(
    column: $table.toVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get migrationId => $composableBuilder(
    column: $table.migrationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MigrationLedgerTableOrderingComposer
    extends Composer<_$LocalDatabase, $MigrationLedgerTable> {
  $$MigrationLedgerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schemaName => $composableBuilder(
    column: $table.schemaName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fromVersion => $composableBuilder(
    column: $table.fromVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toVersion => $composableBuilder(
    column: $table.toVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get migrationId => $composableBuilder(
    column: $table.migrationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MigrationLedgerTableAnnotationComposer
    extends Composer<_$LocalDatabase, $MigrationLedgerTable> {
  $$MigrationLedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get schemaName => $composableBuilder(
    column: $table.schemaName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fromVersion => $composableBuilder(
    column: $table.fromVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get toVersion =>
      $composableBuilder(column: $table.toVersion, builder: (column) => column);

  GeneratedColumn<String> get migrationId => $composableBuilder(
    column: $table.migrationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get appliedAt =>
      $composableBuilder(column: $table.appliedAt, builder: (column) => column);
}

class $$MigrationLedgerTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $MigrationLedgerTable,
          MigrationLedgerData,
          $$MigrationLedgerTableFilterComposer,
          $$MigrationLedgerTableOrderingComposer,
          $$MigrationLedgerTableAnnotationComposer,
          $$MigrationLedgerTableCreateCompanionBuilder,
          $$MigrationLedgerTableUpdateCompanionBuilder,
          (
            MigrationLedgerData,
            BaseReferences<
              _$LocalDatabase,
              $MigrationLedgerTable,
              MigrationLedgerData
            >,
          ),
          MigrationLedgerData,
          PrefetchHooks Function()
        > {
  $$MigrationLedgerTableTableManager(
    _$LocalDatabase db,
    $MigrationLedgerTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MigrationLedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MigrationLedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MigrationLedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> schemaName = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<int?> fromVersion = const Value.absent(),
                Value<int?> toVersion = const Value.absent(),
                Value<String?> migrationId = const Value.absent(),
                Value<DateTime> appliedAt = const Value.absent(),
              }) => MigrationLedgerCompanion(
                id: id,
                schemaName: schemaName,
                schemaVersion: schemaVersion,
                fromVersion: fromVersion,
                toVersion: toVersion,
                migrationId: migrationId,
                appliedAt: appliedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String schemaName,
                required int schemaVersion,
                Value<int?> fromVersion = const Value.absent(),
                Value<int?> toVersion = const Value.absent(),
                Value<String?> migrationId = const Value.absent(),
                required DateTime appliedAt,
              }) => MigrationLedgerCompanion.insert(
                id: id,
                schemaName: schemaName,
                schemaVersion: schemaVersion,
                fromVersion: fromVersion,
                toVersion: toVersion,
                migrationId: migrationId,
                appliedAt: appliedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MigrationLedgerTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $MigrationLedgerTable,
      MigrationLedgerData,
      $$MigrationLedgerTableFilterComposer,
      $$MigrationLedgerTableOrderingComposer,
      $$MigrationLedgerTableAnnotationComposer,
      $$MigrationLedgerTableCreateCompanionBuilder,
      $$MigrationLedgerTableUpdateCompanionBuilder,
      (
        MigrationLedgerData,
        BaseReferences<
          _$LocalDatabase,
          $MigrationLedgerTable,
          MigrationLedgerData
        >,
      ),
      MigrationLedgerData,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$LocalAccountsTableTableManager get localAccounts =>
      $$LocalAccountsTableTableManager(_db, _db.localAccounts);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$StoresTableTableManager get stores =>
      $$StoresTableTableManager(_db, _db.stores);
  $$PeopleTableTableManager get people =>
      $$PeopleTableTableManager(_db, _db.people);
  $$PaymentMethodsTableTableManager get paymentMethods =>
      $$PaymentMethodsTableTableManager(_db, _db.paymentMethods);
  $$AccountPreferencesTableTableManager get accountPreferences =>
      $$AccountPreferencesTableTableManager(_db, _db.accountPreferences);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$PurchaseItemsTableTableManager get purchaseItems =>
      $$PurchaseItemsTableTableManager(_db, _db.purchaseItems);
  $$SyncEventsTableTableManager get syncEvents =>
      $$SyncEventsTableTableManager(_db, _db.syncEvents);
  $$PendingEventsTableTableManager get pendingEvents =>
      $$PendingEventsTableTableManager(_db, _db.pendingEvents);
  $$SyncStateTableTableManager get syncState =>
      $$SyncStateTableTableManager(_db, _db.syncState);
  $$InstallationMetadataTableTableManager get installationMetadata =>
      $$InstallationMetadataTableTableManager(_db, _db.installationMetadata);
  $$SyncSubmissionsTableTableManager get syncSubmissions =>
      $$SyncSubmissionsTableTableManager(_db, _db.syncSubmissions);
  $$SyncSubmissionEventsTableTableManager get syncSubmissionEvents =>
      $$SyncSubmissionEventsTableTableManager(_db, _db.syncSubmissionEvents);
  $$SyncInboxTableTableManager get syncInbox =>
      $$SyncInboxTableTableManager(_db, _db.syncInbox);
  $$RecoverySessionsTableTableManager get recoverySessions =>
      $$RecoverySessionsTableTableManager(_db, _db.recoverySessions);
  $$RecoveryChunksTableTableManager get recoveryChunks =>
      $$RecoveryChunksTableTableManager(_db, _db.recoveryChunks);
  $$HostedAuthStatesTableTableManager get hostedAuthStates =>
      $$HostedAuthStatesTableTableManager(_db, _db.hostedAuthStates);
  $$MigrationLedgerTableTableManager get migrationLedger =>
      $$MigrationLedgerTableTableManager(_db, _db.migrationLedger);
}
