import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/app_bar_action.dart';

class HomeAppBar extends StatefulWidget {
  HomeAppBar({Key key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  List<Map<String, dynamic>> _actionsList = [
    {'title': '扫一扫', 'icon': AntDesign.scan1, 'funtion': null},
    {'title': '消息', 'icon': AntDesign.bells, 'funtion': null}
  ];

  List<Widget> _actions() {
    return _actionsList
        .map((item) => AppBarAction(
              title: item['title'],
              icon: item['icon'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xffffd000), Color(0xffffbd00)],
        ),
      ),
      child: AppBar(
        elevation: 0,
        title: Text(
          '皇冠花园二期',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 36.sp,
            color: Color(0xff333333),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.only(left: 32.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '深圳',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                    color: Color(0xff333333),
                  ),
                ),
                Text(
                  '阴 27℃',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(0xff333333),
                  ),
                )
              ]),
        ),
        actions: _actions(),
      ),
    );
  }
}
