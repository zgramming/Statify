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

class $LogoTableTable extends LogoTable
    with TableInfo<$LogoTableTable, LogoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _logoMeta = const VerificationMeta('logo');
  @override
  late final GeneratedColumn<Uint8List> logo = GeneratedColumn<Uint8List>(
      'logo', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, logo];
  @override
  String get aliasedName => _alias ?? 'logo';
  @override
  String get actualTableName => 'logo';
  @override
  VerificationContext validateIntegrity(Insertable<LogoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('logo')) {
      context.handle(
          _logoMeta, logo.isAcceptableOrUnknown(data['logo']!, _logoMeta));
    } else if (isInserting) {
      context.missing(_logoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      logo: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}logo'])!,
    );
  }

  @override
  $LogoTableTable createAlias(String alias) {
    return $LogoTableTable(attachedDatabase, alias);
  }
}

class LogoTableData extends DataClass implements Insertable<LogoTableData> {
  final int id;
  final Uint8List logo;
  const LogoTableData({required this.id, required this.logo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['logo'] = Variable<Uint8List>(logo);
    return map;
  }

  LogoTableCompanion toCompanion(bool nullToAbsent) {
    return LogoTableCompanion(
      id: Value(id),
      logo: Value(logo),
    );
  }

  factory LogoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogoTableData(
      id: serializer.fromJson<int>(json['id']),
      logo: serializer.fromJson<Uint8List>(json['logo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'logo': serializer.toJson<Uint8List>(logo),
    };
  }

  LogoTableData copyWith({int? id, Uint8List? logo}) => LogoTableData(
        id: id ?? this.id,
        logo: logo ?? this.logo,
      );
  @override
  String toString() {
    return (StringBuffer('LogoTableData(')
          ..write('id: $id, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, $driftBlobEquality.hash(logo));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogoTableData &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.logo, this.logo));
}

class LogoTableCompanion extends UpdateCompanion<LogoTableData> {
  final Value<int> id;
  final Value<Uint8List> logo;
  const LogoTableCompanion({
    this.id = const Value.absent(),
    this.logo = const Value.absent(),
  });
  LogoTableCompanion.insert({
    this.id = const Value.absent(),
    required Uint8List logo,
  }) : logo = Value(logo);
  static Insertable<LogoTableData> custom({
    Expression<int>? id,
    Expression<Uint8List>? logo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logo != null) 'logo': logo,
    });
  }

  LogoTableCompanion copyWith({Value<int>? id, Value<Uint8List>? logo}) {
    return LogoTableCompanion(
      id: id ?? this.id,
      logo: logo ?? this.logo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (logo.present) {
      map['logo'] = Variable<Uint8List>(logo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogoTableCompanion(')
          ..write('id: $id, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $ApplicationConfigTableTable applicationConfigTable =
      $ApplicationConfigTableTable(this);
  late final $LogoTableTable logoTable = $LogoTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [applicationConfigTable, logoTable];
}
