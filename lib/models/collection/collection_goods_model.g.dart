// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_goods_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionGoodsModel _$CollectionGoodsModelFromJson(
        Map<String, dynamic> json) =>
    CollectionGoodsModel(
      id: json['id'] as int,
      goodsPushId: json['goodsPushId'] as int?,
      skuName: json['skuName'] as String?,
      mainPhoto: json['mainPhoto'] as String?,
      status: json['status'] as int?,
      shopStatus: json['shopStatus'] as int?,
      sellPrice: (json['sellPrice'] as num?)?.toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      kind: json['kind'] as int?,
    );
