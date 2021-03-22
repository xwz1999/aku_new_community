import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/message/system_message_detail_model.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';

class MessageFunc {
  static Future<SystemMessageDetailModel> getSystemMessageDetial(int id) async {
    BaseModel baseModel =
        await NetUtil().get(API.message.getSystemMessageDetial, params: {
      'sysMessageId': id,
    });
    return SystemMessageDetailModel.fromJson(baseModel.data);
  }
}
