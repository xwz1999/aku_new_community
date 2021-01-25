
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:flustars/flustars.dart';

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
      int type, String reportDetail, List<String> fileUrls) async {
    BaseModel baseModel = await NetUtil().post(
      API.manager.reportRepairInsert,
      params: {
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
}
