class API {
  static const String host = 'http://192.168.2.201:8804/IntelligentCommunity';
  static String get resource => '$host/static';
  static const int networkTimeOut = 10000;
  static _Login login = _Login();
  static _User user = _User();
}

class _Login {
  /// 获取手机验证码
  String get sendSMSCode => '/login/sendMMSLogin';

  /// 通过验证码短信登陆
  String get loginBySMS => '/login/loginSMSUser';

  /// 查询楼栋ID
  String get buildingInfo => '/login/findAllBuildingIAN';

  ///查询单元ID
  String get unitInfo => '/login/findEstateIANByBuilding';

  /// app用户注册
  String get signUp => '/login/register';
}

class _User {
  ///用户资料
  String get userProfile => '/user/personalData/findPersonalData';

  ///设置用户性别
  String get setSex => '/user/personalData/updateSex';

  ///设置用户生日
  String get setBirthday => '/user/personalData/updateBirthday';
}
