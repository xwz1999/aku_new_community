// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HallListModel _$HallListModelFromJson(Map<String, dynamic> json) =>
    HallListModel(
      id: json['id'] as int,
      title: json['title'] as String,
      status: json['status'] as int,
      type: json['type'] as int,
      sex: json['sex'] as int,
      serviceObject: json['serviceObject'] as int,
      content: json['content'] as String,
      appointmentDate: json['appointmentDate'] as String,
      appointmentAddress: json['appointmentAddress'] as String,
      rewardType: json['rewardType'] as int,
      reward: json['reward'] as int,
      createType: json['createType'] as int,
      createName: json['createName'] as String?,
      createDate: json['createDate'] as String,
    );
