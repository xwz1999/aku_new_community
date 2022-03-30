// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_pay_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LifePayRecordModel _$LifePayRecordModelFromJson(Map<String, dynamic> json) =>
    LifePayRecordModel(
      id: json['id'] as int,
      chargesName: json['chargesName'] as String,
      communityName: json['communityName'] as String,
      buildingName: json['buildingName'] as String,
      unitName: json['unitName'] as String,
      estateName: json['estateName'] as String,
      billDateStart: json['billDateStart'] as String,
      billDateEnd: json['billDateEnd'] as String,
      billCreateDate: json['billCreateDate'] as String,
      payAmount: json['payAmount'] as num,
      createDate: json['createDate'] as String,
      payType: json['payType'] as int,
      code: json['code'] as String,
    );
