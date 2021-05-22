import 'package:aku_community/ui/market/order/my_order_view.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrderPage extends StatefulWidget {
  MyOrderPage({Key? key}) : super(key: key);

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> _tabs = [
    '待发货',
    '已发货',
    '已收货',
    '退换/投诉',
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的订单',
      appBarBottom: PreferredSize(
        preferredSize: Size.fromHeight(88.w),
        child: BeeTabBar(controller: _tabController, tabs: _tabs),
      ),
      body: TabBarView(
          controller: _tabController,
          children: List.generate(
              _tabs.length, (index) => MyOrderView(index: index))),
    );
  }
}
