import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_list_model.g.dart';

@JsonSerializable()
class TeamListModel {
  final int id;
  final String name;
  final List<ImgModel> imgs;
  final String tel;
  final String position;

  factory TeamListModel.fromJson(Map<String, dynamic> json) =>
      _$TeamListModelFromJson(json);

  const TeamListModel({
    required this.id,
    required this.name,
    required this.imgs,
    required this.tel,
    required this.position,
  });
}
