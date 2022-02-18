import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/tab_navigator.dart';
import 'package:aku_new_community/utils/developer_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/websocket/alarm_models/fall_model.dart';
import 'package:aku_new_community/utils/websocket/alarm_models/fire_model.dart';

class FireDialog {
  static fireAlarm(String content) async {
    var json = jsonDecode(content);
    int type = json['type'] as int;

    await Get.dialog(
      CupertinoAlertDialog(
        title: getImage(type),
        content: Column(
          children: [
            Text(
              getTitle(type),
              style: TextStyle(color: Colors.black, fontSize: 34.sp),
            ),
            10.hb,
            Text(
              getContent(json, type),
              style: TextStyle(color: Colors.black, fontSize: 26.sp),
              textAlign: TextAlign.start,
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

  static String getTitle(int type) {
    switch (type) {
      case 1:
        return '发现火灾！请立刻组织疏散人群！';
      case 2:
        return '设备故障';
      case 3:
        return '管家端APP报警';
      case 4:
        return '跌倒报警';
      case 5:
        return 'SOS紧急联系报警';
      default:
        return '';
    }
  }

  static String getContent(dynamic json, int type) {
    switch (type) {
      case 1:
        var alarmModel = FireModel.fromJson(json);
        return '于${alarmModel.time},${alarmModel.deviceName}附近出现了火灾报警，请各位业主、租户保持镇静，不要慌乱，有序开始撤离！';
      case 2:
        var alarmModel = FireModel.fromJson(json);
        return '于${alarmModel.time},小区内有设备${alarmModel.deviceName}发生了报警，请物业负责人员尽快前往现场排查故障！';
      case 3:
        var alarmModel = FireModel.fromJson(json);
        return '注意：\n于${alarmModel.time},${alarmModel.deviceNo}${alarmModel.deviceName}' +
            '在管家端app上点击了"一键报警",请尽快联系他沟通情况。\n' +
            '${alarmModel.deviceName}联系方式：${alarmModel.alarmNo}\n' +
            '如未能联系到${alarmModel.deviceName}。可择情报警';
      case 4:
        var alarmModel = FallModel.fromJson(json);
        return '注意：\n\n有住户 ${alarmModel.userName} 发生跌倒情况，请及时上门或联系人员前往查看，住户联系方式：${alarmModel.tel}\n\n' +
            '跌倒位置————\n${alarmModel.address}，经度${alarmModel.lon}，纬度${alarmModel.lat}\n\n如未能联系到住户，可择情报警';
      case 5:
        var alarmModel = FallModel.fromJson(json);
        return '注意：\n\n有住户 ${alarmModel.userName} 使用了SOS紧急联系报警，请及时上门或联系人员前往查看，住户联系方式：${alarmModel.tel}\n\n' +
            '跌倒位置————\n${alarmModel.address}，经度${alarmModel.lon}，纬度${alarmModel.lat}\n\n如未能联系到住户，可择情报警';
      default:
        return '';
    }
  }

  static Widget getImage(int type) {
    switch (type) {
      case 1:
        return Image.asset(
          R.ASSETS_ICONS_FIRE_ALARM_PNG,
          width: 110.w,
          height: 110.w,
          fit: BoxFit.fitHeight,
        );
      case 2:
        return Image.asset(
          R.ASSETS_ICONS_DEVICE_ALARM_PNG,
          width: 110.w,
          height: 110.w,
          fit: BoxFit.fitHeight,
        );
      case 3:
        return Image.asset(
          R.ASSETS_ICONS_APP_ALARM_PNG,
          width: 110.w,
          height: 110.w,
          fit: BoxFit.fitHeight,
        );
      case 4:
        return Image.asset(
          R.ASSETS_ICONS_APP_ALARM_PNG,
          width: 110.w,
          height: 110.w,
          fit: BoxFit.fitHeight,
        );
      case 5:
        return Image.asset(
          Assets.icons.sos.path,
          width: 110.w,
          height: 110.w,
          fit: BoxFit.fitHeight,
        );
      default:
        return SizedBox(width: 110.w, height: 110.w);
    }
  }
}
