// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsItemModel _$NewsItemModelFromJson(Map<String, dynamic> json) =>
    NewsItemModel(
      id: json['id'] as int,
      title: json['title'] as String,
      createDate: json['createDate'] as String,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
