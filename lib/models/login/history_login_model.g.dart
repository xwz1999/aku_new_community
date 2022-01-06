// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_login_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryLoginModelAdapter extends TypeAdapter<HistoryLoginModel> {
  @override
  final int typeId = 4;

  @override
  HistoryLoginModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryLoginModel(
      cityModel: fields[0] as PickedCityModel,
      communityModel: fields[1] as CommunityModel?,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryLoginModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cityModel)
      ..writeByte(1)
      ..write(obj.communityModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryLoginModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryLoginModel _$HistoryLoginModelFromJson(Map<String, dynamic> json) =>
    HistoryLoginModel(
      cityModel:
          PickedCityModel.fromJson(json['cityModel'] as Map<String, dynamic>),
      communityModel: json['communityModel'] == null
          ? null
          : CommunityModel.fromJson(
              json['communityModel'] as Map<String, dynamic>),
    );
