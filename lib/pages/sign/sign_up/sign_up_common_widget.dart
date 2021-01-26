// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

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
