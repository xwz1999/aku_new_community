import 'package:flutter/material.dart';

import 'package:aku_new_community/pages/personal/wallet/point_record_view.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';
import 'balance_record_view.dart';

class WalletTradeRecordPage extends StatefulWidget {
  const WalletTradeRecordPage({Key? key}) : super(key: key);

  @override
  _WalletTradeRecordPageState createState() => _WalletTradeRecordPageState();
}

class _WalletTradeRecordPageState extends State<WalletTradeRecordPage>
    with SingleTickerProviderStateMixin {
  List<String> _tabs = ['余额账单', '积分账单'];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: BeeTabBar(
        controller: _tabController,
        tabs: _tabs,
        scrollable: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BalanceRecordView(),
          PointRecordView(),
        ],
      ),
    );
  }
}
