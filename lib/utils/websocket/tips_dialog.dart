import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:aku_new_community/extensions/num_ext.dart';

class TipsDialog {
  static tipsDialog() async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text('功能提醒'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hb,
            Row(
              children: [
                Text(
                  '请各位住户注意：',
                  style: TextStyle(color: Color(0xA6000000), fontSize: 26.sp),
                ),
              ],
            ),
            20.hb,
            Text(
              '本功能已实现，但当前小区不具备能够使用该功能使用的条件，页面内容仅供参考。',
              style: TextStyle(color: Color(0xA6000000), fontSize: 26.sp),
              textAlign: TextAlign.start,
            ),
            20.hb,
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('确定'),
            textStyle: TextStyle(color: Color(0xFF007AFF), fontSize: 28.sp),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
