import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/base/base_style.dart';

class BeeLongButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backColor;
  final BorderSide border;
  final double? width;

  const BeeLongButton({Key? key, required this.onPressed, required this.text, this.width})
      : backColor = kPrimaryColor,
        border = BorderSide.none,
        super(key: key);

  BeeLongButton.white({Key? key, required this.onPressed, required this.text, this.width})
      : backColor = Colors.white,
        border = BorderSide(color: Colors.black.withOpacity(0.45)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      height: 93.w,
      minWidth: width,
      disabledColor: Colors.black.withOpacity(0.06),
      disabledTextColor: Colors.black.withOpacity(0.25),
      textColor: Colors.black.withOpacity(0.85),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(65.w), side: border),
      color: backColor,
      onPressed: onPressed,
      child: text.text.size(32.sp).bold.make(),
    );
  }
}
