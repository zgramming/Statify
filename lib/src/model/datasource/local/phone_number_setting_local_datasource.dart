import '../../database/database.dart';
import '../../model/phone_number_setting/phone_number_setting_model.dart';

class PhoneNumberSettingLocalDatasource {
  const PhoneNumberSettingLocalDatasource({required this.database});

  final MyDatabase database;

  Future<List<PhoneNumberSettingModel>> getAllPhoneNumberSetting() async {
    final result = await database.getAllPhoneNumberSetting();
    return result;
  }

  Future<PhoneNumberSettingModel?> getFirstPhoneNumberSetting() async {
    final result = await database.getFirstPhoneNumberSetting();
    return result;
  }

  Future<bool> upsertPhoneNumberSetting(
    PhoneNumberSettingTableCompanion phoneNumberSetting,
  ) async {
    final result = await database.upsertPhoneNumberSetting(phoneNumberSetting);
    return result;
  }
}
