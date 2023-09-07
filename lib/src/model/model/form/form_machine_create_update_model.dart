// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FormMachineCreateUpdateModel extends Equatable {
  const FormMachineCreateUpdateModel({
    required this.serialNumber,
    required this.name,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
  });

  final String serialNumber;
  final String name;
  final String number;
  final String license;
  final String action;
  final String smsSetting;

  @override
  List<Object> get props {
    return [
      serialNumber,
      name,
      number,
      license,
      action,
      smsSetting,
    ];
  }

  FormMachineCreateUpdateModel copyWith({
    String? serialNumber,
    String? name,
    String? number,
    String? license,
    String? action,
    String? smsSetting,
  }) {
    return FormMachineCreateUpdateModel(
      serialNumber: serialNumber ?? this.serialNumber,
      name: name ?? this.name,
      number: number ?? this.number,
      license: license ?? this.license,
      action: action ?? this.action,
      smsSetting: smsSetting ?? this.smsSetting,
    );
  }

  @override
  bool get stringify => true;
}
