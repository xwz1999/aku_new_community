// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_pay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LifePayModel _$LifePayModelFromJson(Map<String, dynamic> json) => LifePayModel(
      id: json['id'] as int,
      chargesName: json['chargesName'] as String,
      billDateStart: json['billDateStart'] as String,
      billDateEnd: json['billDateEnd'] as String,
      createDate: json['createDate'] as String,
      payPrincipal: (json['payPrincipal'] as num).toDouble(),
      defaultAmount: (json['defaultAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$LifePayModelToJson(LifePayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chargesName': instance.chargesName,
      'billDateStart': instance.billDateStart,
      'billDateEnd': instance.billDateEnd,
      'createDate': instance.createDate,
      'payPrincipal': instance.payPrincipal,
      'defaultAmount': instance.defaultAmount,
    };
