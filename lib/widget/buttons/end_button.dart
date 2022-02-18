import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const EndButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.width,
      this.padding,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      disabledTextColor: Colors.white.withOpacity(0.3),
      minWidth: width ?? 220.w,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 48.w, vertical: 20.w),
      color: color ?? Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(42.w)),
      onPressed: onPressed,
      child: text,
    );
  }
}
