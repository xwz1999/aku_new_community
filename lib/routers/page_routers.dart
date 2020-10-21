import 'package:akuCommunity/pages/setting_page/agreement_page/privacy_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/pages/market/market_detail_page/market_detail_page.dart';
import 'package:akuCommunity/pages/market/market_cart_page/market_cart_page.dart';
import 'package:akuCommunity/pages/goods_details/goods_details_page.dart';
import 'package:akuCommunity/pages//goods_details/view_comments_page.dart';
import 'package:akuCommunity/pages/community/note_create_page.dart';
import 'package:akuCommunity/pages/community/topice_detail_page.dart';
import 'package:akuCommunity/pages/common/common_page.dart';
import 'package:akuCommunity/pages/personal/order_page.dart';
import 'package:akuCommunity/pages/personal/order_details_page.dart';
import 'package:akuCommunity/pages/personal/refund_select_page.dart';
import 'package:akuCommunity/pages/personal/refund_apply_page.dart';
import 'package:akuCommunity/pages/personal/evaluate_good_page.dart';
import 'package:akuCommunity/pages/personal/look_logistics_page.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/pages/sign/user_authentication_page.dart';

import 'package:akuCommunity/pages/confirm_order_page/confirm_order_page.dart';
import 'package:akuCommunity/pages/confirm_order_page/pay_order_page.dart';

import 'package:akuCommunity/pages/scan/scan_page.dart';

import 'package:akuCommunity/pages/message_center_page/message_center_page.dart';
import 'package:akuCommunity/pages/message_center_page/system_message_page/system_message_page.dart';
import 'package:akuCommunity/pages/message_center_page/comment_message_page/comment_message_page.dart';
import 'package:akuCommunity/pages/message_center_page/shop_message_page/shop_message_page.dart';
import 'package:akuCommunity/pages/message_center_page/system_message_page/system_details_page/system_details_page.dart';

import 'package:akuCommunity/pages/open_door_page/open_door_page.dart';
import 'package:akuCommunity/pages/certification_page/certification_page.dart';

import 'package:akuCommunity/pages/visitor_access_page/visitor_access_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_record_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_pass_page.dart';

import 'package:akuCommunity/pages/life_pay/life_pay_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_record_page/life_pay_record_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_bill_page/life_pay_bill_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_info_page/life_pay_info_page.dart';

import 'package:akuCommunity/pages/industry_committee/industry_committee_page.dart';
import 'package:akuCommunity/pages/industry_committee/committee_mailbox/committee_mailbox_page.dart';

import 'package:akuCommunity/pages/convenient_phone/convenient_phone_page.dart';

import 'package:akuCommunity/pages/total_application_page/total_applications_page.dart';

import 'package:akuCommunity/pages/questionnaire_page/questionnaire_page.dart';
import 'package:akuCommunity/pages/questionnaire_page/questionnaire_details_page/questionnaire_details_page.dart';

import 'package:akuCommunity/pages/goods_manage_page/goods_manage_page.dart';
import 'package:akuCommunity/pages/goods_manage_page/mine_goods_page/mine_goods_page.dart';

import 'package:akuCommunity/pages/opening_code_page/opening_code_page.dart';

import 'package:akuCommunity/pages/goods_deto_page/goods_deto_page.dart';
import 'package:akuCommunity/pages/goods_deto_page/deto_code_page/deto_code_page.dart';
import 'package:akuCommunity/pages/goods_deto_page/deto_create_page/deto_create_page.dart';

import 'package:akuCommunity/pages/activities_page/activities_page.dart';
import 'package:akuCommunity/pages/activities_page/activities_details_page/activities_details_page.dart';
import 'package:akuCommunity/pages/activities_page/member_list_page/member_list_page.dart';

import 'package:akuCommunity/pages/notice_page/notice_page.dart';

import 'package:akuCommunity/pages/mine_house_page/mine_house_page.dart';
import 'package:akuCommunity/pages/mine_house_page/house_authenticate_page/house_authenticate_page.dart';

import 'package:akuCommunity/pages/mine_car_page/mine_car_page.dart';
import 'package:akuCommunity/pages/mine_car_page/car_add_page/car_add_page.dart';
import 'package:akuCommunity/pages/mine_car_page/select_community_page/select_community_page.dart';
import 'package:akuCommunity/pages/mine_car_page/select_parking_page/select_parking_page.dart';

import 'package:akuCommunity/pages/market_class/market_class_page.dart';

import 'package:akuCommunity/pages/address_page/address_page.dart';
import 'package:akuCommunity/pages/address_page/address_edit_page.dart';

import 'package:akuCommunity/pages/one_alarm/one_alarm_page.dart';

import 'package:akuCommunity/pages/fitup_manage/fitup_manage_page.dart';

import 'package:akuCommunity/pages/invoice/invoice_page.dart';

import 'package:akuCommunity/pages/setting_page/setting_page.dart';
import 'package:akuCommunity/pages/setting_page/about_page/about_page.dart';
import 'package:akuCommunity/pages/setting_page/feedback_page/feedback_page.dart';
import 'package:akuCommunity/pages/setting_page/invite_page/invite_page.dart';
import 'package:akuCommunity/pages/setting_page/agreement_page/agreement_page.dart';

import 'package:akuCommunity/pages/things_page/things_page.dart';
import 'package:akuCommunity/pages/things_page/things_detail_page/things_detail_page.dart';
import 'package:akuCommunity/pages/things_page/things_create_page/things_create_page.dart';
import 'package:akuCommunity/pages/things_page/things_evaluate_page/things_evaluate_page.dart';

enum PageName {
  market_detail_page,
  market_cart_page,
  goods_details_page,
  view_comments_page,
  invoice_page,
  common_page,
  note_create_page,
  topice_detail_page,
  order_page,
  order_details_page,
  refund_select_page,
  refund_apply_page,
  evaluate_good_page,
  look_logistics_page,
  sign_in_page,
  user_authentication_page,
  confirm_order_page,
  pay_order_page,
  pay_success_page,
  scan_page,
  message_center_page,
  system_message_page,
  comment_message_page,
  shop_message_page,
  system_details_page,
  open_door_page,
  certification_page,
  visitor_access_page,
  visitor_record_page,
  visitor_pass_page,
  life_pay_page,
  life_pay_record_page,
  life_pay_bill_page,
  life_pay_info_page,
  industry_committee_page,
  committee_mailbox_page,
  convenient_phone_page,
  total_applications_page,
  questionnaire_page,
  questionnaire_details_page,
  goods_manage_page,
  mine_goods_page,
  opening_code_page,
  goods_deto_page,
  deto_code_page,
  deto_create_page,
  activities_page,
  activities_details_page,
  member_list_page,
  notice_page,
  mine_house_page,
  house_authenticate_page,
  mine_car_page,
  car_add_page,
  select_community_page,
  select_parking_page,
  market_class_page,
  address_page,
  address_edit_page,
  one_alarm_page,
  fitup_manage_page,
  setting_page,
  about_page,
  feedback_page,
  invite_page,
  things_page,
  things_detail_page,
  things_create_page,
  things_evaluate_page,
  agreement_page,
  privacy_page,
}

class Bundle {
  Map<String, dynamic> _map = {};

  _setValue(var k, var v) => _map[k] = v;

  _getValue(String k) {
    if (!_map.containsKey(k)) {
      throw Exception("你使用的${k}在payload不存在,请检查你的key名字是否正确,或者确定key是否存在payload");
    }
    return _map[k];
  }

  putInt(String k, int v) => _map[k] = v;

  putString(String k, String v) => _setValue(k, v);

  putBool(String k, bool v) => _setValue(k, v);

  putList<V>(String k, List<V> v) => _setValue(k, v);

  putMap<K, V>(String k, Map<K, V> v) => _setValue(k, v);

  int getInt(String k) => _getValue(k) as int;

  String getString(String k) => _getValue(k) as String;

  bool getBool(String k) => _getValue(k) as bool;

  List getList(String k) => _getValue(k) as List;

  Map getMap(String k) => _getValue(k) as Map;

  @override
  String toString() {
    return _map.toString();
  }
}

typedef Widget HandlerFunc(
    BuildContext context, Map<String, List<String>> params);

typedef Widget PageBuilderFunc(Bundle bundle);

class PageBuilder {
  final PageBuilderFunc builder;
  HandlerFunc handlerFunc;
  PageBuilder({this.builder}) {
    this.handlerFunc = (context, _) {
      return this.builder(ModalRoute.of(context).settings.arguments as Bundle);
    };
  }
  Handler getHandler() {
    return Handler(handlerFunc: this.handlerFunc);
  }
}

final Map<PageName, PageBuilder> pageRoutes = {
  PageName.market_detail_page:
      PageBuilder(builder: (bundle) => MarketDetailPage(bundle: bundle)),
  PageName.market_cart_page:
      PageBuilder(builder: (bundle) => MarketCartPage()),
  PageName.goods_details_page:
      PageBuilder(builder: (bundle) => GoodsDetailsPage(bundle: bundle)),
  PageName.view_comments_page:
      PageBuilder(builder: (bundle) => ViewCommentsPage()),
  PageName.invoice_page:
      PageBuilder(builder: (bundle) => InvoicePage(bundle: bundle)),
  PageName.note_create_page:
      PageBuilder(builder: (bundle) => NoteCreatePage()),
  PageName.topice_detail_page:
      PageBuilder(builder: (bundle) => TopiceDetailPage(bundle: bundle)),
  PageName.order_page:
      PageBuilder(builder: (bundle) => OrderPage(bundle: bundle)),
  PageName.order_details_page:
      PageBuilder(builder: (bundle) => OrderDetailsPage(bundle: bundle)),
  PageName.refund_select_page:
      PageBuilder(builder: (bundle) => RefundSelectPage(bundle: bundle)),
  PageName.refund_apply_page:
      PageBuilder(builder: (bundle) => RefundApplyPage(bundle: bundle)),
  PageName.evaluate_good_page:
      PageBuilder(builder: (bundle) => EvaluateGoodPage(bundle: bundle)),
  PageName.look_logistics_page:
      PageBuilder(builder: (bundle) => LookLogisticsPage()),
   PageName.sign_in_page:
      PageBuilder(builder: (bundle) => SignInPage()),
  PageName.user_authentication_page:
      PageBuilder(builder: (bundle) => UserAuthenticationPage()),
  PageName.common_page:
      PageBuilder(builder: (bundle) => CommonPage(bundle: bundle)),
  PageName.privacy_page:
  PageBuilder(builder:(bundle)=>PrivacyPage()),

  PageName.confirm_order_page:
      PageBuilder(builder: (bundle) => ConfirmOrderPage(bundle: bundle)),
  PageName.pay_order_page:
      PageBuilder(builder: (bundle) => PayOrderPage(bundle: bundle)),
  PageName.scan_page:
      PageBuilder(builder: (bundle) => ScanPage()),
  PageName.message_center_page:
      PageBuilder(builder: (bundle) => MessageCenterPage()),
  PageName.system_message_page:
      PageBuilder(builder: (bundle) => SystemMessagePage()),
  PageName.comment_message_page:
      PageBuilder(builder: (bundle) => CommentMessagePage()),
  PageName.shop_message_page:
      PageBuilder(builder: (bundle) => ShopMessagePage()),
  PageName.system_details_page:
      PageBuilder(builder: (bundle) => SystemDetailsPage(bundle: bundle)),
  PageName.open_door_page:
      PageBuilder(builder: (bundle) => OpenDoorPage()),
  PageName.certification_page:
      PageBuilder(builder: (bundle) => CertificationPage()),
  PageName.visitor_access_page:
      PageBuilder(builder: (bundle) => VisitorAccessPage()),
  PageName.visitor_record_page:
      PageBuilder(builder: (bundle) => VisitorRecordPage()),
  PageName.visitor_pass_page:
      PageBuilder(builder: (bundle) => VisitorPassPage()),
  PageName.life_pay_page:
      PageBuilder(builder: (bundle) => LifePayPage()),
  PageName.life_pay_record_page:
      PageBuilder(builder: (bundle) => LifePayRecordPage()),
  PageName.life_pay_bill_page:
      PageBuilder(builder: (bundle) => LifePayBillPage()),
  PageName.life_pay_info_page:
      PageBuilder(builder: (bundle) => LifePayInfoPage(bundle: bundle)),
  PageName.industry_committee_page:
      PageBuilder(builder: (bundle) => IndustryCommitteePage()),
  PageName.committee_mailbox_page:
      PageBuilder(builder: (bundle) => CommitteeMailboxPage()),
  PageName.convenient_phone_page:
      PageBuilder(builder: (bundle) => ConvenientPhonePage()),
  PageName.total_applications_page:
      PageBuilder(builder: (bundle) => TotalApplicationsPage()),
  PageName.questionnaire_page:
      PageBuilder(builder: (bundle) => QuestionnairePage()),
  PageName.questionnaire_details_page:
      PageBuilder(builder: (bundle) => QuestionnaireDetailsPage(bundle: bundle)),
  PageName.goods_manage_page:
      PageBuilder(builder: (bundle) => GoodsManagePage()),
  PageName.mine_goods_page:
      PageBuilder(builder: (bundle) => MineGoodsPage()),
  PageName.opening_code_page:
      PageBuilder(builder: (bundle) => OpeningCodePage()),
  PageName.goods_deto_page:
      PageBuilder(builder: (bundle) => GoodsDetoPage()),
  PageName.deto_code_page:
      PageBuilder(builder: (bundle) => DetoCodePage()),
  PageName.deto_create_page:
      PageBuilder(builder: (bundle) => DetoCreatePage()),
  PageName.activities_page:
      PageBuilder(builder: (bundle) => ActivitiesPage(bundle: bundle)),
  PageName.activities_details_page:
      PageBuilder(builder: (bundle) => ActivitiesDetailsPage(bundle: bundle)),
  PageName.member_list_page:
      PageBuilder(builder: (bundle) => MemberListPage()),
  PageName.notice_page:
      PageBuilder(builder: (bundle) => NoticePage(bundle: bundle)),
  PageName.mine_house_page:
      PageBuilder(builder: (bundle) => MineHousePage()),
  PageName.house_authenticate_page:
      PageBuilder(builder: (bundle) => HouseAuthenticatePage()),
  PageName.mine_car_page:
      PageBuilder(builder: (bundle) => MineCarPage(bundle: bundle)),
  PageName.car_add_page:
      PageBuilder(builder: (bundle) => CarAddPage()),
  PageName.select_community_page:
      PageBuilder(builder: (bundle) => SelectCommunityPage()),
  PageName.select_parking_page:
      PageBuilder(builder: (bundle) => SelectParkingPage(bundle: bundle)),
  PageName.market_class_page:
      PageBuilder(builder: (bundle) => MarketClassPage()),
  PageName.address_page:
      PageBuilder(builder: (bundle) => AddressPage()),
  PageName.address_edit_page:
      PageBuilder(builder: (bundle) => AddressEditPage(bundle: bundle)),
  PageName.one_alarm_page:
      PageBuilder(builder: (bundle) => OneAlarmPage()),
  PageName.fitup_manage_page:
      PageBuilder(builder: (bundle) => FitupManagePage()),
  PageName.setting_page:
      PageBuilder(builder: (bundle) => SettingPage()),
  PageName.about_page:
      PageBuilder(builder: (bundle) => AboutPage()),
  PageName.invite_page:
      PageBuilder(builder: (bundle) => InvitePage()),
  PageName.feedback_page:
      PageBuilder(builder: (bundle) => FeedBackPage()),
  PageName.agreement_page:
      PageBuilder(builder: (bundle) => AgreementPage()),
  PageName.things_page:
      PageBuilder(builder: (bundle) => ThingsPage(bundle: bundle)),
  PageName.things_detail_page:
      PageBuilder(builder: (bundle) => ThingsDetailPage(bundle: bundle)),
  PageName.things_create_page:
      PageBuilder(builder: (bundle) => ThingsCreatePage(bundle: bundle)),
  PageName.things_evaluate_page:
      PageBuilder(builder: (bundle) => ThingsEvaluatePage(bundle: bundle)),
};
