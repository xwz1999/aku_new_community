// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_announce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeAnnounceModel _$HomeAnnounceModelFromJson(Map<String, dynamic> json) =>
    HomeAnnounceModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createDate: json['createDate'] as String,
    );
