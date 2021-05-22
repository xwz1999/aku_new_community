import 'package:aku_community/base/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CardBottomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final bool hasBorder;
  final VoidCallback onPressed;
  const CardBottomButton(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.bgColor,
      this.hasBorder = false,
      required this.onPressed})
      : super(key: key);
  CardBottomButton.white(
    {Key? key, 
    required this.text,
    required this.onPressed,
  })   : this.bgColor = Colors.white,
        this.textColor = ktextPrimary,
        this.hasBorder = true,
        super(key: key);
  CardBottomButton.yellow(
    {Key? key, 
    required this.text,
    required this.onPressed,
  })   : this.bgColor = Color(0xFFFFC40C),
        this.textColor = ktextPrimary,
        this.hasBorder = false,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(74.w),
          side: this.hasBorder
              ? BorderSide(color: Color(0xFF999999), width: 2.w)
              : BorderSide.none),
      child: text.text.size(26.sp).color(this.textColor).bold.make(),
      color: this.bgColor,
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
      height: 52.w,
    );
  }
}
