import 'package:aku_community/constants/api.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';

class HouseKeepingFunc {
 static Future submitHouseKeeping(
    int estateId,
    int type,
    String content,
    List<String> urls
  ) async {
    BaseModel baseModel = await NetUtil().post(API.manager.submitHouseKeeping,
        params: {"estateId": estateId, "type": type, "content": content,"submitImgUrls":urls});
    if (baseModel.status ?? false) {
      return true;
    } else {
      return false;
    }
  }
}
