// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'china_region_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChinaRegionModelAdapter extends TypeAdapter<ChinaRegionModel> {
  @override
  final int typeId = 3;

  @override
  ChinaRegionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChinaRegionModel(
      id: fields[0] as int,
      name: fields[1] as String,
      parentId: fields[2] as int,
      cityList: (fields[3] as List?)?.cast<ChinaRegionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChinaRegionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.parentId)
      ..writeByte(3)
      ..write(obj.cityList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChinaRegionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChinaRegionModel _$ChinaRegionModelFromJson(Map<String, dynamic> json) =>
    ChinaRegionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      parentId: json['parentId'] as int,
      cityList: (json['cityList'] as List<dynamic>?)
          ?.map((e) => ChinaRegionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
