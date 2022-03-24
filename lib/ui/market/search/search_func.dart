import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/models/market/good_detail_model.dart';
import 'package:aku_new_community/models/market/order/order_detail_model.dart';
import 'package:aku_new_community/models/search/search_goods_model.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/utils/text_utils.dart';
import 'package:bot_toast/bot_toast.dart';

class SearchFunc {
  /// 搜索商品 根据关键字
  static Future<List<SearchGoodsModel>> getGoodsList(
      int pageNum,
      int size,
      int orderBySalesVolume,
      int orderByPrice,
      String keyword,
      int brandId,
      double minPrice,
      double maxPrice) async {
    //orderBySalesVolume 1降序 2升序
    Map<String, dynamic> params = {
      "pageNum": pageNum,
      "size": size,
    };
    if (orderBySalesVolume != -1) {
      params.putIfAbsent("orderBySalesVolume", () => orderBySalesVolume);
    }
    if (orderByPrice != -1) {
      params.putIfAbsent("orderByPrice", () => orderByPrice);
    }
    if (!TextUtils.isEmpty(keyword)) {
      params.putIfAbsent("keyword", () => keyword);
    }
    if (brandId != -1) {
      params.putIfAbsent("brandId", () => brandId);
    }
    if (minPrice != -1) {
      params.putIfAbsent("minPrice", () => minPrice);
    }
    if (maxPrice != -1) {
      params.putIfAbsent("maxPrice", () => maxPrice);
    }

    BaseListModel model = await NetUtil().getList(
      API.market.findGoodsList,
      params: params,
    );
    if (model.rows.length == 0) return [];
    return model.rows.map((e) => SearchGoodsModel.fromJson(e)).toList();
  }

  ///查询商品详情
  static Future<GoodDetailModel> getGoodDetail(
      int shopId, int? addressId) async {
    BaseModel model = await NetUtil().get(
      SAASAPI.market.good.goodDetail,
      params: {'appGoodsPushId': shopId, 'appGoodsAddressId': addressId},
    );
    if (model.data == null) return GoodDetailModel.fail();
    return GoodDetailModel.fromJson(model.data);
  }

  ///查询商品详情图
  static Future<List> getGoodDetailImage(int shopId) async {
    BaseModel model = await NetUtil().get(
      API.market.findGoodsDetailBigInfo,
      params: {'shopId': shopId},
    );
    if (model.data == null) return [];
    return model.data!.map((e) => e as String).toList();
  }

  ///加入购物车
  static Future<bool> addGoodsCar(int jcookGoodsId) async {
    BaseModel model = await NetUtil().get(
      SAASAPI.market.shopCart.insert,
      params: {'appGoodsPushId': jcookGoodsId},
    );
    if (!model.success) {
      BotToast.showText(text: model.msg);
    }
    return model.success;
  }

  ///确认收货
  static Future confirmReceive(int goodsAppointmentId) async {
    await NetUtil().get(API.market.confirmReceive,
        params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
  }

  ///申请退换
  static Future refundOrder(
      int goodsAppointmentId, String reson, int type) async {
    BaseModel baseModel = await NetUtil().get(API.market.refundOrder,
        params: {
          "goodsAppointmentId": goodsAppointmentId,
          "backReason": reson,
          "backType": type
        },
        showMessage: true);
    return baseModel;
  }

  ///取消预约
  static Future cancelOrder(int goodsAppointmentId) async {
    BaseModel baseModel = await NetUtil().get(API.market.cancleOrder,
        params: {"goodsAppointmentId": goodsAppointmentId}, showMessage: true);
    return baseModel;
  }

  ///商品评价
  static Future goodsEvalution(
      int goodsAppointmentId, int rating, String evaluationReason) async {
    BaseModel baseModel = await NetUtil().get(API.market.goodsEvaluation,
        params: {
          "goodsAppointmentId": goodsAppointmentId,
          "score": rating,
          "evaluationReason": evaluationReason
        },
        showMessage: true);
    return baseModel;
  }

  ///获取商品详情
  static Future getOrderDetail(int goodsAppointmentId) async {
    BaseModel baseModel = await NetUtil().get(API.market.orderDetail,
        params: {"goodsAppointmentId": goodsAppointmentId});
    if (baseModel.success && baseModel.data != null) {
      return OrderDetailModel.fromJson(baseModel.data);
    }
  }
}
