import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/machine/machine_config_countries.model.dart';

class MachineConfigCountriesState extends Equatable {
  final List<MachineConfigCountriesModel> items;
  const MachineConfigCountriesState({
    this.items = const <MachineConfigCountriesModel>[],
  });

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  MachineConfigCountriesState copyWith({
    List<MachineConfigCountriesModel>? items,
  }) {
    return MachineConfigCountriesState(
      items: items ?? this.items,
    );
  }
}

class MachineConfigCountriesNotifier
    extends StateNotifier<MachineConfigCountriesState> {
  MachineConfigCountriesNotifier() : super(const MachineConfigCountriesState());

  init(List<MachineConfigCountriesModel> items) {
    state = state.copyWith(items: items);
  }

  add(MachineConfigCountriesModel item) {
    state = state.copyWith(items: [...state.items, item]);
  }

  remove(String label) {
    state = state.copyWith(
      items: state.items.where((e) => e.label != label).toList(),
    );
  }

  updateChecklist(MachineConfigCountriesModel item) {
    // Only one item can be active at a time
    final temp = [
      for (final val in state.items)
        if (val.label == item.label)
          val.copyWith(isActive: 1)
        else
          val.copyWith(isActive: 0)
    ];

    state = state.copyWith(items: temp);
  }

  reset() {
    state = const MachineConfigCountriesState();
  }

  // MNCS Section
  addMnc(MachineConfigCountriesMNCModel item) {
    final temp = [...state.items];
    final countryByLabel = temp
        .firstWhere((e) => e.label.toLowerCase() == item.country.toLowerCase());
    final newMncs = [...countryByLabel.mncs, item];

    state = state.copyWith(
      items: [
        for (final val in temp)
          if (val.label.toLowerCase() == item.country.toLowerCase())
            val.copyWith(mncs: newMncs)
          else
            val
      ],
    );
  }

  removeMnc(MachineConfigCountriesMNCModel item) {
    final temp = [...state.items];
    final countryByLabel = temp
        .firstWhere((e) => e.label.toLowerCase() == item.country.toLowerCase());

    final mncs = [
      for (final val in countryByLabel.mncs)
        if (val.label != item.label) val
    ];

    state = state.copyWith(
      items: [
        for (final val in temp)
          if (val.label.toLowerCase() == item.country.toLowerCase())
            val.copyWith(mncs: mncs)
          else
            val
      ],
    );
  }

  updateChecklistMnc(MachineConfigCountriesMNCModel item) {
    final temp = [...state.items];
    final countryByLabel = temp.firstWhere(
      (e) => e.label.toLowerCase() == item.country.toLowerCase(),
    );

    // Checklist can be multiple items
    final newMncs = [
      for (final val in countryByLabel.mncs)
        if (val.mnc == item.mnc && val.mcc == item.mcc)
          val.copyWith(status: item.status == 1 ? 0 : 1)
        else
          val
    ];

    state = state.copyWith(
      items: [
        for (final val in temp)
          if (val.label.toLowerCase() == item.country.toLowerCase())
            val.copyWith(mncs: newMncs)
          else
            val
      ],
    );
  }
}

final machineConfigCountriesNotifier = StateNotifierProvider<
    MachineConfigCountriesNotifier, MachineConfigCountriesState>(
  (ref) => MachineConfigCountriesNotifier(),
);

final machineConfigCountriesByLabel =
    Provider.family<MachineConfigCountriesModel, String>(
  (ref, label) {
    final state = ref.watch(machineConfigCountriesNotifier);
    return state.items.firstWhere((e) => e.label == label);
  },
);
