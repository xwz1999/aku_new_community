// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passed_house_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassedHouseListModel _$PassedHouseListModelFromJson(Map<String, dynamic> json) {
  return PassedHouseListModel(
    id: json['id'] as int,
    estateId: json['estateId'] as int,
    roomName: json['roomName'] as String,
    type: json['type'] as int,
    effectiveTimeStart: json['effectiveTimeStart'] as String?,
    effectiveTimeEnd: json['effectiveTimeEnd'] as String?,
  );
}
