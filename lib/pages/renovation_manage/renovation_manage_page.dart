import 'package:aku_community/pages/renovation_manage/renovation_manage_view.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/material.dart';

class RenovationManagePage extends StatefulWidget {
  RenovationManagePage({Key? key}) : super(key: key);

  @override
  _RenovationManagePageState createState() => _RenovationManagePageState();
}

class _RenovationManagePageState extends State<RenovationManagePage>
    with TickerProviderStateMixin {
  List<String> _tabs = ['待处理', '处理中', '已完成', '全部'];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '装修管理',
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: _tabs,
        scrollable: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          _tabs.length,
          (index) => RenovationManageView(
            index: index,
          ),
        ),
      ),
    );
  }
}
