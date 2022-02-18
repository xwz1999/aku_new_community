// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicDetailModel _$DynamicDetailModelFromJson(Map<String, dynamic> json) =>
    DynamicDetailModel(
      id: json['id'] as int,
      content: json['content'] as String?,
      isComment: json['isComment'] as int,
      isPublic: json['isPublic'] as int,
      createId: json['createId'] as int,
      createName: json['createName'] as String,
      createDate: json['createDate'] as String,
      avatarImgList: (json['avatarImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: json['likes'] as int,
      views: json['views'] as int,
      commentNum: json['commentNum'] as int,
      dynamicImgList: (json['dynamicImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowDelete: json['allowDelete'] as bool,
      topicTags: (json['topicTags'] as List<dynamic>)
          .map((e) => TopicTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLike: json['isLike'] as bool,
    );
