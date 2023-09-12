// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drift/drift.dart';

import '../../database/database.dart';
import '../../model/application_config/application_config_model.dart';

class ApplicationConfigLocalDatasource {
  final MyDatabase database;
  const ApplicationConfigLocalDatasource({
    required this.database,
  });

  Future<List<ApplicationConfigModel>> getAll() async {
    final result = await database.getAllApplicationConfig();
    return result
        .map((e) => ApplicationConfigModel(
              id: e.id,
              key: e.key,
              value: e.value,
            ))
        .toList();
  }

  Future<ApplicationConfigModel?> getById(String id) async {
    final result = await database.getByIdApplicationConfig(id);
    return result == null
        ? null
        : ApplicationConfigModel(
            id: result.id,
            key: result.key,
            value: result.value,
          );
  }

  Future<ApplicationConfigModel?> getByKey(String key) async {
    final result = await database.getByKeyApplicationConfig(key);
    return result == null
        ? null
        : ApplicationConfigModel(
            id: result.id,
            key: result.key,
            value: result.value,
          );
  }

  Future<int> insert({
    required String key,
    required String value,
  }) async {
    final result = await database.insertApplicationConfig(
      ApplicationConfigTableCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
    return result;
  }

  Future<bool> updateByKey({
    required String key,
    required String value,
  }) async {
    final result = await database.updateByKeyApplicationConfig(
      ApplicationConfigTableCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
    return result;
  }

  Future<bool> deleteByKey(String key) async {
    final result = await database.deleteByKeyApplicationConfig(key);
    return result;
  }
}
