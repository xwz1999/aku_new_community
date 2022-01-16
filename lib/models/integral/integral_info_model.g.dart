// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integral_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntegralInfoModel _$IntegralInfoModelFromJson(Map<String, dynamic> json) =>
    IntegralInfoModel(
      points: json['points'] as int,
      rewardSetting: json['rewardSetting'] as String,
      serialNumber: json['serialNumber'] as int,
      isSign: json['isSign'] as bool,
      signRecordList: (json['signRecordList'] as List<dynamic>)
          .map(
              (e) => ClockedRecordListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
