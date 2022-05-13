import 'package:flutter/cupertino.dart';


import 'package:aku_new_community/utils/headers.dart';

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
        title.text.size(32.sp).bold.make(),
        Spacer(),
        GestureDetector(
          onTap: onTap,
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
      ],
    );
  }
}
