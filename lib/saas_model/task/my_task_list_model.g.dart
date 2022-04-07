// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_task_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTaskListModel _$MyTaskListModelFromJson(Map<String, dynamic> json) =>
    MyTaskListModel(
      id: json['id'] as int,
      code: json['code'] as String,
      status: json['status'] as int,
      updateDate: json['updateDate'] as String,
      type: json['type'] as int,
      sex: json['sex'] as int,
      readyStartTime: json['readyStartTime'] as String,
      readyEndTime: json['readyEndTime'] as String,
      accessAddress: json['accessAddress'] as String?,
      accessAddressDetail: json['accessAddressDetail'] as String?,
      serviceTime: json['serviceTime'] as int?,
      remarks: json['remarks'] as String?,
      voiceUrl: json['voiceUrl'] as String?,
      imgList: (json['imgList'] as List<dynamic>?)
          ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rewardType: json['rewardType'] as int,
      reward: json['reward'] as int,
      createId: json['createId'] as int,
      createDate: json['createDate'] as String,
    );
