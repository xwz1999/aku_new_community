import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/home/home_announce_model.dart';
import 'package:aku_new_community/ui/community/notice/notice_detail_page.dart';
import 'package:aku_new_community/utils/bee_date_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNotification extends StatefulWidget {
  final List<HomeAnnounceModel> items;

  HomeNotification({Key? key, required this.items}) : super(key: key);

  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  late HomeAnnounceModel boardItemModel;

  bool isDate = true;

  @override
  void initState() {
    super.initState();
    if (widget.items.length > 0) {
      boardItemModel = widget.items[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        24.wb,
        Assets.home.icGonggao.image(width: 48.w, height: 48.w),
        24.wb,
        widget.items.isEmpty
            ? Spacer()
            : CarouselSlider(
                items: widget.items.map((e) => getText(e)).toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  viewportFraction: 1.0,
                  aspectRatio: 343 / 44,
                  autoPlay: true,
                  onPageChanged: (index, _) {
                    //print(index.toString());
                    // setState(() {
                    //   _currentIndicator = index;
                    // });
                  },
                ),
              ).expand(),
        12.wb,
      ],
    );
  }

  Widget getText(HomeAnnounceModel e) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NoticeDetailPage(id: e.id));
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
                constraints: BoxConstraints(maxWidth: 190),
                child: Text(
                  e.title,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 24.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
            Spacer(),
            Container(
                child: Text(
              BeeDateUtil(DateUtil.getDateTime(e.createDate)).timeAgo,
              style: TextStyle(
                color: Color(0xFF999999),
                fontSize: 24.sp,
              ),
            )),
            8.wb,
            Icon(
              CupertinoIcons.chevron_forward,
              size: 32.w,
              color: Color(0xFF999999),
            ),
          ],
        ),
      ),
    );
  }
}
