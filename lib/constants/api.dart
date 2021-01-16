class API {
  static const String host = 'http://192.168.2.201:8804/IntelligentCommunity';
  static String get resource => '$host/static';
  static const int networkTimeOut = 10000;
  static _Login login = _Login();
}

class _Login {
  /// 获取手机验证码
  String get sendSMSCode => '/login/sendMMSLogin';

  /// 通过验证码短信登陆
  String get loginBySMS => 'login/loginSMSUser';
}
