import 'dart:convert';

import 'package:aku_community/models/pay/pay_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:power_logger/power_logger.dart';
import 'package:tobias/tobias.dart';

enum PAYTYPE {
  ///支付宝
  ALI,

  ///微信
  WX,

  ///现金
  CASH,

  ///pos
  POS
}

class PayUtil {
  void resultSatus(String status) {
    switch (status) {
      case '8000':
        BotToast.showText(text: '正在处理中');
        break;
      case '4000':
        BotToast.showText(text: '订单支付失败');
        break;
      case '5000':
        BotToast.showText(text: '重复请求');
        break;
      case '6001':
        BotToast.showText(text: '	用户中途取消');
        break;
      case '6002':
        BotToast.showText(text: '网络连接出错');
        break;
      case '6004':
        BotToast.showText(text: '支付结果未知,请查询商户订单列表中订单的支付状态');
        break;
      default:
        BotToast.showText(text: '其他支付错误');
        break;
    }
  }

  String _resultStatus = '';

  ///传入订单信息和确认订单请求地址
  Future<bool> callAliPay(String order, String apiPath) async {
    Map<dynamic, dynamic> result = await aliPay(order);
    _resultStatus = result['resultStatus'];
    if (_resultStatus == '9000') {
      String _res = result['result'];
      PayModel _model = PayModel.fromJson(jsonDecode(_res));
      bool _confirmResult = await _confirmPayResult(
          apiPath, _model.aliPayTradeAppPayResponse.outTradeNo);
      return _confirmResult;
    } else {
      resultSatus(_resultStatus);
      return false;
    }
  }

  Future<bool> _confirmPayResult(String path, String code) async {
    try {
      int status = 0;
      for (var i = 0; i < 3; i++) {
        await Future.delayed(Duration(milliseconds: 1000), () async {
          Response response = await NetUtil().dio!.get(path, queryParameters: {
            "code": code,
          });
          status = response.data['status'] as int;
        });
        if (status == 2) {
          break;
        }
      }
      if (status == 2) {
        BotToast.showText(text: '交易成功');
        return true;
      } else {
        BotToast.showText(text: '交易失败 错误码${status}');
        return false;
      }
    } catch (e) {
      BotToast.showText(text: '网络请求错误');
      LoggerData.addData(e);
      return false;
    }
  }
}
