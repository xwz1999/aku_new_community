import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class ThingsAppBar extends StatelessWidget {
  final String title, subtitle;
  final List<Map<String, dynamic>> treeList;
  final TabController tabController;
  const ThingsAppBar({
    Key key,
    @required this.title,
    this.subtitle,
    this.treeList,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            AntDesign.left,
            size: Screenutil.size(45),
            color: Color(0xff333333),
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: Screenutil.size(32),
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          unselectedLabelStyle: TextStyle(
            fontSize: Screenutil.size(28),
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Screenutil.size(28),
          ),
          labelPadding:
              EdgeInsets.symmetric(horizontal: Screenutil.length(131.5)),
          indicatorColor: Color(0xffffc40c),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding:
              EdgeInsets.symmetric(horizontal: Screenutil.length(21)),
          isScrollable: true,
          controller: tabController,
          tabs: List.generate(
            treeList.length,
            (index) => Tab(text: treeList[index]['name']),
          ),
        ),
      ),
    );
  }
}
