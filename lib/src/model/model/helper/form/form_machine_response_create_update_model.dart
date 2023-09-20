// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FormMachineResponseCreateUpdateModel extends Equatable {
  final String platform;
  final String key;
  final String value;
  final bool isVoting;
  final bool isFinish;
  const FormMachineResponseCreateUpdateModel({
    required this.platform,
    required this.key,
    required this.value,
    required this.isVoting,
    required this.isFinish,
  });

  @override
  List<Object> get props {
    return [
      platform,
      key,
      value,
      isVoting,
      isFinish,
    ];
  }

  @override
  bool get stringify => true;
}
