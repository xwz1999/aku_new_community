import 'package:equatable/equatable.dart';

import 'package:aku_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'community_introduce_model.g.dart';

@JsonSerializable()
class CommunityIontroduceModel extends Equatable {
  final int id;
  final String name;
  final String content;
  final String createDate;
  final List<ImgModel>? imgList;
  CommunityIontroduceModel({
    required this.id,
    required this.name,
    required this.content,
    required this.createDate,
    this.imgList,
  });
  factory CommunityIontroduceModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityIontroduceModelFromJson(json);

  factory CommunityIontroduceModel.init() =>
      CommunityIontroduceModel(id: -1, name: '', content: '', createDate: '');
  @override
  List<Object?> get props {
    return [
      id,
      name,
      content,
      createDate,
      imgList,
    ];
  }
}
