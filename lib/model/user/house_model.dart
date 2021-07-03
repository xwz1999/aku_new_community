import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';

class HouseModel {
  int? id;
  String? roomName;

  int? estateId;

  ///1.未审核，3.审核失败，4.审核成功
  int? status;

  ///1 审核业主，2审核亲属，3审核租客
  int? type;
  String? effectiveTimeStart;
  String? effectiveTimeEnd;

  DateTime? get effectiveStartDate => DateUtil.getDateTime(effectiveTimeStart!);
  DateTime? get effectiveEndDate => DateUtil.getDateTime(effectiveTimeEnd!);

  //
  bool get reviewed => status == 4;
  String get typeValue {
    switch (type) {
      case 1:
        return '业主';
      case 2:
        return '租客';
      case 3:
        return '亲属';
    }
    return '';
  }

  String get houseStatus {
    if (status == 1) return '审核中';
    if (status == 3) return '未通过';
    if (type == 1) return '业主';
    if (type == 2) return '亲属';
    if (type == 3) return '租客';
    return '';
  }

  Color get houseStatusColor {
    if (status != 4) return Color(0xFF666666);
    if (type == 1) return Color(0xFF333333);
    return Colors.white;
  }

  ///我的房屋页面背景颜色
  ///
  List<Color> get backgroundColor {
    if (status != 4)
      return [
        Color(0xFFF5F5F5),
        Color(0xFFEFEEEE),
        Color(0xFFE8E8E8),
      ];
    if (type == 1)
      return [
        Color(0xFFFFDF7D),
        Color(0xFFFFD654),
        Color(0xFFFFC40C),
      ];
    if (type == 2)
      return [
        Color(0xFFFFA446),
        Color(0xFFFFA547),
        Color(0xFFFF8200),
      ];
    if (type == 3)
      return [
        Color(0xFF9ADE79),
        Color(0xFF91DE6B),
        Color(0xFF6ECB41),
      ];
    return [
      Color(0xFFF5F5F5),
      Color(0xFFEFEEEE),
      Color(0xFFE8E8E8),
    ];
  }

  HouseModel({
    this.id,
    this.roomName,
    this.status,
    this.type,
    this.effectiveTimeStart,
    this.effectiveTimeEnd,
    this.estateId,
  });

  HouseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomName = json['roomName'];
    status = json['status'];
    type = json['type'];
    effectiveTimeStart = json['effectiveTimeStart'];
    effectiveTimeEnd = json['effectiveTimeEnd'];
    estateId = json['estateId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomName'] = this.roomName;
    data['status'] = this.status;
    data['effectiveTimeStart'] = this.effectiveTimeStart;
    data['effectiveTimeEnd'] = this.effectiveTimeEnd;
    return data;
  }
}
