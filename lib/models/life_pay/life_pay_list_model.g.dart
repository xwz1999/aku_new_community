// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_pay_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LifePayListModel _$LifePayListModelFromJson(Map<String, dynamic> json) {
  return LifePayListModel(
    years: json['years'] as int,
    paymentNum: json['paymentNum'] as int,
    dailyPaymentTypeVos: (json['dailyPaymentTypeVos'] as List<dynamic>)
        .map((e) => DailyPaymentTypeVos.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LifePayListModelToJson(LifePayListModel instance) =>
    <String, dynamic>{
      'years': instance.years,
      'paymentNum': instance.paymentNum,
      'dailyPaymentTypeVos':
          instance.dailyPaymentTypeVos.map((e) => e.toJson()).toList(),
    };

DailyPaymentTypeVos _$DailyPaymentTypeVosFromJson(Map<String, dynamic> json) {
  return DailyPaymentTypeVos(
    id: json['id'] as int,
    name: json['name'] as String,
    detailedVoList: (json['detailedVoList'] as List<dynamic>)
        .map((e) => DetailedVoList.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DailyPaymentTypeVosToJson(
        DailyPaymentTypeVos instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detailedVoList': instance.detailedVoList.map((e) => e.toJson()).toList(),
    };

DetailedVoList _$DetailedVoListFromJson(Map<String, dynamic> json) {
  return DetailedVoList(
    groupId: json['groupId'] as int,
    paymentPrice: json['paymentPrice'] as num,
    detailsVoList: (json['detailsVoList'] as List<dynamic>)
        .map((e) => DetailsVoList.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DetailedVoListToJson(DetailedVoList instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'paymentPrice': instance.paymentPrice,
      'detailsVoList': instance.detailsVoList.map((e) => e.toJson()).toList(),
    };

DetailsVoList _$DetailsVoListFromJson(Map<String, dynamic> json) {
  return DetailsVoList(
    id: json['id'] as int,
    month: json['month'] as String,
    costPrice: json['costPrice'] as num,
    paidPrice: json['paidPrice'] as num,
    totalPrice: json['totalPrice'] as num,
    beginDate: json['beginDate'] as String,
    endDate: json['endDate'] as String,
    unitPriceType: json['unitPriceType'] as String,
    number: json['num'] as int,
  );
}

Map<String, dynamic> _$DetailsVoListToJson(DetailsVoList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'month': instance.month,
      'costPrice': instance.costPrice,
      'paidPrice': instance.paidPrice,
      'totalPrice': instance.totalPrice,
      'beginDate': instance.beginDate,
      'endDate': instance.endDate,
      'unitPriceType': instance.unitPriceType,
      'num': instance.number,
    };
