// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/community/note_create_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
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

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void noteCreateRouter() {
    NoteCreatePage().to();
  }

  List<Widget> _listActions() {
    return [
      FlatButton(
          minWidth: 48.w + 27.w * 2,
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                CupertinoIcons.bell,
                size: 48.w,
              ),
              '消息'.text.black.size(20.sp).make(),
            ],
          ))
    ];
  }

  // AppBar _appBar() {
  //   return AppBar(
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     title: Text("社区"),
  //     centerTitle: true,
  //     actions: _listActions(),
  //     bottom: PreferredSize(
  //       preferredSize: Size.fromHeight(kToolbarHeight),
  //       child: Align(
  //         alignment: Alignment.centerLeft,
  //         child: TabBar(
  //           controller: _tabController,
  //           isScrollable: true,
  //           indicatorColor: Color(0xffFFd000),
  //           labelColor: Color(0xff000000),
  //           unselectedLabelColor: Color(0xFF3A5160).withOpacity(0.5),
  //           indicatorWeight: 2.0,
  //           indicatorSize: TabBarIndicatorSize.label,
  //           labelStyle: TextStyle(
  //             fontSize: 28.sp,
  //             color: Color(0xff333333),
  //             fontWeight: FontWeight.w600,
  //           ),
  //           tabs: List.generate(
  //             tabs.length,
  //             (index) => Tab(
  //               text: tabs[index]['name'],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xffffd000),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: noteCreateRouter,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeScaffold(
      title: '社区',
      actions: _listActions(),
      body: Column(
        children: [
          Material(
            color: kForeGroundColor,
            child: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  indicatorPadding: EdgeInsets.zero,
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Color(0xffFFd000),
                  indicatorWeight: 2.w,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelStyle: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 28.sp,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 28.sp,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold,
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
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                tabs.length,
                (index) => TabList(index: index),
              ),
            ),
          ),
          // _floatingActionButton(),
        ],
      ),
      fab: _floatingActionButton(),
    );
  }
}
