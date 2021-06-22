import 'package:aku_community/base/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class IdentifyCardPicker {
  static front() {
    return Column(
      children: [
        '上传身份证正面'.text.size(28.sp).color(ktextPrimary).make(),
        24.w.heightBox,
        Container(
          width: 350.w,
          height: 220.w,
        )
      ],
    );
  }
}
