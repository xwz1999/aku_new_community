// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    id: json['id'] as int,
    imgUrls: (json['imgUrls'] as List<dynamic>)
        .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    name: json['name'] as String,
    nickName: json['nickName'] as String,
    tel: json['tel'] as String,
    sex: json['sex'] as int?,
    birthday: json['birthday'] as String,
  );
}
