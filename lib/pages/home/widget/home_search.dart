// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/search_bar_delegate.dart';

class HomeSearch extends StatefulWidget {
  HomeSearch({Key key}) : super(key: key);

  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
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
      padding: EdgeInsets.only(
        top: 127.w + ScreenUtil().statusBarHeight,
        left: 32.w,
        right: 32.w,
        bottom: 17.w,
      ),
      child: InkWell(
        onTap: () {
          showSearch(context: context, delegate: SearchBarDelegate());
        },
        child: Container(
          width: 686.w,
          height: 72.w,
          padding: EdgeInsets.only(
            top: 16.w,
            bottom: 16.w,
            left: 24.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(36.w)),
          ),
          child: Row(children: [
            Icon(
              AntDesign.search1,
              color: Color(0xff999999),
              size: 28.sp,
            ),
            SizedBox(width: 16.w),
            Text(
              '搜索商品、活动、帖子、应用',
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xff999999),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
