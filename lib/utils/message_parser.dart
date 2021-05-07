import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_community/utils/headers.dart';

class MessageParser {
  final Map<String, dynamic> message;
  String subTitle = '';
  String type = '0';

  MessageParser(rawMessage) : message = Map<String, dynamic>.from(rawMessage);
  //TODO 只支持Android端显示消息，需要适配iOS
  Future shot() async {
    ///副标题
    subTitle = message['alert'];
    Map<dynamic, dynamic> rawExtras = message['extras'];

    ///extra value
    String? androidExtra = rawExtras['cn.jpush.android.EXTRA'];
    if (androidExtra == null) return;
    Map<String, dynamic> _innerMap = jsonDecode(androidExtra);
    type = _innerMap['type'] ?? '0';

    switch (type) {
      case '1':
        await fireAlarm(subTitle);
    }
  }

  ///火警
  fireAlarm(String content) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text('发生火灾'),
        content: Column(
          children: [
            Text(subTitle),
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
        ],
      ),
      barrierDismissible: false,
    );
  }
}
