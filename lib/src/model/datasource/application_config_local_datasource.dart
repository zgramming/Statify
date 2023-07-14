import 'package:hive_flutter/hive_flutter.dart';

import '../model/application_config_model.dart';

class ApplicationConfigLocalDatasource {
  final Box<ApplicationConfigModel> box;
  const ApplicationConfigLocalDatasource({
    required this.box,
  });

  final key = 'application_config';

  ApplicationConfigModel getApplicationConfig() {
    final result = box.get(
      key,
      defaultValue: const ApplicationConfigModel(),
    )!;

    return result;
  }

  Future<String> saveIntroduction(bool value) async {
    final previousConfig = box.get(
      key,
      defaultValue: const ApplicationConfigModel(),
    );

    await box.put(
      key,
      previousConfig!.copyWith(isIntroductionDone: value),
    );
    return 'Introduction saved';
  }

  Future<String> saveDarkMode(bool isDarkMode) async {
    final previousConfig = box.get(
      key,
      defaultValue: const ApplicationConfigModel(),
    );

    await box.put(
      key,
      previousConfig!.copyWith(isDarkMode: isDarkMode),
    );
    return 'Dark mode saved';
  }
}



// Path: lib\src\model\datasource\phone_local_datasource.dart