import 'package:json_annotation/json_annotation.dart';

import 'package:aku_community/model/common/img_model.dart';

part 'facility_type_model.g.dart';

@JsonSerializable()
class FacilityTypeModel {
  final int id;
  final String name;
  final String openStartDate;
  final String openEndDate;

  String get startDateStr => openStartDate.split(':').getRange(0, 2).join(':');
  String get endDateStr => openEndDate.split(':').getRange(0, 2).join(':');

  @JsonKey(name: 'num')
  final int num_;
  final List<ImgModel>? imgUrls;
  FacilityTypeModel({
    required this.id,
    required this.name,
    required this.openStartDate,
    required this.openEndDate,
    required this.num_,
    required this.imgUrls,
  });

  factory FacilityTypeModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityTypeModelFromJson(json);
}
