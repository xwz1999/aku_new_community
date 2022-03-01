// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announce_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnounceDetailModel _$AnnounceDetailModelFromJson(Map<String, dynamic> json) =>
    AnnounceDetailModel(
      id: json['id'] as int,
      title: json['title'] as String,
      object: json['object'] as int,
      status: json['status'] as int,
      content: json['content'] as String,
      readingVolume: json['readingVolume'] as int,
      downloadNum: json['downloadNum'] as int,
      modifyDate: json['modifyDate'] as String,
      coverImgList: (json['coverImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      annexImgList: (json['annexImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
