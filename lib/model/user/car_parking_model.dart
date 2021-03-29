import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarParkingModel {
  String code;
  int type;
  int status;
  String effectiveTimeEnd;
  String get typeName {
    switch (type) {
      case 1:
        return '产权车位';
      case 2:
        return '临时车位';
      default:
        return '未知';
    }
  }

  String get carTypeName {
    switch (status) {
      case 1:
        return '产权车位';
      case 2:
        return '包年';
      case 3:
        return '包月';
      case 4:
        return '临时';
      default:
        return '未知';
    }
  }

  String get dateName {
    if (effectiveTimeEnd == null) return '永久';
    if (outdated) return '$effectiveDateValue(已过期)';
    return effectiveDateValue;
  }

  DateTime get effectiveDate {
    if (effectiveTimeEnd == null) return null;
    return DateUtil.getDateTime(effectiveTimeEnd);
  }

  String get effectiveDateValue =>
      DateUtil.formatDate(effectiveDate, format: 'yyyy-MM-dd');

  bool get outdated {
    if (effectiveDate == null) return false;
    DateTime now = DateTime.now();
    return effectiveDate.isAfter(now);
  }

  List<BoxShadow> get shadow {
    if (!outdated)
      return [
        BoxShadow(
          offset: Offset(0, 10.w),
          blurRadius: 30.w,
          color: Color(0xFFFFF0BF),
        )
      ];
    return [
      BoxShadow(
        offset: Offset(0, 10.w),
        blurRadius: 30.w,
        color: Color(0xFFF0F0F0),
      )
    ];
  }

  CarParkingModel({this.code, this.type, this.effectiveTimeEnd});

  CarParkingModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
    effectiveTimeEnd = json['effectiveTimeEnd'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['type'] = this.type;
    data['effectiveTimeEnd'] = this.effectiveTimeEnd;
    return data;
  }
}
