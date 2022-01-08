import 'package:json_annotation/json_annotation.dart';

part 'bracelet_model.g.dart';

@JsonSerializable()
class BraceletModel {
  final int sbp;
  final int todaySteps;
  final int bloodOxygen;
  final int switchType;
  final int dbp;
  final int heartRate;
  final int remainingPower;
  final int detectionDays;
  final int alarmNums;
  final int fallNums;

  factory BraceletModel.fromJson(Map<String, dynamic> json) =>
      _$BraceletModelFromJson(json);

  String get switchTypeString {
    switch (switchType) {
      case 0:
        return '开机';
      case 1:
        return '关机';
      case 2:
        return '开机';
      case 3:
        return '低电通知';
      default:
        return '';
    }
  }

  bool get heartNormal => heartRate >= 60 && heartRate <= 100;

  bool get sbpNormal => sbp >= 90 && sbp <= 139;

  bool get dbpNormal => dbp >= 60 && dbp <= 89;

  const BraceletModel({
    required this.sbp,
    required this.todaySteps,
    required this.bloodOxygen,
    required this.switchType,
    required this.dbp,
    required this.heartRate,
    required this.remainingPower,
    required this.detectionDays,
    required this.alarmNums,
    required this.fallNums,
  });
}
