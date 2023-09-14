import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/helper/props/props.get_machine_setting_detail.dart';
import '../../model/model/machine_setting/machine_setting_model.dart';

final getMachineSettingDetailNotifier = AutoDisposeFutureProviderFamily<
    MachineSettingModel?, PropsGetMachineSettingDetail>(
  (ref, props) async {
    final result = await ref
        .watch(machineSettingNotifier(props.machineId).notifier)
        .getById(
          settingId: props.settingId,
        );
    final setting = result.onGetById.valueOrNull;
    return setting;
  },
);
