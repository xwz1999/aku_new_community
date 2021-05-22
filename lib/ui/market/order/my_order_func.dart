import 'package:aku_community/constants/api.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';

class MyOrderFunc {
  static Future confirmReceive(int goodsAppointmentId) async {
    BaseModel baseModel = await NetUtil().get(API.market.confirmReceive,
        params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
  }

  static Future refundOrder(int goodsAppointmentId) async {
    BaseModel baseModel = await NetUtil().get(API.market.confirmReceive,
        params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
  }

  static Future cancelOrder(int goodsAppointmentId) async {
    BaseModel baseModel = await NetUtil().get(API.market.confirmReceive,
        params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
  }
}
