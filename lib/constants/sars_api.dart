part of 'api.dart';

class _SarsApi {
  _City city = _City();
  _LoginAndSignup login = _LoginAndSignup();
}

class _City {
  ///查询所有的城市信息
  String get allCity => '/app/city/allCity';
}

class _LoginAndSignup {
  ///查询所有小区信息
  String get allCommunity => '/app/login/findAllCommunity';
}
