import 'package:aku_new_community/model/common/img_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_order_detail_model.g.dart';

@JsonSerializable()
class WorkOrderDetailModel extends Equatable {
  final int id;
  final String code;
  final int status;
  final String workOrderTypeName;
  final String reserveAddress;
  final String reserveDate;
  final String content;
  final String createDate;
  final List<ImgModel>? servicePersonnelImgList;
  final int newReportNum;
  final int? evaluateLevel;
  final String? evaluateContent;
  final String? evaluateDate;

  factory WorkOrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderDetailModelFromJson(json);

  const WorkOrderDetailModel({
    required this.id,
    required this.code,
    required this.status,
    required this.workOrderTypeName,
    required this.reserveAddress,
    required this.reserveDate,
    required this.content,
    required this.createDate,
    this.servicePersonnelImgList,
    required this.newReportNum,
    this.evaluateLevel,
    this.evaluateContent,
    this.evaluateDate,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        status,
        workOrderTypeName,
        reserveAddress,
        reserveDate,
        content,
        createDate,
        servicePersonnelImgList,
        newReportNum,
        evaluateLevel,
        evaluateContent,
        evaluateDate,
      ];
}
