// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrderReportModel _$WorkOrderReportModelFromJson(
        Map<String, dynamic> json) =>
    WorkOrderReportModel(
      id: json['id'] as int,
      type: json['type'] as int,
      content: json['content'] as String,
      userType: json['userType'] as int,
      createId: json['createId'] as int,
      createName: json['createName'] as String,
      createDate: json['createDate'] as String,
      totalCost: json['totalCost'] as String,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reportRecordVoList: (json['reportRecordVoList'] as List<dynamic>)
          .map((e) => ReportRecordVoList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ReportRecordVoList _$ReportRecordVoListFromJson(Map<String, dynamic> json) =>
    ReportRecordVoList(
      id: json['id'] as int,
      costType: json['costType'] as int,
      name: json['name'] as String,
      number: json['num'] as int,
      price: json['price'] as num,
    );
