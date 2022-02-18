import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/community/all_dynamic_list_model.dart';

part 'dynamic_detail_model.g.dart';

@JsonSerializable()
class DynamicDetailModel {
  final int id;
  final String? content;
  final int isComment;
  final int isPublic;
  final int createId;
  final String createName;
  final String createDate;
  final List<ImgModel> avatarImgList;
  final int likes;
  final int views;
  final int commentNum;
  final List<ImgModel> dynamicImgList;
  final bool allowDelete;
  final List<TopicTag> topicTags;
  final bool isLike;
  factory DynamicDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicDetailModelFromJson(json);

  const DynamicDetailModel({
    required this.id,
    this.content,
    required this.isComment,
    required this.isPublic,
    required this.createId,
    required this.createName,
    required this.createDate,
    required this.avatarImgList,
    required this.likes,
    required this.views,
    required this.commentNum,
    required this.dynamicImgList,
    required this.allowDelete,
    required this.topicTags,
    required this.isLike,
  });
}
