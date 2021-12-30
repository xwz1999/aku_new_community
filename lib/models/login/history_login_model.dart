import 'package:aku_new_community/models/login/community_model.dart';
import 'package:aku_new_community/models/login/picked_city_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_login_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class HistoryLoginModel {
  @HiveField(0)
  final PickedCityModel cityModel;
  @HiveField(1)
  final CommunityModel communityModel;
  factory HistoryLoginModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryLoginModelFromJson(json);

  const HistoryLoginModel({
    required this.cityModel,
    required this.communityModel,
  });
}
