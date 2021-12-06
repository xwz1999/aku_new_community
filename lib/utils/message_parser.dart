import 'dart:convert';

import 'package:aku_new_community/utils/websocket/fire_dialog.dart';

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
        await FireDialog.fireAlarm(subTitle);
    }
  }
}
