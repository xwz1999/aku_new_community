// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_all_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketAllCategoryModel _$MarketAllCategoryModelFromJson(
        Map<String, dynamic> json) =>
    MarketAllCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      imgUrls: (json['imgUrls'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryList: (json['categoryList'] as List<dynamic>)
          .map(
              (e) => MarketAllCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
