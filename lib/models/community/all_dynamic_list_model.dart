import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'all_dynamic_list_model.g.dart';

@JsonSerializable()
class AllDynamicListModel {
  final int id;
  final String? content;
  final int isComment;
  final int isPublic;
  final int createId;
  final String createName;
  final String createDate;
  final List<ImgModel>? avatarImgList;
  final int likes;
  final int views;
  final int commentNum;
  final List<ImgModel>? dynamicImgList;
  final bool allowDelete;
  final List<TopicTag> topicTags;
  final bool isLike;

  factory AllDynamicListModel.fromJson(Map<String, dynamic> json) =>
      _$AllDynamicListModelFromJson(json);

  List<ImgModel> get dynamicList => dynamicImgList ?? [];

  const AllDynamicListModel({
    required this.id,
    this.content,
    required this.isComment,
    required this.isPublic,
    required this.createId,
    required this.createName,
    required this.createDate,
    this.avatarImgList,
    required this.likes,
    required this.views,
    required this.commentNum,
    this.dynamicImgList,
    required this.allowDelete,
    required this.topicTags,
    required this.isLike,
  });
}

@JsonSerializable()
class TopicTag {
  final int id;
  final String title;
  final int type;

  factory TopicTag.fromJson(Map<String, dynamic> json) =>
      _$TopicTagFromJson(json);

  const TopicTag({
    required this.id,
    required this.title,
    required this.type,
  });
}
