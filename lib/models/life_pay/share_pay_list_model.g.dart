// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_pay_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharePayListModel _$SharePayListModelFromJson(Map<String, dynamic> json) =>
    SharePayListModel(
      id: json['id'] as int,
      months: json['months'] as String,
      type: json['type'] as int,
      num: json['num'] as int,
      total: (json['total'] as num).toDouble(),
      appMeterShareDetailsVos:
          (json['appMeterShareDetailsVos'] as List<dynamic>)
              .map((e) =>
                  AppMeterShareDetailsVos.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SharePayListModelToJson(SharePayListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'months': instance.months,
      'type': instance.type,
      'num': instance.num,
      'total': instance.total,
      'appMeterShareDetailsVos': instance.appMeterShareDetailsVos,
    };

AppMeterShareDetailsVos _$AppMeterShareDetailsVosFromJson(
        Map<String, dynamic> json) =>
    AppMeterShareDetailsVos(
      id: json['id'] as int,
      houseArea: (json['houseArea'] as num).toDouble(),
      amountPayable: (json['amountPayable'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num).toDouble(),
      remainingUnpaidAmount: (json['remainingUnpaidAmount'] as num).toDouble(),
      status: json['status'] as int,
      rate: (json['rate'] as num).toDouble(),
      paymentPeriod: json['paymentPeriod'] as String,
      paymentTime: json['paymentTime'] as String?,
      lateFree: (json['lateFree'] as num).toDouble(),
    );

Map<String, dynamic> _$AppMeterShareDetailsVosToJson(
        AppMeterShareDetailsVos instance) =>
    <String, dynamic>{
      'id': instance.id,
      'houseArea': instance.houseArea,
      'amountPayable': instance.amountPayable,
      'paidAmount': instance.paidAmount,
      'remainingUnpaidAmount': instance.remainingUnpaidAmount,
      'status': instance.status,
      'rate': instance.rate,
      'paymentPeriod': instance.paymentPeriod,
      'paymentTime': instance.paymentTime,
      'lateFree': instance.lateFree,
    };
