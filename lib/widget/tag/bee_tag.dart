import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class BeeTag extends StatelessWidget {
  final String text;
  final Color bgColor;
  final bool hasBorder;
  final Color? borderColor;
  final Color textColor;

  const BeeTag(
      {Key? key,
      required this.text,
      required this.bgColor,
      required this.hasBorder,
      this.borderColor,
      required this.textColor})
      : super(key: key);

  BeeTag.yellowSolid({
    required this.text,
  })  : this.bgColor = Color(0xFFFAC058).withOpacity(0.1),
        this.borderColor = null,
        this.hasBorder = false,
        this.textColor = Color(0xFFFAC058);
  BeeTag.yellowHollow({
    required this.text,
  })  : this.bgColor = Colors.white,
        this.borderColor = Color(0xFFFAC058),
        this.hasBorder = true,
        this.textColor = Color(0xFFFAC058);
  BeeTag.blackSolid({
    required this.text,
  })  : this.bgColor = Colors.black.withOpacity(0.06),
        this.borderColor = null,
        this.hasBorder = false,
        this.textColor = Colors.black.withOpacity(0.45);
  BeeTag.blackHollow({
    required this.text,
  })  : this.bgColor = Colors.white,
        this.borderColor = Colors.black.withOpacity(0.45),
        this.hasBorder = true,
        this.textColor = Colors.black.withOpacity(0.45);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96.w,
      height: 42.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: hasBorder ? Border.all(color: borderColor!) : null,
        color: bgColor,
        borderRadius: BorderRadius.circular(21.w),
      ),
      child: text.text.size(24.sp).color(textColor).make(),
    );
  }
}
