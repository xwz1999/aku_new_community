import 'package:bot_toast/bot_toast.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/message/system_message_detail_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class MessageFunc {
  static Future<SystemMessageDetailModel> getSystemMessageDetial(
      int? id) async {
    BaseModel baseModel =
        await NetUtil().get(API.message.getSystemMessageDetial, params: {
      'sysMessageId': id,
    });
    return SystemMessageDetailModel.fromJson(baseModel.data);
  }

  static Future<bool> readMessage(int? id) async {
    BaseModel baseModel = await NetUtil().get(SAASAPI.message.read, params: {
      'messageId': id,
    });
    if (baseModel.success) {
      return true;
    } else {
      BotToast.showText(text: baseModel.msg);
      return false;
    }
  }
}
