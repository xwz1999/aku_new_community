import 'dart:io';

import 'package:bot_toast/bot_toast.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/house_keeping/house_keeping_process_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class HouseKeepingFunc {
  ///提交新增家政服务
  static Future submitHouseKeeping(
      int estateId, int type, String content, List<String> urls) async {
    BaseModel baseModel = await NetUtil().post(API.manager.submitHouseKeeping,
        params: {
          "estateId": estateId,
          "type": type,
          "content": content,
          "submitImgUrls": urls
        });
    if (baseModel.success) {
      return true;
    } else {
      return false;
    }
  }

  ///获取家政服务进程
  static Future getHouseKeepingProcess(int id) async {
    BaseModel baseModel = await NetUtil().get(API.manager.houseKeepingProcess,
        params: {"housekeepingServiceId": id});
    if (baseModel.success) {
      return (baseModel.data as List)
          .map((e) => HouseKeepingProcessModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  ///取消家政服务
  static Future cancelHouseKeepingProcess(int id) async {
    BaseModel baseModel =
        await NetUtil().get(API.manager.housekeepingCancel, params: {
      "housekeepingServiceId": id,
    });
    if (baseModel.success) {
      BotToast.showText(text: '取消成功');
      return true;
    } else {
      return false;
    }
  }

  ///上传家政服务评价照片
  static Future<List<String>> uploadHouseKeepingEvaluationPhotos(
      List<File> files) async {
    List<String> urls = await NetUtil()
        .uploadFiles(files, API.upload.uploadHouseKeepingEvaluationPhotos);

    if (urls.isNotEmpty) {
      return urls;
    } else {
      return [];
    }
  }

  ///家政服务：评价
  static Future<bool> houseKeepingEvaluation(int id, int evaluation,
      String evaluationContent, List<String> imgs) async {
    BaseModel baseModel =
        await NetUtil().post(API.manager.houseKeepingEvaluation, params: {
      "id": id,
      "evaluation": evaluation,
      "evaluationContent": evaluationContent,
      "evaluationImgUrls": imgs,
    });
    return baseModel.success;
  }

  ///支付宝支付：app 家政服务-服务费用支付 完成订单支付宝支付(生成 APP 支付订单信息)
  ///支付方式暂写死为1
  ///支付方式：1.支付宝 2.微信 3.现金 4.pos
  static Future<String> houseKeepingOrderAlipay(
      int id, int type, double price) async {
    BaseModel baseModel = await NetUtil()
        .post(API.pay.houseKeepingServiceOrderAlipay, params: {
      "housekeepingServiceId": id,
      "payType": type,
      "payPrice": price
    });
    if (baseModel.success) {
      return baseModel.msg;
    } else {
      return '';
    }
  }
}
