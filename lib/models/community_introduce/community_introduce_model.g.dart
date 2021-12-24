// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_introduce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityIontroduceModel _$CommunityIontroduceModelFromJson(
        Map<String, dynamic> json) =>
    CommunityIontroduceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      content: json['content'] as String,
      createDate: json['createDate'] as String,
      imgList: (json['imgList'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
