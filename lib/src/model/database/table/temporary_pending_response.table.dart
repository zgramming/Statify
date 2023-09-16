import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class TemporaryPendingResponseTable extends Table {
  final uuid = const Uuid();
  TextColumn get surveyResponseId => text().clientDefault(
        () => uuid.v4(),
      )();
  TextColumn get surveyId => text()();
  TextColumn get machineId => text()();
  IntColumn get simSlot => integer()();
  TextColumn get phoneNumber => text()();
  TextColumn get message => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {surveyResponseId};

  @override
  String? get tableName => "temporary_pending_response";
}
