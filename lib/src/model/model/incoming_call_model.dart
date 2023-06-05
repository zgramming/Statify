// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class IncomingCallModel extends Equatable {
  final String state;
  final String? number;

  const IncomingCallModel({
    required this.state,
    this.number,
  });

  @override
  List<Object?> get props => [state, number];

  @override
  bool get stringify => true;

  IncomingCallModel copyWith({
    String? state,
    String? number,
  }) {
    return IncomingCallModel(
      state: state ?? this.state,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'number': number,
    };
  }

  factory IncomingCallModel.fromMap(Map<String, dynamic> map) {
    return IncomingCallModel(
      state: map['state'] as String,
      number: map['number'] != null ? map['number'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomingCallModel.fromJson(String source) =>
      IncomingCallModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
