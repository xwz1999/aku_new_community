// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/pages/address_page/address_page.dart';
import 'package:akuCommunity/pages/convenient_phone/convenient_phone_page.dart';
import 'package:akuCommunity/pages/event_activity/event_voting_page.dart';
import 'package:akuCommunity/pages/fitup_manage/fitup_manage_page.dart';
import 'package:akuCommunity/pages/goods_deto_page/goods_deto_page.dart';
import 'package:akuCommunity/pages/goods_manage_page/goods_manage_page.dart';
import 'package:akuCommunity/pages/industry_committee/industry_committee_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_page.dart';
import 'package:akuCommunity/pages/mine_car_page/mine_car_page.dart';
import 'package:akuCommunity/pages/mine_house_page/mine_house_page.dart';
import 'package:akuCommunity/pages/one_alarm/widget/alarm_page.dart';
import 'package:akuCommunity/pages/open_door_page/open_door_page.dart';
import 'package:akuCommunity/pages/opening_code_page/opening_code_page.dart';
import 'package:akuCommunity/pages/setting_page/settings_page.dart';
import 'package:akuCommunity/pages/things_page/fixed_submit_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_access_page.dart';
import 'package:akuCommunity/ui/community/activity/activity_list_page.dart';
import 'package:akuCommunity/ui/home/application/all_application.dart';
import 'package:akuCommunity/ui/manager/advice/advice_page.dart';
import 'package:akuCommunity/ui/manager/questionnaire/questionnaire_page.dart';

///应用对象
///Application Object
class AO {
  String title = '';
  String path = '';
  Widget page = Scaffold();

  AO(
    this.title,
    this.path,
    this.page,
  );

  AO.fromRaw(String raw) {
    appObjects.forEach((element) {
      if (element.title == raw) {
        this.title = element.title;
        this.path = element.path;
        this.page = element.page;
      }
    });
  }

  @override
  bool operator ==(Object other) =>
      other is AO && runtimeType == other.runtimeType && title == other.title;

  @override
  int get hashCode => title.hashCode;
}

///所有应用
List<AO> appObjects = [
  AO('一键开门', R.ASSETS_APPLICATIONS_OEPN_DOOR_PNG, OpenDoorPage()),
  AO('开门码', R.ASSETS_APPLICATIONS_DOOR_CODE_PNG, OpeningCodePage()),
  AO('访客邀请', R.ASSETS_APPLICATIONS_VISITOR_INVITE_PNG, VisitorAccessPage()),
  AO('报事报修', R.ASSETS_APPLICATIONS_FIX_PNG, FixedSubmitPage()),
  AO('生活缴费', R.ASSETS_APPLICATIONS_PAYMENT_PNG, LifePayPage()),
  AO('业委会', R.ASSETS_APPLICATIONS_COMMITTEE_PNG, IndustryCommitteePage()),
  AO('建议咨询', R.ASSETS_APPLICATIONS_ADVICE_PNG,
      AdvicePage(type: AdviceType.SUGGESTION)),
  AO('便民电话', R.ASSETS_APPLICATIONS_COMMUNITY_PHONE_PNG, ConvenientPhonePage()),
  AO('活动投票', R.ASSETS_APPLICATIONS_VOTE_PNG, EventVotingPage()),
  AO('物品出门', R.ASSETS_APPLICATIONS_GOODS_OUT_PNG, GoodsDetoPage()),
  AO('投诉表扬', R.ASSETS_APPLICATIONS_COMPLAINT_PNG,
      AdvicePage(type: AdviceType.COMPLAIN)),
  AO('问卷调查', R.ASSETS_APPLICATIONS_QUESTION_PNG, QuestionnairePage()),
  // AO('装修管理', R.ASSETS_APPLICATIONS_DECORATION_PNG, FitupManagePage()),
  AO('借还管理', R.ASSETS_APPLICATIONS_BORROW_PNG, GoodsManagePage()),
  AO('一键报警', R.ASSETS_APPLICATIONS_POLICE_PNG, AlarmPage()),
];

List<AO> userAppObjects = [
  AO('我的房屋', R.ASSETS_ICONS_USER_ICON_WDFW_PNG, MineHousePage()),
  AO('我的车位', R.ASSETS_ICONS_USER_ICON_WDCW_PNG, MineCarPage()),
  AO('我的车', R.ASSETS_ICONS_USER_ICON_WDC_PNG, MineCarPage()),
  AO('社区活动', R.ASSETS_ICONS_USER_ICON_WDSQHD_PNG, ActivityListPage()),
  AO('我的缴费', R.ASSETS_ICONS_USER_ICON_WDJF_PNG, LifePayPage()),
  AO('我的报修', R.ASSETS_ICONS_USER_ICON_WDBX_PNG, FixedSubmitPage()),
  AO('我的地址', R.ASSETS_ICONS_USER_ICON_WDDZ_PNG, AddressPage()),
  AO('我的管家', R.ASSETS_ICONS_USER_ICON_WDGJ_PNG, Scaffold()),
  AO('我的访客', R.ASSETS_ICONS_USER_ICON_WDFK_PNG, VisitorAccessPage()),
  AO('设置', R.ASSETS_ICONS_USER_ICON_SZ_PNG, SettingsPage()),
];

///全部应用按钮
AO allApp = AO('全部应用', R.ASSETS_APPLICATIONS_ALL_APP_PNG, AllApplicationPage());

///为您推荐 original value
List<String> _recommendApp = [
  '一键开门',
  '访客邀请',
  '报事报修',
  '建议咨询',
  '一键报警',
];

///为您推荐
List<AO> get recommendApp => _recommendApp.map((e) => AO.fromRaw(e)).toList();

///智慧管家 original value
List<String> _smartManagerApp = [
  '一键开门',
  '开门码',
  '访客邀请',
  '报事报修',
  '生活缴费',
  '业委会',
  '建议咨询',
  '便民电话',
  '活动投票',
  '物品出门',
  '投诉表扬',
  '问卷调查',
  // '装修管理',
  '借还管理',
  '一键报警',
];

///智慧管家
List<AO> get smartManagerApp =>
    _smartManagerApp.map((e) => AO.fromRaw(e)).toList();
