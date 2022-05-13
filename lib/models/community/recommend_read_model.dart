import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'recommend_read_model.g.dart';

@JsonSerializable()
class RecommendReadModel {
  final int id;
  final String title;
  final String content;
  final int viewsNum;
  final String createDate;
  final List<ImgModel> imgList;
  factory RecommendReadModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendReadModelFromJson(json);
  DateTime? get createDateDT => DateUtil.getDateTime(createDate);
  const RecommendReadModel({
    required this.id,
    required this.title,
    required this.content,
    required this.viewsNum,
    required this.createDate,
    required this.imgList,
  });
}
