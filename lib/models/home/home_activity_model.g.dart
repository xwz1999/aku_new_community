// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeActivityModel _$HomeActivityModelFromJson(Map<String, dynamic> json) =>
    HomeActivityModel(
      id: json['id'] as int,
      title: json['title'] as String,
      status: json['status'] as int,
      registrationStartTime: json['registrationStartTime'] as String,
      registrationEndTime: json['registrationEndTime'] as String,
      activityStartTime: json['activityStartTime'] as String,
      activityEndTime: json['activityEndTime'] as String,
      imgList: (json['imgList'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      registrationNum: json['registrationNum'] as int?,
      avatarImgList: (json['avatarImgList'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
