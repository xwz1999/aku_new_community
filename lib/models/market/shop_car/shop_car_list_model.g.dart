// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_car_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopCarListModel _$ShopCarListModelFromJson(Map<String, dynamic> json) =>
    ShopCarListModel(
      id: json['id'] as int?,
      skuName: json['skuName'] as String?,
      mainPhoto: json['mainPhoto'] as String?,
      status: json['status'] as int?,
      shopStatus: json['shopStatus'] as int?,
      sellPrice: (json['sellPrice'] as num?)?.toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      stockStatus: json['stockStatus'] as int?,
      unit: json['unit'] as String?,
      kind: json['kind'] as int?,
      weight: (json['weight'] as num?)?.toDouble(),
      num: json['num'] as int?,
    );
