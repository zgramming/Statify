// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../database/database.dart';

class TemporaryPendingResponseModel extends Equatable {
  final String surveyResponseId;
  final String surveyId;
  final String machineId;
  final int simSlot;
  final String phoneNumber;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const TemporaryPendingResponseModel({
    required this.surveyResponseId,
    required this.surveyId,
    required this.machineId,
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
      surveyResponseId: data.surveyResponseId,
      surveyId: data.surveyId,
      machineId: data.machineId,
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
      surveyResponseId,
      surveyId,
      machineId,
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
