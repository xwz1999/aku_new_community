import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        SizedBox(width: 59.w),
        Row(
          children: [
            Icon(
              EvilIcons.location,
              size: ScreenUtil().setSp(34),
              color: Color(0xff666666),
            ),
            SizedBox(
              width: 9.w,
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
        SizedBox(width: 38.w),
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
              width: 9.w,
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
        SizedBox(width: 59.w),
        Text(
          '品质保证',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: Color(0xff333333),
          ),
        ),
        SizedBox(width: 16.w),
        SizedBox(
          width: 1,
          height: 24.w,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xffd8d8d8)),
          ),
        ),
        SizedBox(width: 16.w),
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
      margin: EdgeInsets.only(top: 30.w),
      padding: EdgeInsets.symmetric(
        vertical: 20.w,
        horizontal: 60.w,
      ),
      child: Column(
        children: [
          _rowDelivergoods(),
          SizedBox(height: 39.w),
          _rowService(),
        ],
      ),
    );
  }
}
