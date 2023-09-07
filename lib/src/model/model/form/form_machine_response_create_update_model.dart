// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FormMachineResponseCreateUpdateModel extends Equatable {
  final String platform;
  final String key;
  final String value;
  final String type;
  const FormMachineResponseCreateUpdateModel({
    required this.platform,
    required this.key,
    required this.value,
    required this.type,
  });

  @override
  List<Object> get props => [platform, key, value, type];

  @override
  bool get stringify => true;

  FormMachineResponseCreateUpdateModel copyWith({
    String? platform,
    String? key,
    String? value,
    String? type,
  }) {
    return FormMachineResponseCreateUpdateModel(
      platform: platform ?? this.platform,
      key: key ?? this.key,
      value: value ?? this.value,
      type: type ?? this.type,
    );
  }
}
