import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thumbs_up_list_model.g.dart';

@JsonSerializable()
class ThumbsUpListModel {
  final int id;
  final int status;
  final int sendId;
  final String sendName;
  final String sendDate;
  final List<ImgModel> avatarImgList;
  final List<ImgModel> dynamicImgList;
  factory ThumbsUpListModel.fromJson(Map<String, dynamic> json) =>
      _$ThumbsUpListModelFromJson(json);

  const ThumbsUpListModel({
    required this.id,
    required this.status,
    required this.sendId,
    required this.sendName,
    required this.sendDate,
    required this.avatarImgList,
    required this.dynamicImgList,
  });
}
