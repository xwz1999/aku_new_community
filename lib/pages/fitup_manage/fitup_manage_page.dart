// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/sliver_app_bar_delegate.dart';
import 'widget/director_manage.dart';
import 'widget/owner_manage.dart';

class FitupManagePage extends StatefulWidget {
  FitupManagePage({Key key}) : super(key: key);

  @override
  _FitupManagePageState createState() => _FitupManagePageState();
}

class _FitupManagePageState extends State<FitupManagePage>
    with TickerProviderStateMixin {
  TabController _controller;

  //导航标签
  List<Map<String, dynamic>> treeList = [
    {'name': '业主'},
    {'name': '装修负责人'},
  ];
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 56,
          maxHeight: 56,
          child: Container(
            color: Colors.white,
            child: TabBar(
              unselectedLabelStyle: TextStyle(
                fontSize: BaseStyle.fontSize28,
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: BaseStyle.fontSize28,
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: (131.5).w),
              indicatorColor: Color(0xffffc40c),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 21.w),
              isScrollable: true,
              controller: _controller,
              tabs: List.generate(
                treeList.length,
                (index) => Tab(text: treeList[index]['name']),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '装修管理',
      body: NestedScrollView(
        headerSliverBuilder: _silverBuilder,
        body: TabBarView(
          controller: _controller,
          children: List.generate(
            treeList.length,
            (index) => index == 0 ? OwnerManage() : DirectorManage(),
          ),
        ),
      ),
    );
  }
}
