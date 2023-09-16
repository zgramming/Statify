import 'package:drift/drift.dart';

import 'package:uuid/uuid.dart';

class ApplicationConfigTable extends Table {
  final uuid = const Uuid();
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
