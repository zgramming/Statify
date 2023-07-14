import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:telephony/telephony.dart';
import 'src/model/model/application_config_model.dart';
import 'src/model/model/phone_model.dart';
import 'src/utils/constant.dart';

import 'src/app.dart';
import 'src/model/model/sms_model.dart';

// dart run build_runner watch --delete-conflicting-outputs
Future<void> backgrounMessageHandler(SmsMessage message) async {
  //Handle background message
}

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SMSModelAdapter());
  Hive.registerAdapter(PhoneModelAdapter());
  Hive.registerAdapter(ApplicationConfigModelAdapter());
  await Hive.openBox<SMSModel>(hiveSMSBox); // Hive Type ID 1
  await Hive.openBox<PhoneModel>(hivePhoneBox); // Hive Type ID 2
  await Hive.openBox<ApplicationConfigModel>(
    hiveApplicationConfigBox,
  ); // Hive Type ID 3
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();

  runApp(const ProviderScope(child: MyApp()));
}
