import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class SendSMSModel extends Equatable {
  final String phoneNumber;
  final String message;
  final int simSlot;
  final String surveyResponseId;
  final Uint8List? image;
  const SendSMSModel({
    required this.phoneNumber,
    required this.message,
    required this.simSlot,
    required this.surveyResponseId,
    this.image,
  });

  @override
  List<Object?> get props {
    return [
      phoneNumber,
      message,
      simSlot,
      surveyResponseId,
      image,
    ];
  }

  @override
  bool get stringify => true;

  SendSMSModel copyWith({
    String? phoneNumber,
    String? message,
    int? simSlot,
    String? surveyResponseId,
    Uint8List? image,
  }) {
    return SendSMSModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      message: message ?? this.message,
      simSlot: simSlot ?? this.simSlot,
      surveyResponseId: surveyResponseId ?? this.surveyResponseId,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'message': message,
      'simSlot': simSlot,
      'surveyResponseId': surveyResponseId,
    };
  }

  factory SendSMSModel.fromMap(Map<String, dynamic> map) {
    return SendSMSModel(
      phoneNumber: map['phoneNumber'] as String,
      message: map['message'] as String,
      simSlot: map['simSlot'] as int,
      surveyResponseId: map['surveyResponseId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendSMSModel.fromJson(String source) =>
      SendSMSModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
