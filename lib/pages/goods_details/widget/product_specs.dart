import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akuCommunity/widget/goods_specs_sheet.dart';

class ProductSpecs extends StatefulWidget {
  ProductSpecs({Key key}) : super(key: key);

  @override
  _ProductSpecsState createState() => _ProductSpecsState();
}

class _ProductSpecsState extends State<ProductSpecs> {
  void _showModelBotoomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return GoodsSpecsSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showModelBotoomSheet,
      child: Container(
        color: Color(0xffffffff),
        margin: EdgeInsets.only(top: 30.w),
        padding: EdgeInsets.only(
          left: 60.w,
          top: 20.w,
          bottom: 20.w,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Text(
                  '规格',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color(0xff999999),
                  ),
                ),
                SizedBox(width: 59.w),
                Text(
                  '请选择规格',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color(0xff333333),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 32.w,
              child: Icon(
                AntDesign.right,
                size: ScreenUtil().setSp(34),
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
