import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Toast {
  static ToastFuture globalToast(String text) {
    return showToast(
      text,
      duration: Duration(milliseconds: 2000),
      // position: ToastPosition.top,
      radius: 3.0,
      backgroundColor: Color(0xff000000).withOpacity(0.85),
      animationBuilder: Miui10AnimBuilder(),
      textStyle: TextStyle(fontSize: ScreenUtil().setSp(34)),
    );
  }
}
