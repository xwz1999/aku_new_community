import 'package:equatable/equatable.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_community/model/common/img_model.dart';

part 'my_order_list_model.g.dart';

@JsonSerializable()
class MyOrderListModel extends Equatable {
  final int id;
  final String code;
  final int goodsId;
  final String goodsName;
  final int? backType;
  final List<ImgModel> goodsImgList;
  final double sellingPrice;
  final double? markingPrice;
  final int num;
  final String supplierName;
  final String levelOneCategory;
  final String levelTwoCategory;
  final int status;
  final String arrivalTime;
  MyOrderListModel({
    required this.id,
    required this.code,
    required this.goodsId,
    required this.goodsName,
    this.backType,
    required this.goodsImgList,
    required this.sellingPrice,
    this.markingPrice,
    required this.num,
    required this.supplierName,
    required this.levelOneCategory,
    required this.levelTwoCategory,
    required this.status,
    required this.arrivalTime,
  });

  factory MyOrderListModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrderListModelFromJson(json);

  String get arrivlaTimeString =>
      DateUtil.formatDateStr(this.arrivalTime, format: 'yyyy-MM-dd HH:mm');

  String get statusString {
    switch (this.status) {
      case 1:
        return '待发货';
      case 2:
        return '已发货';
      case 3:
        return '已收货';
      case 4:
        return '申请退换货';
      case 5:
        return '申请通过';
      case 6:
        return '申请驳回';
      default:
        return '未知';
    }
  }

  Color get statusColor {
    switch (this.status) {
      case 1:
        return Color(0xFFFF8200);
      case 2:
        return Color(0xFF030303);
      case 3:
        return Color(0xFF999999);
      case 4:
        return Color(0xFFFB4702);
      case 5:
        return Color(0xFF999999);
      case 6:
        return Color(0xFF999999);
      default:
        return Colors.black;
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
      num,
      supplierName,
      levelOneCategory,
      levelTwoCategory,
      status,
      arrivalTime,
    ];
  }
}
