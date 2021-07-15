import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/house_keeping/house_keeping_process_model.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:bot_toast/bot_toast.dart';

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
    if (baseModel.status ?? false) {
      return true;
    } else {
      return false;
    }
  }

  ///获取家政服务进程
  static Future getHouseKeepingProcess(int id) async {
    BaseModel baseModel = await NetUtil().get(API.manager.houseKeepingProcess,
        params: {"housekeepingServiceId": id});
    if (baseModel.status ?? false) {
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
    if (baseModel.status ?? false) {
      BotToast.showText(text: '取消成功');
      return true;
    } else {
      return false;
    }
  }
}
