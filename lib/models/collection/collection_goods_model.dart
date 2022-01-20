import 'package:json_annotation/json_annotation.dart';

part 'collection_goods_model.g.dart';

@JsonSerializable()
class CollectionGoodsModel {
  int id;
  int? goodsPushId;
  String? skuName;
  String? mainPhoto;
  int? status;
  int? shopStatus;
  double? sellPrice;
  double? discountPrice;
  int? kind;
  factory CollectionGoodsModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionGoodsModelFromJson(json);

  CollectionGoodsModel({
    required this.id,
    this.goodsPushId,
    this.skuName,
    this.mainPhoto,
    this.status,
    this.shopStatus,
    this.sellPrice,
    this.discountPrice,
    this.kind,
  });
}
