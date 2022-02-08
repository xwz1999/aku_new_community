import 'package:aku_new_community/base/base_style.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'facility_appointment_model.g.dart';

@JsonSerializable()
class FacilityAppointmentModel {
  final int id;
  final String code;
  final String facilitiesName;

  ///预约状态
  ///* 1.未签到(预约时间前30分钟显示扫码签到，之前为取消预约)，
  ///* 2.已签到
  ///* 3.已作废
  ///* 4.已取消
  ///* 5.已结束
  final int status;
  final String address;
  final String appointmentStartDate;
  final String appointmentEndDate;
  final String? nullifyReason;
  final String? useEndDate;

  DateTime? get appointmentStart => DateUtil.getDateTime(appointmentStartDate);

  DateTime? get appointmentEnd => DateUtil.getDateTime(appointmentEndDate);

  String get displayDate {
    return '${DateUtil.formatDate(
      appointmentStart,
      format: 'yyyy-MM-dd HH:mm',
    )}-${DateUtil.formatDate(
      appointmentEnd,
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
    required this.facilitiesName,
    required this.status,
    required this.address,
    required this.appointmentStartDate,
    required this.appointmentEndDate,
    required this.nullifyReason,
    required this.useEndDate,
  });

  factory FacilityAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityAppointmentModelFromJson(json);
}
