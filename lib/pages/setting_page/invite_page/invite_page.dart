import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container _containerImage(String imagePath) {
      return Container(
        alignment: Alignment.center,
        child: QrImage(
          padding: EdgeInsets.zero,
          data: '智慧社区开门码',
          size: Screenutil.length(460),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '邀请注册',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: Screenutil.length(146)),
        child: ListView(
          children: [
            _containerImage('assets/example/QR_code.png'),
            SizedBox(height: Screenutil.length(29)),
            Container(
              alignment: Alignment.center,
              child: Text(
                '扫一扫，二维码直接下载小蜜蜂智慧社区',
                style: TextStyle(
                  fontSize: Screenutil.size(28),
                  color: Color(0xff666666),
                ),
              ),
            ),
            SizedBox(height: Screenutil.length(89)),
            Container(
              color: Color(0xfffffbf6),
              height: Screenutil.length(105),
              padding: EdgeInsets.symmetric(vertical: Screenutil.length(30)),
              alignment: Alignment.center,
              child: Text(
                '分享小蜜蜂智慧社区APP',
                style: TextStyle(
                  fontSize: Screenutil.size(32),
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
