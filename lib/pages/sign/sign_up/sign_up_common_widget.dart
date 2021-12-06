import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

signUpTitle(String subTitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      '欢迎登录小蜜蜂'.text.bold.size(38.sp).color(ktextPrimary).make(),
      8.hb,
      subTitle.text.size(28.sp).color(ktextSubColor).make(),
    ],
  );
}
