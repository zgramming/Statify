import 'package:equatable/equatable.dart';

class FormMachineGroupCreateOrUpdateModel extends Equatable {
  final String userId;
  final String name;
  final String master;
  final bool copySetting;
  final bool copySmsSetting;
  final List<String> machineIds;
  const FormMachineGroupCreateOrUpdateModel({
    required this.userId,
    required this.name,
    required this.master,
    required this.copySetting,
    required this.copySmsSetting,
    required this.machineIds,
  });

  @override
  List<Object> get props {
    return [
      userId,
      name,
      master,
      copySetting,
      copySmsSetting,
      machineIds,
    ];
  }

  @override
  bool get stringify => true;

  FormMachineGroupCreateOrUpdateModel copyWith({
    String? userId,
    String? name,
    String? master,
    bool? copySetting,
    bool? copySmsSetting,
    List<String>? machineIds,
  }) {
    return FormMachineGroupCreateOrUpdateModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      master: master ?? this.master,
      copySetting: copySetting ?? this.copySetting,
      copySmsSetting: copySmsSetting ?? this.copySmsSetting,
      machineIds: machineIds ?? this.machineIds,
    );
  }
}
