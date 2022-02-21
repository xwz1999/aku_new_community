// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_my_list_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicMyListBody _$DynamicMyListBodyFromJson(Map<String, dynamic> json) =>
    DynamicMyListBody(
      id: json['id'] as int,
      content: json['content'] as String?,
      isComment: json['isComment'] as int,
      isPublic: json['isPublic'] as int,
      createDate: json['createDate'] as String,
      likes: json['likes'] as int,
      views: json['views'] as int,
      commentNum: json['commentNum'] as int,
      dynamicImgList: (json['dynamicImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topicTags: (json['topicTags'] as List<dynamic>)
          .map((e) => TopicTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLike: json['isLike'] as bool,
    );
