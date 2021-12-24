// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrderListModel _$MyOrderListModelFromJson(Map<String, dynamic> json) =>
    MyOrderListModel(
      id: json['id'] as int,
      code: json['code'] as String,
      goodsId: json['goodsId'] as int,
      goodsName: json['goodsName'] as String,
      backType: json['backType'] as int?,
      goodsImgList: (json['goodsImgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      markingPrice: (json['markingPrice'] as num?)?.toDouble(),
      num: json['num'] as int,
      supplierName: json['supplierName'] as String,
      levelOneCategory: json['levelOneCategory'] as String,
      levelTwoCategory: json['levelTwoCategory'] as String,
      status: json['status'] as int,
      sendDate: json['sendDate'] as String?,
      sendDetail: json['sendDetail'] as String?,
      arrivalDate: json['arrivalDate'] as String?,
      receivingDate: json['receivingDate'] as String?,
      backDate: json['backDate'] as String?,
      backReason: json['backReason'] as String?,
      reason: json['reason'] as String?,
      score: json['score'] as int?,
      evaluationDate: json['evaluationDate'] as String?,
      evaluationReason: json['evaluationReason'] as String?,
      createDate: json['createDate'] as String?,
      arrivalTime: json['arrivalTime'] as String,
    );
