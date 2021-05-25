import 'package:aku_community/constants/api.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';

class MyOrderFunc {
  ///确认收货
  static Future confirmReceive(int goodsAppointmentId) async {
    BaseModel baseModel = await NetUtil().get(API.market.confirmReceive,
        params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
  }

  ///申请退换
  static Future refundOrder(int goodsAppointmentId, String reson) async {
    BaseModel baseModel = await NetUtil().get(API.market.confirmReceive,
        params: {"goodsAppointmentId": goodsAppointmentId, "backReason": reson},
        showMessage: true);
  }

  ///取消预约
  static Future cancelOrder(int goodsAppointmentId) async {
    BaseModel baseModel = await NetUtil().get(API.market.confirmReceive,
        params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
  }

  ///商品评价
  static Future goodsEvalution(
      int goodsAppointmentId, int rating, String evaluationReason) async {
    BaseModel baseModel = await NetUtil().get(API.market.confirmReceive,
        params: {
          "goodsAppointmentId": goodsAppointmentId,
          "score": rating,
          "evaluationReason": evaluationReason
        },
        showMessage: true);
  }
}
