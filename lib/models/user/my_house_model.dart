import 'package:json_annotation/json_annotation.dart';

part 'my_house_model.g.dart';

@JsonSerializable()
class MyHouseModel {
  final int id;
  final String addressName;
  final String communityName;
  final String buildingName;
  final String estateName;
  final String unitName;
  final String manageEstateTypeName;
  final int identity;
  final String name;
  final String tel;
  final int isDefault;
  factory MyHouseModel.fromJson(Map<String, dynamic> json) =>
      _$MyHouseModelFromJson(json);

  const MyHouseModel({
    required this.id,
    required this.addressName,
    required this.communityName,
    required this.buildingName,
    required this.estateName,
    required this.unitName,
    required this.manageEstateTypeName,
    required this.identity,
    required this.name,
    required this.tel,
    required this.isDefault,
  });
}
