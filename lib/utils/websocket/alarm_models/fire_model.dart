import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'fire_model.g.dart';

@JsonSerializable()
class FireModel extends Equatable {
 final String? model;
 final String? communityCode;
 final int? alarmType;
 final String? alarmNo;
 final String? deviceNo;
 final String? deviceName;
 final String? time;
 final String? alarmContent;

  factory FireModel.fromJson(Map<String, dynamic> json) =>
      _$FireModelFromJson(json);

  @override
  List<Object?> get props => [
        model,
        communityCode,
        alarmType,
        alarmNo,
        deviceNo,
        deviceName,
        time,
        alarmContent,
      ];

  FireModel({
    this.model,
    this.communityCode,
    this.alarmType,
    this.alarmNo,
    this.deviceNo,
    this.deviceName,
    this.time,
    this.alarmContent,
  });
}
