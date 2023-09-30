import 'package:equatable/equatable.dart';

class FormMachineGroupCreateOrUpdateModel extends Equatable {
  final String? machineGroupId;
  final String userId;
  final String name;
  final String masterMachineId;
  final List<String> machineIds;
  const FormMachineGroupCreateOrUpdateModel({
    this.machineGroupId,
    required this.userId,
    required this.name,
    required this.masterMachineId,
    required this.machineIds,
  });

  @override
  List<Object?> get props {
    return [
      machineGroupId,
      userId,
      name,
      masterMachineId,
      machineIds,
    ];
  }

  @override
  bool get stringify => true;

  FormMachineGroupCreateOrUpdateModel copyWith({
    String? machineGroupId,
    String? userId,
    String? name,
    String? masterMachineId,
    List<String>? machineIds,
  }) {
    return FormMachineGroupCreateOrUpdateModel(
      machineGroupId: machineGroupId ?? this.machineGroupId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      masterMachineId: masterMachineId ?? this.masterMachineId,
      machineIds: machineIds ?? this.machineIds,
    );
  }
}
