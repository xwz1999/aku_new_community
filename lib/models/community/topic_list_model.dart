import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'topic_list_model.g.dart';

@JsonSerializable()
class TopicListModel {
  final int id;
  final String title;
  final String content;
  final int isPublic;
  final int isRating;
  final int dynamicNum;
  final int commentNum;
  final List<ImgModel> imgList;
  factory TopicListModel.fromJson(Map<String, dynamic> json) =>
      _$TopicListModelFromJson(json);
  const TopicListModel({
    required this.id,
    required this.title,
    required this.content,
    required this.isPublic,
    required this.isRating,
    required this.dynamicNum,
    required this.commentNum,
    required this.imgList,
  });
}
