import 'package:aku_new_community/ui/function_and_service/work_order/publish_work_order_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_card.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class WorkOrderPage extends StatefulWidget {
  const WorkOrderPage({Key? key}) : super(key: key);

  @override
  _WorkOrderPageState createState() => _WorkOrderPageState();
}

class _WorkOrderPageState extends State<WorkOrderPage>
    with SingleTickerProviderStateMixin {
  List<String> _tabs = ['全部', '待分配', '已接单', '处理中', '待确认'];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '报事报修',
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => PublishWorkOrderPage());
            },
            icon: Icon(
              CupertinoIcons.plus_circle,
              size: 40.w,
            ))
      ],
      appBarBottom: BeeTabBar(
        tabs: _tabs,
        controller: _tabController,
      ),
      body: TabBarView(
          controller: _tabController,
          children:
              _tabs.mapIndexed((e, index) => _getOrderView(index)).toList()),
    );
  }

  Widget _getOrderView(int index) {
    return EasyRefresh(
        child: ListView.separated(
            padding: EdgeInsets.all(24.w),
            itemBuilder: (context, index) {
              return WorkOrderCard();
            },
            separatorBuilder: (context, index) {
              return 24.w.heightBox;
            },
            itemCount: 1));
  }
}
