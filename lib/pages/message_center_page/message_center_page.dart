import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/pages/message_center_page/announce/announce_view.dart';
import 'package:aku_new_community/pages/message_center_page/reply/replay_view.dart';
import 'package:aku_new_community/pages/message_center_page/thumbs_up/thumbs_up_view.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class MessageCenterPage extends StatefulWidget {
  MessageCenterPage({Key? key}) : super(key: key);

  @override
  _MessageCenterPageState createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage>
    with TickerProviderStateMixin {
  List<EasyRefreshController> _controllers =
      List.generate(2, (index) => EasyRefreshController());
  List<String> _tabs = ['回复我的', '收到的赞', '通知公告'];
  late final TabController _tabController;

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
    for (var item in _controllers) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      bgColor: Colors.white,
      bodyColor: Color(0xFFF9F9F9),
      title: '消息',
      actions: [
        MaterialButton(
          onPressed: () async {
            var res = await NetUtil().get(SAASAPI.message.allRead, params: {
              'type': _tabController.index + 1,
            });
            if (res.success) {
              _controllers[_tabController.index].callRefresh();
              setState(() {});
            } else {
              BotToast.showText(text: res.msg);
            }
          },
          child: '全部已读'.text.size(28.sp).black.make(),
          padding: EdgeInsets.symmetric(horizontal: 32.w),
        ),
      ],
      appBarBottom:
      TabBar(
        controller: _tabController,
        indicatorColor: Color(0xffffc40c),
        tabs: _tabs.map((e) => Tab(text: e)).toList(),
        indicatorPadding: EdgeInsets.only(bottom: 15.w,left: 35.w,right: 35.w),
      ),
      body:
      Padding(
        padding:  EdgeInsets.only(top: 10.w),
        child: TabBarView(
          children: [
            ReplayView(
              controller: _controllers[0],
            ),
            ThumbsUpView(
              controller: _controllers[1],
            ),
            AnnounceView(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
