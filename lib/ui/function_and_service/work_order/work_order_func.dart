import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/saas_model/work_order/work_order_bill_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class WorkOrderFuc {
  ///催促
  static Future<bool> promotionRate(int id) async {
    BaseModel baseModel = await NetUtil().get(SAASAPI.workOrder.promotionRate,
        params: {'workOrderId': id}, showMessage: true);
    return baseModel.success;
  }

  ///确认完成
  static Future<bool> confirmComplete(int id) async {
    BaseModel baseModel = await NetUtil().get(
        SAASAPI.workOrder.confirmCompletion,
        params: {'workOrderId': id},
        showMessage: true);
    return baseModel.success;
  }

  ///评价
  static Future<bool> evaluate({
    required int workOrderId,
    required int star,
    required String evaluation,
  }) async {
    var base = await NetUtil().get(SAASAPI.workOrder.evaluate,
        params: {
          'workOrderId': workOrderId,
          'evaluateLevel': star,
          'evaluateContent': evaluation
        },
        showMessage: true);
    return base.success;
  }

  ///取消
  static Future<bool> cancel({
    required int workOrderId,
  }) async {
    var base = await NetUtil().get(SAASAPI.workOrder.cancel,
        params: {
          'workOrderId': workOrderId,
        },
        showMessage: true);
    return base.success;
  }

  ///账单
  static Future<List<WorkOrderBillModel>> getBill({
    required int workOrderId,
  }) async {
    var models = <WorkOrderBillModel>[];
    var base = await NetUtil().get(SAASAPI.workOrder.cancel, params: {
      'workOrderId': workOrderId,
    });
    if (base.success) {
      models = (base.data as List)
          .map((e) => WorkOrderBillModel.fromJson(e))
          .toList();
    }
    return models;
  }

  ///发布工单
  static Future<bool> publish({
    required int estateId,
    required int workOrderTypeId,
    required String reserveDate,
    required String reserveAddress,
    required String content,
    required List<String> imgUrls,
  }) async {
    var base = await NetUtil().post(SAASAPI.workOrder.insert,
        params: {
          'estateId': estateId,
          'workOrderTypeId': workOrderTypeId,
          'reserveDate': reserveDate,
          'reserveAddress': reserveAddress,
          'content': content,
          'imgUrls': imgUrls,
        },
        showMessage: true);

    return base.success;
  }
}
