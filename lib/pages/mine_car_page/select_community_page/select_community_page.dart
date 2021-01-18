import 'package:akuCommunity/pages/mine_car_page/select_parking_page/select_parking_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class SelectCommunityPage extends StatefulWidget {
  SelectCommunityPage({Key key}) : super(key: key);

  @override
  _SelectCommunityPageState createState() => _SelectCommunityPageState();
}

class _SelectCommunityPageState extends State<SelectCommunityPage> {
  List _communityList = ['大唐景园', '龙环小区', '雍景院', '月湖盛院', '五城花园'];

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择小区',
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            margin: EdgeInsets.only(top: 32.w),
            padding: EdgeInsets.symmetric(vertical: 28.w, horizontal: 32.w),
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
                  SelectParkingPage(
                    bundle: Bundle()..putString('title', _communityList[index]),
                  ).to;
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 28.w, horizontal: 32.w),
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
