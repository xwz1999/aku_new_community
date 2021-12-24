// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityTypeModel _$FacilityTypeModelFromJson(Map<String, dynamic> json) =>
    FacilityTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      openStartDate: json['openStartDate'] as String,
      openEndDate: json['openEndDate'] as String,
      num_: json['num'] as int,
      imgUrls: (json['imgUrls'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
