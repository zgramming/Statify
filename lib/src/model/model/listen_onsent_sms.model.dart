import 'dart:convert';

import 'package:equatable/equatable.dart';

class ListenOnsentSMSModel extends Equatable {
  final String message;
  final int code;
  final bool status;
  final String surveyRespondenId;
  final String surveyRespondenResponseId;

  const ListenOnsentSMSModel({
    required this.message,
    required this.code,
    required this.status,
    required this.surveyRespondenId,
    required this.surveyRespondenResponseId,
  });

  @override
  List<Object> get props {
    return [
      message,
      code,
      status,
      surveyRespondenId,
      surveyRespondenResponseId,
    ];
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'status': status,
      'surveyRespondenId': surveyRespondenId,
      'surveyRespondenResponseId': surveyRespondenResponseId,
    };
  }

  factory ListenOnsentSMSModel.fromMap(Map<String, dynamic> map) {
    return ListenOnsentSMSModel(
      message: map['message'] as String,
      code: map['code'] as int,
      status: map['status'] as bool,
      surveyRespondenId: map['surveyRespondenId'] as String,
      surveyRespondenResponseId: map['surveyRespondenResponseId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListenOnsentSMSModel.fromJson(String source) =>
      ListenOnsentSMSModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
