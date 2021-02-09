// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Toast {
  static globalToast(String text) {
    return BotToast.showText(
      text: text,
      duration: Duration(milliseconds: 2000),
      borderRadius: BorderRadius.circular(3.w),
      backgroundColor: Color(0xff000000).withOpacity(0.85),
      textStyle: TextStyle(fontSize: ScreenUtil().setSp(34)),
    );
  }
}
