import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class HouseModel {
  int id;
  String roomName;
  int status;
  int type;
  String effectiveTimeStart;
  String effectiveTimeEnd;

  DateTime get effectiveStartDate => DateUtil.getDateTime(effectiveTimeStart);
  DateTime get effectiveEndDate => DateUtil.getDateTime(effectiveTimeEnd);
  String get typeValue {
    switch (type) {
      case 1:
        return '业主';
      case 2:
        return '租客';
      case 3:
        return '情书';
    }
    return '';
  }

  ///我的房屋页面背景颜色
  ///
  List<Color> get backgroundColor {
    //TODO 未通过状态
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
  });

  HouseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomName = json['roomName'];
    status = json['status'];
    type = json['type'];
    effectiveTimeStart = json['effectiveTimeStart'];
    effectiveTimeEnd = json['effectiveTimeEnd'];
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
