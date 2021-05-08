import 'package:aku_community/pages/express_packages/express_package_view.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/material.dart';

class ExpressPackagePage extends StatefulWidget {
  ExpressPackagePage({Key? key}) : super(key: key);

  @override
  _ExpressPackagePageState createState() => _ExpressPackagePageState();
}

class _ExpressPackagePageState extends State<ExpressPackagePage>
    with TickerProviderStateMixin {
  List<String> _tabs = ['未领取', '已领取'];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '快递包裹',
      appBarBottom: BeeTabBar(controller: _tabController, tabs: _tabs),
      body: TabBarView(
        controller: _tabController,
        children:List.generate(_tabs.length, (index) => ExpressPackageView(index:index)) ),
    );
  }


}
