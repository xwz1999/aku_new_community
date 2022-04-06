// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityDetailModel _$ActivityDetailModelFromJson(Map<String, dynamic> json) =>
    ActivityDetailModel(
      id: json['id'] as int,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      status: json['status'] as int,
      registrationStartTime: json['registrationStartTime'] as String,
      registrationEndTime: json['registrationEndTime'] as String,
      activityStartTime: json['activityStartTime'] as String,
      activityEndTime: json['activityEndTime'] as String,
      activityAddress: json['activityAddress'] as String,
      registrationList: (json['registrationList'] as List<dynamic>)
          .map((e) => Registration.fromJson(e as Map<String, dynamic>))
          .toList(),
      registrationNum: json['registrationNum'] as int,
      registrationNumMax: json['registrationNumMax'] as int,
      registrationCost: (json['registrationCost'] as num).toDouble(),
      activityContact: json['activityContact'] as String,
      activityTel: json['activityTel'] as String,
      content: json['content'] as String,
      unit: json['unit'] as String,
      contact: json['contact'] as String,
      tel: json['tel'] as String,
      organizerImgList: (json['organizerImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
        isRegistration:json['isRegistration'] as int
    );

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
      id: json['id'] as int,
      name: json['name'] as String,
      avatarImgList: (json['avatarImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
