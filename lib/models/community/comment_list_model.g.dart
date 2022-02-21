// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentListModel _$CommentListModelFromJson(Map<String, dynamic> json) =>
    CommentListModel(
      id: json['id'] as int,
      content: json['content'] as String,
      createId: json['createId'] as int,
      createName: json['createName'] as String,
      createDate: json['createDate'] as String,
      avatarImgList: (json['avatarImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: json['likes'] as int,
      commentNum: json['commentNum'] as int,
      allowDelete: json['allowDelete'] as bool,
      isLike: json['isLike'] as bool,
      commentTwoList: (json['commentTwoList'] as List<dynamic>)
          .map((e) => CommentTwoList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

CommentTwoList _$CommentTwoListFromJson(Map<String, dynamic> json) =>
    CommentTwoList(
      id: json['id'] as int,
      content: json['content'] as String,
      createId: json['createId'] as int,
      createName: json['createName'] as String,
      parentId: json['parentId'] as int,
      parentName: json['parentName'] as String?,
      createDate: json['createDate'] as String,
      avatarImgList: (json['avatarImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: json['likes'] as int,
      allowDelete: json['allowDelete'] as bool,
      isLike: json['isLike'] as bool,
    );
