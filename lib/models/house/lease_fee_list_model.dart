import 'package:equatable/equatable.dart';
import 'package:flustars/flustars.dart';
import 'package:json_annotation/json_annotation.dart';
part 'lease_fee_list_model.g.dart';

@JsonSerializable()
class LeaseFeeListModel extends Equatable {
  final int id;
  final num price;
  final int payStatus;
  final String createDate;
  final int type;
  LeaseFeeListModel({
    required this.id,
    required this.price,
    required this.payStatus,
    required this.createDate,
    required this.type,
  });
  factory LeaseFeeListModel.fromJson(Map<String, dynamic> json) =>
      _$LeaseFeeListModelFromJson(json);
  @override
  List<Object> get props {
    return [
      id,
      price,
      payStatus,
      createDate,
      type,
    ];
  }

  String get typeString {
    switch (this.type) {
      case 1:
        return '保证金';
      case 2:
        return '租金';
      case 3:
        return '剩余需结清租金';
      default:
        return '未知';
    }
  }

  String get payStatusString {
    switch (this.payStatus) {
      case 0:
        return '未缴纳';
      case 1:
        return '已缴纳';
      case 2:
        return '已结算';
      default:
        return '未知';
    }
  }

  DateTime get createDateTime => DateUtil.getDateTime(this.createDate)!;
}
