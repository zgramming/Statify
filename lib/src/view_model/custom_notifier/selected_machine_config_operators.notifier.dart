import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/helper/props_provider/props_is_machine_config_operators_selected.model.dart';
import '../../model/model/machine/machine_config_operator.model.dart';

class SelectedMachineConfigOperatorsState extends Equatable {
  final List<MachineConfigOperatorsModel> items;
  const SelectedMachineConfigOperatorsState({
    this.items = const [],
  });

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  SelectedMachineConfigOperatorsState copyWith({
    List<MachineConfigOperatorsModel>? items,
  }) {
    return SelectedMachineConfigOperatorsState(
      items: items ?? this.items,
    );
  }
}

class SelectedMachineConfigOperatorsNotifier
    extends StateNotifier<SelectedMachineConfigOperatorsState> {
  SelectedMachineConfigOperatorsNotifier()
      : super(const SelectedMachineConfigOperatorsState());

  init(List<MachineConfigOperatorsModel> items) {
    state = state.copyWith(items: items);
  }

  updateChecklist(MachineConfigOperatorsModel item, bool value) {
    final temp = [...state.items].map((e) {
      if (e.mcc == item.mcc &&
          e.mnc == item.mnc &&
          e.country == item.country &&
          e.label == item.label) {
        return e.copyWith(isPlay: value ? 1 : 0);
      } else {
        return e;
      }
    }).toList();

    state = state.copyWith(items: temp);
  }
}

final selectedMachineConfigOperatorsNotifier = StateNotifierProvider<
    SelectedMachineConfigOperatorsNotifier,
    SelectedMachineConfigOperatorsState>(
  (ref) => SelectedMachineConfigOperatorsNotifier(),
);

final isMachineConfigOperatorsSelectedProvider =
    ProviderFamily<bool, PropsIsMachineConfigOperatorsSelectedModel>(
        (ref, arg) {
  final items = ref.watch(selectedMachineConfigOperatorsNotifier).items;
  final result = items.firstWhereOrNull((e) =>
      e.mcc == arg.mcc &&
      e.mnc == arg.mnc &&
      e.country == arg.country &&
      e.label == arg.label);

  return result?.isPlay == 1;
});
