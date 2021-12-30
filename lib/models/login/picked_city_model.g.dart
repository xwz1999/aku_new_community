// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picked_city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickedCityModel _$PickedCityModelFromJson(Map<String, dynamic> json) =>
    PickedCityModel(
      province:
          ChinaRegionModel.fromJson(json['province'] as Map<String, dynamic>),
      city: ChinaRegionModel.fromJson(json['city'] as Map<String, dynamic>),
      district:
          ChinaRegionModel.fromJson(json['district'] as Map<String, dynamic>),
    );
