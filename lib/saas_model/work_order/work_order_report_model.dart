import 'dart:core';

import 'package:aku_new_community/model/common/img_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_order_report_model.g.dart';

@JsonSerializable()
class WorkOrderReportModel extends Equatable {
  final int id;
  final int type;
  final String content;
  final int userType;
  final int createId;
  final String createName;
  final String createDate;
  final String totalCost;
  final List<ImgModel> imgList;
  final List<ReportRecordVoList> reportRecordVoList;

  factory WorkOrderReportModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderReportModelFromJson(json);

  const WorkOrderReportModel({
    required this.id,
    required this.type,
    required this.content,
    required this.userType,
    required this.createId,
    required this.createName,
    required this.createDate,
    required this.totalCost,
    required this.imgList,
    required this.reportRecordVoList,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        content,
        userType,
        createId,
        createName,
        createDate,
        totalCost,
        imgList,
        reportRecordVoList,
      ];
}

@JsonSerializable()
class ReportRecordVoList extends Equatable {
  final int id;
  final int costType;
  final String name;
  @JsonKey(name: 'num')
  final int number;
  final num price;

  factory ReportRecordVoList.fromJson(Map<String, dynamic> json) =>
      _$ReportRecordVoListFromJson(json);

  const ReportRecordVoList({
    required this.id,
    required this.costType,
    required this.name,
    required this.number,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        costType,
        name,
        number,
        price,
      ];
}
