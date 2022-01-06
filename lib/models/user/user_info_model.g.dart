// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      id: json['id'] as int,
      communityId: json['communityId'] as int,
      name: json['name'] as String?,
      tel: json['tel'] as String,
      imgUrls: (json['imgUrls'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sex: json['sex'] as int?,
      nickName: json['nickName'] as String?,
      isExistPassword: json['isExistPassword'] as bool,
    );
