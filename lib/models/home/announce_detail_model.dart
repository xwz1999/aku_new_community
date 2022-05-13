import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'announce_detail_model.g.dart';

@JsonSerializable()
class AnnounceDetailModel {
  final int id;
  final String title;
  final int object;
  final int status;
  final String content;
  final int readingVolume;
  final int downloadNum;
  final String modifyDate;
  final List<ImgModel> coverImgList;
  final List<ImgModel> annexImgList;

  factory AnnounceDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AnnounceDetailModelFromJson(json);

  const AnnounceDetailModel({
    required this.id,
    required this.title,
    required this.object,
    required this.status,
    required this.content,
    required this.readingVolume,
    required this.downloadNum,
    required this.modifyDate,
    required this.coverImgList,
    required this.annexImgList,
  });
}
