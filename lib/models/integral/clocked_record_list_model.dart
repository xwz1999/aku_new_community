import 'package:json_annotation/json_annotation.dart';

part 'clocked_record_list_model.g.dart';

@JsonSerializable()
class ClockedRecordListModel {
  final int id;
  final int addNums;
  final int serialNumber;
  final String signDate;
  factory ClockedRecordListModel.fromJson(Map<String, dynamic> json) =>
      _$ClockedRecordListModelFromJson(json);

  const ClockedRecordListModel({
    required this.id,
    required this.addNums,
    required this.serialNumber,
    required this.signDate,
  });
}
