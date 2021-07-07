import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lease_list_model.g.dart';

@JsonSerializable()
class LeaseListModel extends Equatable {
  final int id;
  final String roomName;
  final int type;
  final String estateType;
  final int status;
  LeaseListModel({
    required this.id,
    required this.roomName,
    required this.type,
    required this.estateType,
    required this.status,
  });

  factory LeaseListModel.fromJson(Map<String, dynamic> json) =>
      _$LeaseListModelFromJson(json);

  @override
  List<Object> get props {
    return [
      id,
      roomName,
      type,
      estateType,
      status,
    ];
  }

  String get getTypeString {
    switch (this.type) {
      case 1:
        return '一类人才';
      case 2:
        return '二类人才';
      case 3:
        return '三类人才';
      default:
        return '未知';
    }
  }

  String get statusString {
    switch (this.status) {
      case 1:
        return '待签署';
      case 2:
        return '待提交';
      case 3:
        return '审核中';
      case 4:
        return '已驳回';
      case 5:
        return '待支付';
      case 6:
        return '已完成';
      case 11:
        return '申请终止合同';
      case 12:
        return '申请终止失败';
      case 13:
        return '申请终止成功';
      case 14:
        return '已支付剩余租金';
      case 15:
        return '申请退还保证金';
      case 16:
        return '申请退还保证金驳回';
      case 17:
        return '申请退还保证金成功';
      default:
        return '未知';
    }
  }
}
