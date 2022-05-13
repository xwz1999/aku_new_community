import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'information_detail_model.g.dart';

@JsonSerializable()
class InformationDetailModel extends Equatable {
  final int id;
  final String title;
  final String content;
  final int viewsNum;
  final String createDate;
  final List<ImgModel> imgList;

  factory InformationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$InformationDetailModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        viewsNum,
        createDate,
        imgList,
      ];

  const InformationDetailModel({
    required this.id,
    required this.title,
    required this.content,
    required this.viewsNum,
    required this.createDate,
    required this.imgList,
  });
}
