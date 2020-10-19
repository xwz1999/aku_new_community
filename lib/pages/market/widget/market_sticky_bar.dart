import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketStickyBar extends StatefulWidget {
  final TabController controller;
  final List<Map<String, dynamic>> treeList;
  MarketStickyBar({Key key, this.controller, this.treeList}) : super(key: key);

  @override
  _MarketStickyBarState createState() => _MarketStickyBarState();
}

class _MarketStickyBarState extends State<MarketStickyBar> {
  TabBar _tabBar() {
    return TabBar(
      controller: widget.controller,
      isScrollable: true,
      indicatorColor: Color(0xffFFC100),
      labelColor: Color(0xff000000),
      unselectedLabelColor: Color(0xFF3A5160).withOpacity(0.5),
      indicatorWeight: 3.0,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: ScreenUtil().setSp(34),
        color: Color(0xff999999),
        fontWeight: FontWeight.w600,
      ),
      tabs: List.generate(
          widget.treeList.length,
          (index) => Tab(
                text: widget.treeList[index]['name'],
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        child: _tabBar(),
      ),
      pinned: true,
      floating: true,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  _SliverAppBarDelegate({
    @required this.child,
  });

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(
      child: Container(
        color: Color(0xfff9f9f9),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
