class API {
  ///HOST
  static const String host = 'http://192.168.2.201:8804';

  ///接口基础地址
  static const String baseURL = '$host/IntelligentCommunity/app';

  ///静态资源路径
  static String get resource => '$host/static';

  static String image(String path) => '$resource$path';

  static const int networkTimeOut = 10000;
  static _Login login = _Login();
  static _User user = _User();
  static _Manager manager = _Manager();
  static _Upload upload = _Upload();
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

  ///用户详细资料
  String get userDetail => '/user/personalData/getUserDetail';

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

  ///修改头像
  String get udpdateAvatar => '/user/personalData/updateHeadPortrait';
}

class _Manager {
  ///获取业委会列表
  String get commiteeStaff => '/ownersCommittee/findAll';

  ///获取便民电话联系人列表
  String get convenientPhone => '/convenientTelephone/list';

  ///查询当前用户的报事报修信息
  String get fixedSubmit => '/user/reportRepair/list';

  ///访客通行：添加填写的访客信息
  String get insertVisitorInfo => '/user/visitorAccess/insertVisitorInfo';

  ///物品出户：查询当前用户所有的物品出户信息
  String get articleOut => '/user/articleOut/list';

  ///报事报修：app提交报事报修信息
  String get reportRepairInsert => '/user/reportRepair/insert';

  ///报事报修：批量删除报事报修信息（业主端）
  String get reportRepairDelete => '/user/reportRepair/falseDelete';
}

class _Upload {
  ///上传咨询建议照片
  String get uploadArticle => '/user/upload/uploadArticle';

  ///上传头像
  String get uploadAvatar => '/user/upload/appHeadSculpture';
}
