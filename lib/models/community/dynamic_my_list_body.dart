import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/community/all_dynamic_list_model.dart';

part 'dynamic_my_list_body.g.dart';

@JsonSerializable()
class DynamicMyListBody {
  final int id;
  final String? content;
  final int isComment;
  final int isPublic;
  final String createDate;
  final int likes;
  final int views;
  final int commentNum;
  final List<ImgModel> dynamicImgList;
  final List<TopicTag> topicTags;
  final bool isLike;

  factory DynamicMyListBody.fromJson(Map<String, dynamic> json) =>
      _$DynamicMyListBodyFromJson(json);

  DateTime? get createDT => DateUtil.getDateTime(createDate);

  const DynamicMyListBody({
    required this.id,
    this.content,
    required this.isComment,
    required this.isPublic,
    required this.createDate,
    required this.likes,
    required this.views,
    required this.commentNum,
    required this.dynamicImgList,
    required this.topicTags,
    required this.isLike,
  });
}
