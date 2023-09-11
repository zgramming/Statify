import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:telephony/telephony.dart';
import 'src/model/model/application_config_model.dart';
import 'src/model/model/phone_model.dart';
import 'src/utils/constant.dart';

import 'src/app.dart';
import 'src/model/model/sms_model.dart';

// factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
//     _$AuthenticationResponseModelFromJson(json);

// /// Connect the generated [_$AuthenticationResponseModelToJson] function to the `toJson` method.
// Map<String, dynamic> toJson() => _$AuthenticationResponseModelToJson(this);

// dart run build_runner watch --delete-conflicting-outputs

@pragma('vm:entry-point')
void onBackgroundMessage(SmsMessage msg) {
  log("new message from background : ${msg.body}");
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
