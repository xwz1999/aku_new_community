import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/ui/market/shop_car/shop_car_func.dart';

part 'good_detail_model.g.dart';

@JsonSerializable()
class GoodDetailModel {
  final int id;
  final List<JcookImageVoList>? jcookImageVoList;
  final num sellPrice;
  final num discountPrice;
  final String? skuName;
  final int status;
  final int shopStatus;
  final int? sellNum;
  final int? kind;
  final String defaultLocation;
  final String defaultAddressDetail;
  final int stockStatus;
  final List<JcookSpecificationVoList> jcookSpecificationVoList;
  final int isCollection;
  final String unit;
  final num weight;

  factory GoodDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GoodDetailModelFromJson(json);

  GoodStatus get goodStatus => ShopCarFunc.getGoodsStatus(status, shopStatus);

  static GoodDetailModel fail() => GoodDetailModel(
      id: 0,
      jcookImageVoList: [],
      sellPrice: 0,
      discountPrice: 0,
      skuName: '',
      status: 0,
      shopStatus: 0,
      sellNum: 0,
      kind: 0,
      defaultLocation: '',
      defaultAddressDetail: '',
      stockStatus: 0,
      jcookSpecificationVoList: [],
      isCollection: 0,
      unit: '',
      weight: 0);

  const GoodDetailModel({
    required this.id,
    required this.jcookImageVoList,
    required this.sellPrice,
    required this.discountPrice,
    required this.skuName,
    required this.status,
    required this.shopStatus,
    required this.sellNum,
    required this.kind,
    required this.defaultLocation,
    required this.defaultAddressDetail,
    required this.stockStatus,
    required this.jcookSpecificationVoList,
    required this.isCollection,
    required this.unit,
    required this.weight,
  });
}

@JsonSerializable()
class JcookImageVoList {
  final int id;
  final int jcookGoodsId;
  final String url;
  final int isPrimer;
  final int orderSort;

  factory JcookImageVoList.fromJson(Map<String, dynamic> json) =>
      _$JcookImageVoListFromJson(json);

  const JcookImageVoList({
    required this.id,
    required this.jcookGoodsId,
    required this.url,
    required this.isPrimer,
    required this.orderSort,
  });
}

@JsonSerializable()
class JcookSpecificationVoList {
  final String groupName;
  final List<Attribute> attribute;

  factory JcookSpecificationVoList.fromJson(Map<String, dynamic> json) =>
      _$JcookSpecificationVoListFromJson(json);

  const JcookSpecificationVoList({
    required this.groupName,
    required this.attribute,
  });
}

@JsonSerializable()
class Attribute {
  final String? name;
  final String? value;

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  const Attribute({
    required this.name,
    required this.value,
  });
}
