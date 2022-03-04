import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_task_list_model.g.dart';

@JsonSerializable()
class MyTaskListModel {
  final int id;
  final String code;
  final int status;
  final String updateDate;
  final int type;
  final int sex;
  final String readyStartTime;
  final String readyEndTime;
  final String? accessAddress;
  final String? accessAddressDetail;
  final int? serviceTime;
  final String remarks;
  final String voiceUrl;
  final List<ImgModel>? imgList;
  final int rewardType;
  final int reward;
  factory MyTaskListModel.fromJson(Map<String, dynamic> json) =>
      _$MyTaskListModelFromJson(json);

  const MyTaskListModel({
    required this.id,
    required this.code,
    required this.status,
    required this.updateDate,
    required this.type,
    required this.sex,
    required this.readyStartTime,
    required this.readyEndTime,
    this.accessAddress,
    this.accessAddressDetail,
    this.serviceTime,
    required this.remarks,
    required this.voiceUrl,
    this.imgList,
    required this.rewardType,
    required this.reward,
  });
}
