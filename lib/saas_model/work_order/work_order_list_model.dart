import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_order_list_model.g.dart';

@JsonSerializable()
class WorkOrderListModel extends Equatable {
  final int id;
  final String code;
  final int status;
  final String workOrderTypeName;
  final String reserveAddress;
  final String reserveDate;
  final String content;
  final String updateDate;
  final String createDate;
  final List<ImgModel>? imgList;

  factory WorkOrderListModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderListModelFromJson(json);

  DateTime? get updateDateDT => DateUtil.getDateTime(updateDate);

  DateTime? get createDateDT => DateUtil.getDateTime(createDate);

  @override
  List<Object?> get props => [
        id,
        code,
        status,
        workOrderTypeName,
        reserveAddress,
        reserveDate,
        content,
        updateDate,
        createDate,
        imgList
      ];

  const WorkOrderListModel({
    required this.id,
    required this.code,
    required this.status,
    required this.workOrderTypeName,
    required this.reserveAddress,
    required this.reserveDate,
    required this.content,
    required this.updateDate,
    required this.createDate,
    this.imgList,
  });
}
