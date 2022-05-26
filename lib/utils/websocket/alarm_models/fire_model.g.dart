// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fire_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FireModel _$FireModelFromJson(Map<String, dynamic> json) => FireModel(
      model: json['model'] as String,
      communityCode: json['communityCode'] as String,
      type: json['type'] as int,
      fireAlarm: json['fireAlarm'] == null
          ? null
          : FireAlarm.fromJson(json['fireAlarm'] as Map<String, dynamic>),
      deviceAlarm: json['deviceAlarm'] == null
          ? null
          : DeviceAlarm.fromJson(json['deviceAlarm'] as Map<String, dynamic>),
      oneButtonAlarm: json['oneButtonAlarm'] == null
          ? null
          : OneButtonAlarm.fromJson(
              json['oneButtonAlarm'] as Map<String, dynamic>),
      clientAlarm: json['clientAlarm'] == null
          ? null
          : ClientAlarm.fromJson(json['clientAlarm'] as Map<String, dynamic>),
      elderlyCareEquipmentReminder: json['elderlyCareEquipmentReminder'] == null
          ? null
          : ElderlyCareEquipmentReminder.fromJson(
              json['elderlyCareEquipmentReminder'] as Map<String, dynamic>),
    );

FireAlarm _$FireAlarmFromJson(Map<String, dynamic> json) => FireAlarm(
      time: json['time'] as String,
      deviceName: json['deviceName'] as String,
    );

DeviceAlarm _$DeviceAlarmFromJson(Map<String, dynamic> json) => DeviceAlarm(
      time: json['time'] as String,
      deviceName: json['deviceName'] as String,
    );

OneButtonAlarm _$OneButtonAlarmFromJson(Map<String, dynamic> json) =>
    OneButtonAlarm(
      time: json['time'] as String,
      roomName: json['roomName'] as String,
      name: json['name'] as String,
      tel: json['tel'] as String,
    );

ClientAlarm _$ClientAlarmFromJson(Map<String, dynamic> json) => ClientAlarm(
      time: json['time'] as String,
      content: json['content'] as String,
    );

ElderlyCareEquipmentReminder _$ElderlyCareEquipmentReminderFromJson(
        Map<String, dynamic> json) =>
    ElderlyCareEquipmentReminder(
      deviceNo: json['deviceNo'] as String,
      deviceType: json['deviceType'] as int,
      content: json['content'] as String,
    );
