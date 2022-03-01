// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_swiper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeSwiperModel _$HomeSwiperModelFromJson(Map<String, dynamic> json) =>
    HomeSwiperModel(
      id: json['id'] as int,
      type: json['type'] as int,
      customizeUrl: json['customizeUrl'] as String?,
      associationId: json['associationId'] as int?,
      imgList: (json['imgList'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
