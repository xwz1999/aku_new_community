import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/utils/headers.dart';

///上图片 下文字 的button
class ColumnActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final String? path;
  const ColumnActionButton({Key? key, this.onPressed, this.title, this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 72.w,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(path!, height: 48.w, width: 48.w),
          4.hb,
          title!.text.size(20.sp).black.make(),
        ],
      ),
    );
  }
}
