import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeNotification extends StatefulWidget {
  HomeNotification({Key key}) : super(key: key);

  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        85.hb,
        24.wb,
        Image.asset(
          R.ASSETS_ICONS_ICON_NOTIFICATION_PNG,
          height: 40.w,
          width: 40.w,
        ),
        24.wb,
        'TTTTTTTTT'.text.size(28.sp).make(),
        Spacer(),
        MaterialButton(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          onPressed: () {},
          child: Row(
            children: [
              '更多公告'.text.size(20.sp).color(Color(0xFF999999)).make(),
              8.wb,
              Icon(
                CupertinoIcons.chevron_forward,
                size: 24.w,
                color: Color(0xFF999999),
              ),
            ],
          ),
        ),
        12.wb,
      ],
    );
  }
}
