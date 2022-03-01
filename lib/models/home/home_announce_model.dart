import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_announce_model.g.dart';

@JsonSerializable()
class HomeAnnounceModel {
  final int id;
  final String title;
  final String content;
  final List<ImgModel> imgList;
  final String createDate;
  factory HomeAnnounceModel.fromJson(Map<String, dynamic> json) =>
      _$HomeAnnounceModelFromJson(json);
  DateTime? get createDateString => DateUtil.getDateTime(createDate);
  const HomeAnnounceModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imgList,
    required this.createDate,
  });
}
