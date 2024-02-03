import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/machine/machine_config.model.dart';

class MachineConfigCommonSettingState extends Equatable {
  final MachineConfigModel item;
  const MachineConfigCommonSettingState({
    this.item = const MachineConfigModel(),
  });

  @override
  List<Object> get props => [item];

  @override
  bool get stringify => true;

  MachineConfigCommonSettingState copyWith({
    MachineConfigModel? item,
  }) {
    return MachineConfigCommonSettingState(
      item: item ?? this.item,
    );
  }
}

class MachineConfigCommonSettingNotifier
    extends StateNotifier<MachineConfigCommonSettingState> {
  MachineConfigCommonSettingNotifier()
      : super(const MachineConfigCommonSettingState());

  void init(MachineConfigModel item) {
    state = state.copyWith(item: item);
  }

  void updateAllRotation(bool value) {
    state = state.copyWith(
      item: state.item.copyWith(
        allRotation: value ? "1" : "0",
      ),
    );
  }

  void updateAutoCellId(bool value) {
    state = state.copyWith(
      item: state.item.copyWith(
        autoCellId: value ? "1" : "0",
      ),
    );
  }
}

final machineConfigCommonSettingNotifier = StateNotifierProvider<
    MachineConfigCommonSettingNotifier, MachineConfigCommonSettingState>(
  (ref) => MachineConfigCommonSettingNotifier(),
);
