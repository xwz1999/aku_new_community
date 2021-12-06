import 'package:aku_new_community/base/base_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishResultImage extends StatelessWidget {
  const FinishResultImage({
    Key? key,
    required this.status,
    this.haveInHandStatus = false,
  }) : super(key: key);

  final bool status;
  final bool haveInHandStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 110.w,
      height: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55.w),
        color: this.haveInHandStatus
            ? Colors.yellow.shade900
            : this.status
                ? kPrimaryColor
                : kDangerColor,
      ),
      child: Icon(
        this.haveInHandStatus
            ? CupertinoIcons.exclamationmark
            : this.status
                ? CupertinoIcons.checkmark
                : CupertinoIcons.multiply,
        size: 70.w,
        color: Colors.white,
      ),
    );
  }
}
