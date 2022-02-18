import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/painters/progress_bar_painter.dart';

class ProgressPaint extends StatelessWidget {
  final double proportion;
  final int activity;
  final int lowLevel;

  const ProgressPaint(
      {Key? key,
      required this.proportion,
      required this.activity,
      required this.lowLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 110.w,
          alignment: Alignment.center,
          child: CustomPaint(
            painter:
                ProgressBarPainter(proportion: proportion, lowLevel: lowLevel),
          ),
        ),
        Positioned(
          left: 180.w,
          bottom: 16.w,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.w),
              color: Color(0x000000).withOpacity(0.2),
            ),
            child: '距离下一级还有 ${activity} 活跃度'
                .text
                .size(22.sp)
                .color(Colors.white)
                .make(),
          ),
        ),
      ],
    );
  }
}
