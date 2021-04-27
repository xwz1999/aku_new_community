import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aku_community/ui/manager/visitor/visitor_record_view.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';

class VisitorRecordPage extends StatefulWidget {
  VisitorRecordPage({Key key}) : super(key: key);

  @override
  _VisitorRecordPageState createState() => _VisitorRecordPageState();
}

class _VisitorRecordPageState extends State<VisitorRecordPage>
    with TickerProviderStateMixin {
  TabController _controller;

  //导航标签
  List<String> _tabs = ['未到访客', '已到访客'];
  @override
  void initState() {
    _controller = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '访客记录',
      appBarBottom: BeeTabBar(
        controller: _controller,
        tabs: _tabs,
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          VisitorRecordView(type: 1),
          VisitorRecordView(type: 2),
        ],
      ),
    );
  }
}
