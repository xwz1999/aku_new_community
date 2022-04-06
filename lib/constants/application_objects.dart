// import 'package:aku_new_community/widget/bee_scaffold.dart';

import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/community_introduce/community_introduce_page.dart';
import 'package:aku_new_community/pages/convenient_phone/convenient_phone_page.dart';
import 'package:aku_new_community/pages/electronic_commerc/electronic_commerc_page.dart';
import 'package:aku_new_community/pages/event_activity/event_voting_page.dart';
import 'package:aku_new_community/pages/express_packages/express_package_page.dart';
import 'package:aku_new_community/pages/geographic_information/geographic_information_page.dart';
import 'package:aku_new_community/pages/goods_deto_page/goods_deto_page.dart';
import 'package:aku_new_community/pages/goods_manage_page/select_borrow_return_page.dart';
import 'package:aku_new_community/pages/house_introduce/house_introduce.dart';
import 'package:aku_new_community/pages/industry_committee/industry_committee_page.dart';
import 'package:aku_new_community/pages/life_pay/life_pay_page_new.dart';
import 'package:aku_new_community/pages/opening_code_page/opening_code_page.dart';
import 'package:aku_new_community/pages/renovation_manage/new_renovation/new_renovation_page.dart';
import 'package:aku_new_community/pages/service_browse/service_browse_page.dart';
import 'package:aku_new_community/pages/services/old_age/old_age_support_page_simple.dart';
import 'package:aku_new_community/pages/setting_page/settings_page.dart';
import 'package:aku_new_community/pages/surrounding_enterprises/surrounding_enterprises_page.dart';
import 'package:aku_new_community/pages/visitor_access_page/visitor_access_page.dart';
import 'package:aku_new_community/ui/community/activity/activity_list_page.dart';
import 'package:aku_new_community/ui/community/facility/facility_appointment_page.dart';
import 'package:aku_new_community/ui/function_and_service/task/task_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_page.dart';
import 'package:aku_new_community/ui/home/application/all_application.dart';
import 'package:aku_new_community/ui/manager/advice/advice_page.dart';
import 'package:aku_new_community/ui/manager/questionnaire/questionnaire_page.dart';
import 'package:aku_new_community/ui/profile/car/car_manage_page.dart';
import 'package:aku_new_community/ui/profile/car_parking/car_parking_page.dart';
import 'package:aku_new_community/ui/profile/house/house_owners_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///应用对象
///Application Object
class AO {
  String title = '';
  String path = '';
  VoidCallback? callback = () {};

  AO(
    this.title,
    this.path,
    this.callback,
  );

  AO.fromRaw(String raw, {String? replaceTitle}) {
    appObjects.forEach((element) {
      if (element.title == raw) {
        this.title = replaceTitle ?? element.title;
        this.path = element.path;
        this.callback = element.callback;
      }
    });
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AO && other.title == title && other.path == path;
  }

  @override
  int get hashCode => title.hashCode ^ path.hashCode;
}

///所有应用
List<AO> appObjects = [
  // if (false) AO('一键开门', R.ASSETS_APPLICATIONS_OEPN_DOOR_PNG, () => Scaffold()),

  AO('开门码', Assets.newIcon.icKmm.path, () => Get.to(() => OpeningCodePage())),
  // AO('访客邀请', R.ASSETS_ICONS_FUNC_FKYQ_PNG, () => Get.to(()=>VisitorAccessPage()),
  AO('报事报修', Assets.home.icBsbx.path, () => Get.to(() => WorkOrderPage())),
  AO('生活缴费', Assets.home.icShjf.path, () => Get.to(() => LifePayPageNew())),
  AO('业委会', Assets.newIcon.icYwh.path,
      () => Get.to(() => IndustryCommitteePage())),
  // AO('建议咨询', R.ASSETS_ICONS_FUNC_JYZX_PNG,
  //     () => AdvicePage(type: AdviceType.SUGGESTION)),
  AO('便民电话', Assets.newIcon.imgBmdh.path,
      () => Get.to(() => ConvenientPhonePage())),
  AO('活动投票', Assets.newIcon.icHdtp.path, () => Get.to(() => EventVotingPage())),
  AO('物品出门', Assets.newIcon.imgWpcm.path, () => Get.to(() => GoodsDetoPage())),
  AO('投诉表扬', Assets.newIcon.icTsby.path,
      () => Get.to(() => AdvicePage(type: AdviceType.COMPLAIN))),
  AO('问卷调查', Assets.newIcon.icWjdc.path,
      () => Get.to(() => QuestionnairePage())),
  AO('装修管理', Assets.newIcon.imgZxgl.path,
      () => Get.to(() => NewRenovationPage())),
  AO('借还管理', Assets.newIcon.icJhgl.path,
      () => Get.to(SelectBorrowReturnPage())),
  // AO('一键报警', Assets.newIcon.yj, () => AlarmPage()),
  AO('设施预约', Assets.home.icSsyy.path, () => FacilityAppointmentPage()),
  AO('快递包裹', Assets.newIcon.icKdbg.path,
      () => Get.to(() => ExpressPackagePage())),
  AO('电子商务', Assets.newIcon.icDzsw.path,
      () => Get.to(() => ElectronicCommercPage())),
  AO('服务浏览', Assets.newIcon.icFwll.path,
      () => Get.to(() => ServiceBrowsePage())),
  AO('社区介绍', Assets.newIcon.icSqjs.path,
      () => Get.to(() => CommunityIntroducePage())),
  // AO('家政服务', R.ASSETS_ICONS_FUNC_JZFW_PNG, () => HouseKeepingPage()),

  AO('地理信息', Assets.newIcon.icDlxx.path,
      () => Get.to(() => GeographicInformationPage())),
  AO('周边企业', Assets.newIcon.icZbqy.path,
      () => Get.to(() => SurroundingEnterprisesPage())),
  AO('住房说明', Assets.newIcon.icRwsm.path,
      () => Get.to(() => HouseIntroducePage())),
  AO('智慧养老', Assets.home.icZhyl.path,
      () => Get.to(() => OldAgeSupportPageSimple())),
  AO('周边服务', Assets.home.icZbfw.path, null),
  AO('任务发布', Assets.home.icRwfb.path, () => Get.to(() => TaskPage())),
  AO('自营商城', Assets.icons.shoppingMall.path, null),
  AO('邻家宠物', Assets.home.icLjcw.path, null),
  AO('共享停车', Assets.icons.sharePark.path, null),
  AO('二手市场', Assets.icons.secondHandMarket.path, null),
  AO('共享投屏', Assets.icons.projectionScreen.path, null),
  AO('全部应用', Assets.home.icQbyy.path, () => Get.to(() => AllApplicationPage())),

  // AO(
  //   '小区教育',
  //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
  //   () => BeeScaffold(title: '小区教育'),
  // ),
  // AO(
  //   '健康运动',
  //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
  //   () => BeeScaffold(title: '健康运动'),
  // ),
  // AO(
  //   '家政服务',
  //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
  //   () => BeeScaffold(title: '家政服务'),
  // ),
  // AO(
  //   '居家养老',
  //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
  //   () => BeeScaffold(title: '居家养老'),
  // ),
  // AO(
  //   '物业租赁',
  //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
  //   () => BeeScaffold(title: '物业租赁'),
  // ),
];

List<AO> userAppObjects = [
  AO(
      '我的房屋',
      R.ASSETS_ICONS_USER_ICON_WDFW_PNG,
      () => HouseOwnersPage(
            identify: 4,
          )),
  AO('我的车位', R.ASSETS_ICONS_USER_ICON_WDCW_PNG, () => CarParkingPage()),
  AO('我的车', R.ASSETS_ICONS_USER_ICON_WDC_PNG, () => CarManagePage()),
  AO('社区活动', R.ASSETS_ICONS_USER_ICON_WDSQHD_PNG, () => ActivityListPage()),
  // AO('我的缴费', R.ASSETS_ICONS_USER_ICON_WDJF_PNG, () => LifePayPage()),
  // AO('我的报修', R.ASSETS_ICONS_USER_ICON_WDBX_PNG, () => FixedSubmitPage()),
  // AO('我的地址', R.ASSETS_ICONS_USER_ICON_WDDZ_PNG, () => Scaffold()),
  // AO('我的管家', R.ASSETS_ICONS_USER_ICON_WDGJ_PNG, () => Scaffold()),
  AO('我的访客', R.ASSETS_ICONS_USER_ICON_WDFK_PNG, () => VisitorAccessPage()),
  AO('设置', R.ASSETS_ICONS_USER_ICON_SZ_PNG, () => SettingsPage()),
];

///全部应用按钮
AO allApp =
    AO('全部应用', R.ASSETS_APPLICATIONS_ALL_APP_PNG, () => AllApplicationPage());

///暂未上线 original value
List<String> _recommendApp = [
  '业委会',
  '便民电话',
  '活动投票',
  '物品出门',
  '投诉表扬',
  '问卷调查',
  '借还管理',
  '设施预约',
  '电子商务',
  '服务浏览',
  '社区介绍',
  '地理信息',
  '周边企业',
  '住房说明',
  '智慧养老',
  '周边服务',
  '自营商城',
  '邻家宠物',
  '共享停车',
  '二手市场',
  '共享投屏',
];

///暂未上线
List<AO> get recommendApp => _recommendApp.map((e) => AO.fromRaw(e)).toList();

///智慧管家 original value
List<String> _smartManagerApp = [
  '开门码',
  '报事报修',
  '生活缴费',
  '任务发布',
];

///智慧管家
List<AO> get smartManagerApp =>
    _smartManagerApp.map((e) => AO.fromRaw(e)).toList();

///出行安全
List<String> _getOutApp = [
  // if (false) '一键开门',
  '开门码',
  '访客邀请',
  '物品出门',
  '一键报警',
];

///出行安全
List<AO> get getOutApp => _getOutApp.map((e) => AO.fromRaw(e)).toList();

///物业服务
List<String> _propertyServicesApp = [
  // if (false) '一键开门',
  '报事报修',
  '设施预约',
  '生活缴费',
  '装修管理',
];

///物业服务
List<AO> get propertyServicesApp =>
    _propertyServicesApp.map((e) => AO.fromRaw(e)).toList();

///居民生活
List<String> _residentLifeApp = [
  '便民电话',
  '问卷调查',
  '建议咨询',
  '设施预约',
  '借还管理',
  '业委会',
  '快递包裹',
  '投诉表扬',
  '活动投票',
  '地理信息',
  '周边企业',
];

///居民生活
List<AO> get residentLifeApp =>
    _residentLifeApp.map((e) => AO.fromRaw(e)).toList();

///About community
List<String> _aboutCommunityApp = [
  '服务浏览',
  '社区介绍',
  // '地理信息',
  // '周边企业',
  '住房说明',
  '电子商务',
];

///关于社区
List<AO> get aboutCommunityApp =>
    _aboutCommunityApp.map((e) => AO.fromRaw(e)).toList();

List<String> _wisdomServiceApp = ['智慧养老', '周边服务', '任务发布', '共享投屏'];

List<AO> get wisdomServiceApp =>
    _wisdomServiceApp.map((e) => AO.fromRaw(e)).toList();
List<String> _nearbyShoppingApp = ['自营商城', '邻家宠物', '共享停车', '二手市场'];

List<AO> get nearbyShoppingApp =>
    _nearbyShoppingApp.map((e) => AO.fromRaw(e)).toList();
