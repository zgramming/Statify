import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../model/model/machine/machine_model.dart';
import '../model/model/survey_setting/survey_setting_model.dart';
import 'enum.dart';
import 'package:uuid/uuid.dart';

Future<File> placeFileToDownloadFolder(
  Uint8List file,
  String customName,
) async {
  try {
    const ext = "xlsx";
    final path = await getDownloadPath();
    final newFile = File("$path/$customName.$ext");
    await newFile.writeAsBytes(file);
    return newFile;
  } catch (e) {
    throw Exception("error when place file to download folder, $e");
  }
}

Future<String> getDownloadPath() async {
  Directory? dir;
  if (Platform.isIOS) {
    dir = await getDownloadsDirectory();
    return dir!.path;
  } else {
    dir = Directory("/storage/emulated/0/Download");
    if (!dir.existsSync()) {
      dir = Directory("/storage/emulated/0/Downloads");
      if (!dir.existsSync()) {
        dir = await getDownloadsDirectory();
        return dir!.path;
      }
    }

    return dir.path;
  }
}

String generateUUID() {
  return const Uuid().v4();
}

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

int generateRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
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

SurveySettingModel? getMachineSettingPlatformList(
  List<SurveySettingModel> items,
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

String textMachineConnectOrDisconnected(
  MachineModel? item,
) {
  final config = item?.config;
  final machineStatus = item?.status;
  if (config == null) {
    return "-";
  }

  var message = "";

  if (machineStatus == MachineStatusEnum.offline) {
    message = "Device is not connected";
  }

  if (machineStatus == MachineStatusEnum.online) {
    message = "Device is connected";
  }

  final runningText = config.runningText;
  final connectedWith = config.operators.firstWhereOrNull((element) {
    final combination = "${element.mcc}${element.mnc}";
    return combination == config.plmn;
  });

  if (connectedWith == null) {
    message += " | $runningText";
  } else {
    final combinationMccMnc = "${connectedWith.mcc}${connectedWith.mnc}";
    message +=
        " with ${connectedWith.label} $combinationMccMnc ${connectedWith.arfcn} | $runningText";
  }

  return message;
}
