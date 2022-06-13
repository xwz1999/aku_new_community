import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/saas_model/work_order/work_order_list_model.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/publish_work_order_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_view.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';

class WorkOrderPage extends StatefulWidget {
  const WorkOrderPage({Key? key}) : super(key: key);

  @override
  _WorkOrderPageState createState() => _WorkOrderPageState();
}

class _WorkOrderPageState extends State<WorkOrderPage>
    with SingleTickerProviderStateMixin {
  List<String> _tabs = ['全部', '待分配', '已接单', '处理中', '待确认'];
  late TabController _tabController;
  List<EasyRefreshController> _refreshControllers = [];
  int _page = 1;
  int _size = 10;
  List<WorkOrderListModel> _models = [];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _refreshControllers = List.filled(_tabs.length, EasyRefreshController());
    super.initState();
  }

  @override
  void dispose() {
    _refreshControllers.forEach((element) {
      element.dispose();
    });
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '报事报修',
      actions: [
        IconButton(
            onPressed: () async {
              await Get.to(() => PublishWorkOrderPage());
              _refreshControllers[_tabController.index].callRefresh();
            },
            icon: Icon(
              CupertinoIcons.plus_circle,
              size: 40.w,
            ))
      ],
      appBarBottom: BeeTabBar(
        tabs: _tabs,
        controller: _tabController,
        scrollable: true,
      ),
      body: TabBarView(
          controller: _tabController,
          children: _tabs
              .mapIndexed((e, index) => WorkOrderView(
                    refreshController: _refreshControllers[index],
                    index: index==1?index:index+1,
                  ))
              .toList()),
    );
  }
}
