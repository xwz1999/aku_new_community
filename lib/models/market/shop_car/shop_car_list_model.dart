import 'package:aku_community/ui/market/shop_car/shop_car_func.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop_car_list_model.g.dart';

@JsonSerializable()
class ShopCarListModel {
  final int id;
  final String skuName;
  final String mainPhoto;
  //0.下架，1.上架(当该状态下架，商品直接下架，不考虑小蜜蜂商品状态)
  final int status;
  //0.下架，1.上架（当jcook商品状态为上架才生效）
  final int shopStatus;
  final double sellPrice;
  final double discountPrice;
  final String unit;
  // 0=未知 1=自营 2=其 他,商品类别
  final int kind;
  final double weight;
  final int num;
  factory ShopCarListModel.fromJson(Map<String, dynamic> json) =>
      _$ShopCarListModelFromJson(json);
  GoodStatus get goodStatus => ShopCarFunc.getGoodsStatus(status, shopStatus);
  const ShopCarListModel({
    required this.id,
    required this.skuName,
    required this.mainPhoto,
    required this.status,
    required this.shopStatus,
    required this.sellPrice,
    required this.discountPrice,
    required this.unit,
    required this.kind,
    required this.weight,
    required this.num,
  });
}
