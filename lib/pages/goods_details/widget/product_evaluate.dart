import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductEvaluate extends StatelessWidget {
  final Function fun;
  ProductEvaluate({Key key, this.fun}) : super(key: key);

  Stack _stackEvaluateHeader() {
    return Stack(
      children: [
        Row(
          children: [
            Text(
              '宝贝评价(1239)',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Color(0xff333333),
              ),
            ),
          ],
        ),
        Positioned(
          right: 32.w,
          child: InkWell(
            onTap: () {
              fun();
            },
            child: Row(
              children: [
                Text(
                  '查看全部',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color(0xff999999),
                  ),
                ),
                SizedBox(width: 20.w),
                Icon(
                  AntDesign.right,
                  size: ScreenUtil().setSp(34),
                  color: Color(0xff999999),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _columnEvaluateContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/example/touxiang1.png',
                height: 50.w,
                width: 50.w,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              '就是安安啊',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.w),
        Text(
          '面料和版型都不错，会回购',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.only(top: 30.w),
      padding: EdgeInsets.only(
        top: 20.w,
        left: 32.w,
        bottom: 32.w,
      ),
      child: Column(
        children: [
          _stackEvaluateHeader(),
          SizedBox(height: 32.w),
          _columnEvaluateContent(),
        ],
      ),
    );
  }
}
