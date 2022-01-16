import 'package:json_annotation/json_annotation.dart';

part 'my_family_member_list_model.g.dart';

@JsonSerializable()
class MyFamilyMemberListModel {
  final int estateId;
  final String estateName;
  final String unitName;
  final String buildingName;
  final List<Member> members;
  final String estateTypeName;

  factory MyFamilyMemberListModel.fromJson(Map<String, dynamic> json) =>
      _$MyFamilyMemberListModelFromJson(json);

  const MyFamilyMemberListModel({
    required this.estateId,
    required this.estateName,
    required this.unitName,
    required this.buildingName,
    required this.members,
    required this.estateTypeName,
  });
}

@JsonSerializable()
class Member {
  final int id;
  final String name;
  final int identity;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  const Member({
    required this.id,
    required this.name,
    required this.identity,
  });
}
