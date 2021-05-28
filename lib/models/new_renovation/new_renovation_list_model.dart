import 'package:equatable/equatable.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_community/base/base_style.dart';

part 'new_renovation_list_model.g.dart';

@JsonSerializable()
class NewRenovationListModel extends Equatable {
  final int id;
  final String roomName;
  final int status;
  final String constructionUnit;
  final String director;
  final String directorTel;
  final String expectedBegin;
  final String expectedEnd;
  final String? actualBegin;
  final String? actualEnd;
  final String? rejectReason;
  final String? reviewerName;
  final String? auditDate;
  final String? trackerName;
  final String? applicationCheckDate;
  final int? isQualified;
  final String createName;
  final String createDate;
  final List<CheckVoList?> checkVoList;
  NewRenovationListModel({
    required this.id,
    required this.roomName,
    required this.status,
    required this.constructionUnit,
    required this.director,
    required this.directorTel,
    required this.expectedBegin,
    required this.expectedEnd,
    this.actualBegin,
    this.actualEnd,
    this.rejectReason,
    this.reviewerName,
    this.auditDate,
    this.trackerName,
    this.applicationCheckDate,
    this.isQualified,
    required this.createName,
    required this.createDate,
    required this.checkVoList,
  });

  @override
  List<Object?> get props {
    return [
      id,
      roomName,
      status,
      constructionUnit,
      director,
      directorTel,
      expectedBegin,
      expectedEnd,
      actualBegin,
      actualEnd,
      rejectReason,
      reviewerName,
      auditDate,
      trackerName,
      applicationCheckDate,
      isQualified,
      createName,
      createDate,
      checkVoList,
    ];
  }

  factory NewRenovationListModel.fromJson(Map<String, dynamic> json) =>
      _$NewRenovationListModelFromJson(json);

  String get statusString {
    switch (this.status) {
      case 1:
        return '申请中';
      case 2:
        return '装修中';
      case 3:
        return '申请驳回';
      // case 4:
      //   return '装修中';
      case 5:
        return '申请完工检查';
      case 6:
        return '完工检查中';
      case 7:
        return '检查通过';
      case 8:
        return '检查不通过';
      default:
        return '未知';
    }
  }

  Color get statusColor {
    switch (this.status) {
      case 1:
        return kPrimaryColor;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      // case 4:
      //   return ktextPrimary;
      case 5:
        return kPrimaryColor;
      case 6:
        return ktextSubColor;

      case 7:
        return Colors.green;
      case 8:
        return Colors.red;
      default:
        return ktextPrimary;
    }
  }

  String get expectBginString =>
      DateUtil.formatDateStr(this.expectedBegin, format: 'yyyy-MM-dd HH:mm');

  String get expectEndString =>
      DateUtil.formatDateStr(this.expectedEnd, format: 'yyyy-MM-dd HH:mm');

  String get actualBginString => DateUtil.formatDateStr(this.actualBegin ?? '',
      format: 'yyyy-MM-dd HH:mm');

  String get actualEndString =>
      DateUtil.formatDateStr(this.actualEnd ?? '', format: 'yyyy-MM-dd HH:mm');
  String get expectSlot =>
      '${expectBginString}-${DateUtil.formatDateStr(this.expectedEnd, format: 'HH:mm')}';
  String get actualSlot =>
      '${actualBginString}-${DateUtil.formatDateStr(this.actualEnd ?? '', format: 'HH:mm')}';

  String get qualitfied {
    switch (this.isQualified) {
      case 1:
        return '合格';
      case 2:
        return '不合格';
      default:
        return '未知';
    }
  }
}

@JsonSerializable()
class CheckVoList extends Equatable {
  final int id;
  final int decorationNewId;
  final String detail;
  final int isQualified;
  final String createName;
  final String createDate;
  CheckVoList({
    required this.id,
    required this.decorationNewId,
    required this.detail,
    required this.isQualified,
    required this.createName,
    required this.createDate,
  });

  @override
  List<Object> get props {
    return [
      id,
      decorationNewId,
      detail,
      isQualified,
      createName,
      createDate,
    ];
  }

  factory CheckVoList.fromJson(Map<String, dynamic> json) =>
      _$CheckVoListFromJson(json);
  String get qualitfied {
    switch (this.isQualified) {
      case 1:
        return '合格';
      case 2:
        return '不合格';
      default:
        return '未知';
    }
  }
}
