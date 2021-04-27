import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/model/community/board_model.dart';
import 'package:aku_community/ui/community/notice/notice_page.dart';
import 'package:aku_community/utils/headers.dart';

class HomeNotification extends StatefulWidget {
  final List<BoardItemModel> items;
  HomeNotification({Key key, @required this.items}) : super(key: key);

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
        widget.items.isEmpty
            ? Spacer()
            : Container(
                alignment: Alignment.centerLeft,
                height: 85.w,
                child: AnimatedTextKit(
                  pause: Duration(milliseconds: 2000),
                  animatedTexts: widget.items
                      .map((e) => RotateAnimatedText(
                            e.title,
                            duration: Duration(milliseconds: 3000),
                          ))
                      .toList(),
                  repeatForever: true,
                ),
              ),
        Spacer(),
        MaterialButton(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          onPressed: () {
            Get.to(() => NoticePage());
          },
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
