// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityTypeModel _$FacilityTypeModelFromJson(Map<String, dynamic> json) =>
    FacilityTypeModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      type: json['type'] as int,
      num_: json['num'] as int,
      imgUrls: (json['imgUrls'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
