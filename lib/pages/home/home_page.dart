// Dart imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:badges/badges.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/extensions/page_router.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';
import 'package:akuCommunity/model/community/activity_item_model.dart';
import 'package:akuCommunity/model/community/board_model.dart';
import 'package:akuCommunity/pages/home/widget/animate_app_bar.dart';
import 'package:akuCommunity/pages/message_center_page/message_center_page.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/ui/community/activity/activity_card.dart';
import 'package:akuCommunity/ui/community/activity/activity_list_page.dart';
import 'package:akuCommunity/ui/community/community_func.dart';
import 'package:akuCommunity/ui/home/home_notification.dart';
import 'package:akuCommunity/ui/home/home_title.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/buttons/column_action_button.dart';
import 'package:akuCommunity/widget/views/application_box.dart';
import 'package:akuCommunity/widget/views/application_view.dart';
import 'widget/home_search.dart';

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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AnimateAppBar(
        scrollController: _scrollController,
        actions: [
         Badge(
           elevation: 0,
           showBadge: appProvider.messageCenterModel.sysCount==0,
           position: BadgePosition.topEnd(),
           child: ColumnActionButton(
              onPressed: MessageCenterPage().to,
              title: '消息',
              path: R.ASSETS_ICONS_ALARM_PNG,
            ),
         )
        ],
      ),
      body: EasyRefresh(
        controller: _refreshController,
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          _activityItemModel = await CommunityFunc.activity();
          _boardItemModels = await CommunityFunc.board();
          appProvider.getMessageCenter();
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
                  // HomeSwiper(),
                  // SizedBox(height: 100.w),
                  ApplicationBox(child: ApplicationView()),
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
