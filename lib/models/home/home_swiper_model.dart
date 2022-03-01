import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_swiper_model.g.dart';

@JsonSerializable()
class HomeSwiperModel {
  final int id;
  final int type;
  final String? customizeUrl;
  final int? associationId;
  final List<ImgModel>? imgList;
  factory HomeSwiperModel.fromJson(Map<String, dynamic> json) =>
      _$HomeSwiperModelFromJson(json);

  const HomeSwiperModel({
    required this.id,
    required this.type,
    this.customizeUrl,
    this.associationId,
    this.imgList,
  });
}
