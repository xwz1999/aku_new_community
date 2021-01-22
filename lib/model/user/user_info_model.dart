import 'package:common_utils/common_utils.dart';

class UserInfoModel {
  int id;
  String imgUrl;
  String name;
  String nickName;
  String tel;

  /// 性别 1.男 2.女
  int sex;
  String birthday;

  String get sexValue {
    if (sex == null) return '未设置';
    if (sex == 1) return '男';
    if (sex == 2) return '女';
    return '未设置';
  }

  DateTime get birthdayDate => DateUtil.getDateTime(birthday);
  String get birthdayValue {
    if (TextUtil.isEmpty(birthday))
      return '未设置';
    else
      return DateUtil.formatDate(birthdayDate, format: 'yyyy-MM-dd');
  }

  UserInfoModel(
      {this.id,
      this.imgUrl,
      this.name,
      this.nickName,
      this.tel,
      this.sex,
      this.birthday});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['imgUrls'] != null)
      imgUrl = (json['imgUrls'] as List).first['url'];
    name = json['name'];
    nickName = json['nickName'];
    tel = json['tel'];
    sex = json['sex'];
    birthday = json['birthday'];
  }
}
