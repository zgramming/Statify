import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'machine_summary.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineSummaryModel extends Equatable {
  final int totalSent;
  final int totalReplied;
  final int totalVoted;
  final int totalFinished;
  const MachineSummaryModel({
    required this.totalSent,
    required this.totalReplied,
    required this.totalVoted,
    required this.totalFinished,
  });

  factory MachineSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$MachineSummaryModelFromJson(json);

  /// Connect the generated [_$MachineSummaryModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineSummaryModelToJson(this);

  @override
  List<Object> get props =>
      [totalSent, totalReplied, totalVoted, totalFinished];

  @override
  bool get stringify => true;
}
