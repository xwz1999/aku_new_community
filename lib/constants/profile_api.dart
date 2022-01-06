part of 'sars_api.dart';

class _ProfileApi {
  _MyHouse house = _MyHouse();
}

class _MyHouse {
  ///查询所有我的房屋
  String get userHouse => '/app/user/myEstate/findAllMyEstate';
}
