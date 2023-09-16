import 'dart:convert';

import 'package:equatable/equatable.dart';

class ListenOnsentSMSModel extends Equatable {
  final String message;
  final int code;
  final bool status;
  final String surveyResponseId;

  const ListenOnsentSMSModel({
    required this.message,
    required this.code,
    required this.status,
    required this.surveyResponseId,
  });

  @override
  List<Object> get props => [message, code, status, surveyResponseId];

  @override
  bool get stringify => true;

  ListenOnsentSMSModel copyWith({
    String? message,
    int? code,
    bool? status,
    String? surveyResponseId,
  }) {
    return ListenOnsentSMSModel(
      message: message ?? this.message,
      code: code ?? this.code,
      status: status ?? this.status,
      surveyResponseId: surveyResponseId ?? this.surveyResponseId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'status': status,
      'surveyResponseId': surveyResponseId,
    };
  }

  factory ListenOnsentSMSModel.fromMap(Map<String, dynamic> map) {
    return ListenOnsentSMSModel(
      message: map['message'] as String,
      code: map['code'] as int,
      status: map['status'] as bool,
      surveyResponseId: map['surveyResponseId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListenOnsentSMSModel.fromJson(String source) =>
      ListenOnsentSMSModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
