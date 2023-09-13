import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ApplicationConfigTable extends Table {
  TextColumn get id => text().clientDefault(
        () => uuid.v4(),
      )();
  TextColumn get key => text().unique()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  String? get tableName => 'application_config';
}
