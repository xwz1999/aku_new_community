import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dynamic_my_list_head.g.dart';

@JsonSerializable()
class DynamicMyListHead {
  final int id;
  final String createName;
  final List<ImgModel> avatarImgList;
  final int dynamicNum;
  final int commentNum;
  final int likesNum;
  factory DynamicMyListHead.fromJson(Map<String, dynamic> json) =>
      _$DynamicMyListHeadFromJson(json);

  const DynamicMyListHead({
    required this.id,
    required this.createName,
    required this.avatarImgList,
    required this.dynamicNum,
    required this.commentNum,
    required this.likesNum,
  });
}
