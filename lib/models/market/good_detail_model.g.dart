// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodDetailModel _$GoodDetailModelFromJson(Map<String, dynamic> json) =>
    GoodDetailModel(
      id: json['id'] as int,
      jcookImageVoList: (json['jcookImageVoList'] as List<dynamic>?)
          ?.map((e) => JcookImageVoList.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellPrice: json['sellPrice'] as num,
      discountPrice: json['discountPrice'] as num,
      skuName: json['skuName'] as String?,
      status: json['status'] as int,
      shopStatus: json['shopStatus'] as int,
      sellNum: json['sellNum'] as int?,
      kind: json['kind'] as int?,
      defaultLocation: json['defaultLocation'] as String,
      defaultAddressDetail: json['defaultAddressDetail'] as String,
      stockStatus: json['stockStatus'] as int,
      jcookSpecificationVoList:
          (json['jcookSpecificationVoList'] as List<dynamic>)
              .map((e) =>
                  JcookSpecificationVoList.fromJson(e as Map<String, dynamic>))
              .toList(),
      isCollection: json['isCollection'] as int,
      unit: json['unit'] as String,
      weight: json['weight'] as num,
    );

JcookImageVoList _$JcookImageVoListFromJson(Map<String, dynamic> json) =>
    JcookImageVoList(
      id: json['id'] as int,
      jcookGoodsId: json['jcookGoodsId'] as int,
      url: json['url'] as String,
      isPrimer: json['isPrimer'] as int,
      orderSort: json['orderSort'] as int,
    );

JcookSpecificationVoList _$JcookSpecificationVoListFromJson(
        Map<String, dynamic> json) =>
    JcookSpecificationVoList(
      groupName: json['groupName'] as String,
      attribute: (json['attribute'] as List<dynamic>)
          .map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );
