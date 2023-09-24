// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_summary.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineSummaryModel _$MachineSummaryModelFromJson(Map<String, dynamic> json) =>
    MachineSummaryModel(
      totalSent: json['total_sent'] as int,
      totalReplied: json['total_replied'] as int,
      totalVoted: json['total_voted'] as int,
      totalFinished: json['total_finished'] as int,
    );

Map<String, dynamic> _$MachineSummaryModelToJson(
        MachineSummaryModel instance) =>
    <String, dynamic>{
      'total_sent': instance.totalSent,
      'total_replied': instance.totalReplied,
      'total_voted': instance.totalVoted,
      'total_finished': instance.totalFinished,
    };
