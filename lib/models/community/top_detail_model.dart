import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'top_detail_model.g.dart';

@JsonSerializable()
class TopDetailModel {
  final int id;
  final String title;
  final String content;
  final int isPublic;
  final int isRating;
  final int dynamicNum;
  final int commentNum;
  final List<ImgModel> imgList;
  factory TopDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TopDetailModelFromJson(json);

  const TopDetailModel({
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
