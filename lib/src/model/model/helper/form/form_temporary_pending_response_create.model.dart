import 'package:equatable/equatable.dart';

class FormTemporaryPendingResponseCreateModel extends Equatable {
  final String surveyRespondentId;
  final int simSlot;
  final String phoneNumber;
  final String message;

  const FormTemporaryPendingResponseCreateModel({
    required this.surveyRespondentId,
    required this.simSlot,
    required this.phoneNumber,
    required this.message,
  });

  @override
  List<Object> get props => [surveyRespondentId, simSlot, phoneNumber, message];

  @override
  bool get stringify => true;
}
