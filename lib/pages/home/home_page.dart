// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:akuCommunity/model/community/board_model.dart';
import 'package:akuCommunity/ui/home/application/all_application.dart';
import 'package:akuCommunity/widget/views/application_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:akuCommunity/extensions/page_router.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';
import 'package:akuCommunity/model/community/activity_item_model.dart';
import 'package:akuCommunity/pages/convenient_phone/convenient_phone_page.dart';
import 'package:akuCommunity/pages/home/widget/animate_app_bar.dart';
import 'package:akuCommunity/pages/industry_committee/industry_committee_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_page.dart';
import 'package:akuCommunity/pages/message_center_page/message_center_page.dart';
import 'package:akuCommunity/pages/open_door_page/open_door_page.dart';
import 'package:akuCommunity/pages/things_page/fixed_submit_page.dart';
import 'package:akuCommunity/pages/total_application_page/total_applications_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_access_page.dart';
import 'package:akuCommunity/service/base_model.dart';
import 'package:akuCommunity/ui/community/activity/activity_card.dart';
import 'package:akuCommunity/ui/community/activity/activity_list_page.dart';
import 'package:akuCommunity/ui/community/community_func.dart';
import 'package:akuCommunity/ui/home/home_notification.dart';
import 'package:akuCommunity/ui/home/home_title.dart';
import 'package:akuCommunity/ui/manager/advice/advice_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/container_comment.dart';
import 'package:akuCommunity/widget/grid_buttons.dart';
import 'widget/home_search.dart';
import 'widget/home_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController;

  List<AkuShopModel> _shopList = [];
  List<dynamic> data;

  EasyRefreshController _refreshController = EasyRefreshController();

  int page = 1;

  ActivityItemModel _activityItemModel;
  List<BoardItemModel> _boardItemModels = [];

  List<GridButton> _gridList = [
    GridButton('一键开门', R.ASSETS_ICONS_TOOL_YJKM_PNG, OpenDoorPage().to),
    GridButton('访客通行', R.ASSETS_ICONS_TOOL_FKYQ_PNG, VisitorAccessPage().to),
    GridButton('报事报修', R.ASSETS_ICONS_TOOL_BSBX_PNG, FixedSubmitPage().to),
    GridButton('生活缴费', R.ASSETS_ICONS_TOOL_SHJF_PNG, LifePayPage().to),
    GridButton('业委会', R.ASSETS_ICONS_TOOL_YWH_PNG, IndustryCommitteePage().to),
    GridButton('建议咨询', R.ASSETS_ICONS_TOOL_JYTS_PNG,
        AdvicePage(type: AdviceType.SUGGESTION).to),
    GridButton('便民电话', R.ASSETS_ICONS_TOOL_BMDH_PNG, ConvenientPhonePage().to),
    GridButton('全部应用', R.ASSETS_ICONS_TOOL_QBYY_PNG, AllApplicationPage().to),
  ];

  @override
  void initState() {
    super.initState();
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("assets/json/shop.json");
    loadString.then((String value) {
      // 通知框架此对象的内部状态已更改
      akuShop(value);
    });
    // akuShop(page);
    _scrollController = ScrollController();
  }

  Future<void> akuShop(String response) async {
    Map<String, dynamic> result = json.decode(response.toString());
    BaseModel model = BaseModel.fromJson(result);
    model.result.forEach((item) {
      item["count"] = 1;
      item["isCheck"] = false;
      AkuShopModel list = AkuShopModel.fromJson(item);
      setState(() {
        _shopList.add(list);
      });
    });
  }

  _buildColButton({IconData icon, String title, VoidCallback onTap}) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: 0,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48.w, color: Colors.black),
          4.hb,
          title.text.size(20.sp).black.make(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AnimateAppBar(
        scrollController: _scrollController,
        actions: [
          _buildColButton(
            icon: AntDesign.bells,
            title: '消息',
            onTap: MessageCenterPage().to,
          ),
          16.wb,
        ],
      ),
      body: EasyRefresh(
        controller: _refreshController,
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          _activityItemModel = await CommunityFunc.activity();
          _boardItemModels = await CommunityFunc.board();
          setState(() {});
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomeSearch(),
                  HomeSwiper(),
                  SizedBox(height: 100.w),
                  ContainerComment(
                    radius: 8,
                    customWidget: ApplicationView(),
                  ),
                  ContainerComment(
                    radius: 8,
                    customWidget: GridButtons(
                      gridList: _gridList,
                      crossCount: 4,
                    ),
                  ),
                  // SingleAdSpace(
                  //   imagePath: R.ASSETS_EXAMPLE_GUANGGAO2_PNG,
                  // ),
                  // Column(
                  //   children: [
                  //     HomeTagBar(
                  //       title: '社区团购',
                  //       tag: '团购',
                  //       isShowImage: false,
                  //     ),
                  //     HomeCard(
                  //       isActivity: false,
                  //       title: '新疆库尔阿勒4.5斤,仙人蕉 香甜可口',
                  //       subtitleOne: '中国新疆',
                  //       subtitleTwo: '2020年07月03日',
                  //       imagePath:
                  //           'http://news.eastday.com/d/file/tga/2013-02-17/c2e7bd7fca1ed2ecf5d50dc9fb30275d.jpg',
                  //     ),
                  //     HomeCard(
                  //       isActivity: false,
                  //       title: '刚果柠檬大果4盒 鲜果新鲜采摘15斤',
                  //       subtitleOne: '非洲刚果',
                  //       subtitleTwo: '2020年08月09日',
                  //       imagePath:
                  //           'http://5b0988e595225.cdn.sohucs.com/images/20180203/328e145f84c54dd08d1b11b890109862.jpeg',
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 30.w),
                  // HomeTagBar(
                  //   title: '社区商城',
                  //   tag: '团购',
                  //   isShowImage: false,
                  //   isShowTitle: true,
                  // ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  HomeNotification(items: _boardItemModels),
                  HomeTitle(
                    title: '社区活动',
                    suffixTitle: '更多活动',
                    onTap: ActivityListPage().to,
                  ),
                  _activityItemModel == null
                      ? SizedBox()
                      : ActivityCard(model: _activityItemModel)
                          .pSymmetric(h: 24.w, v: 24.w),
                ],
              )
                  .box
                  .white
                  .withRounded(value: 8.w)
                  .clip(Clip.antiAlias)
                  .margin(EdgeInsets.symmetric(horizontal: 32.w))
                  .make(),
            ),
            // SliverPadding(
            //     padding: EdgeInsets.only(
            //       top: 30.w,
            //       left: 32.w,
            //       right: 32.w,
            //     ),
            //     sliver: _shopList.length == 0
            //         ? SliverToBoxAdapter(child: GoodsCardSkeleton())
            //         : SliverGoodsCard(shoplist: _shopList)),
          ],
        ),
      ),
    );
  }
}
