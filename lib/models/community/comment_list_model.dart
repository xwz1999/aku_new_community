import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_list_model.g.dart';

@JsonSerializable()
class CommentListModel {
  final int id;
  final String content;
  final int createId;
  final String createName;
  final String createDate;
  final List<ImgModel> avatarImgList;
  final int likes;
  final int commentNum;
  final bool allowDelete;
  final bool isLike;
  final List<CommentTwoList> commentTwoList;
  factory CommentListModel.fromJson(Map<String, dynamic> json) =>
      _$CommentListModelFromJson(json);

  const CommentListModel({
    required this.id,
    required this.content,
    required this.createId,
    required this.createName,
    required this.createDate,
    required this.avatarImgList,
    required this.likes,
    required this.commentNum,
    required this.allowDelete,
    required this.isLike,
    required this.commentTwoList,
  });
}

@JsonSerializable()
class CommentTwoList {
  final int id;
  final String content;
  final int createId;
  final String createName;
  final int parentId;
  final String? parentName;
  final String createDate;
  final List<ImgModel> avatarImgList;
  final int likes;
  final bool allowDelete;
  final bool isLike;
  factory CommentTwoList.fromJson(Map<String, dynamic> json) =>
      _$CommentTwoListFromJson(json);
  const CommentTwoList({
    required this.id,
    required this.content,
    required this.createId,
    required this.createName,
    required this.parentId,
    required this.parentName,
    required this.createDate,
    required this.avatarImgList,
    required this.likes,
    required this.allowDelete,
    required this.isLike,
  });
}
