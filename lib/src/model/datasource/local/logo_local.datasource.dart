import 'package:drift/drift.dart';

import '../../database/database.dart';
import '../../model/logo/logo.model.dart';

class LogoLocalDatasource {
  final MyDatabase database;
  const LogoLocalDatasource({
    required this.database,
  });

  Future<LogoModel?> getFirstLogo() async {
    final result = await database.getFirstLogo();
    if (result == null) return null;
    return LogoModel(
      id: result.id,
      logo: result.logo,
    );
  }

  Future<LogoModel?> upload(Uint8List file) async {
    final result = await database.uploadLogo(LogoTableCompanion(
      logo: Value(file),
    ));

    return result;
  }
}
