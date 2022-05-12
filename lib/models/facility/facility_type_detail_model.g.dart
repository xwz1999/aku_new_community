// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_type_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityTypeDetailModel _$FacilityTypeDetailModelFromJson(
        Map<String, dynamic> json) =>
    FacilityTypeDetailModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      openStartDate: json['openStartDate'] as String,
      openEndDate: json['openEndDate'] as String,
      imgList: (json['imgList'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
