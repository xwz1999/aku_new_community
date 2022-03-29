import 'package:json_annotation/json_annotation.dart';

part 'my_family_examine_list_model.g.dart';

@JsonSerializable()
class MyFamilyExamineListModel {
  final int estateId;
  final String estateName;
  final String unitName;
  final String buildingName;
  final String name;
  final String tel;
  final int status;
  final int identity;
  final String estateTypeName;
  factory MyFamilyExamineListModel.fromJson(Map<String, dynamic> json) =>
      _$MyFamilyExamineListModelFromJson(json);

  const MyFamilyExamineListModel({
    required this.estateId,
    required this.estateName,
    required this.unitName,
    required this.buildingName,
    required this.name,
    required this.tel,
    required this.status,
    required this.identity,
    required this.estateTypeName,
  });
}
