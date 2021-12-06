import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final int initIndex;

  OrderPage({Key? key, required this.initIndex}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> _tabs = ['全部', '待付款', '待收货', '待评价', '售后'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: widget.initIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '订单',
      appBarBottom: BeeTabBar(controller: _tabController, tabs: _tabs),
    );
  }
}
