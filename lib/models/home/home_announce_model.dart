import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_announce_model.g.dart';

@JsonSerializable()
class HomeAnnounceModel {
  final int id;
  final String title;
  final String content;
  final List<ImgModel> imgList;
  final String createDate;
  factory HomeAnnounceModel.fromJson(Map<String, dynamic> json) =>
      _$HomeAnnounceModelFromJson(json);
  DateTime? get createDateDT => DateUtil.getDateTime(createDate);
  int? get month => createDateDT?.month;

  int? get year => createDateDT?.year;
  const HomeAnnounceModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imgList,
    required this.createDate,
  });

  HomeAnnounceModel copyWith({
    int? id,
    String? title,
    String? content,
    List<ImgModel>? imgList,
    String? createDate,
  }) {
    return HomeAnnounceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imgList: imgList ?? this.imgList,
      createDate: createDate ?? this.createDate,
    );
  }
}
