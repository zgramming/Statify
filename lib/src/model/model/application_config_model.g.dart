// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_config_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApplicationConfigModelAdapter
    extends TypeAdapter<ApplicationConfigModel> {
  @override
  final int typeId = 3;

  @override
  ApplicationConfigModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApplicationConfigModel(
      isIntroductionDone: fields[0] as bool,
      isDarkMode: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ApplicationConfigModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isIntroductionDone)
      ..writeByte(1)
      ..write(obj.isDarkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationConfigModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
