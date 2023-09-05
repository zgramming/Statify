import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_delete_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineDeleteResponseModel extends Equatable {
  final String id;
  final String userId;
  final String number;
  final String license;
  final String action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineDeleteResponseModel({
    required this.id,
    required this.userId,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineDeleteResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MachineDeleteResponseModelFromJson(json);

  /// Connect the generated [_$MachineDeleteResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineDeleteResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      userId,
      number,
      license,
      action,
      smsSetting,
      send,
      replied,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  MachineDeleteResponseModel copyWith({
    String? id,
    String? userId,
    String? number,
    String? license,
    String? action,
    String? smsSetting,
    int? send,
    int? replied,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineDeleteResponseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      number: number ?? this.number,
      license: license ?? this.license,
      action: action ?? this.action,
      smsSetting: smsSetting ?? this.smsSetting,
      send: send ?? this.send,
      replied: replied ?? this.replied,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
