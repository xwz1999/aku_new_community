// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationDetailModel _$InformationDetailModelFromJson(
        Map<String, dynamic> json) =>
    InformationDetailModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      viewsNum: json['viewsNum'] as int,
      createDate: json['createDate'] as String,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
