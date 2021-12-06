import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AkuSingleCheckButton<T> extends StatefulWidget {
  final String text;
  final T value;
  final T gropValue;
  final VoidCallback onPressed;

  AkuSingleCheckButton(
      {Key? key,
      required this.text,
      required this.value,
      required this.gropValue,
      required this.onPressed})
      : super(key: key);

  @override
  _AkuSingleCheckButtonState createState() => _AkuSingleCheckButtonState();
}

class _AkuSingleCheckButtonState extends State<AkuSingleCheckButton> {
  bool get isSelect => widget.value == widget.gropValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isSelect ? Color(0xFFFFF8E0) : Colors.white,
          border: Border.all(
              color: isSelect ? Color(0xFFFFC40C) : Color(0xFF999999),
              width: 3.w),
          borderRadius: BorderRadius.circular(4.w)),
      width: 180.w,
      height: 72.w,
      child: widget.text.text
          .color(isSelect ? Color(0xFF333333) : Color(0xFF999999))
          .bold
          .size(32.sp)
          .make(),
    ).onInkTap(() {
      widget.onPressed();
    });
  }
}
