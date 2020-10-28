import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/app_bar_action.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/tab_list.dart';

class CommunityIndex extends StatefulWidget {
  CommunityIndex({Key key}) : super(key: key);

  @override
  _CommunityIndexState createState() => _CommunityIndexState();
}

class _CommunityIndexState extends State<CommunityIndex>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _tabController;

  List tabs = [
    {'name': '最新', 'id': 'new'},
    {'name': '话题', 'id': 'new'},
    {'name': '我的', 'id': 'new'},
  ];

  List<Map<String, dynamic>> actionsList = [
    {'title': '消息', 'icon': AntDesign.bells, 'funtion': null}
  ];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void noteCreateRouter() {
    Navigator.pushNamed(
      context,
      PageName.note_create_page.toString(),
    );
  }

  
  List<Widget> _listActions() {
    return actionsList
        .map((item) => AppBarAction(
              title: item['title'],
              icon: item['icon'],
            ))
        .toList();
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text("社区"),
      centerTitle: true,
      actions: _listActions(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Color(0xffFFd000),
            labelColor: Color(0xff000000),
            unselectedLabelColor: Color(0xFF3A5160).withOpacity(0.5),
            indicatorWeight: 2.0,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(
              fontSize: 28.sp,
              color: Color(0xff333333),
              fontWeight: FontWeight.w600,
            ),
            tabs: List.generate(
              tabs.length,
              (index) => Tab(
                text: tabs[index]['name'],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xffffd000),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40.sp,
      ),
      onPressed: noteCreateRouter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          tabs.length,
          (index) => TabList(index: index),
        ),
      ),
    );
  }
}
