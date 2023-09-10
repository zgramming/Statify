import 'package:equatable/equatable.dart';

class FormMachineResponseCreateUpdateModel extends Equatable {
  final String platform;
  final String key;
  final String value;
  const FormMachineResponseCreateUpdateModel({
    required this.platform,
    required this.key,
    required this.value,
  });

  @override
  List<Object> get props => [platform, key, value];

  @override
  bool get stringify => true;

  FormMachineResponseCreateUpdateModel copyWith({
    String? platform,
    String? key,
    String? value,
  }) {
    return FormMachineResponseCreateUpdateModel(
      platform: platform ?? this.platform,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}
