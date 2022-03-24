import 'package:aku_new_community/widget/others/user_tool.dart';

part 'market_api.dart';
part 'profile_api.dart';

class SAASAPI {
  ///HOST
  static const String host = 'http://121.41.26.225:8006';

  ///接口基础地址
  static const String baseURL = '$host';

  ///静态资源路径
  static String get resource =>
      'https://saas.kaidalai.cn/resource/${UserTool.userProvider.userInfoModel!.communityCode}/';

  static String image(String? path) => '$resource$path';

  static String file(String? path) => '$resource$path';
  static const int networkTimeOut = 10000;

  ///根分类
  static _City city = _City();
  static _Login login = _Login();
  static _User user = _User();
  static _House house = _House();
  static _File uploadFile = _File();
  static _Message message = _Message();
  static _Community community = _Community();
  static _Task task = _Task();
  static _HomeCarouse homeCarouse = _HomeCarouse();
  static _Activity activity = _Activity();
  static _Announce announce = _Announce();
  static _Information information = _Information();
  static _WorkOrder workOrder = _WorkOrder();

  ///二级分类
  static _ProfileApi profile = _ProfileApi();
  static _MarketApi market = _MarketApi();
}

class _City {
  ///查询所有的城市信息
  String get allCity => '/app/city/allCity';
}

class _User {
  ///用户资料
  String get userProfile => '/app/user/findDetail';

  ///设置密码（密码不存在时调用）
  String get settingPsd => '/app/user/settingPassword';

  ///提交修改的新密码（忘记密码）
  String get settingForgotPsd => '/app/user/forgetPassword';

  ///app用户发送手机号验证码(忘记密码)
  String get sendForgotTelCode => '/app/user/sendTelCodeForgetPwd';

  ///检测昵称是否重复
  String get checkNickRepeat => '/app/user/checkNickNameRepeat';

  ///设置昵称
  String get setNickName => '/app/user/settingNickName';

  ///实名认证
  String get certification => '/app/user/verified';

  ///修改用户头像
  String get updateAvatar => '/app/user/updateAvatarImg';
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

class _House {
  ///查询所有的房屋(级联)
  String get allHouses => '/app/estate/findEstateCascade';
}

class _File {
  ///上传app照片
  String get uploadImg => '/app/user/upload/uploadImg';
}

class _Message {
  ///全部已读
  String get allRead => '/app/user/message/allRead';

  ///已读
  String get read => '/app/user/message/read';

  ///所有点赞消息
  String get allLikes => '/app/user/message/likesMessage';

  ///所有评论消息
  String get allComment => '/app/user/message/commentMessage';
}

class _Community {
  ///查询动态下的单个评论信息
  String get singleComment => '/app/user/community/comment/findById';

  ///话题详情
  String get topicDetail => '/app/user/community/topic/findById';

  ///动态信息详情
  String get dynamicDetail => '/app/user/community/dynamic/details';

  ///点赞动态
  String get dynamicLike => '/app/user/community/dynamic/likes';

  ///点赞评论
  String get commentLike => '/app/user/community/comment/likes';

  ///发送评论
  String get commentInsert => '/app/user/community/comment/insert';

  ///查询动态下的评论信息列表
  String get commentList => '/app/user/community/comment/list';

  ///发布动态
  String get dynamicInsert => '/app/user/community/dynamic/insert';

  ///我的动态资料部分(头部)
  String get dynamicMyListH => '/app/user/community/dynamic/myListH';

  ///我的动态信息部分(底部)
  String get dynamicMyListL => '/app/user/community/dynamic/myListL';

  ///所有动态信息
  String get dynamicList => '/app/user/community/dynamic/list';

  ///所有话题
  String get topicList => '/app/user/community/topic/list';

  ///新鲜话题
  String get topNewList => '/app/user/community/topic/newList';
}

class _Task {
  ///取消任务（发布者,接单者）
  String get cancel => '/app/user/taskRelease/cancel';

  ///任务评价（发布者）
  String get evaluation => '/app/user/taskRelease/evaluation';

  ///确认任务（发布者）
  String get confirm => '/app/user/taskRelease/confirm';

  ///完成任务（接单者）
  String get finish => '/app/user/taskRelease/finish';

  ///开始服务（接单者）
  String get startService => '/app/user/taskRelease/startService';

  ///领取任务（接单者）
  String get receive => '/app/user/taskRelease/receive';

  ///发布任务
  String get insert => '/app/user/taskRelease/insert';

  ///查询任务发布信息列表
  String get list => '/app/user/taskRelease/list';
}

class _HomeCarouse {
  ///获取首页轮播图列表
  String get list => '/app/user/homepageCarousel/list';
}

class _Activity {
  ///查询活动详情
  String get detail => '/app/user/activity/findById';

  ///活动报名
  String get registration => '/app/user/activity/registration';

  ///查询所有的活动列表
  String get list => '/app/user/activity/list';
}

class _Announce {
  ///查询通知公告列表
  String get list => '/app/user/announcement/list';

  ///查询通知公告详情
  String get detail => '/app/user/announcement/detail';
}

class _Information {
  ///查询app资讯推荐阅读列表信息
  String get recommendList => '/app/user/information/recommendList';

  ///查询app资讯列表信息
  String get list => '/app/user/information/list';

  ///查询app所有的资讯分类信息
  String get categoryList => '/app/user/information/categoryList';
}

class _WorkOrder {
  ///根据工单主键id查询工单账单
  String get workOrderBill => '/app/user/workOrder/workOrderBill';

  ///根据工单主键id查询工单报告列表
  String get findRRById => '/app/user/workOrder/findRRById';

  ///根据工单主键id查询工单信息
  String get findById => '/app/user/workOrder/findById';

  ///根据工单主键id查询工单进度列表
  String get findScheduleById => '/app/user/workOrder/findScheduleById';

  ///评价
  String get evaluate => '/app/user/workOrder/evaluate';

  ///确认完成
  String get confirmCompletion => '/app/user/workOrder/confirmCompletion';

  ///催促进度
  String get promotionRate => '/app/user/workOrder/promotionRate';

  ///取消工单
  String get cancel => '/app/user/workOrder/cancel';

  ///查询服务团队名单
  String get findServiceTeamList => '/app/user/workOrder/findServiceTeamList';

  ///发布工单
  String get insert => '/app/user/workOrder/insert';

  ///查询所有的工单类型信息
  String get typeList => '/app/user/workOrder/typeList';

  ///查询所有的工单信息
  String get list => '/app/user/workOrder/list';
}