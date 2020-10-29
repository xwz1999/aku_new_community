import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';

class MarketCartAppBar extends StatelessWidget {
  const MarketCartAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(AntDesign.left, size: 40.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Color(0xff333333),
            ),
            children: <InlineSpan>[
              TextSpan(
                text: '购物车  ',
                style: TextStyle(
                  fontSize: 38.sp,
                ),
              ),
              TextSpan(
                text: '业主尊享，购物更省心',
                style: TextStyle(fontSize: 24.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
