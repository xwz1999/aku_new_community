// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_my_list_head.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicMyListHead _$DynamicMyListHeadFromJson(Map<String, dynamic> json) =>
    DynamicMyListHead(
      id: json['id'] as int,
      createName: json['createName'] as String,
      avatarImgList: (json['avatarImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dynamicNum: json['dynamicNum'] as int,
      commentNum: json['commentNum'] as int,
      likesNum: json['likesNum'] as int,
    );
