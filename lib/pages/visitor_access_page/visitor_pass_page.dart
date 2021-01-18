import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/dotted_line.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class VisitorPassPage extends StatefulWidget {
  VisitorPassPage({Key key}) : super(key: key);

  @override
  _VisitorPassPageState createState() => _VisitorPassPageState();
}

class _VisitorPassPageState extends State<VisitorPassPage> {
  Widget _header() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '宁波华茂悦峰',
            style: TextStyle(fontSize: 40.sp, color: Color(0xffffffff)),
          ),
          SizedBox(height: 10.w),
          Text(
            '1幢-1单元-702室',
            style: TextStyle(fontSize: 26.sp, color: Color(0xffffffff)),
          ),
        ],
      ),
    );
  }

  Widget _card() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(16.w)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 75.w,
        vertical: 32.w,
      ),
      padding: EdgeInsets.only(
        bottom: 16.w,
        left: 32.w,
        right: 21.w,
        top: 25.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    AntDesign.contacts,
                    size: 40.sp,
                    color: Color(0xff999999),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '马成泽先生',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 36.sp,
                        color: Color(0xff333333)),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    AntDesign.car,
                    size: 40.sp,
                    color: Color(0xff999999),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '无车辆信息',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 36.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 13.w),
          Text(
            '有限时间：2020年6月30日',
            style: TextStyle(
              fontSize: 26.sp,
              color: Color(0xff999999),
            ),
          ),
          SizedBox(height: 23.w),
          DottedLine(color: Color(0xfff5f5f5)),
          Container(
            padding: EdgeInsets.only(
              top: 30.w,
              bottom: 38.w,
            ),
            height: 389.w,
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  '020-598-230',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 36.sp,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 11.w),
                Image.asset(
                  'assets/example/QR_code.png',
                  height: 260.w,
                  width: 260.w,
                  color: Color(0xff333333),
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          DottedLine(color: Color(0xfff5f5f5)),
          SizedBox(height: 16.w),
          Container(
            alignment: Alignment.center,
            child: Text(
              '进入小区时,请出示此通行证给门岗',
              style: TextStyle(
                fontSize: 24.sp,
                color: Color(0xff999999),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        height: 98.w,
        width: 750.w,
        padding: EdgeInsets.symmetric(vertical: 26.5.w),
        color: Color(0xffffc40c),
        child: Text(
          '发送给访客',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '访客通行证',
      body: Container(
        color: Color(0xff333333),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 192.w - kToolbarHeight),
                _header(),
                SizedBox(height: 32.w),
                _card(),
              ],
            ),
            Positioned(
              bottom: 0,
              child: _bottomButton(),
            ),
          ],
        ),
      ),
    );
  }
}
