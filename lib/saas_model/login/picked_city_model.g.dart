// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picked_city_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PickedCityModelAdapter extends TypeAdapter<PickedCityModel> {
  @override
  final int typeId = 6;

  @override
  PickedCityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PickedCityModel(
      province: fields[0] as ChinaRegionModel,
      city: fields[1] as ChinaRegionModel,
      district: fields[2] as ChinaRegionModel,
    );
  }

  @override
  void write(BinaryWriter writer, PickedCityModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.province)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.district);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickedCityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickedCityModel _$PickedCityModelFromJson(Map<String, dynamic> json) =>
    PickedCityModel(
      province:
          ChinaRegionModel.fromJson(json['province'] as Map<String, dynamic>),
      city: ChinaRegionModel.fromJson(json['city'] as Map<String, dynamic>),
      district:
          ChinaRegionModel.fromJson(json['district'] as Map<String, dynamic>),
    );
