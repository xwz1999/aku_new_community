import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/message/system_message_detail_model.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';

class MessageFunc {
  static Future<SystemMessageDetailModel> getSystemMessageDetial(int id) async {
    BaseModel baseModel =
        await NetUtil().get(API.message.getSystemMessageDetial, params: {
      'sysMessageId': id,
    });
    return SystemMessageDetailModel.fromJson(baseModel.data);
  }
}
