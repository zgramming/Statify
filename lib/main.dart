import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:telephony/telephony.dart';
import 'package:wabot_utils/src/utils/constant.dart';

import 'src/app.dart';
import 'src/model/model/sms_model.dart';

// flutter packages pub run build_runner watch --delete-conflicting-outputs
Future<void> backgrounMessageHandler(SmsMessage message) async {
  //Handle background message
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(SMSModelAdapter());
  await Hive.openBox<SMSModel>(hiveSMSBox);

  runApp(const ProviderScope(child: MyApp()));
}
