// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_config_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserConfigModelAdapter extends TypeAdapter<UserConfigModel> {
  @override
  final int typeId = 5;

  @override
  UserConfigModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserConfigModel(
      userId: fields[0] as int,
      clockRemind: fields[1] as bool,
      todayClocked: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserConfigModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.clockRemind)
      ..writeByte(2)
      ..write(obj.todayClocked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserConfigModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConfigModel _$UserConfigModelFromJson(Map<String, dynamic> json) =>
    UserConfigModel(
      userId: json['userId'] as int,
      clockRemind: json['clockRemind'] as bool,
      todayClocked: json['todayClocked'] as bool,
    );
