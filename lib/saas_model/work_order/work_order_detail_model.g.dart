// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrderDetailModel _$WorkOrderDetailModelFromJson(
        Map<String, dynamic> json) =>
    WorkOrderDetailModel(
      id: json['id'] as int,
      code: json['code'] as String,
      status: json['status'] as int,
      workOrderTypeName: json['workOrderTypeName'] as String,
      reserveAddress: json['reserveAddress'] as String,
      reserveDate: json['reserveDate'] as String,
      content: json['content'] as String,
      createDate: json['createDate'] as String,
      imgList: (json['imgList'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      servicePersonnelImgList:
          (json['servicePersonnelImgList'] as List<dynamic>?)
              ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      newReportNum: json['newReportNum'] as int,
      evaluateLevel: json['evaluateLevel'] as int?,
      evaluateContent: json['evaluateContent'] as String?,
      evaluateDate: json['evaluateDate'] as String?,
    );
