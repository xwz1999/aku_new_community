import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeDivider extends StatelessWidget {
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
  final bool? isHorizontal;

  BeeDivider(
      {Key? key,
      this.thickness,
      this.indent,
      this.endIndent,
      this.color,
      this.isHorizontal = true})
      : super(key: key);

  BeeDivider.horizontal({
    Key? key,
    this.indent,
    this.endIndent,
  })  : thickness = 1.w,
        color = Color(0xFFE8E8E8),
        isHorizontal = true,
        super(key: key);

  BeeDivider.vertical({
    Key? key,
    this.indent,
    this.endIndent,
  })  : thickness = 1.w,
        color = Color(0xFFE8E8E8),
        isHorizontal = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isHorizontal!
        ? Divider(
            height: 0,
            thickness: this.thickness ?? 1.w,
            indent: this.indent ?? 0,
            endIndent: this.endIndent ?? 0,
            color: this.color ?? Color(0xFFE8E8E8),
          )
        : VerticalDivider(
            width: 0,
            thickness: this.thickness ?? 1.w,
            indent: this.indent ?? 0,
            endIndent: this.endIndent ?? 0,
            color: this.color ?? Color(0xFFE8E8E8),
          );
  }
}
