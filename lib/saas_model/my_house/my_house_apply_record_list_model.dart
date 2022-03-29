import 'package:json_annotation/json_annotation.dart';

part 'my_house_apply_record_list_model.g.dart';

@JsonSerializable()
class MyHouseApplyRecordListModel {
  final int id;
  final String addressName;
  final String communityName;
  final String buildingName;
  final String unitName;
  final String estateName;
  final String manageEstateTypeName;
  final int identity;
  final String name;
  final String tel;
  final int status;
  final String? remarks;
  factory MyHouseApplyRecordListModel.fromJson(Map<String, dynamic> json) =>
      _$MyHouseApplyRecordListModelFromJson(json);

  const MyHouseApplyRecordListModel({
    required this.id,
    required this.addressName,
    required this.communityName,
    required this.buildingName,
    required this.unitName,
    required this.estateName,
    required this.manageEstateTypeName,
    required this.identity,
    required this.name,
    required this.tel,
    required this.status,
    this.remarks,
  });
}
