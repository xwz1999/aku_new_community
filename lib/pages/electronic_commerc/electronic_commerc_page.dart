import 'package:aku_community/pages/electronic_commerc/electronic_commerc_view.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/material.dart';

class ElectronicCommercPage extends StatefulWidget {
  ElectronicCommercPage({Key? key}) : super(key: key);

  @override
  _ElectronicCommercPageState createState() => _ElectronicCommercPageState();
}

class _ElectronicCommercPageState extends State<ElectronicCommercPage>
    with TickerProviderStateMixin {
  List<String> _tabs = [
    '小区教育',
    '健康运动',
    '家政服务',
    '居家养老',
    '装修服务',
    '物业租售',
    '网上商城',
    '代购代送',
    '网上询价',
    '网上采购',
    '商品退换',
    '质量投诉'
  ];
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
      title: '电子商务',
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: _tabs,
        scrollable: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          _tabs.length,
          (index) => ElectronicCommercView(
            index: index,
          ),
        ),
      ),
    );
  }
}
