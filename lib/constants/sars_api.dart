part 'profile_api.dart';

class SARSAPI {
  ///HOST
  static const String host = 'http://121.41.26.225:8006';

  ///接口基础地址
  static const String baseURL = '$host';

  ///静态资源路径
  static String get resource => '$host/static';

  static String image(String? path) => '$resource$path';

  static String file(String? path) => '$resource$path';
  static const int networkTimeOut = 10000;
  static _City city = _City();
  static _ProfileApi profile = _ProfileApi();
  static _Login login = _Login();
  static _User user = _User();
}

class _City {
  ///查询所有的城市信息
  String get allCity => '/app/city/allCity';
}

class _User {
  ///用户资料
  String get userProfile => '/app/user/findDetail';
}

class _Login {
  ///查询所有小区信息
  String get allCommunity => '/app/login/findAllCommunity';

  ///账号密码登录
  String get login => '/app/login/loginTelPwd';

  /// 获取手机验证码
  String get sendSMSCode => '/app/login/sendTelCode';

  ///app用户（手机号验证码）登录
  String get loginTelCode => '/app/login/loginTelCode';
}
