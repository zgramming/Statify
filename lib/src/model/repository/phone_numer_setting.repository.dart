import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../database/database.dart';
import '../datasource/local/phone_number_setting_local_datasource.dart';
import '../model/phone_number_setting/phone_number_setting_model.dart';

class PhoneNumberSettingRepository {
  const PhoneNumberSettingRepository({
    required this.localDatasource,
  });

  final PhoneNumberSettingLocalDatasource localDatasource;

  Future<Either<Failure, List<PhoneNumberSettingModel>>>
      getAllPhoneNumberSetting() async {
    try {
      final result = await localDatasource.getAllPhoneNumberSetting();
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, PhoneNumberSettingModel?>>
      getFirstPhoneNumberSetting() async {
    try {
      final result = await localDatasource.getFirstPhoneNumberSetting();
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> upsertPhoneNumberSetting(
    PhoneNumberSettingTableCompanion phoneNumberSetting,
  ) async {
    try {
      final result =
          await localDatasource.upsertPhoneNumberSetting(phoneNumberSetting);
      return Right(result);
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
