// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsDetailModel _$GoodsDetailModelFromJson(Map<String, dynamic> json) {
  return GoodsDetailModel(
    json['id'] as int,
    json['recommend'] as String,
    json['title'] as String,
    (json['sellingPrice'] as num).toDouble(),
    (json['markingPrice'] as num).toDouble(),
    json['categoryName'] as String,
    json['subscribeNum'] as int,
    json['detail'] as String,
    json['arrivalTime'] as String?,
    (json['goodsImgList'] as List<dynamic>)
        .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['supplierId'] as int,
    json['supplierName'] as String,
    json['supplierTel'] as String,
    json['supplierAddress'] as String?,
    (json['supplierImgList'] as List<dynamic>)
        .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['isSubscribe'] as int,
  );
}
