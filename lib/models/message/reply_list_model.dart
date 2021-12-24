import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reply_list_model.g.dart';

@JsonSerializable()
class ReplyListModel {
  final int id;
  final String name;
  final String date;
  final String content;
  final ImgModel img;
  final String title;
  final ImgModel pic;
  factory ReplyListModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyListModelFromJson(json);

  const ReplyListModel({
    required this.id,
    required this.name,
    required this.date,
    required this.content,
    required this.img,
    required this.title,
    required this.pic,
  });
}
