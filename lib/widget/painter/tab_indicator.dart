import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aku_new_community/widget/painter/tab_indicator_parinter.dart';

class TabIndicator extends StatelessWidget {
  final double? width;
  final double? height;

  const TabIndicator({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 40.w,
      height: height ?? 10.w,
      child: CustomPaint(
        painter: TabIndicatorPainter(),
      ),
    );
  }
}
