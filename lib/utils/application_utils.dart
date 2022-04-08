import 'dart:ui';

import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/community_introduce/community_introduce_page.dart';
import 'package:aku_new_community/pages/convenient_phone/convenient_phone_page.dart';
import 'package:aku_new_community/pages/electronic_commerc/electronic_commerc_page.dart';
import 'package:aku_new_community/pages/event_activity/event_voting_page.dart';
import 'package:aku_new_community/pages/express_packages/express_package_page.dart';
import 'package:aku_new_community/pages/geographic_information/geograhic_information.dart';
import 'package:aku_new_community/pages/goods_deto_page/goods_deto_page.dart';
import 'package:aku_new_community/pages/goods_manage_page/select_borrow_return_page.dart';
import 'package:aku_new_community/pages/house_introduce/house_introduce.dart';
import 'package:aku_new_community/pages/industry_committee/industry_committee_page.dart';
import 'package:aku_new_community/pages/life_pay/life_pay_page_new.dart';
import 'package:aku_new_community/pages/opening_code_page/opening_code_page.dart';
import 'package:aku_new_community/pages/renovation_manage/new_renovation/new_renovation_page.dart';
import 'package:aku_new_community/pages/service_browse/service_browse_page.dart';
import 'package:aku_new_community/pages/services/old_age/old_age_support_page_simple.dart';
import 'package:aku_new_community/pages/surrounding_enterprises/surrounding_enterprises_page.dart';
import 'package:aku_new_community/ui/community/facility/facility_appointment_page.dart';
import 'package:aku_new_community/ui/function_and_service/task/task_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_page.dart';
import 'package:aku_new_community/ui/home/application/all_application.dart';
import 'package:aku_new_community/ui/manager/advice/advice_page.dart';
import 'package:aku_new_community/ui/manager/questionnaire/questionnaire_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class ApplicationUtil {
  ApplicationUtil(this.titles);

  List<String> titles = [];

  List<AppElement> get elements {
    var list = <AppElement>[];
    this.titles.forEach((element) {
      var re = _findByTitle(element);
      if (re != null) {
        list.add(re);
      }
    });
    return list;
  }

  AppElement? _findByTitle(String title) {
    for (var item in allApplications) {
      if (title == item.title) {
        return item;
      } else if (item.nickTitles.contains(title)) {
        return item;
      }
    }
  }

  List<AppElement> get allApplications => [
        AppElement(
            title: '开门码',
            imgPath: Assets.newIcon.icKmm.path,
            onTap: () => Get.to(() => OpeningCodePage())),
        // AppElement('访客邀请', R.ASSETS_ICONS_FUNC_FKYQ_PNG, () => Get.to(()=>VisitorAccessPage()),
        AppElement(
            title: '报事报修',
            imgPath: Assets.home.icBsbx.path,
            onTap: () => Get.to(() => WorkOrderPage())),
        AppElement(
            title: '生活缴费',
            imgPath: Assets.home.icShjf.path,
            onTap: () => Get.to(() => LifePayPageNew())),
        AppElement(
            title: '业委会',
            imgPath: Assets.newIcon.icYwh.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
              Get.to(() => IndustryCommitteePage());
            }),
        // AppElement('建议咨询', R.ASSETS_ICONS_FUNC_JYZX_PNG,
        //     () => AdvicePage(type: AdviceType.SUGGESTION)),
        AppElement(
            title: '便民电话',
            imgPath: Assets.newIcon.imgBmdh.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
              Get.to(() => ConvenientPhonePage());
            }),
        AppElement(
            title: '活动投票',
            imgPath: Assets.newIcon.icHdtp.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
              Get.to(() => EventVotingPage());
            }),
        AppElement(
            title: '物品出门',
            imgPath: Assets.newIcon.imgWpcm.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
              Get.to(() => GoodsDetoPage());
            }),
        AppElement(
            title: '投诉表扬',
            imgPath: Assets.newIcon.icTsby.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
              Get.to(() => AdvicePage(type: AdviceType.COMPLAIN));
            }),
        AppElement(
            title: '问卷调查',
            imgPath: Assets.newIcon.icWjdc.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
              Get.to(() => QuestionnairePage());
            }),
        AppElement(
            title: '装修管理',
            imgPath: Assets.newIcon.imgZxgl.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => NewRenovationPage());
            }),
        AppElement(
            title: '借还管理',
            imgPath: Assets.newIcon.icJhgl.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
              Get.to(SelectBorrowReturnPage());
            }),
        // AppElement('一键报警', Assets.newIcon.yj, () => AlarmPage()),
        AppElement(
            title: '设施预约',
            imgPath: Assets.home.icSsyy.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => FacilityAppointmentPage());
            }),
        AppElement(
            title: '快递包裹',
            imgPath: Assets.newIcon.icKdbg.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => ExpressPackagePage());
            }),
        AppElement(
            title: '电子商务',
            imgPath: Assets.newIcon.icDzsw.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => ElectronicCommercPage());
            }),
        AppElement(
            title: '服务浏览',
            imgPath: Assets.newIcon.icFwll.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => ServiceBrowsePage());
            }),
        AppElement(
            title: '社区介绍',
            imgPath: Assets.newIcon.icSqjs.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => CommunityIntroducePage());
            }),
        // AppElement('家政服务', R.ASSETS_ICONS_FUNC_JZFW_PNG, () => HouseKeepingPage()),

        AppElement(
            title: '地理信息',
            imgPath: Assets.newIcon.icDlxx.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => GeographicInformationPage());
            }),
        AppElement(
            title: '周边企业',
            imgPath: Assets.newIcon.icZbqy.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => SurroundingEnterprisesPage());
            }),
        AppElement(
            title: '住房说明',
            imgPath: Assets.newIcon.icRwsm.path,
            onTap: () {
              BotToast.showText(text: '此功能升级中，敬请期待');
              return;
              Get.to(() => HouseIntroducePage());
            }),
        AppElement(
            title: '智慧养老',
            imgPath: Assets.home.icZhyl.path,
            onTap: () {
              Get.to(() => OldAgeSupportPageSimple());
            }),
        AppElement(
            title: '周边服务',
            imgPath: Assets.home.icZbfw.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
            }),
        AppElement(
            title: '任务发布',
            imgPath: Assets.home.icRwfb.path,
            onTap: () => Get.to(() => TaskPage()),
            nickTitles: ['小蜜蜂任务']),
        AppElement(
            title: '自营商城',
            imgPath: Assets.icons.shoppingMall.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
            }),
        AppElement(
            title: '邻家宠物',
            imgPath: Assets.home.icLjcw.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
            }),
        AppElement(
            title: '共享停车',
            imgPath: Assets.icons.sharePark.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
            }),
        AppElement(
            title: '二手市场',
            imgPath: Assets.icons.secondHandMarket.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
            }),
        AppElement(
            title: '共享投屏',
            imgPath: Assets.icons.projectionScreen.path,
            onTap: () {
              BotToast.showText(text: '此功能暂未上线');
              return;
            }),
        AppElement(
            title: '全部应用',
            imgPath: Assets.home.icQbyy.path,
            onTap: () => Get.to(() => AllApplicationPage())),

        // AppElement(
        //   '小区教育',
        //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
        //   () => BeeScaffold(title: '小区教育'),
        // ),
        // AppElement(
        //   '健康运动',
        //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
        //   () => BeeScaffold(title: '健康运动'),
        // ),
        // AppElement(
        //   '家政服务',
        //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
        //   () => BeeScaffold(title: '家政服务'),
        // ),
        // AppElement(
        //   '居家养老',
        //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
        //   () => BeeScaffold(title: '居家养老'),
        // ),
        // AppElement(
        //   '物业租赁',
        //   R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
        //   () => BeeScaffold(title: '物业租赁'),
        // ),
      ];
}

class AppElement extends Equatable {
  final String title;
  final String imgPath;
  final VoidCallback onTap;
  final List<String> nickTitles;

  const AppElement({
    required this.title,
    required this.imgPath,
    required this.onTap,
    this.nickTitles = const [],
  });

  @override
  List<Object?> get props => [
        title,
        imgPath,
        onTap,
      ];
}
