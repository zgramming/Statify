import 'package:drift/drift.dart';

class WifiControlTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get url => text()();

  @override
  String? get tableName => "wifi_control";
}
