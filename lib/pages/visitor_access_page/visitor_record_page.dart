import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'widget/record_list.dart';

class VisitorRecordPage extends StatefulWidget {
  VisitorRecordPage({Key key}) : super(key: key);

  @override
  _VisitorRecordPageState createState() => _VisitorRecordPageState();
}

class _VisitorRecordPageState extends State<VisitorRecordPage>
    with TickerProviderStateMixin {
  TabController _controller;

  //导航标签
  List<Map<String, dynamic>> treeList = [
    {'name': '未到访客'},
    {'name': '已到访客'},
  ];
  @override
  void initState() {
    _controller = TabController(length: treeList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: treeList.length,
      child: Scaffold(
        appBar: PreferredSize(
          child: CommonAppBar(
            title: '访客记录',
            tabController: _controller,
            treeList: treeList,
          ),
          preferredSize: Size.fromHeight(kToolbarHeight * 1.8),
        ),
        body: TabBarView(
          controller: _controller,
          children: List.generate(
            treeList.length,
            (index) => RecordList(),
          ),
        ),
      ),
    );
  }
}
