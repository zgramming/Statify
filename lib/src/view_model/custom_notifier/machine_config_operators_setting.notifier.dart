import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/helper/props_provider/props_is_machine_config_operators_selected.model.dart';
import '../../model/model/machine/machine_config_operator.model.dart';

class MachineConfigOperatorsSettingState extends Equatable {
  final List<MachineConfigOperatorsModel> items;
  const MachineConfigOperatorsSettingState({
    this.items = const [],
  });

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  MachineConfigOperatorsSettingState copyWith({
    List<MachineConfigOperatorsModel>? items,
  }) {
    return MachineConfigOperatorsSettingState(
      items: items ?? this.items,
    );
  }
}

class MachineConfigOperatorsSettingNotifier
    extends StateNotifier<MachineConfigOperatorsSettingState> {
  MachineConfigOperatorsSettingNotifier()
      : super(const MachineConfigOperatorsSettingState());

  init(List<MachineConfigOperatorsModel> items) {
    state = state.copyWith(items: items);
  }

  updateChecklist(MachineConfigOperatorsModel item, bool value) {
    final temp = [...state.items].map((e) {
      if (e.mcc == item.mcc && e.mnc == item.mnc) {
        return e.copyWith(isPlay: value ? 1 : 0);
      } else {
        return e;
      }
    }).toList();

    state = state.copyWith(items: temp);
  }

  updateAutoSwitch({
    required MachineConfigOperatorsModel item,
    required String value,
  }) {
    final temp = [...state.items].map((e) {
      if (e.mcc == item.mcc && e.mnc == item.mnc) {
        return e.copyWith(timeout: value);
      } else {
        return e;
      }
    }).toList();

    state = state.copyWith(items: temp);
  }

  update2GArfcn({
    required MachineConfigOperatorsModel item,
    required String value,
  }) {
    final temp = [...state.items].map((e) {
      if (e.mcc == item.mcc && e.mnc == item.mnc) {
        return e.copyWith(arfcn: value);
      } else {
        return e;
      }
    }).toList();

    state = state.copyWith(items: temp);
  }

  update3GArfcn({
    required MachineConfigOperatorsModel item,
    required String value,
  }) {
    final temp = [...state.items].map((e) {
      if (e.mcc == item.mcc && e.mnc == item.mnc) {
        return e.copyWith(threeGArfcn: value);
      } else {
        return e;
      }
    }).toList();

    state = state.copyWith(items: temp);
  }

  update4GArfcn({
    required MachineConfigOperatorsModel item,
    required String value,
  }) {
    final temp = [...state.items].map((e) {
      if (e.mcc == item.mcc && e.mnc == item.mnc) {
        return e.copyWith(lteArfcn: value);
      } else {
        return e;
      }
    }).toList();

    state = state.copyWith(items: temp);
  }

  update5GArfcn({
    required MachineConfigOperatorsModel item,
    required String value,
  }) {
    final temp = [...state.items].map((e) {
      if (e.mcc == item.mcc && e.mnc == item.mnc) {
        return e.copyWith(fiveGArfcn: value);
      } else {
        return e;
      }
    }).toList();

    state = state.copyWith(items: temp);
  }

  updateDetailModal4G({
    required MachineConfigOperatorsModel item,
    required String lteArfcn,
    required String ltePci,
    required String lteTac,
    required String lteCellId,
    required bool lteIsDefault,
    required String ltePlmn,
    required String lteDowngrade,
    required String lteRotationTime,
  }) {
    final temp = [...state.items].map((e) {
      if (e.mcc == item.mcc && e.mnc == item.mnc) {
        return e.copyWith(
          lteArfcn: lteArfcn,
          ltePci: ltePci,
          lteTac: lteTac,
          lteCellId: lteCellId,
          operatorDefault: lteIsDefault ? "true" : "false",
          ltePlmn: ltePlmn,
          lteDowngrade: lteDowngrade,
          lteRotationTime: lteRotationTime,
        );
      } else {
        return e;
      }
    }).toList();

    state = state.copyWith(items: temp);
  }
}

final machineConfigOperatorsSettingNotifier = StateNotifierProvider<
    MachineConfigOperatorsSettingNotifier, MachineConfigOperatorsSettingState>(
  (ref) => MachineConfigOperatorsSettingNotifier(),
);

final isMachineConfigOperatorsSelectedProvider =
    ProviderFamily<bool, PropsIsMachineConfigOperatorsSelectedModel>(
        (ref, arg) {
  final items = ref.watch(machineConfigOperatorsSettingNotifier).items;
  final result =
      items.firstWhereOrNull((e) => e.mcc == arg.mcc && e.mnc == arg.mnc);

  return result?.isPlay == 1;
});
