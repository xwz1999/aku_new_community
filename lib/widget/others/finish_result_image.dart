import 'package:aku_community/base/base_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishResultImage extends StatelessWidget {
  const FinishResultImage({
    Key? key,
    required this.status,
  }) : super(key: key);

  final bool? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 110.w,
      height: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55.w),
        color: this.status! ? kPrimaryColor : kDangerColor,
      ),
      child: Icon(
        this.status!
            ? CupertinoIcons.checkmark
            : CupertinoIcons.multiply,
        size: 70.w,
        color: Colors.white,
      ),
    );
  }
}