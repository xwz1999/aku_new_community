import 'package:flutter/material.dart';

class RenovationMap {
  static String getTagName(int operationStatus, int status, {int? tracker}) {
    switch (operationStatus) {
      case 0:
          return '待指派';
        
      case 1:
          return '待执行';
        
      case 2:
          return '已完成';
        
      default:
        return '已完成';
    }
  }

  static Color getTagColor(int operationStatus) {
    switch (operationStatus) {
      case 1:
      case 2:
        return Color(0xFFFF4501);
      case 3:
        return Color(0xFF32B814);
      default:
        return Color(0xFFFF4501);
    }
  }

  Map<int, String> stautsToString = {
    -1: '申请中',
    -2: '申请未通过',
    -3: '申请通过',
    0:'待处理',
    1: '已付押金',
    2: '装修中',
    3: '完工检查申请中',
    4: '完工检查不通过',
    5: '完工检查通过',
    6: '申请退款中',
    7: '装修结束',
    8: '已作废',
  };

  String getDecorationStatus(int status) {
    return stautsToString[status]!;
  }
}
