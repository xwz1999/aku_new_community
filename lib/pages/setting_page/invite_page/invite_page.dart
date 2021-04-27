import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container _containerImage(String imagePath) {
      return Container(
        alignment: Alignment.center,
        child: QrImage(
          padding: EdgeInsets.zero,
          data: '智慧社区开门码',
          size: 460.w,
        ),
      );
    }

    return BeeScaffold(
      title: '邀请注册',
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 146.w),
        child: ListView(
          children: [
            _containerImage('assets/example/QR_code.png'),
            SizedBox(height: 29.w),
            Container(
              alignment: Alignment.center,
              child: Text(
                '扫一扫，二维码直接下载小蜜蜂智慧社区',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff666666),
                ),
              ),
            ),
            SizedBox(height: 89.w),
            Container(
              color: Color(0xfffffbf6),
              height: 105.w,
              padding: EdgeInsets.symmetric(vertical: 30.w),
              alignment: Alignment.center,
              child: Text(
                '分享小蜜蜂智慧社区APP',
                style: TextStyle(
                  fontSize: 32.sp,
                  color: Color(0xff333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
