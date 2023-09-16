// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FormTemporaryPendingResponseCreateModel extends Equatable {
  final String surveyId;
  final String machineId;
  final int simSlot;
  final String phoneNumber;
  final String message;

  const FormTemporaryPendingResponseCreateModel({
    required this.surveyId,
    required this.machineId,
    required this.simSlot,
    required this.phoneNumber,
    required this.message,
  });

  @override
  List<Object> get props {
    return [
      surveyId,
      machineId,
      simSlot,
      phoneNumber,
      message,
    ];
  }

  @override
  bool get stringify => true;
}
