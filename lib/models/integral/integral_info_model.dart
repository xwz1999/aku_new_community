import 'package:aku_new_community/models/integral/clocked_record_list_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'integral_info_model.g.dart';

@JsonSerializable()
class IntegralInfoModel {
  final int points;
  final String rewardSetting;
  final int serialNumber;
  final bool isSign;
  final List<ClockedRecordListModel> signRecordList;
  factory IntegralInfoModel.fromJson(Map<String, dynamic> json) =>
      _$IntegralInfoModelFromJson(json);

  const IntegralInfoModel({
    required this.points,
    required this.rewardSetting,
    required this.serialNumber,
    required this.isSign,
    required this.signRecordList,
  });
}
