// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_record_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeRecordListModel _$TradeRecordListModelFromJson(
        Map<String, dynamic> json) =>
    TradeRecordListModel(
      id: json['id'] as int,
      type: json['type'] as int,
      content: json['content'] as String,
      payAmount: (json['payAmount'] as num).toDouble(),
      createName: json['createName'] as String,
      createDate: json['createDate'] as String,
    );
