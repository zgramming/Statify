import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../model/application_config/application_config_model.dart';
import '../model/logo/logo.model.dart';
import '../model/wifi_control/wifi_control.model.dart';

import 'table/application_config.table.dart';
import 'table/logo.table.dart';
import 'table/temporary_pending_response.table.dart';
import 'table/wifi_control.table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  ApplicationConfigTable,
  LogoTable,
  TemporaryPendingResponseTable,
  WifiControlTable
])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      // beforeOpen: (details) async {
      // await customStatement('PRAGMA foreign_keys = ON');
      // },
      // onCreate: (details) async {
      //   await customStatement('PRAGMA foreign_keys = ON');
      // },
      // onUpgrade: (m, from, to) {
      //   return m.createAll();
      // },
      );

  //! Temporary Pending Response Table Query Start

  // Listen when have new Temporary Pending Response
  Stream<List<TemporaryPendingResponseTableData>>
      listenNewTemporaryPendingResponse() {
    final query = select(temporaryPendingResponseTable)
      ..orderBy([
        (tbl) => OrderingTerm(
              expression: tbl.createdAt,
              mode: OrderingMode.desc,
            ),
      ]);

    return query.watch();
  }

  // Get All Temporary Pending Response
  Future<List<TemporaryPendingResponseTableData>>
      getAllTemporaryPendingResponse() =>
          select(temporaryPendingResponseTable).get();

  // Get by surveyResponseId Temporary Pending Response
  Future<TemporaryPendingResponseTableData?>
      getBySurveyRespondenIdTemporaryPendingResponse({
    required String surveyRespondenId,
  }) =>
          (select(temporaryPendingResponseTable)
                ..where(
                  (tbl) => tbl.surveyRespondentId.equals(surveyRespondenId),
                ))
              .getSingleOrNull();

  // Create Temporary Pending Response, error when have same surveyResponseId
  Future<TemporaryPendingResponseTableData> createTemporaryPendingResponse(
    TemporaryPendingResponseTableCompanion temporaryPendingResponse,
  ) async {
    final result = await into(temporaryPendingResponseTable)
        .insertReturning(temporaryPendingResponse);
    return result;
  }

  // Delete all Temporary Pending Response
  Future<int> deleteAllTemporaryPendingResponse() async {
    final result = await (delete(temporaryPendingResponseTable)).go();
    return result;
  }

  // Delete by surveyResponseId Temporary Pending Response
  Future<bool> deleteBySurveyRespondenIdTemporaryPendingResponse({
    required String surveyRespondenId,
  }) async {
    final result = await (delete(temporaryPendingResponseTable)
          ..where((tbl) => tbl.surveyRespondentId.equals(surveyRespondenId)))
        .go();
    return result > 0;
  }

  //! Application Config Table Query Start
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
    try {
      final result = await (update(applicationConfigTable)
            ..where((tbl) => tbl.key.equals(applicationConfig.key.value)))
          .write(applicationConfig);

      return result > 0;
    } catch (e) {
      return false;
    }
  }

  // Delete by key Application Config
  Future<bool> deleteByKeyApplicationConfig(String key) async {
    final result = await (delete(applicationConfigTable)
          ..where((tbl) => tbl.key.equals(key)))
        .go();
    return result > 0;
  }

  Future<ApplicationConfigModel> upsertApplicationConfig(
    ApplicationConfigTableCompanion applicationConfig,
  ) async {
    final result = await getByKeyApplicationConfig(applicationConfig.key.value);
    if (result == null) {
      await insertApplicationConfig(applicationConfig);
    } else {
      await updateByKeyApplicationConfig(applicationConfig);
    }

    final currentApplicationConfig =
        await getByKeyApplicationConfig(applicationConfig.key.value);

    return ApplicationConfigModel(
      id: currentApplicationConfig!.id,
      key: currentApplicationConfig.key,
      value: currentApplicationConfig.value,
    );
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

  //! Wifi Control Table Query Start
  Future<WifiControlTableData?> getFirstWifiControl() async {
    return select(wifiControlTable).getSingleOrNull();
  }

  Future<WifiControlModel> upsertWifiControl(
      WifiControlTableCompanion form) async {
    // Delete first previous wifi control then insert new one
    await (delete(wifiControlTable)).go();
    await into(wifiControlTable).insert(form);

    final currentWifiControl = await getFirstWifiControl();
    if (currentWifiControl == null) {
      throw Exception("Failed to get wifi control after upsert");
    }

    return WifiControlModel(
      id: currentWifiControl.id,
      url: currentWifiControl.url,
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
