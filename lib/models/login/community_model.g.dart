// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommunityModelAdapter extends TypeAdapter<CommunityModel> {
  @override
  final int typeId = 7;

  @override
  CommunityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommunityModel(
      id: fields[0] as int,
      name: fields[1] as String,
      address: fields[2] as String,
      addressDetails: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CommunityModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.addressDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityModel _$CommunityModelFromJson(Map<String, dynamic> json) =>
    CommunityModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      addressDetails: json['addressDetails'] as String,
    );
