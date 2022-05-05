import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'community_introduce_model.g.dart';

@JsonSerializable()
class CommunityIontroduceModel extends Equatable {
  final String name;
  final String content;
  final List<ImgModel>? imgList;

  factory CommunityIontroduceModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityIontroduceModelFromJson(json);

  factory CommunityIontroduceModel.init() =>
      CommunityIontroduceModel(name: '', content: '', imgList: []);

  @override
  List<Object?> get props {
    return [
      name,
      content,
      imgList,
    ];
  }

  const CommunityIontroduceModel({
    required this.name,
    required this.content,
    this.imgList,
  });
}
