import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommitteeItemModel {
  final int? id;
  final String? name;
  final String? tel;
  final String? industryCommitteeTypeName;
  final String? buildingName;
  final String? unitName;
  final String? estateName;
  final String? appointmentStartTime;
  final String? appointmentEndTime;
  final String? createDate;
  final List<ImgModel>? imgList;

  factory CommitteeItemModel.fromJson(Map<String, dynamic> json) =>
      _$CommitteeItemModel(json);
  DateTime? get appointmentStartDT => DateUtil.getDateTime(appointmentStartTime!);
  DateTime? get appointmentEndDT => DateUtil.getDateTime(appointmentEndTime!);
  DateTime? get createDateDT => DateUtil.getDateTime(createDate!);
  const CommitteeItemModel({
    required this.id,
    required this.name,
    required this.tel,
    required this.industryCommitteeTypeName,
    required this.buildingName,
    required this.unitName,
    required this.estateName,
    required this.appointmentStartTime,
    required this.appointmentEndTime,
    required this.createDate,
    required this.imgList,
  });
}
CommitteeItemModel _$CommitteeItemModel(Map<String, dynamic> json) =>
    CommitteeItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
      tel: json['tel'] as String,
      industryCommitteeTypeName: json['industryCommitteeTypeName'] as String,
      buildingName: json['buildingName'] as String,
      unitName: json['unitName'] as String,
      estateName: json['estateName'] as String,
      appointmentStartTime: json['appointmentStartTime'] as String,
      appointmentEndTime: json['appointmentEndTime'] as String,
      createDate: json['createDate'] as String,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );