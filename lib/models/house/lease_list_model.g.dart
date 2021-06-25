// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lease_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaseListModel _$LeaseListModelFromJson(Map<String, dynamic> json) {
  return LeaseListModel(
    id: json['id'] as int,
    roomName: json['roomName'] as String,
    type: json['type'] as int,
    estateType: json['estateType'] as String,
    status: json['status'] as int,
  );
}
