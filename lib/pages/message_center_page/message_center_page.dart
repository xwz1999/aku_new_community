import 'package:aku_new_community/pages/message_center_page/announce/announce_view.dart';
import 'package:aku_new_community/pages/message_center_page/reply/replay_view.dart';
import 'package:aku_new_community/pages/message_center_page/thumbs_up/thumbs_up_view.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/all_select_button.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MessageCenterPage extends StatefulWidget {
  MessageCenterPage({Key? key}) : super(key: key);

  @override
  _MessageCenterPageState createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage>
    with TickerProviderStateMixin {
  EasyRefreshController _refreshController = EasyRefreshController();
  List<String> _tabs = ['回复我的', '收到的赞', '通知公告'];
  late final TabController _tabController;
  bool inEdit = false;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '消息',
      actions: [
        // MaterialButton(
        //   onPressed: () async {
        //     setState(() {});
        //   },
        //   child: '${inEdit ? '取消' : '编辑'}'.text.size(28.sp).black.make(),
        //   padding: EdgeInsets.symmetric(horizontal: 32.w),
        // ),
      ],
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: _tabs,
      ),
      body: TabBarView(
        children: [
          ReplayView(),
          ThumbsUpView(),
          AnnounceView(),
        ],
        controller: _tabController,
      ),
      bottomNavi: Offstage(
          offstage: !inEdit,
          child: AllSelectButton(
            onPressed: () {},
            selected: true,
          )),
    );
  }
}
