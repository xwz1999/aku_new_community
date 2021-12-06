import 'package:aku_new_community/base/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeTextField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onChange;
  final String hintText;
  final int? minLines;
  final int? maxLines;

  BeeTextField(
      {Key? key,
      required this.controller,
      this.onChange,
      required this.hintText,
      this.minLines,
      this.maxLines})
      : super(key: key);

  @override
  _BeeTextFieldState createState() => _BeeTextFieldState();
}

class _BeeTextFieldState extends State<BeeTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(
          width: 2.w,
          color: Color(0xFFE8E8E8),
        ),
      ),
      child: TextField(
        minLines: widget.minLines ?? 5,
        maxLines: widget.maxLines ?? 10,
        autofocus: false,
        onChanged: (value) {
          if (widget.onChange != null) {
            widget.onChange!();
          }
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 28.sp,
            color: ktextSubColor,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}
