// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_pay_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LifePayRecordModel _$LifePayRecordModelFromJson(Map<String, dynamic> json) =>
    LifePayRecordModel(
      id: json['id'] as int,
      chargesTemplateDetailName: json['chargesTemplateDetailName'] as String,
      roomName: json['roomName'] as String,
      years: json['years'] as String,
      paidPrice: json['paidPrice'] as num,
      createName: json['createName'] as String,
      createDate: json['createDate'] as String,
      payType: json['payType'] as int,
      code: json['code'] as String,
    );
