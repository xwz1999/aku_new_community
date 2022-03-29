import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/saas_model/work_order/work_order_list_model.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/publish_work_order_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_card.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
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
  EasyRefreshController _refreshController = EasyRefreshController();
  int _page = 1;
  int _size = 10;
  List<WorkOrderListModel> _models = [];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _tabController.dispose();
    super.dispose();
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
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          _page = 1;
          var base = await NetUtil().getList(SAASAPI.workOrder.list, params: {
            'pageNum': _page,
            'size': _size,
            'status': index == 0 ? null : index,
          });
          _models =
              base.rows.map((e) => WorkOrderListModel.fromJson(e)).toList();
          setState(() {});
        },
        onLoad: () async {
          _page++;
          var base = await NetUtil().getList(SAASAPI.workOrder.list, params: {
            'pageNum': _page,
            'size': _size,
            'status': index == 0 ? null : index,
          });
          if (_models.length < base.total) {
            _models.addAll(
                base.rows.map((e) => WorkOrderListModel.fromJson(e)).toList());
            setState(() {});
          } else {
            _refreshController.finishLoad();
          }
        },
        child: ListView.separated(
            padding: EdgeInsets.all(24.w),
            itemBuilder: (context, index) {
              return WorkOrderCard(
                model: _models[index],
                refresh: _refreshController.callRefresh,
              );
            },
            separatorBuilder: (context, index) {
              return 24.w.heightBox;
            },
            itemCount: _models.length));
  }
}
