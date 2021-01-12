import 'package:akuCommunity/widget/search_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';

class ApplicationsBar extends StatelessWidget {
  const ApplicationsBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            AntDesign.left,
            size: 45.sp,
            color: Color(0xff333333),
          ),
        ),
        centerTitle: true,
        title: InkWell(
          onTap: () {
            showSearch(context: context, delegate: SearchBarDelegate());
          },
          child: Container(
            margin: EdgeInsets.only(right: 32.w),
            padding: EdgeInsets.only(
                left: 40.w,
                top: 15.w,
                bottom: 15.w),
            decoration: BoxDecoration(
              color: Color(0xfff3f3f3),
              borderRadius: BorderRadius.all(Radius.circular(36)),
            ),
            child: Row(children: [
              Icon(
                AntDesign.search1,
                size: 28.sp,
                color: Color(0xff999999),
              ),
              SizedBox(width: 5),
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
      ),
    );
  }
}
