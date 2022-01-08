import 'package:json_annotation/json_annotation.dart';

part 'fire_model.g.dart';

@JsonSerializable()
class FireModel {
  String? alarmNo;
  String? alarmType;
  String? deviceName;
  String? deviceNo;
  String? time;
  int? type;

  factory FireModel.fromJson(Map<String, dynamic> json) =>
      _$FireModelFromJson(json);

  FireModel({
    this.alarmNo,
    this.alarmType,
    this.deviceName,
    this.deviceNo,
    this.time,
    this.type,
  });
}
