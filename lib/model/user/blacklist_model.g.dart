// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blacklist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlacklistModel _$BlacklistModelFromJson(Map<String, dynamic> json) =>
    BlacklistModel(
      id: json['id'] as int,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      nickName: json['nickName'] as String,
    );
