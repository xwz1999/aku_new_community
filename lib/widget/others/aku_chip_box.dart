import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AkuChipBox extends StatelessWidget {
  final String title;
  final Color? borderClor;
  final Color? textColor;

  const AkuChipBox(
      {Key? key, required this.title, this.borderClor, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          color: textColor ?? Color(0xFF3F8FFE),
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(width: 2.w, color: borderClor ?? Color(0xFF3F8FFE)),
      ),
    );
  }
}
