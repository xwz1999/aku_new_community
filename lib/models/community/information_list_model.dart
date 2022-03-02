import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'information_list_model.g.dart';

@JsonSerializable()
class InformationListModel {
  final int id;
  final String title;
  final String content;
  final int viewsNum;
  final String createDate;
  final List<ImgModel> imgList;
  factory InformationListModel.fromJson(Map<String, dynamic> json) =>
      _$InformationListModelFromJson(json);
  DateTime? get createDateDT => DateUtil.getDateTime(createDate);
  const InformationListModel({
    required this.id,
    required this.title,
    required this.content,
    required this.viewsNum,
    required this.createDate,
    required this.imgList,
  });
}
