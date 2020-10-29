import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class SelectCommunityPage extends StatefulWidget {
  SelectCommunityPage({Key key}) : super(key: key);

  @override
  _SelectCommunityPageState createState() => _SelectCommunityPageState();
}

class _SelectCommunityPageState extends State<SelectCommunityPage> {
  List _communityList = ['大唐景园', '龙环小区', '雍景院', '月湖盛院', '五城花园'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '选择小区',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            margin: EdgeInsets.only(top: 32.w),
            padding: EdgeInsets.symmetric(
                vertical: 28.w,
                horizontal: 32.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      EvilIcons.location,
                      color: Color(0xff333333),
                      size: 40.sp,
                    ),
                    SizedBox(width: 18.w),
                    Text(
                      '深圳市',
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: Color(0xff333333),
                      ),
                    )
                  ],
                ),
                InkWell(
                  child: Icon(
                    MaterialIcons.refresh,
                    color: Color(0xff333333),
                    size: 40.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(32.w),
            child: Text(
              '所有社区',
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          Column(
            children: List.generate(
              _communityList.length,
              (index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, PageName.select_parking_page.toString(),
                      arguments: Bundle()
                        ..putString('title', _communityList[index]));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      vertical: 28.w,
                      horizontal: 32.w),
                  child: Text(
                    _communityList[index],
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
