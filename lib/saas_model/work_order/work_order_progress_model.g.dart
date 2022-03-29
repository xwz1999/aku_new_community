// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrderProgressModel _$WorkOrderProgressModelFromJson(
        Map<String, dynamic> json) =>
    WorkOrderProgressModel(
      id: json['id'] as int,
      status: json['status'] as int,
      content: json['content'] as String,
      userType: json['userType'] as int,
      createId: json['createId'] as int,
      createName: json['createName'] as String,
      createDate: json['createDate'] as String,
    );
