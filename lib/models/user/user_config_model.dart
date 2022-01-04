import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_config_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class UserConfigModel {
  @HiveField(0)
  int userId;
  @HiveField(1)
  bool clockRemind;
  @HiveField(2)
  bool todayClocked;
  factory UserConfigModel.fromJson(Map<String, dynamic> json) =>
      _$UserConfigModelFromJson(json);
  UserConfigModel({
    required this.userId,
    required this.clockRemind,
    required this.todayClocked,
  });
}
