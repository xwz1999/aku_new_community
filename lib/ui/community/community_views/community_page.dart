// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:akuCommunity/ui/community/community_views/add_new_event_page.dart';
import 'package:akuCommunity/ui/community/community_views/my_community_view.dart';
import 'package:akuCommunity/ui/community/community_views/new_community_view.dart';
import 'package:akuCommunity/ui/community/community_views/topic/topic_community_view.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/column_action_button.dart';
import 'package:akuCommunity/widget/tab_bar/bee_tab_bar.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List<String> _tabs = ['最新', '话题', '我的'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeScaffold(
      title: '社区',
      actions: [
        ColumnActionButton(
          onPressed: () {},
          title: '消息',
          path: R.ASSETS_ICONS_ALARM_PNG,
        ),
      ],
      fab: FloatingActionButton(
        onPressed: () => Get.to(AddNewEventPage()),
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
        children: [
          NewCommunityView(),
          TopicCommunityView(),
          MyCommunityView(),
        ],
        controller: _tabController,
      ),
      bodyColor: Colors.white,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
