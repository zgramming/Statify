import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_config_countries.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineConfigCountriesModel extends Equatable {
  final String name;
  final String label;
  final int isActive;
  final List<MachineConfigCountriesMNCModel> mncs;

  const MachineConfigCountriesModel({
    this.name = '',
    this.label = '',
    this.isActive = 1,
    this.mncs = const [],
  });

  factory MachineConfigCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigCountriesModelFromJson(json);

  /// Connect the generated [_$MachineConfigCountriesModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigCountriesModelToJson(this);

  @override
  List<Object> get props => [name, label, isActive, mncs];

  @override
  bool get stringify => true;

  MachineConfigCountriesModel copyWith({
    String? name,
    String? label,
    int? isActive,
    List<MachineConfigCountriesMNCModel>? mncs,
  }) {
    return MachineConfigCountriesModel(
      name: name ?? this.name,
      label: label ?? this.label,
      isActive: isActive ?? this.isActive,
      mncs: mncs ?? this.mncs,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineConfigCountriesMNCModel extends Equatable {
  final String mcc;
  final String mnc;
  final String name;
  final String label;
  final int status;
  @JsonKey(
    defaultValue: 'Indonesia',
  )
  final String country;

  const MachineConfigCountriesMNCModel({
    required this.mcc,
    required this.mnc,
    required this.name,
    required this.label,
    this.status = 1,
    required this.country,
  });

  factory MachineConfigCountriesMNCModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigCountriesMNCModelFromJson(json);

  /// Connect the generated [_$MachineConfigCountriesMNCModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigCountriesMNCModelToJson(this);

  @override
  List<Object> get props {
    return [
      mcc,
      mnc,
      name,
      label,
      status,
      country,
    ];
  }

  @override
  bool get stringify => true;

  MachineConfigCountriesMNCModel copyWith({
    String? mcc,
    String? mnc,
    String? name,
    String? label,
    int? status,
    String? country,
  }) {
    return MachineConfigCountriesMNCModel(
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      name: name ?? this.name,
      label: label ?? this.label,
      status: status ?? this.status,
      country: country ?? this.country,
    );
  }
}
