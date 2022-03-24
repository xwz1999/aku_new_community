import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_activity_model.g.dart';

@JsonSerializable()
class HomeActivityModel extends Equatable {
  final int id;
  final String title;
  final int status;
  final String registrationStartTime;
  final String registrationEndTime;
  final String activityStartTime;
  final String activityEndTime;
  final List<ImgModel>? imgList;
  final int? registrationNum;
  final List<ImgModel>? avatarImgList;

  factory HomeActivityModel.fromJson(Map<String, dynamic> json) =>
      _$HomeActivityModelFromJson(json);

  DateTime? get begin => DateUtil.getDateTime(registrationStartTime);

  DateTime? get end => DateUtil.getDateTime(registrationEndTime);

  String get statusString {
    switch (this.status) {
      case 1:
        return '未开始';
      case 2:
        return '进行中';
      case 3:
        return '已结束';
      case 4:
        return '已投票';
      default:
        return '未知';
    }
  }

  Color get statusColor {
    switch (this.status) {
      case 1:
        return kPrimaryColor;
      case 2:
        return Colors.black;
      case 3:
        return ktextSubColor;
      case 4:
        return ktextSubColor;
      default:
        return Colors.red;
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        status,
        registrationStartTime,
        registrationEndTime,
        activityStartTime,
        activityEndTime,
        imgList,
        registrationNum,
        avatarImgList,
      ];

  const HomeActivityModel({
    required this.id,
    required this.title,
    required this.status,
    required this.registrationStartTime,
    required this.registrationEndTime,
    required this.activityStartTime,
    required this.activityEndTime,
    this.imgList,
    required this.registrationNum,
    this.avatarImgList,
  });
}
