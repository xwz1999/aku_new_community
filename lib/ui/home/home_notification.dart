// Flutter imports:
import 'dart:async';
import 'dart:math';

import 'package:akuCommunity/model/community/board_model.dart';
import 'package:akuCommunity/ui/community/notice/notice_detail_page.dart';
import 'package:akuCommunity/ui/community/notice/notice_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Package imports:
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/utils/headers.dart';

class HomeNotification extends StatefulWidget {
  final List<BoardItemModel> items;
  HomeNotification({Key key, @required this.items}) : super(key: key);

  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  BoardItemModel get randomItem {
    if (widget.items.isEmpty) return null;
    int index = Random().nextInt(widget.items.length - 1);
    return widget.items[index];
  }

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
        Duration(milliseconds: 5000), (timer) => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
            : GestureDetector(
                onTap: () {
                  if (randomItem != null)
                    Get.to(NoticeDetailPage(id: randomItem.id));
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 1000),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    key: ValueKey(randomItem?.id ?? 0),
                    child: Text(randomItem?.title ?? ''),
                  ),
                ),
              ).expand(),
        MaterialButton(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          onPressed: () {
            NoticePage().to();
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
