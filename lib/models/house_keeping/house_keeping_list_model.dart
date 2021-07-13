import 'package:equatable/equatable.dart';

import 'package:aku_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'house_keeping_list_model.g.dart';

@JsonSerializable()
class HouseKeepingListModel extends Equatable {
  final int id;
  final String proposerName;
  final String proposerTel;
  final String roomName;
  final int type;
  final String content;
  final int status;
  final int? completion;
  final String? processDescription;
  final String? handlingTime;
  final double? payFee;
  final int? evaluation;
  final String? evaluationContent;
  final String? evaluationTime;
  final String createDate;
  final List<ImgModel> submitImgList;
  HouseKeepingListModel({
    required this.id,
    required this.proposerName,
    required this.proposerTel,
    required this.roomName,
    required this.type,
    required this.content,
    required this.status,
    this.completion,
    this.processDescription,
    this.handlingTime,
    this.payFee,
    this.evaluation,
    this.evaluationContent,
    this.evaluationTime,
    required this.createDate,
    required this.submitImgList,
  });
  factory HouseKeepingListModel.fromJson(Map<String, dynamic> json) =>
      _$HouseKeepingListModelFromJson(json);
  @override
  List<Object?> get props {
    return [
      id,
      proposerName,
      proposerTel,
      roomName,
      type,
      content,
      status,
      completion,
      processDescription,
      handlingTime,
      payFee,
      evaluation,
      evaluationContent,
      evaluationTime,
      createDate,
      submitImgList,
    ];
  }
}
