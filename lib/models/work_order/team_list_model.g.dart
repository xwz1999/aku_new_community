// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamListModel _$TeamListModelFromJson(Map<String, dynamic> json) =>
    TeamListModel(
      id: json['id'] as int,
      userType: json['userType'] as int,
      manageUserId: json['manageUserId'] as int,
      manageUserName: json['manageUserName'] as String,
      manageUserTel: json['manageUserTel'] as String,
      departmentId: json['departmentId'] as int,
      departmentName: json['departmentName'] as String,
      positionId: json['positionId'] as int,
      positionName: json['positionName'] as String,
    );
