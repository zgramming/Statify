import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'machine_config_boardips.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineBoardIpsModel extends Equatable {
  final String name;
  final String ip;
  final String status;

  const MachineBoardIpsModel({
    required this.name,
    required this.ip,
    required this.status,
  });

  factory MachineBoardIpsModel.fromJson(Map<String, dynamic> json) =>
      _$MachineBoardIpsModelFromJson(json);

  /// Connect the generated [_$MachineBoardIpsModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineBoardIpsModelToJson(this);

  @override
  List<Object> get props => [name, ip, status];

  @override
  bool get stringify => true;

  MachineBoardIpsModel copyWith({
    String? name,
    String? ip,
    String? status,
  }) {
    return MachineBoardIpsModel(
      name: name ?? this.name,
      ip: ip ?? this.ip,
      status: status ?? this.status,
    );
  }
}
