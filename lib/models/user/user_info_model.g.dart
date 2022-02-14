// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      id: json['id'] as int,
      communityId: json['communityId'] as int,
      communityCode: json['communityCode'] as String,
      name: json['name'] as String?,
      idCard: json['idCard'] as String?,
      tel: json['tel'] as String,
      sex: json['sex'] as int?,
      nickName: json['nickName'] as String?,
      isExistPassword: json['isExistPassword'] as bool,
      isPointsSignSetting: json['isPointsSignSetting'] as bool,
      isSign: json['isSign'] as bool,
      points: json['points'] as int?,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
