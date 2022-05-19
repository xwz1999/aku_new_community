// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bracelet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BraceletModel _$BraceletModelFromJson(Map<String, dynamic> json) =>
    BraceletModel(
      sbp: json['sbp'] as int,
      todaySteps: json['todaySteps'] as int,
      bloodOxygen: json['bloodOxygen'] as int,
      switchType: json['switchType'] as int,
      dbp: json['dbp'] as int,
      heartRate: json['heartRate'] as int,
      remainingPower: json['remainingPower'] as int?,
      detectionDays: json['detectionDays'] as int,
      alarmNums: json['alarmNums'] as int,
      fallNums: json['fallNums'] as int,
    );
