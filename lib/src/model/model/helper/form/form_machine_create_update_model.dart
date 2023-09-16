import 'package:equatable/equatable.dart';

class FormMachineCreateUpdateModel extends Equatable {
  const FormMachineCreateUpdateModel({
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.action,
  });

  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final String action;

  @override
  List<Object> get props {
    return [
      name,
      number,
      serialNumber,
      license,
      action,
    ];
  }

  FormMachineCreateUpdateModel copyWith({
    String? name,
    String? number,
    String? serialNumber,
    String? license,
    String? action,
  }) {
    return FormMachineCreateUpdateModel(
      name: name ?? this.name,
      number: number ?? this.number,
      serialNumber: serialNumber ?? this.serialNumber,
      license: license ?? this.license,
      action: action ?? this.action,
    );
  }

  @override
  bool get stringify => true;
}
