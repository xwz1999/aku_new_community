// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsItem _$GoodsItemFromJson(Map<String, dynamic> json) {
  return GoodsItem(
    id: json['id'] as int,
    title: json['title'] as String,
    recommend: json['recommend'] as String,
    sellingPrice: json['sellingPrice'] as num,
    markingPrice: json['markingPrice'] as num,
    subscribeNum: json['subscribeNum'] as int,
    imgList: (json['imgList'] as List<dynamic>)
        .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
