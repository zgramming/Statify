import 'package:flutter/material.dart';

import '../model/model/machine_setting/machine_setting_model.dart';
import 'enum.dart';

int generateUniqueNotificationId() {
  // Get the current timestamp in milliseconds
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  // Calculate a unique ID within the range 1 - 9999
  int uniqueId = (timestamp % 10000) + 1;

  return uniqueId;
}

String chooseSMSSettingfromSIMSlot(int simSlot) {
  switch (simSlot) {
    case 0:
      return "sim_1";
    case 1:
      return "sim_2";

    default:
      throw Exception("Unknown sim slot, cant get sms setting");
  }
}

int chooseSimSlotSMS(String smsSetting) {
  switch (smsSetting) {
    case "sim_1":
      return 0;
    case "sim_2":
      return 1;

    default:
      throw Exception("Unknown sms setting, cant get sim slot");
  }
}

void showSnackbar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  Duration? duration,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    duration: duration ?? const Duration(seconds: 3),
  );

  // Hide current snackbar if any
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget Function(BuildContext, Widget, ImageChunkEvent?)?
    imageNetworkLoadingBuilder() {
  return (context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }

    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  };
}

MachineSettingModel? getMachineSettingPlatformList(
  List<MachineSettingModel> items,
  MachineResponsePlatformEnum platform,
) {
  final result =
      items.where((element) => element.platform == platform).toList();

  if (result.isEmpty) {
    return null;
  }

  return result.first;
}

String? getMachineSettingPlatformReadable({
  bool? usePassword,
  int? timeout,
  int? tries,
  int? backoff,
}) {
  if (usePassword == null) {
    return null;
  }

  if (usePassword) {
    return """
Only Invited Numbers Can Join Survey \n
Invitation Password Timeout since received : $timeout hours \n
Disqualified / Banned Numbers for $backoff hours, when $tries times wrong password
""";
  }

  return "All Numbers Can Join Survey";
}
