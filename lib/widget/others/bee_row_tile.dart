import 'package:aku_community/base/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class BeeRowTile extends StatelessWidget {
  final String assetPath;
  final String titile;
  final Widget content;
  const BeeRowTile(
      {Key? key,
      required this.assetPath,
      required this.titile,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 40.w,
          height: 40.w,
        ),
        12.w.widthBox,
        titile.text.size(24.sp).color(ktextSubColor).make(),
        Spacer(),
        content,
      ],
    );
  }
}
