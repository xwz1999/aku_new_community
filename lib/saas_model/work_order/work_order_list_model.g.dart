// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrderListModel _$WorkOrderListModelFromJson(Map<String, dynamic> json) =>
    WorkOrderListModel(
      id: json['id'] as int,
      code: json['code'] as String,
      status: json['status'] as int,
      workOrderTypeName: json['workOrderTypeName'] as String,
      reserveAddress: json['reserveAddress'] as String,
      reserveDate: json['reserveDate'] as String,
      content: json['content'] as String,
      updateDate: json['updateDate'] as String,
      createDate: json['createDate'] as String,
      imgList: (json['imgList'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
