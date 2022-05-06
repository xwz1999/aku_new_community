// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_family_member_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyFamilyMemberListModel _$MyFamilyMemberListModelFromJson(
        Map<String, dynamic> json) =>
    MyFamilyMemberListModel(
      estateId: json['estateId'] as int,
      estateName: json['estateName'] as String,
      unitName: json['unitName'] as String,
      buildingName: json['buildingName'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      estateTypeName: json['estateTypeName'] as String,
    );

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: json['id'] as int,
      name: json['name'] as String,
      identity: json['identity'] as int,
      avatarImgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
