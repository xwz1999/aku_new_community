import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:get/get.dart';

//TODO CLEAN BOTTOM CODES. 
@Deprecated("sh*t app bar need to be cleaned.")
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
          onTap: () => Get.back(),
          child: Icon(
            AntDesign.left,
            size: 45.sp,
            color: Color(0xff333333),
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          unselectedLabelStyle: TextStyle(
            fontSize: 28.sp,
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28.sp,
          ),
          labelPadding:
              EdgeInsets.symmetric(horizontal: 131.5.w),
          indicatorColor: Color(0xffffc40c),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding:
              EdgeInsets.symmetric(horizontal: 21.w),
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
