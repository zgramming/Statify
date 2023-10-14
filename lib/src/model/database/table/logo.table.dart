import 'package:drift/drift.dart';

class LogoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  BlobColumn get logo => blob()();

  @override
  String? get tableName => "logo";
}
