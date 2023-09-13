import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telephony/telephony.dart';
import 'src/injection.dart';
import 'src/model/database/database.dart';

import 'src/app.dart';
import 'src/utils/flutter_local_notification.dart';

// factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
//     _$AuthenticationResponseModelFromJson(json);

// /// Connect the generated [_$AuthenticationResponseModelToJson] function to the `toJson` method.
// Map<String, dynamic> toJson() => _$AuthenticationResponseModelToJson(this);

// dart run build_runner watch --delete-conflicting-outputs

@pragma('vm:entry-point')
void onBackgroundMessage(SmsMessage msg) {
  log("new message from background : ${msg.body}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalNotificationUtils().initialize();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(MyDatabase()),
      ],
      child: const MyApp(),
    ),
  );
}
