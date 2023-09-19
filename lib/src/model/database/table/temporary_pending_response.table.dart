import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class TemporaryPendingResponseTable extends Table {
  final uuid = const Uuid();
  TextColumn get surveyRespondentId => text().clientDefault(
        () => uuid.v4(),
      )();
  IntColumn get simSlot => integer()();
  TextColumn get phoneNumber => text()();
  TextColumn get message => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {surveyRespondentId};

  @override
  String? get tableName => "temporary_pending_response";
}
