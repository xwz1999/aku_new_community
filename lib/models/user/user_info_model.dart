import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final int id;
  final int communityId;
  final String communityName;
  final String communityCode;
  final String? name;
  final String? idCard;
  final String tel;

  // 性别 1.男 2.女 3.保密
  final int? sex;
  final String? nickName;
  final bool isExistPassword;
  final bool isPointsSignSetting;
  final bool isSign;
  final int? points;
  final double? balance;
  final bool isBalancePayPwd;
  final List<ImgModel> imgList;

  String get sexValue {
    if (sex == 1) return '男';
    if (sex == 2) return '女';
    if (sex == 3) return '保密';
    return '未设置';
  }

  // DateTime? get birthdayDate => DateUtil.getDateTime(birthday ?? '');

  // String get birthdayValue {
  //   if (TextUtil.isEmpty(birthday))
  //     return '未设置';
  //   else
  //     return DateUtil.formatDate(birthdayDate, format: 'yyyy-MM-dd');
  // }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  const UserInfoModel({
    required this.id,
    required this.communityId,
    required this.communityName,
    required this.communityCode,
    this.name,
    this.idCard,
    required this.tel,
    this.sex,
    this.nickName,
    required this.isExistPassword,
    required this.isPointsSignSetting,
    required this.isSign,
    this.points,
    this.balance,
    required this.isBalancePayPwd,
    required this.imgList,
  });
}
