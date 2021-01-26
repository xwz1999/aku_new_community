// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/pages/market/market_cart_page/market_cart_page.dart';
import 'package:akuCommunity/pages/market_class/market_class_page.dart';
import 'package:akuCommunity/pages/message_center_page/message_center_page.dart';
import 'package:akuCommunity/utils/headers.dart';

class AppBarAction extends StatefulWidget {
  final IconData icon;
  final String title;
  AppBarAction({Key key, this.icon, this.title}) : super(key: key);

  @override
  _AppBarActionState createState() => _AppBarActionState();
}

class _AppBarActionState extends State<AppBarAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 32.w),
      child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Color(0xff333333),
              ),
              SizedBox(height: 4.w),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Color(0xff333333),
                ),
              )
            ],
          ),
          onTap: () {
            switch (widget.title) {
              case '扫一扫':
                break;
              case '消息':
                MessageCenterPage().to;
                break;
              case '购物车':
                MarketCartPage().to;
                break;
              case '分类':
                MarketClassPage().to;
                break;
              default:
            }
          }),
    );
  }
}
