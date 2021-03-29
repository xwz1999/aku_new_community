import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:akuCommunity/pages/certification_page/certification_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class OpenDoorPage extends StatefulWidget {
  OpenDoorPage({Key key}) : super(key: key);

  @override
  _OpenDoorPageState createState() => _OpenDoorPageState();
}

class _OpenDoorPageState extends State<OpenDoorPage> {
  void _showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            '实名认证',
            style: TextStyle(
              fontSize: 34.sp,
              color: Color(0xff030303),
            ),
          ),
          content: Text(
            '\n为了小区的安全，需要先进行实名认证',
            style: TextStyle(
              fontSize: 28.sp,
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '考虑考虑',
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '前去认证',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 34.sp,
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                Get.back();
                Get.to(() => CertificationPage());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '一键开门',
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 220.w),
              child: Column(
                children: [
                  InkWell(
                    onTap: _showDialog,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 400.w,
                          height: 420.w,
                          child: Image.asset(
                            'assets/images/open_door.png',
                            width: 400.w,
                            height: 420.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 120.w,
                          left: 137.5.w,
                          child: Image.asset(
                            'assets/images/lock.png',
                            width: 125.w,
                            height: 150.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.w),
                    child: Text(
                      '未检测到相关设备',
                      style: TextStyle(
                        fontSize: 44.w,
                        color: Color(0xff999999),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
