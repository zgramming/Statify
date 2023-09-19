// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SendSMSModel extends Equatable {
  final String phoneNumber;
  final String message;
  final int simSlot;
  final String surveyRespondenId;
  final String surveyRespondenResponseId;
  const SendSMSModel({
    required this.phoneNumber,
    required this.message,
    required this.simSlot,
    required this.surveyRespondenId,
    required this.surveyRespondenResponseId,
  });

  @override
  List<Object> get props {
    return [
      phoneNumber,
      message,
      simSlot,
      surveyRespondenId,
      surveyRespondenResponseId,
    ];
  }

  @override
  bool get stringify => true;
}
