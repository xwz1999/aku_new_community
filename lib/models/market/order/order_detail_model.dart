import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_community/model/common/img_model.dart';

part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel extends Equatable {
  final int id;
  final String code;
  final int goodsId;
  final String goodsName;
  final int? backType;
  final List<ImgModel> goodsImgList;
  final num? sellingPrice;
  final num? markingPrice;
  @JsonKey(name: 'num')
  final int count;
  final int? supplierId;
  final String? supplierName;
  final String? levelOneCategory;
  final String? levelTwoCategory;
  final int? status;
  final String? sendDate;
  final String? sendDetail;
  final String? arrivalDate;
  final String? receivingDate;
  final String? backDate;
  final String? backReason;
  final String? score;
  final String? evaluationDate;
  final String? evaluationReason;
  final String? arrivalTime;
  final String? createDate;
  OrderDetailModel({
    required this.id,
    required this.code,
    required this.goodsId,
    required this.goodsName,
    this.backType,
    required this.goodsImgList,
    this.sellingPrice,
    this.markingPrice,
    required this.count,
    this.supplierId,
    this.supplierName,
    this.levelOneCategory,
    this.levelTwoCategory,
    this.status,
    this.sendDate,
    this.sendDetail,
    this.arrivalDate,
    this.receivingDate,
    this.backDate,
    this.backReason,
    this.score,
    this.evaluationDate,
    this.evaluationReason,
    this.arrivalTime,
    this.createDate,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  String get statusString {
    switch (this.status) {
      case 1:
        return '待发货';
      case 2:
        return '已发货';
      case 3:
        return '已到货';
      case 4:
        return '已收货';
      case 5:
        return '未知';
      case 6:
        return '已评价';
      case 8:
        return '申请退换';
      case 9:
        return '申请通过';
      case 10:
        return '申请驳回';
      default:
        return '未知';
    }
  }

  String get statusTime {
    switch (this.status) {
      case 1:
        return this.createDate!;
      case 2:
        return this.sendDate!;
      case 3:
        return this.arrivalDate!;
      case 4:
        return this.receivingDate!;
      case 6:
        return this.evaluationDate!;
      case 8:
        return this.backDate!;
      case 9:
        return this.backDate!;
      case 10:
        return this.backDate!;
      default:
        return '未知';
    }
  }

  @override
  List<Object?> get props {
    return [
      id,
      code,
      goodsId,
      goodsName,
      backType,
      goodsImgList,
      sellingPrice,
      markingPrice,
      count,
      supplierId,
      supplierName,
      levelOneCategory,
      levelTwoCategory,
      status,
      sendDate,
      sendDetail,
      arrivalDate,
      receivingDate,
      backDate,
      backReason,
      score,
      evaluationDate,
      evaluationReason,
      arrivalTime,
      createDate,
    ];
  }
}
