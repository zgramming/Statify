import 'package:equatable/equatable.dart';

class IncomingSMSModel extends Equatable {
  final String body;
  final String address;
  final int simSlot;
  final int date;

  const IncomingSMSModel({
    required this.body,
    required this.address,
    required this.simSlot,
    required this.date,
  });

  @override
  List<Object?> get props => [
        body,
        address,
        simSlot,
        date,
      ];

  @override
  bool get stringify => true;

  IncomingSMSModel copyWith({
    String? body,
    String? address,
    int? simSlot,
    int? date,
  }) {
    return IncomingSMSModel(
      body: body ?? this.body,
      address: address ?? this.address,
      simSlot: simSlot ?? this.simSlot,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'address': address,
      'simSlot': simSlot,
      'date': date,
    };
  }

  factory IncomingSMSModel.fromMap(Map<String, dynamic> map) {
    return IncomingSMSModel(
      body: map['body'] as String,
      address: map['address'] as String,
      simSlot: map['simSlot'] as int,
      date: map['date'] as int,
    );
  }
}
