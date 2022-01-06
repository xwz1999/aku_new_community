import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final int id;
  final int communityId;
  final String? name;
  final String tel;
  final List<ImgModel> imgUrls;

  /// 性别 1.男 2.女 3.保密
  final int? sex;
  final String? nickName;
  final bool isExistPassword;

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
    this.name,
    required this.tel,
    required this.imgUrls,
    this.sex,
    this.nickName,
    required this.isExistPassword,
  });
}
