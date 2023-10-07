import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/local/logo_local.datasource.dart';
import '../model/logo/logo.model.dart';

class LogoRepository {
  final LogoLocalDatasource localDatasource;
  const LogoRepository({
    required this.localDatasource,
  });

  Future<Either<Failure, LogoModel?>> getFirstLogo() async {
    try {
      final result = await localDatasource.getFirstLogo();
      return right(result);
    } catch (e) {
      return left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, LogoModel?>> upload(Uint8List file) async {
    try {
      final result = await localDatasource.upload(file);
      return right(result);
    } catch (e) {
      return left(CommonFailure(e.toString()));
    }
  }
}
