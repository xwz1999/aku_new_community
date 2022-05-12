import 'package:common_utils/common_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../model/common/img_model.dart';

part 'facility_type_detail_model.g.dart';

@JsonSerializable()
class FacilityTypeDetailModel extends Equatable {
  final int id;
  final String code;
  final String address;
  final String name;
  final String openStartDate;
  final String openEndDate;
  final List<ImgModel>? imgList;

  DateTime? get openStartDt => DateUtil.getDateTime(openStartDate);

  DateTime? get openEndDt => DateUtil.getDateTime(openEndDate);

  FacilityTypeDetailModel({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.openStartDate,
    required this.openEndDate,
    required this.imgList,
  });

  factory FacilityTypeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityTypeDetailModelFromJson(json);

  @override
  List<Object?> get props =>
      [id, code, name, address,  openStartDate, openEndDate, imgList];
}
