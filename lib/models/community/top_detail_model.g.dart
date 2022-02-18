// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopDetailModel _$TopDetailModelFromJson(Map<String, dynamic> json) =>
    TopDetailModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      isPublic: json['isPublic'] as int,
      isRating: json['isRating'] as int,
      dynamicNum: json['dynamicNum'] as int,
      commentNum: json['commentNum'] as int,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
