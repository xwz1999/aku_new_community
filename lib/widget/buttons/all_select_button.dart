import 'package:aku_new_community/base/base_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllSelectButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backColor;
  final bool selected;
  final Widget? indent;

  const AllSelectButton(
      {Key? key,
      required this.onPressed,
      this.backColor,
      required this.selected,
      this.indent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 40.w,
      width: 40.w,
      decoration: BoxDecoration(
        color: (backColor ?? kPrimaryColor).withOpacity(selected ? 1 : 0),
        border: Border.all(
          color: backColor != null
              ? Color(0xFFBBBBBB)
              : (selected ? kPrimaryColor : Color(0xFF979797)),
          width: 3.w,
        ),
        borderRadius: BorderRadius.circular(20.w),
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.center,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        opacity: selected ? 1 : 0,
        child: indent ??
            Icon(
              CupertinoIcons.checkmark,
              color: Colors.white,
              size: 28.w,
            ),
      ),
    );
  }
}
