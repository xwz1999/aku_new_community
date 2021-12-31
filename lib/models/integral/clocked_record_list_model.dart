import 'package:json_annotation/json_annotation.dart';

part 'clocked_record_list_model.g.dart';

@JsonSerializable()
class ClockedRecordListModel {
  final int day;
  final String date;
  final int addIntegral;
  factory ClockedRecordListModel.fromJson(Map<String, dynamic> json) =>
      _$ClockedRecordListModelFromJson(json);

  const ClockedRecordListModel({
    required this.day,
    required this.date,
    required this.addIntegral,
  });
}
