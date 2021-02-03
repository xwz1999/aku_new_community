import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/pages/convenient_phone/convenient_phone_page.dart';
import 'package:akuCommunity/pages/fitup_manage/fitup_manage_page.dart';
import 'package:akuCommunity/pages/goods_deto_page/goods_deto_page.dart';
import 'package:akuCommunity/pages/goods_manage_page/goods_manage_page.dart';
import 'package:akuCommunity/pages/industry_committee/industry_committee_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_page.dart';
import 'package:akuCommunity/pages/open_door_page/open_door_page.dart';
import 'package:akuCommunity/pages/opening_code_page/opening_code_page.dart';
import 'package:akuCommunity/pages/questionnaire_page/questionnaire_details_page/questionnaire_details_page.dart';
import 'package:akuCommunity/pages/things_page/fixed_submit_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_access_page.dart';
import 'package:akuCommunity/ui/home/application/all_application.dart';
import 'package:akuCommunity/ui/manager/advice/advice_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      identical(this, other) ||
      other is AO && runtimeType == other.runtimeType && title == other.title;

  @override
  int get hashCode => title.hashCode;
}

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
  AO('活动投票', R.ASSETS_APPLICATIONS_VOTE_PNG, SizedBox()),
  AO('物品出门', R.ASSETS_APPLICATIONS_GOODS_OUT_PNG, GoodsDetoPage()),
  AO('投诉表扬', R.ASSETS_APPLICATIONS_COMPLAINT_PNG,
      AdvicePage(type: AdviceType.COMPLAIN)),
  AO('问卷调查', R.ASSETS_APPLICATIONS_QUESTION_PNG, QuestionnaireDetailsPage()),
  AO('装修管理', R.ASSETS_APPLICATIONS_DECORATION_PNG, FitupManagePage()),
  AO('借还管理', R.ASSETS_APPLICATIONS_BORROW_PNG, GoodsManagePage()),
];

AO allApp = AO('全部应用', R.ASSETS_APPLICATIONS_ALL_APP_PNG, AllApplicationPage());
