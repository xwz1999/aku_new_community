// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'widget/order_list.dart';

class OrderPage extends StatefulWidget {
  final Bundle bundle;
  OrderPage({Key key, this.bundle}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Map<String, dynamic>> tabs = [
    {'name': '全部', 'id': 'new'},
    {'name': '待付款', 'id': 'new'},
    {'name': '待发货', 'id': 'new'},
    {'name': '待收货', 'id': 'new'},
    {'name': '待评价', 'id': 'new'},
    {'name': '售后', 'id': 'new'},
  ];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  PreferredSize _preferredSizeBottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicator: BoxDecoration(),
          labelColor: BaseStyle.colorff8500,
          unselectedLabelColor: ktextPrimary,
          labelStyle: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
          tabs: List.generate(
            tabs.length,
            (index) => Tab(
              text: tabs[index]['name'],
            ),
          ),
        ),
      ),
    );
  }

  InkWell _inkWellSearch() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 32.w),
        padding: EdgeInsets.only(
            left: 40.w,
            top: 20.w,
            bottom: 20.w),
        decoration: BoxDecoration(
          color: BaseStyle.colorf3f3f3,
          borderRadius: BorderRadius.all(Radius.circular(36)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Row(children: [
          Icon(
            AntDesign.search1,
            size: BaseStyle.fontSize28,
            color: BaseStyle.color999999,
          ),
          SizedBox(width: 5),
          Text(
            '搜索我的订单',
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: BaseStyle.color999999,
            ),
          )
        ]),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Color(0xffffffff),
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(AntDesign.left, size: 40.sp),
      ),
      centerTitle: false,
      title: _inkWellSearch(),
      bottom: _preferredSizeBottom(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          tabs.length,
          (index) => OrderList(),
        ),
      ),
    );
  }
}
