import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_item_model.g.dart';

@JsonSerializable()
class NewsItemModel {
  final int id;
  final String title;
  final String createDate;
  final List<ImgModel> imgList;

  DateTime? get create => DateUtil.getDateTime(createDate);

  NewsItemModel({
    required this.id,
    required this.title,
    required this.createDate,
    required this.imgList,
  });

  factory NewsItemModel.fromJson(Map<String, dynamic> json) =>
      _$NewsItemModelFromJson(json);
}
