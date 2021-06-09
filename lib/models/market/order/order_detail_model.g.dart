// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) {
  return OrderDetailModel(
    id: json['id'] as int,
    code: json['code'] as String,
    goodsId: json['goodsId'] as int,
    goodsName: json['goodsName'] as String,
    backType: json['backType'] as int?,
    goodsImgList: (json['goodsImgList'] as List<dynamic>)
        .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    sellingPrice: json['sellingPrice'] as num?,
    markingPrice: json['markingPrice'] as num?,
    count: json['num'] as int,
    supplierId: json['supplierId'] as int?,
    supplierName: json['supplierName'] as String?,
    levelOneCategory: json['levelOneCategory'] as String?,
    levelTwoCategory: json['levelTwoCategory'] as String?,
    status: json['status'] as int?,
    sendDate: json['sendDate'] as String?,
    sendDetail: json['sendDetail'] as String?,
    arrivalDate: json['arrivalDate'] as String?,
    receivingDate: json['receivingDate'] as String?,
    backDate: json['backDate'] as String?,
    backReason: json['backReason'] as String?,
    score: json['score'] as String?,
    evaluationDate: json['evaluationDate'] as String?,
    evaluationReason: json['evaluationReason'] as String?,
    arrivalTime: json['arrivalTime'] as String?,
    createDate: json['createDate'] as String?,
  );
}
