import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_config_countries.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineConfigCountriesModel extends Equatable {
  final String label;
  final String name;
  final List<MachineConfigCountriesMNCModel> mncs;
  // ignore: non_constant_identifier_names
  final int is_active;

  const MachineConfigCountriesModel({
    required this.label,
    required this.name,
    this.mncs = const [],
    // ignore: non_constant_identifier_names
    this.is_active = 1,
  });

  factory MachineConfigCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigCountriesModelFromJson(json);

  /// Connect the generated [_$MachineConfigCountriesModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigCountriesModelToJson(this);

  @override
  List<Object> get props => [label, name, mncs, is_active];

  @override
  bool get stringify => true;

  MachineConfigCountriesModel copyWith({
    String? label,
    String? name,
    List<MachineConfigCountriesMNCModel>? mncs,
    // ignore: non_constant_identifier_names
    int? is_active,
  }) {
    return MachineConfigCountriesModel(
      label: label ?? this.label,
      name: name ?? this.name,
      mncs: mncs ?? this.mncs,
      is_active: is_active ?? this.is_active,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineConfigCountriesMNCModel extends Equatable {
  final int status;
  final String label;
  final String mcc;
  final String mnc;
  final String name;

  const MachineConfigCountriesMNCModel({
    required this.status,
    required this.label,
    required this.mcc,
    required this.mnc,
    required this.name,
  });

  factory MachineConfigCountriesMNCModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigCountriesMNCModelFromJson(json);

  /// Connect the generated [_$MachineConfigCountriesMNCModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigCountriesMNCModelToJson(this);

  @override
  List<Object> get props {
    return [
      status,
      label,
      mcc,
      mnc,
      name,
    ];
  }

  @override
  bool get stringify => true;

  MachineConfigCountriesMNCModel copyWith({
    int? status,
    String? label,
    String? mcc,
    String? mnc,
    String? name,
  }) {
    return MachineConfigCountriesMNCModel(
      status: status ?? this.status,
      label: label ?? this.label,
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      name: name ?? this.name,
    );
  }
}
