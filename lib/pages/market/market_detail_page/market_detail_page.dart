import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:akuCommunity/routers/page_routers.dart';
import '../widget/market_list.dart';
import 'widget/market_details_app_bar.dart';

class MarketDetailPage extends StatefulWidget {
  final Bundle bundle;
  MarketDetailPage({Key key, this.bundle}) : super(key: key);

  @override
  _MarketDetailPageState createState() => _MarketDetailPageState();
}

class _MarketDetailPageState extends State<MarketDetailPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  TabController _controller;

  //导航标签
  List<Map<String, dynamic>> treeList = [
    {'name': '新品推荐', 'imagePath': 'assets/tab/nanz.png'},
    {'name': '爆款集合', 'imagePath': 'assets/tab/bkjh.png'},
    {'name': '口碑好物', 'imagePath': 'assets/tab/kbhw.png'},
    {'name': '男装', 'imagePath': 'assets/tab/nanz.png'},
    {'name': '女装', 'imagePath': 'assets/tab/nvz.png'}
  ];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: treeList.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), //319
        child: MarketDetailsAppBar(title: widget.bundle.getString('title')),
      ),
      body: MarketList(
        isGroup: false,
        title: widget.bundle.getString('title'),
      ),

      //  TabBarView(
      //   controller: _controller,
      //   children: List.generate(
      //     treeList.length,
      //     (index) => MarketListPage(
      //       isGroup: false,
      //       title: widget.bundle.getString('title'),
      //     ),
      //   ),
      // ),
    );
  }
}
