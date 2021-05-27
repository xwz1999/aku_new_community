import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aku_community/ui/market/order/my_order_view.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';

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
    '已到货',
    '已收货',
    '已评价',
    '退换货申请',
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

  int _transIndes(int index) {
    switch (index) {
      case 0:
        return 1;
      case 1:
        return 2;
      case 2:
        return 3;
      case 3:
        return 4;
      case 4:
        return 6;
      case 5:
        return 8;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的订单',
      appBarBottom: PreferredSize(
        preferredSize: Size.fromHeight(88.w),
        child: BeeTabBar(
            scrollable: true, controller: _tabController, tabs: _tabs),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          _tabs.length,
          (index) => MyOrderView(
            index: _transIndes(index),
          ),
        ),
      ),
    );
  }
}
