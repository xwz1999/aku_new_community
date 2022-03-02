// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbs_up_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbsUpListModel _$ThumbsUpListModelFromJson(Map<String, dynamic> json) =>
    ThumbsUpListModel(
      id: json['id'] as int,
      status: json['status'] as int,
      sendId: json['sendId'] as int,
      sendName: json['sendName'] as String,
      sendDate: json['sendDate'] as String,
      avatarImgList: (json['avatarImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dynamicImgList: (json['dynamicImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
