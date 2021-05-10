import 'package:aku_community/provider/app_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/pages/message_center_page/message_center_page.dart';
import 'package:aku_community/provider/user_provider.dart';
import 'package:aku_community/ui/community/community_views/add_new_event_page.dart';
import 'package:aku_community/ui/community/community_views/my_community_view.dart';
import 'package:aku_community/ui/community/community_views/new_community_view.dart';
import 'package:aku_community/ui/community/community_views/topic/topic_community_view.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/login_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/column_action_button.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  List<String> _tabs = [];
  GlobalKey<TopicCommunityViewState> topicKey =
      GlobalKey<TopicCommunityViewState>();
  GlobalKey<MyCommunityViewState> myKey = GlobalKey<MyCommunityViewState>();
  GlobalKey<NewCommunityViewState> newKey = GlobalKey<NewCommunityViewState>();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.isLogin) _tabs = ['最新', '话题', '我的'];
    if (userProvider.isNotLogin) _tabs = ['最新', '话题'];
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '社区',
      actions: [
        Badge(
          elevation: 0,
          showBadge: appProvider.messageCenterModel.commentCount != 0 ||
              appProvider.messageCenterModel.sysCount != 0,
          position: BadgePosition.topEnd(
            top: 8,
            end: 8,
          ),
          child: ColumnActionButton(
            onPressed: () {
              if (LoginUtil.isNotLogin) return;
              Get.to(() => MessageCenterPage());
            },
            title: '消息',
            path: R.ASSETS_ICONS_ALARM_PNG,
          ),
        ),
      ],
      fab: FloatingActionButton(
        onPressed: () async {
          if (LoginUtil.isNotLogin) return;
          bool? result = await Get.to(() => AddNewEventPage());
          if (result == true) {
            switch (_tabController!.index) {
              case 0:
                newKey.currentState!.refresh();
                break;
              case 1:
                topicKey.currentState!.refresh();
                break;
              case 2:
                myKey.currentState!.refresh();
                break;
            }
          }
        },
        heroTag: 'event_add',
        child: Icon(Icons.add),
      ),
      appBarBottom: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: Align(
          alignment: Alignment.centerLeft,
          child: BeeTabBar(
            controller: _tabController,
            tabs: _tabs,
            scrollable: true,
          ),
        ),
      ),
      body: TabBarView(
        children: userProvider.isLogin
            ? [
                NewCommunityView(key: newKey),
                TopicCommunityView(key: topicKey),
                MyCommunityView(key: myKey),
              ]
            : [
                NewCommunityView(key: newKey),
                TopicCommunityView(key: topicKey),
              ],
        controller: _tabController,
      ),
      bodyColor: Colors.white,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
