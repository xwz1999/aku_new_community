import 'package:aku_community/pages/tab_navigator.dart';
import 'package:aku_community/utils/developer_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aku_community/extensions/num_ext.dart';

class FireDialog {
  static fireAlarm(String content) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text('发生火灾'),
        content: Column(
          children: [
            Text(content),
            10.hb,
            Icon(
              CupertinoIcons.bell_fill,
              color: Colors.red,
              size: 48.w,
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('确认'),
            onPressed: () => Get.back(),
          ),
          if (DeveloperUtil.dev)
            CupertinoDialogAction(
              child: Text('清除所有弹窗'),
              onPressed: () => Get.offAll(
                () => TabNavigator(),
              ),
            ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
