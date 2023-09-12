// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ApplicationConfigTableTable extends ApplicationConfigTable
    with TableInfo<$ApplicationConfigTableTable, ApplicationConfigTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApplicationConfigTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, key, value];
  @override
  String get aliasedName => _alias ?? 'application_config';
  @override
  String get actualTableName => 'application_config';
  @override
  VerificationContext validateIntegrity(
      Insertable<ApplicationConfigTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApplicationConfigTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApplicationConfigTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $ApplicationConfigTableTable createAlias(String alias) {
    return $ApplicationConfigTableTable(attachedDatabase, alias);
  }
}

class ApplicationConfigTableData extends DataClass
    implements Insertable<ApplicationConfigTableData> {
  final String id;
  final String key;
  final String value;
  const ApplicationConfigTableData(
      {required this.id, required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  ApplicationConfigTableCompanion toCompanion(bool nullToAbsent) {
    return ApplicationConfigTableCompanion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
    );
  }

  factory ApplicationConfigTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApplicationConfigTableData(
      id: serializer.fromJson<String>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  ApplicationConfigTableData copyWith(
          {String? id, String? key, String? value}) =>
      ApplicationConfigTableData(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('ApplicationConfigTableData(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApplicationConfigTableData &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value);
}

class ApplicationConfigTableCompanion
    extends UpdateCompanion<ApplicationConfigTableData> {
  final Value<String> id;
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const ApplicationConfigTableCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApplicationConfigTableCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<ApplicationConfigTableData> custom({
    Expression<String>? id,
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApplicationConfigTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? key,
      Value<String>? value,
      Value<int>? rowid}) {
    return ApplicationConfigTableCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationConfigTableCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhoneNumberSettingTableTable extends PhoneNumberSettingTable
    with TableInfo<$PhoneNumberSettingTableTable, PhoneNumberSettingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhoneNumberSettingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sim1NumberMeta =
      const VerificationMeta('sim1Number');
  @override
  late final GeneratedColumn<String> sim1Number = GeneratedColumn<String>(
      'sim1_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sim2NumberMeta =
      const VerificationMeta('sim2Number');
  @override
  late final GeneratedColumn<String> sim2Number = GeneratedColumn<String>(
      'sim2_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, sim1Number, sim2Number];
  @override
  String get aliasedName => _alias ?? 'phone_number_setting';
  @override
  String get actualTableName => 'phone_number_setting';
  @override
  VerificationContext validateIntegrity(
      Insertable<PhoneNumberSettingTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sim1_number')) {
      context.handle(
          _sim1NumberMeta,
          sim1Number.isAcceptableOrUnknown(
              data['sim1_number']!, _sim1NumberMeta));
    } else if (isInserting) {
      context.missing(_sim1NumberMeta);
    }
    if (data.containsKey('sim2_number')) {
      context.handle(
          _sim2NumberMeta,
          sim2Number.isAcceptableOrUnknown(
              data['sim2_number']!, _sim2NumberMeta));
    } else if (isInserting) {
      context.missing(_sim2NumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhoneNumberSettingTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhoneNumberSettingTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sim1Number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sim1_number'])!,
      sim2Number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sim2_number'])!,
    );
  }

  @override
  $PhoneNumberSettingTableTable createAlias(String alias) {
    return $PhoneNumberSettingTableTable(attachedDatabase, alias);
  }
}

class PhoneNumberSettingTableData extends DataClass
    implements Insertable<PhoneNumberSettingTableData> {
  final int id;
  final String sim1Number;
  final String sim2Number;
  const PhoneNumberSettingTableData(
      {required this.id, required this.sim1Number, required this.sim2Number});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sim1_number'] = Variable<String>(sim1Number);
    map['sim2_number'] = Variable<String>(sim2Number);
    return map;
  }

  PhoneNumberSettingTableCompanion toCompanion(bool nullToAbsent) {
    return PhoneNumberSettingTableCompanion(
      id: Value(id),
      sim1Number: Value(sim1Number),
      sim2Number: Value(sim2Number),
    );
  }

  factory PhoneNumberSettingTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhoneNumberSettingTableData(
      id: serializer.fromJson<int>(json['id']),
      sim1Number: serializer.fromJson<String>(json['sim1Number']),
      sim2Number: serializer.fromJson<String>(json['sim2Number']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sim1Number': serializer.toJson<String>(sim1Number),
      'sim2Number': serializer.toJson<String>(sim2Number),
    };
  }

  PhoneNumberSettingTableData copyWith(
          {int? id, String? sim1Number, String? sim2Number}) =>
      PhoneNumberSettingTableData(
        id: id ?? this.id,
        sim1Number: sim1Number ?? this.sim1Number,
        sim2Number: sim2Number ?? this.sim2Number,
      );
  @override
  String toString() {
    return (StringBuffer('PhoneNumberSettingTableData(')
          ..write('id: $id, ')
          ..write('sim1Number: $sim1Number, ')
          ..write('sim2Number: $sim2Number')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sim1Number, sim2Number);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhoneNumberSettingTableData &&
          other.id == this.id &&
          other.sim1Number == this.sim1Number &&
          other.sim2Number == this.sim2Number);
}

class PhoneNumberSettingTableCompanion
    extends UpdateCompanion<PhoneNumberSettingTableData> {
  final Value<int> id;
  final Value<String> sim1Number;
  final Value<String> sim2Number;
  const PhoneNumberSettingTableCompanion({
    this.id = const Value.absent(),
    this.sim1Number = const Value.absent(),
    this.sim2Number = const Value.absent(),
  });
  PhoneNumberSettingTableCompanion.insert({
    this.id = const Value.absent(),
    required String sim1Number,
    required String sim2Number,
  })  : sim1Number = Value(sim1Number),
        sim2Number = Value(sim2Number);
  static Insertable<PhoneNumberSettingTableData> custom({
    Expression<int>? id,
    Expression<String>? sim1Number,
    Expression<String>? sim2Number,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sim1Number != null) 'sim1_number': sim1Number,
      if (sim2Number != null) 'sim2_number': sim2Number,
    });
  }

  PhoneNumberSettingTableCompanion copyWith(
      {Value<int>? id, Value<String>? sim1Number, Value<String>? sim2Number}) {
    return PhoneNumberSettingTableCompanion(
      id: id ?? this.id,
      sim1Number: sim1Number ?? this.sim1Number,
      sim2Number: sim2Number ?? this.sim2Number,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sim1Number.present) {
      map['sim1_number'] = Variable<String>(sim1Number.value);
    }
    if (sim2Number.present) {
      map['sim2_number'] = Variable<String>(sim2Number.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhoneNumberSettingTableCompanion(')
          ..write('id: $id, ')
          ..write('sim1Number: $sim1Number, ')
          ..write('sim2Number: $sim2Number')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $ApplicationConfigTableTable applicationConfigTable =
      $ApplicationConfigTableTable(this);
  late final $PhoneNumberSettingTableTable phoneNumberSettingTable =
      $PhoneNumberSettingTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [applicationConfigTable, phoneNumberSettingTable];
}
