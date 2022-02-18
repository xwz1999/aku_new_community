import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

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
  final String? sendDate;
  final String? sendDetail;
  final String? arrivalDate;
  final String? receivingDate;
  final String? backDate;
  final String? backReason;
  final String? reason;
  final int? score;
  final String? evaluationDate;
  final String? evaluationReason;
  final String? createDate;
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
    this.sendDate,
    this.sendDetail,
    this.arrivalDate,
    this.receivingDate,
    this.backDate,
    this.backReason,
    this.reason,
    this.score,
    this.evaluationDate,
    this.evaluationReason,
    this.createDate,
    required this.arrivalTime,
  });

  factory MyOrderListModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrderListModelFromJson(json);

  String get sendDateString =>
      DateUtil.formatDateStr(this.sendDate ?? '', format: 'yyyy-MM-dd HH:mm');

  String get arrivalDateString => DateUtil.formatDateStr(this.arrivalDate ?? '',
      format: 'yyyy-MM-dd HH:mm');

  String get receiveDateString =>
      DateUtil.formatDateStr(this.receivingDate ?? '',
          format: 'yyyy-MM-dd HH:mm');

  String get backDateString =>
      DateUtil.formatDateStr(this.backDate ?? '', format: 'yyyy-MM-dd HH:mm');

  String get evaluateDateString =>
      DateUtil.formatDateStr(this.evaluationDate ?? '',
          format: 'yyyy-MM-dd HH:mm');

  String get createDateString =>
      DateUtil.formatDateStr(this.createDate ?? '', format: 'yyyy-MM-dd HH:mm');

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

  Color get statusColor {
    switch (this.status) {
      case 1:
        return Color(0xFFFF8200);
      case 2:
        return Color(0xFF030303);
      case 3:
        return Color(0xFF999999);
      case 4:
        return Color(0xFF999999);
      case 6:
        return Color(0xFF999999);
      case 8:
        return Color(0xFFFB4702);
      case 9:
        return Color(0xFF3F8FFE);
      case 10:
        return Color(0xFFE60E0E);
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
      sendDate,
      sendDetail,
      arrivalDate,
      receivingDate,
      backDate,
      backReason,
      reason,
      score,
      evaluationDate,
      evaluationReason,
      createDate,
      arrivalTime,
    ];
  }
}
