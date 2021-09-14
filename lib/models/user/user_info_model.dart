import 'package:aku_community/model/common/img_model.dart';
import 'package:flustars/flustars.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  int id;
  List<ImgModel> imgUrls;
  String name;
  String nickName;
  String tel;

  /// 性别 1.男 2.女
  int? sex;
  String birthday;

  String get sexValue {
    if (sex == null) return '未设置';
    if (sex == 1) return '男';
    if (sex == 2) return '女';
    return '未设置';
  }

  DateTime? get birthdayDate => DateUtil.getDateTime(birthday);

  String get birthdayValue {
    if (TextUtil.isEmpty(birthday))
      return '未设置';
    else
      return DateUtil.formatDate(birthdayDate, format: 'yyyy-MM-dd');
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  UserInfoModel({
    required this.id,
    required this.imgUrls,
    required this.name,
    required this.nickName,
    required this.tel,
    this.sex,
    required this.birthday,
  });
}
