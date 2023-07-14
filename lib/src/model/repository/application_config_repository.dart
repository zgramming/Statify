import '../datasource/application_config_local_datasource.dart';
import '../model/application_config_model.dart';

class ApplicationConfigRepository {
  final ApplicationConfigLocalDatasource localDatasource;
  const ApplicationConfigRepository({
    required this.localDatasource,
  });

  Future<ApplicationConfigModel> getApplicationConfig() async {
    return localDatasource.getApplicationConfig();
  }

  Future<String> saveIntroduction(bool value) async {
    return localDatasource.saveIntroduction(value);
  }

  Future<String> saveDarkMode(bool isDarkMode) async {
    return localDatasource.saveDarkMode(isDarkMode);
  }
}
