import 'package:equatable/equatable.dart';

class FormMachineWhatsappCreateOrUpdateModel extends Equatable {
  final String number;
  final String machineId;
  final String? whatsappId;
  const FormMachineWhatsappCreateOrUpdateModel({
    required this.number,
    required this.machineId,
    required this.whatsappId,
  });

  @override
  List<Object?> get props => [number, machineId, whatsappId];

  @override
  bool get stringify => true;

  FormMachineWhatsappCreateOrUpdateModel copyWith({
    String? number,
    String? machineId,
    String? whatsappId,
  }) {
    return FormMachineWhatsappCreateOrUpdateModel(
      number: number ?? this.number,
      machineId: machineId ?? this.machineId,
      whatsappId: whatsappId ?? this.whatsappId,
    );
  }
}
