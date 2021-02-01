// Package imports:
import 'package:akuCommunity/model/manager/article_QR_code_model.dart';
import 'package:akuCommunity/model/manager/moving_company_model.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';

// Project imports:
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/fixed_detail_model.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';

class ManagerFunc {
  static insertVisitorInfo(int id, int type, String name, int sex, String tel,
      String carNum, DateTime expectedVisitDate) async {
    BaseModel baseModel = await NetUtil().post(API.manager.insertVisitorInfo,
        params: {
          'buildingUnitEstateId': id,
          'type': type,
          'name': name,
          'sex': sex,
          'tel': tel,
          'carNum': carNum,
          'expectedVisitDate': DateUtil.formatDate(expectedVisitDate,
              format: "yyyy-MM-dd HH:mm:ss")
        },
        showMessage: true);
    return baseModel;
  }

  static reportRepairInsert(
      int id, int type, String reportDetail, List<String> fileUrls) async {
    BaseModel baseModel = await NetUtil().post(
      API.manager.reportRepairInsert,
      params: {
        'buildingUnitEstateId': id,
        'type': type,
        'reportDetail': reportDetail,
        'fileUrls': fileUrls,
      },
      showMessage: false,
    );
    return baseModel;
  }

  static reportRepairDelete(List<int> ids) async {
    BaseModel baseModel = await NetUtil().post(
      API.manager.reportRepairDelete,
      params: {'ids': ids},
      showMessage: true,
    );
    return baseModel;
  }

  static Future<FixedDetailModel> reportRepairFindBYLD(int id) async {
    Response response = await NetUtil().dio.get(
      API.manager.reportRepairFindBYLD,
      queryParameters: {
        'repairId': id,
      },
    );
    return FixedDetailModel.fromJson(response.data);
  }

  static Future<BaseModel> reportRepairCancel(int id) async {
    BaseModel baseModel = await NetUtil().get(API.manager.reportRepairCancel,
        params: {
          'repairId': id,
        },
        showMessage: true);
    return baseModel;
  }

  static Future<BaseModel> reportRepairEvaluate(
      int id, int rate, String text) async {
    BaseModel baseModel = await NetUtil().post(
      API.manager.reportRepairEvaluate,
      params: {
        'repairId': id,
        'evaluationLevel': rate,
        'evaluationContent': text,
      },
      showMessage: true,
    );
    return baseModel;
  }

  static Future<BaseModel> reportRepairComplete(int id) async {
    BaseModel baseModel = await NetUtil().get(
      API.manager.reportRepairComplete,
      params: {
        'repairId': id,
      },
      showMessage: true,
    );
    return baseModel;
  }

  static Future<MovingCompanyModel> getMovingCompanyTel() async {
    Response response = await NetUtil().dio.get(
          API.manager.getMovingCompanyTel,
        );
    return MovingCompanyModel.fromJson(response.data);
  }

  static Future<BaseModel> articleOutSubmit({
    int id,
    String name,
    int weight,
    int approach,
    String tel,
    String time,
    List<String> urls,
  }) async {
    BaseModel baseModel = await NetUtil().post(
      API.manager.articleOutSubmit,
      params: {
        'buildingUnitEstateId': id,
        'name': name,
        'weight': weight,
        'approach': approach,
        'movingCompanyTel': tel,
        'expectedTime':
            DateUtil.formatDateStr(time, format: "yyyy-MM-dd HH:mm:ss"),
        'imgUrls': urls,
      },
      showMessage: true,
    );
    return baseModel;
  }

  static Future<ArticleQRModel> getQRcode(int id) async {
    Response response = await NetUtil().dio.get(
      API.manager.getQRcode,
      queryParameters: {
        'articleOutId': id,
      },
    );
    return ArticleQRModel.fromJson(response.data);
  }

  static Future<BaseModel> articleOutDelete(List<int> ids) async {
    BaseModel baseModel = await NetUtil().post(
      API.manager.articleOutDelete,
      params: {'ids': ids},
      showMessage: true,
    );
    return baseModel;
  }
  
}
