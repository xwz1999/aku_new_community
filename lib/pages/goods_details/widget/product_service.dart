import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductService extends StatelessWidget {
  const ProductService({Key key}) : super(key: key);

  Row _rowDelivergoods() {
    return Row(
      children: [
        Text(
          '发货',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: Color(0xff999999),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(59)),
        Row(
          children: [
            Icon(
              EvilIcons.location,
              size: ScreenUtil().setSp(34),
              color: Color(0xff666666),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(9),
            ),
            Text(
              '浙江杭州',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color(0xff333333),
              ),
            ),
          ],
        ),
        SizedBox(width: ScreenUtil().setWidth(38)),
        Row(
          children: [
            Text(
              '快递:',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color(0xff333333),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(9),
            ),
            Text(
              '全国包邮',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color(0xff333333),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _rowService() {
    return Row(
      children: [
        Text(
          '服务',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: Color(0xff999999),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(59)),
        Text(
          '品质保证',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: Color(0xff333333),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(16)),
        SizedBox(
          width: 1,
          height: ScreenUtil().setWidth(24),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xffd8d8d8)),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(16)),
        Text(
          '售后无忧',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: Color(0xff333333),
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
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(20),
        horizontal: ScreenUtil().setWidth(60),
      ),
      child: Column(
        children: [
          _rowDelivergoods(),
          SizedBox(height: ScreenUtil().setWidth(39)),
          _rowService(),
        ],
      ),
    );
  }
}
