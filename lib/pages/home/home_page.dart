// Dart imports:

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/const/resource.dart';
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
import 'package:akuCommunity/utils/login_util.dart';
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
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AnimateAppBar(
        scrollController: _scrollController,
        actions: [
          Badge(
            elevation: 0,
            showBadge: appProvider.messageCenterModel.sysCount == 0,
            position: BadgePosition.topEnd(),
            child: ColumnActionButton(
              onPressed: () {
                if (LoginUtil.isNotLogin) return;
                Get.to(() => MessageCenterPage());
              },
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
                    onTap: () => Get.to(() => ActivityListPage()),
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
          ],
        ),
      ),
    );
  }
}
