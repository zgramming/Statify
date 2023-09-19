// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../database/database.dart';

class TemporaryPendingResponseModel extends Equatable {
  final String surveyRespondenId;
  final int simSlot;
  final String phoneNumber;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const TemporaryPendingResponseModel({
    required this.surveyRespondenId,
    required this.simSlot,
    required this.phoneNumber,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TemporaryPendingResponseModel.fromData(
      TemporaryPendingResponseTableData data) {
    return TemporaryPendingResponseModel(
      surveyRespondenId: data.surveyRespondentId,
      simSlot: data.simSlot,
      phoneNumber: data.phoneNumber,
      message: data.message,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      deletedAt: data.deletedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      surveyRespondenId,
      simSlot,
      phoneNumber,
      message,
      createdAt,
      updatedAt,
      deletedAt,
    ];
  }

  @override
  bool get stringify => true;
}
