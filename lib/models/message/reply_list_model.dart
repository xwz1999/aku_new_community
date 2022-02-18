import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'reply_list_model.g.dart';

@JsonSerializable()
class ReplyListModel {
  final int id;
  final int status;
  final String content;
  final int sendId;
  final String sendName;
  final String sendDate;
  final List<ImgModel> avatarImgList;
  final List<ImgModel> dynamicImgList;

  factory ReplyListModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyListModelFromJson(json);

  String get avatar =>
      avatarImgList.isEmpty ? '' : avatarImgList.first.url ?? '';
  String get pic =>
      dynamicImgList.isEmpty ? '' : dynamicImgList.first.url ?? '';

  const ReplyListModel({
    required this.id,
    required this.status,
    required this.content,
    required this.sendId,
    required this.sendName,
    required this.sendDate,
    required this.avatarImgList,
    required this.dynamicImgList,
  });
}
