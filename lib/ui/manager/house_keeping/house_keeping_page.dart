import 'package:aku_new_community/ui/manager/house_keeping/add_house_keeping_page.dart';
import 'package:aku_new_community/ui/manager/house_keeping/house_keeping_view.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/utils/websocket/tips_dialog.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HouseKeepingPage extends StatefulWidget {
  HouseKeepingPage({Key? key}) : super(key: key);

  @override
  _HouseKeepingPageState createState() => _HouseKeepingPageState();
}

class _HouseKeepingPageState extends State<HouseKeepingPage>
    with TickerProviderStateMixin {
  List<String> _tabs = ['全部', '待派单', '已派单', '处理中', '待支付', '待评价', '已完成'];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () async {
      var agreement = await HiveStore.appBox?.get('HouseKeepingPage') ?? false;
      if (!agreement) {
        await TipsDialog.tipsDialog();
        HiveStore.appBox!.put('HouseKeepingPage', true);
      }
    });
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '家政服务',
      appBarBottom: BeeTabBar(
        controller: _controller,
        tabs: _tabs,
        scrollable: true,
      ),
      body: TabBarView(
        controller: _controller,
        children: List.generate(
          _tabs.length,
          (index) => HouseKeepingView(
            index: index,
          ),
        ),
      ),
      bottomNavi: BottomButton(
          onPressed: () {
            Get.to(() => AddHouseKeepingPage());
          },
          child: '新增'.text.size(32.sp).bold.black.make()),
    );
  }
}
