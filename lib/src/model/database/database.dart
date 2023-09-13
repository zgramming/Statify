import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../model/phone_number_setting/phone_number_setting_model.dart';
import 'table/application_config.table.dart';
import 'table/phone_number_setting.table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  ApplicationConfigTable,
  PhoneNumberSettingTable,
])
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

  // Phone Number Setting Query Start

  // Get All Phone Number Setting
  Future<List<PhoneNumberSettingModel>> getAllPhoneNumberSetting() async {
    final result = (await select(phoneNumberSettingTable).get())
        .map((e) => PhoneNumberSettingModel(
              id: e.id,
              sim1: e.sim1Number,
              sim2: e.sim2Number,
            ))
        .toList();
    return result;
  }

  // Get First Phone Number Setting
  Future<PhoneNumberSettingModel?> getFirstPhoneNumberSetting() async {
    // Delete all data

    final result = (await select(phoneNumberSettingTable).get())
        .map((e) => PhoneNumberSettingModel(
              id: e.id,
              sim1: e.sim1Number,
              sim2: e.sim2Number,
            ))
        .firstOrNull;
    return result;
  }

  // Upsert Phone Number Setting
  Future<bool> upsertPhoneNumberSetting(
    PhoneNumberSettingTableCompanion phoneNumberSetting,
  ) async {
    final result = await into(phoneNumberSettingTable)
        .insertOnConflictUpdate(phoneNumberSetting);
    return result > 0;
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
