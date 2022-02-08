import 'package:json_annotation/json_annotation.dart';

part 'my_take_task_list_model.g.dart';

@JsonSerializable()
class MyTakeTaskListModel {
  final int id;
  final String title;
  final int status;
  final int type;
  final int sex;
  final int serviceObject;
  final String content;
  final String appointmentDate;
  final String appointmentAddress;
  final int rewardType;
  final int reward;
  final int createType;
  final String? createName;
  final String createDate;

  factory MyTakeTaskListModel.fromJson(Map<String, dynamic> json) =>
      _$MyTakeTaskListModelFromJson(json);

  const MyTakeTaskListModel({
    required this.id,
    required this.title,
    required this.status,
    required this.type,
    required this.sex,
    required this.serviceObject,
    required this.content,
    required this.appointmentDate,
    required this.appointmentAddress,
    required this.rewardType,
    required this.reward,
    required this.createType,
    this.createName,
    required this.createDate,
  });
}
