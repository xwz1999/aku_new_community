import 'package:flutter/material.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/utils/headers.dart';

class PublicInfomationCard extends StatelessWidget {
  const PublicInfomationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: Container(
        height: 248.w,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('今日快讯｜日本决定将核污水拍入海中，中方对此强势喊话日本考虑需谨慎'),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 20.sp,
                    ),
                    child: Row(
                      children: [
                        Text('测试'),
                        Spacer(),
                        Text('发布于 4-11 10:11'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            32.wb,
            SizedBox(
              width: 240.w,
              height: 200.w,
              child: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }
}
