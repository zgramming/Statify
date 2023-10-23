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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'application_config';
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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logo';
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

class $TemporaryPendingResponseTableTable extends TemporaryPendingResponseTable
    with
        TableInfo<$TemporaryPendingResponseTableTable,
            TemporaryPendingResponseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemporaryPendingResponseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surveyRespondentIdMeta =
      const VerificationMeta('surveyRespondentId');
  @override
  late final GeneratedColumn<String> surveyRespondentId =
      GeneratedColumn<String>('survey_respondent_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          clientDefault: () => uuid.v4());
  static const VerificationMeta _simSlotMeta =
      const VerificationMeta('simSlot');
  @override
  late final GeneratedColumn<int> simSlot = GeneratedColumn<int>(
      'sim_slot', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        surveyRespondentId,
        simSlot,
        phoneNumber,
        message,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'temporary_pending_response';
  @override
  VerificationContext validateIntegrity(
      Insertable<TemporaryPendingResponseTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('survey_respondent_id')) {
      context.handle(
          _surveyRespondentIdMeta,
          surveyRespondentId.isAcceptableOrUnknown(
              data['survey_respondent_id']!, _surveyRespondentIdMeta));
    }
    if (data.containsKey('sim_slot')) {
      context.handle(_simSlotMeta,
          simSlot.isAcceptableOrUnknown(data['sim_slot']!, _simSlotMeta));
    } else if (isInserting) {
      context.missing(_simSlotMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surveyRespondentId};
  @override
  TemporaryPendingResponseTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemporaryPendingResponseTableData(
      surveyRespondentId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}survey_respondent_id'])!,
      simSlot: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sim_slot'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $TemporaryPendingResponseTableTable createAlias(String alias) {
    return $TemporaryPendingResponseTableTable(attachedDatabase, alias);
  }
}

class TemporaryPendingResponseTableData extends DataClass
    implements Insertable<TemporaryPendingResponseTableData> {
  final String surveyRespondentId;
  final int simSlot;
  final String phoneNumber;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const TemporaryPendingResponseTableData(
      {required this.surveyRespondentId,
      required this.simSlot,
      required this.phoneNumber,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['survey_respondent_id'] = Variable<String>(surveyRespondentId);
    map['sim_slot'] = Variable<int>(simSlot);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['message'] = Variable<String>(message);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TemporaryPendingResponseTableCompanion toCompanion(bool nullToAbsent) {
    return TemporaryPendingResponseTableCompanion(
      surveyRespondentId: Value(surveyRespondentId),
      simSlot: Value(simSlot),
      phoneNumber: Value(phoneNumber),
      message: Value(message),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TemporaryPendingResponseTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemporaryPendingResponseTableData(
      surveyRespondentId:
          serializer.fromJson<String>(json['surveyRespondentId']),
      simSlot: serializer.fromJson<int>(json['simSlot']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      message: serializer.fromJson<String>(json['message']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surveyRespondentId': serializer.toJson<String>(surveyRespondentId),
      'simSlot': serializer.toJson<int>(simSlot),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'message': serializer.toJson<String>(message),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TemporaryPendingResponseTableData copyWith(
          {String? surveyRespondentId,
          int? simSlot,
          String? phoneNumber,
          String? message,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      TemporaryPendingResponseTableData(
        surveyRespondentId: surveyRespondentId ?? this.surveyRespondentId,
        simSlot: simSlot ?? this.simSlot,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  @override
  String toString() {
    return (StringBuffer('TemporaryPendingResponseTableData(')
          ..write('surveyRespondentId: $surveyRespondentId, ')
          ..write('simSlot: $simSlot, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(surveyRespondentId, simSlot, phoneNumber,
      message, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemporaryPendingResponseTableData &&
          other.surveyRespondentId == this.surveyRespondentId &&
          other.simSlot == this.simSlot &&
          other.phoneNumber == this.phoneNumber &&
          other.message == this.message &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TemporaryPendingResponseTableCompanion
    extends UpdateCompanion<TemporaryPendingResponseTableData> {
  final Value<String> surveyRespondentId;
  final Value<int> simSlot;
  final Value<String> phoneNumber;
  final Value<String> message;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TemporaryPendingResponseTableCompanion({
    this.surveyRespondentId = const Value.absent(),
    this.simSlot = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemporaryPendingResponseTableCompanion.insert({
    this.surveyRespondentId = const Value.absent(),
    required int simSlot,
    required String phoneNumber,
    required String message,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : simSlot = Value(simSlot),
        phoneNumber = Value(phoneNumber),
        message = Value(message),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TemporaryPendingResponseTableData> custom({
    Expression<String>? surveyRespondentId,
    Expression<int>? simSlot,
    Expression<String>? phoneNumber,
    Expression<String>? message,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (surveyRespondentId != null)
        'survey_respondent_id': surveyRespondentId,
      if (simSlot != null) 'sim_slot': simSlot,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemporaryPendingResponseTableCompanion copyWith(
      {Value<String>? surveyRespondentId,
      Value<int>? simSlot,
      Value<String>? phoneNumber,
      Value<String>? message,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return TemporaryPendingResponseTableCompanion(
      surveyRespondentId: surveyRespondentId ?? this.surveyRespondentId,
      simSlot: simSlot ?? this.simSlot,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surveyRespondentId.present) {
      map['survey_respondent_id'] = Variable<String>(surveyRespondentId.value);
    }
    if (simSlot.present) {
      map['sim_slot'] = Variable<int>(simSlot.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemporaryPendingResponseTableCompanion(')
          ..write('surveyRespondentId: $surveyRespondentId, ')
          ..write('simSlot: $simSlot, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $ApplicationConfigTableTable applicationConfigTable =
      $ApplicationConfigTableTable(this);
  late final $LogoTableTable logoTable = $LogoTableTable(this);
  late final $TemporaryPendingResponseTableTable temporaryPendingResponseTable =
      $TemporaryPendingResponseTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [applicationConfigTable, logoTable, temporaryPendingResponseTable];
}
