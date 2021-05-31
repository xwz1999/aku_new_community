import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'passed_house_list_model.g.dart';

@JsonSerializable()
class PassedHouseListModel extends Equatable {
  final int id;
  final int estateId;
  final String roomName;
  final int type;
  final String? effectiveTimeStart;
  final String? effectiveTimeEnd;
  PassedHouseListModel({
    required this.id,
    required this.estateId,
    required this.roomName,
    required this.type,
    this.effectiveTimeStart,
    this.effectiveTimeEnd,
  });

  @override
  List<Object?> get props {
    return [
      id,
      estateId,
      roomName,
      type,
      effectiveTimeStart,
      effectiveTimeEnd,
    ];
  }

  factory PassedHouseListModel.fromJson(Map<String, dynamic> json) =>
      _$PassedHouseListModelFromJson(json);

      String get houseStatus {
    if (type == 1) return '业主';
    if (type == 2) return '亲属';
    if (type == 3) return '租客';
    return '';
  }
  Color get houseStatusColor {
    // if (status != 4) return Color(0xFF666666);
    if (type == 1) return Color(0xFF333333);
    return Colors.white;
  }

  ///我的房屋页面背景颜色
  ///
  List<Color> get backgroundColor {
    //TODO 未通过状态
    // if (status != 4)
    //   return [
    //     Color(0xFFF5F5F5),
    //     Color(0xFFEFEEEE),
    //     Color(0xFFE8E8E8),
    //   ];
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
}
