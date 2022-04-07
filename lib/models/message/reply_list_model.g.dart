// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyListModel _$ReplyListModelFromJson(Map<String, dynamic> json) =>
    ReplyListModel(
      id: json['id'] as int,
      type: json['type'] as int,
      status: json['status'] as int,
      content:  json['content'] !=null? json['content'] as String:'',
      sendId: json['sendId'] as int,
      sendName: json['sendName'] as String,
      sendDate: json['sendDate'] as String,
      avatarImgList: (json['avatarImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dynamicImgList: (json['dynamicImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
        jumpId:json['jumpId'] as int
    );
