import 'package:equatable/equatable.dart';

class FormMachineCreateUpdateModel extends Equatable {
  const FormMachineCreateUpdateModel({
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.code,
    required this.ip,
  });

  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final String code;
  final String ip;

  @override
  List<Object> get props {
    return [
      name,
      number,
      serialNumber,
      license,
      code,
      ip,
    ];
  }

  @override
  bool get stringify => true;
}
