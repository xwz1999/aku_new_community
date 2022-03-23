import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_order_progress_model.g.dart';

@JsonSerializable()
class WorkOrderProgressModel extends Equatable {
  final int id;

  ///  工单进度状态：1.待分配，2.工单池，3.已接单，4.处理中，5.待确认，6.待支付，7.已完成，8.已评价，9.已拒绝，10.已取消
  final int status;
  final String content;

  ///创建人类型：1.申请人，2.分配人，3.负责人，4.管理员，5.协同人
  final int userType;
  final int createId;
  final String createName;
  final String createDate;

  factory WorkOrderProgressModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderProgressModelFromJson(json);

  const WorkOrderProgressModel({
    required this.id,
    required this.status,
    required this.content,
    required this.userType,
    required this.createId,
    required this.createName,
    required this.createDate,
  });
  @override
  List<Object?> get props => [
        id,
        status,
        content,
        userType,
        createId,
        createName,
        createDate,
      ];
}
