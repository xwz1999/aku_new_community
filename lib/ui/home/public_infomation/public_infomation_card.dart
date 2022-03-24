import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/community/information_list_model.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_information_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/beeImageNetwork.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicInfomationCard extends StatelessWidget {
  final InformationListModel model;

  const PublicInfomationCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        Get.to(() => PublicInformationDetailPage(id: this.model.id));
      },
      padding: EdgeInsets.zero,
      child: Container(
        height: 248.w,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.title),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 20.sp,
                    ),
                    child: Row(
                      children: [
                        // Text('测试'),
                        Spacer(),
                        Text('发布于 ${RelativeDateFormat.format(model.createDateDT)}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            32.wb,
            BeeImageNetwork(
              width: 240.w,
              height: 200.w,
              imgs: model.imgList,
            ),
          ],
        ),
      ),
    );
  }
}
class RelativeDateFormat {
  static final num ONE_MINUTE = 60000;
  static final num ONE_HOUR = 3600000;
  static final num ONE_DAY = 86400000;
  static final num ONE_WEEK = 604800000;

  static final String ONE_SECOND_AGO = "秒前";
  static final String ONE_MINUTE_AGO = "分钟前";
  static final String ONE_HOUR_AGO = "小时前";
  static final String ONE_DAY_AGO = "天前";
  static final String ONE_MONTH_AGO = "月前";
  static final String ONE_YEAR_AGO = "年前";

//时间转换
  static String format(DateTime? date) {
    num delta = DateTime.now().millisecondsSinceEpoch - date!.millisecondsSinceEpoch;
    if (delta < 1 * ONE_MINUTE) {
      num seconds = toSeconds(delta);
      return (seconds <= 0 ? 1 : seconds).toInt().toString() + ONE_SECOND_AGO;
    }
    if (delta < 60 * ONE_MINUTE) {
      num minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toInt().toString() + ONE_MINUTE_AGO;
    }
    if (delta < 24 * ONE_HOUR) {
      num hours = toHours(delta);
      return (hours <= 0 ? 1 : hours).toInt().toString() + ONE_HOUR_AGO;
    }
    if (delta < 48 * ONE_HOUR) {
      return "昨天";
    }
    if (delta < 30 * ONE_DAY) {
      num days = toDays(delta);
      return (days <= 0 ? 1 : days).toInt().toString() + ONE_DAY_AGO;
    }
    if (delta < 12 * 4 * ONE_WEEK) {
      num months = toMonths(delta);
      return (months <= 0 ? 1 : months).toInt().toString() + ONE_MONTH_AGO;
    } else {
      num years = toYears(delta);
      return (years <= 0 ? 1 : years).toInt().toString() + ONE_YEAR_AGO;
    }
  }

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }
}


