import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_list_model.g.dart';

@JsonSerializable()
class TeamListModel extends Equatable {
  final int id;
  final int userType;
  final int manageUserId;
  final String manageUserName;
  final String manageUserTel;
  final int departmentId;
  final String departmentName;
  final int positionId;
  final String positionName;

  factory TeamListModel.fromJson(Map<String, dynamic> json) =>
      _$TeamListModelFromJson(json);

  const TeamListModel({
    required this.id,
    required this.userType,
    required this.manageUserId,
    required this.manageUserName,
    required this.manageUserTel,
    required this.departmentId,
    required this.departmentName,
    required this.positionId,
    required this.positionName,
  });

  @override
  List<Object?> get props => [
        id,
        userType,
        manageUserId,
        manageUserName,
        manageUserTel,
        departmentId,
        departmentName,
        positionId,
        positionName,
      ];
}
