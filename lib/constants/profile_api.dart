part of 'sars_api.dart';

class _ProfileApi {
  _MyHouse house = _MyHouse();
  _MyFamily family = _MyFamily();
  _Integral integral = _Integral();
}

class _MyHouse {
  ///查询所有我的房屋
  String get userHouse => '/app/user/myEstate/findAllMyEstate';

  ///添加房屋申请
  String get addHouse => '/app/user/myEstate/insertEstateApply';

  //查询所有我的房屋申请列表信息
  String get applyRecord => '/app/user/myEstate/findAllMyEstateApply';
}

class _MyFamily {
  ///查询房屋当前成员
  String get myFamilyMember => '/app/user/myFamily/findCurrentMembers';

  ///查询当前用户的审核列表
  String get myFamilyExamine => '/app/user/myFamily/findCurrentUserApply';

  ///通过/驳回房屋审核
  String get myFamilyReview => '/app/user/myFamily/review';
}

class _Integral {
  ///获取积分页面详情
  String get info => '/app/user/points/getPointsInfo';

  ///积分签到
  String get sign => '/app/user/points/sign';
}
