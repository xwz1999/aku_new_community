import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/utils/headers.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  final String suffixTitle;
  final VoidCallback onTap;

  const HomeTitle({
    Key? key,
    required this.title,
    required this.suffixTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        85.hb,
        32.wb,
        Stack(
          children: [
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 4.w,
            //   child: Container(
            //     color: kPrimaryColor,
            //     height: 8.w,
            //   ),
            // ),
            title.text.size(32.sp).bold.make(),
          ],
        ),
        Spacer(),
        MaterialButton(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          onPressed: onTap,
          child: Row(
            children: [
              suffixTitle.text.size(24.sp).color(Color(0xFF999999)).make(),
              8.wb,
              Icon(
                CupertinoIcons.chevron_forward,
                size: 24.w,
                color: Color(0xFF999999),
              ),
            ],
          ),
        ),
        12.wb,
      ],
    );
  }
}
