import 'package:equatable/equatable.dart';

import '../../../../utils/enum.dart';

class FormUserUpdateModel extends Equatable {
  final String username;
  final String name;
  final String countryCode;
  final String sim1;
  final String sim2;
  final List<String> machineIds;
  final WhatSIMHasBeenChanged machineSimSlot;

  const FormUserUpdateModel({
    required this.username,
    required this.name,
    required this.countryCode,
    required this.sim1,
    required this.sim2,
    required this.machineIds,
    required this.machineSimSlot,
  });

  @override
  List<Object> get props {
    return [
      username,
      name,
      countryCode,
      sim1,
      sim2,
      machineIds,
      machineSimSlot,
    ];
  }

  @override
  bool get stringify => true;

  FormUserUpdateModel copyWith({
    String? username,
    String? name,
    String? countryCode,
    String? sim1,
    String? sim2,
    List<String>? machineIds,
    WhatSIMHasBeenChanged? machineSimSlot,
  }) {
    return FormUserUpdateModel(
      username: username ?? this.username,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      sim1: sim1 ?? this.sim1,
      sim2: sim2 ?? this.sim2,
      machineIds: machineIds ?? this.machineIds,
      machineSimSlot: machineSimSlot ?? this.machineSimSlot,
    );
  }
}
