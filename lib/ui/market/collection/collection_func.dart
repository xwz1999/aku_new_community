import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/collection/collection_goods_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class CollectionFunc {
  ///加入和取消收藏
  static Future collection(int jcookGoodsId) async {
    await NetUtil().get(SARSAPI.market.collection.changeCollection,
        params: {"appGoodsPushId": jcookGoodsId}, showMessage: true);
  }

  /// 获取此供应商热度最高的商品
  static Future<List<CollectionGoodsModel>> getCollectionList() async {
    BaseModel baseModel =
        await NetUtil().get(SARSAPI.market.collection.myCollection);
    if (baseModel.success == true && baseModel.data != null) {
      return (baseModel.data as List)
          .map((e) => CollectionGoodsModel.fromJson(e))
          .toList();
    }
    return [];
  }

// ///确认收货
// static Future confirmReceive(int goodsAppointmentId) async {
//   await NetUtil().get(API.market.confirmReceive,
//       params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
// }
//
// ///申请退换
// static Future refundOrder(
//     int goodsAppointmentId, String reson, int type) async {
//   BaseModel baseModel = await NetUtil().get(API.market.refundOrder,
//       params: {
//         "goodsAppointmentId": goodsAppointmentId,
//         "backReason": reson,
//         "backType": type
//       },
//       showMessage: true);
//   return baseModel;
// }
//
// ///取消预约
// static Future cancelOrder(int goodsAppointmentId) async {
//   BaseModel baseModel = await NetUtil().get(API.market.cancleOrder,
//       params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
//   return baseModel;
// }
//
// ///商品评价
// static Future goodsEvalution(
//     int goodsAppointmentId, int rating, String evaluationReason) async {
//   BaseModel baseModel = await NetUtil().get(API.market.goodsEvaluation,
//       params: {
//         "goodsAppointmentId": goodsAppointmentId,
//         "score": rating,
//         "evaluationReason": evaluationReason
//       },
//       showMessage: true);
//   return baseModel;
// }
//
// /// 获取此供应商热度最高的商品
// static Future<List<GoodsItem>> getHotTops(int supplierId) async {
//   BaseModel baseModel =
//   await NetUtil().get(API.market.suppliyerHotTop, params: {
//     "supplierId": supplierId,
//   });
//   if (baseModel.success == true && baseModel.data != null) {
//     return (baseModel.data as List)
//         .map((e) => GoodsItem.fromJson(e))
//         .toList();
//   }
//   return [];
// }
//
// ///获取商品详情
// static Future getOrderDetail(int goodsAppointmentId) async {
//   BaseModel baseModel = await NetUtil().get(API.market.orderDetail,
//       params: {"goodsAppointmentId": goodsAppointmentId});
//   if (baseModel.success && baseModel.data != null) {
//     return OrderDetailModel.fromJson(baseModel.data);
//   }
// }
}
