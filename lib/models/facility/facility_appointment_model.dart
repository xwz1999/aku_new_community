import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/base/base_style.dart';

part 'facility_appointment_model.g.dart';

@JsonSerializable()
class FacilityAppointmentModel {
  final int id;
  final String code;
  final String address;
  ///预约状态
  ///* 1.未签到(预约时间前30分钟显示扫码签到，之前为取消预约)，
  ///* 2.已签到
  ///* 3.已作废
  ///* 4.已取消
  ///* 5.已结束
  final int status;
  final String reserveStartDate;
  final String reserveEndDate;
  final String? nullifyReason;

  DateTime? get reserveStartDt => DateUtil.getDateTime(reserveStartDate);

  DateTime? get reserveEndDt => DateUtil.getDateTime(reserveEndDate);

  String get displayDate {
    return '${DateUtil.formatDate(
      reserveStartDt,
      format: 'yyyy-MM-dd HH:mm',
    )}-${DateUtil.formatDate(
      reserveEndDt,
      format: 'HH:mm',
    )}';
  }

  Color get statusColor {
    switch (status) {
      case 1:
        return kPrimaryColor;
      case 2:
        return Color(0xFF2576E5);
      case 3:
        return Color(0xFFFB4702);
      case 4:
        return Color(0xFF999999);
      case 5:
        return Color(0xFF999999);
      default:
        return Color(0xFF999999);
    }
  }

  String get statusValue {
    switch (status) {
      case 1:
        return '预约成功';
      case 2:
        return '签到成功';
      case 3:
        return '预约作废';
      case 4:
        return '已取消';
      case 5:
        return '已结束';
      default:
        return '未知状态';
    }
  }

  FacilityAppointmentModel({
    required this.id,
    required this.code,
    required this.status,
    required this.address,
    required this.reserveEndDate,
    required this.reserveStartDate,
    required this.nullifyReason,
  });

  factory FacilityAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityAppointmentModelFromJson(json);
}
