import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';

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
                Navigator.pushNamed(
                    context, PageName.message_center_page.toString());
                break;
              case '购物车':
                Navigator.pushNamed(
                    context, PageName.market_cart_page.toString());
                break;
              case '分类':
                Navigator.pushNamed(
                    context, PageName.market_class_page.toString());
                break;
              default:
            }
          }),
    );
  }
}
