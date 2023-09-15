import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../model/logo/logo.model.dart';
import 'table/application_config.table.dart';
import 'table/logo.table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [ApplicationConfigTable, LogoTable])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Get All Application Config
  Future<List<ApplicationConfigTableData>> getAllApplicationConfig() =>
      select(applicationConfigTable).get();

  // Get By Id Application Config
  Future<ApplicationConfigTableData?> getByIdApplicationConfig(String id) =>
      (select(applicationConfigTable)..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();

  // Get By Key Application Config
  Future<ApplicationConfigTableData?> getByKeyApplicationConfig(String key) =>
      (select(applicationConfigTable)..where((tbl) => tbl.key.equals(key)))
          .getSingleOrNull();

  // Insert Application Config
  Future<int> insertApplicationConfig(
    ApplicationConfigTableCompanion applicationConfig,
  ) async {
    final result = into(applicationConfigTable).insert(applicationConfig);
    return result;
  }

  // Update by key Application Config
  Future<bool> updateByKeyApplicationConfig(
    ApplicationConfigTableCompanion applicationConfig,
  ) async {
    final result = await (update(applicationConfigTable)
          ..where((tbl) => tbl.key.equals(applicationConfig.key.value)))
        .replace(applicationConfig);
    return result;
  }

  // Delete by key Application Config
  Future<bool> deleteByKeyApplicationConfig(String key) async {
    final result = await (delete(applicationConfigTable)
          ..where((tbl) => tbl.key.equals(key)))
        .go();
    return result > 0;
  }

  //! Logo Table Query Start

  // Get First Logo Table
  Future<LogoTableData?> getFirstLogo() => select(logoTable).getSingleOrNull();

  // Upload Logo Table
  Future<LogoModel?> uploadLogo(LogoTableCompanion logo) async {
    // Delete first previous logo
    await (delete(logoTable)).go();

    final result = await into(logoTable).insert(logo);

    if (result == 0) {
      throw Exception("Failed to upload logo");
    }

    // return previous inserted id

    final currentLogo = await getFirstLogo();
    if (currentLogo == null) {
      throw Exception("Failed to get logo after upload");
    }
    return LogoModel(
      id: currentLogo.id,
      logo: currentLogo.logo,
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
