import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';

class ClockSuccessDialog extends StatelessWidget {
  final int todayIntegral;
  final int tomorrowIntegral;

  const ClockSuccessDialog(
      {Key? key, required this.todayIntegral, required this.tomorrowIntegral})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(16.w),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 500.w,
              height: 600.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.icons.clockSuccess.image(width: 240.w, height: 240.w),
                  48.hb,
                  '签到成功'.text.size(40.sp).black.isIntrinsic.bold.make(),
                  14.hb,
                  '获得'
                      .richText
                      .withTextSpanChildren([
                        '$todayIntegral'
                            .textSpan
                            .size(28.sp)
                            .color(kPrimaryColor)
                            .make(),
                        '点积分'.textSpan.size(28.sp).color(ktextSubColor).make(),
                      ])
                      .size(28.sp)
                      .color(ktextSubColor)
                      .isIntrinsic
                      .make(),
                  56.hb,
                  Container(
                    width: 355.w,
                    height: 58.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE7BA),
                      borderRadius: BorderRadius.circular(44.w),
                    ),
                    child: '明日继续签到可获得'
                        .richText
                        .withTextSpanChildren([
                          '$tomorrowIntegral点积分'
                              .textSpan
                              .size(24.sp)
                              .color(kPrimaryColor)
                              .make(),
                        ])
                        .size(24.sp)
                        .color(Colors.black.withOpacity(0.45))
                        .isIntrinsic
                        .make(),
                  ),
                ],
              ),
            ),
            24.hb,
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  CupertinoIcons.xmark_circle,
                  size: 60.w,
                  color: Colors.white.withOpacity(0.5),
                ))
          ],
        ),
      ),
    );
  }
}
