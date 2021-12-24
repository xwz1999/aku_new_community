// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_pay_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharePayRecordModel _$SharePayRecordModelFromJson(Map<String, dynamic> json) =>
    SharePayRecordModel(
      payPrice: (json['payPrice'] as num).toDouble(),
      paymentTime: json['paymentTime'] as String,
      payType: json['payType'] as int,
      code: json['code'] as String,
      months: json['months'] as String,
      effectiveTimeStart: json['effectiveTimeStart'] as String,
      effectiveTimeEnd: json['effectiveTimeEnd'] as String,
      shareUnitPrice: (json['shareUnitPrice'] as num).toDouble(),
      indoorArea: (json['indoorArea'] as num).toDouble(),
    );
