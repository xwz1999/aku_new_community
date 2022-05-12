import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'facility_type_model.g.dart';

@JsonSerializable()
class FacilityTypeModel {
  final int id;
  final String code;
  final String name;
  final int type;

  @JsonKey(name: 'num')
  final int num_;
  final List<ImgModel>? imgUrls;

  FacilityTypeModel({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.num_,
    required this.imgUrls,
  });

  factory FacilityTypeModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityTypeModelFromJson(json);
}
