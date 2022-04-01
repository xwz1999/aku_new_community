// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketCategoryModel _$MarketCategoryModelFromJson(Map<String, dynamic> json) =>
    MarketCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      imgUrls: (json['imgUrls'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
