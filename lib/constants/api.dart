class API {
  static const String host = 'http://192.168.2.201:8804/IntelligentCommunity';
  static String get resource => '$host/static';
  static const int networkTimeOut = 10000;
  static _Login login = _Login();
  static _User user = _User();
  static _Manager manager = _Manager();
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

  ///通过新手机号发送修改验证码
  String get sendNewMSCode => '/user/personalData/sendTelUpdateCode';
}

class _User {
  ///用户资料
  String get userProfile => '/user/personalData/findPersonalData';

  ///设置用户性别
  String get setSex => '/user/personalData/updateSex';

  ///设置用户生日
  String get setBirthday => '/user/personalData/updateBirthday';

  ///用户退出登陆
  String get logout => '/user/signOut';

  ///修改用户昵称
  String get updateNickName => '/user/personalData/updateNickName';

  ///修改用户手机号
  String get updateTel => '/user/personalData/updateTel';
}

class _Manager {
  ///获取业委会列表
  String get commiteeStaff => '/ownersCommittee/findAll';

  ///获取便民电话联系人列表
  String get convenientPhone => '/convenientTelephone/list';
}
