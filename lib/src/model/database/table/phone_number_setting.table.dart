import 'package:drift/drift.dart';

class PhoneNumberSettingTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get sim1Number => text()();

  TextColumn get sim2Number => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'phone_number_setting';
}
