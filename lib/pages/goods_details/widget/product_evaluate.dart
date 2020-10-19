import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductEvaluate extends StatelessWidget {
  final Function fun;
  ProductEvaluate({Key key,this.fun}) : super(key: key);

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
          right: ScreenUtil().setWidth(32),
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
                SizedBox(width: ScreenUtil().setWidth(20)),
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
                height: ScreenUtil().setWidth(50),
                width: ScreenUtil().setWidth(50),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Text(
              '就是安安啊',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setWidth(12)),
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
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(20),
        left: ScreenUtil().setWidth(32),
        bottom: ScreenUtil().setWidth(32),
      ),
      child: Column(
        children: [
          _stackEvaluateHeader(),
          SizedBox(height: ScreenUtil().setWidth(32)),
          _columnEvaluateContent(),
        ],
      ),
    );
  }
}
