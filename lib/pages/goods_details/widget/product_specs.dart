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
        margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(60),
          top: ScreenUtil().setWidth(20),
          bottom: ScreenUtil().setWidth(20),
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
                SizedBox(width: ScreenUtil().setWidth(59)),
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
              right: ScreenUtil().setWidth(32),
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
