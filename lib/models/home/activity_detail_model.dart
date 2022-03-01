import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_detail_model.g.dart';

@JsonSerializable()
class ActivityDetailModel {
  final int id;
  final List<ImgModel> imgList;
  final String title;
  final int status;
  final String registrationStartTime;
  final String registrationEndTime;
  final String activityStartTime;
  final String activityEndTime;
  final String activityAddress;
  final List<Registration> registrationList;
  final int registrationNum;
  final int registrationNumMax;
  final double registrationCost;
  final String activityContact;
  final String activityTel;
  final String content;
  final String unit;
  final String contact;
  final String tel;
  final List<ImgModel> organizerImgList;

  factory ActivityDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityDetailModelFromJson(json);

  DateTime? get regisStartTime => DateUtil.getDateTime(registrationStartTime);
  DateTime? get regisEndTime => DateUtil.getDateTime(registrationEndTime);
  DateTime? get activeTime => DateUtil.getDateTime(activityStartTime);
  DateTime? get activeEndTime => DateUtil.getDateTime(activityEndTime);
  const ActivityDetailModel({
    required this.id,
    required this.imgList,
    required this.title,
    required this.status,
    required this.registrationStartTime,
    required this.registrationEndTime,
    required this.activityStartTime,
    required this.activityEndTime,
    required this.activityAddress,
    required this.registrationList,
    required this.registrationNum,
    required this.registrationNumMax,
    required this.registrationCost,
    required this.activityContact,
    required this.activityTel,
    required this.content,
    required this.unit,
    required this.contact,
    required this.tel,
    required this.organizerImgList,
  });
}

@JsonSerializable()
class Registration {
  final int id;
  final String name;
  final List<ImgModel> avatarImgList;

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  const Registration({
    required this.id,
    required this.name,
    required this.avatarImgList,
  });
}
