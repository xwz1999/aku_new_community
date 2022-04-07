import 'package:aku_new_community/saas_model/login/picked_city_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'community_model.dart';

part 'history_login_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class HistoryLoginModel {
  @HiveField(0)
  PickedCityModel cityModel;
  @HiveField(1)
  CommunityModel? communityModel;

  factory HistoryLoginModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryLoginModelFromJson(json);

//<editor-fold desc="Data Methods">

  HistoryLoginModel({
    required this.cityModel,
    this.communityModel,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryLoginModel &&
          runtimeType == other.runtimeType &&
          cityModel == other.cityModel &&
          communityModel == other.communityModel);

  @override
  int get hashCode => cityModel.hashCode ^ communityModel.hashCode;

  @override
  String toString() {
    return 'HistoryLoginModel{' +
        ' cityModel: $cityModel,' +
        ' communityModel: $communityModel,' +
        '}';
  }

  HistoryLoginModel copyWith({
    PickedCityModel? cityModel,
    CommunityModel? communityModel,
  }) {
    return HistoryLoginModel(
      cityModel: cityModel ?? this.cityModel,
      communityModel: communityModel ?? this.communityModel,
    );
  }

//</editor-fold>
}
