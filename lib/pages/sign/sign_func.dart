import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:dio/dio.dart';

class SignFunc {
  static Future sendMessageCode(String phone) async {
    BaseModel baseModel = await NetUtil().post(
      API.login.sendSMSCode,
      params: {'tel': phone},
      showMessage: true,
    );
    return baseModel;
  }

  static Future<String> login(String phone, String code) async {
    Response response = await NetUtil().dio.post(
      API.login.loginBySMS,
      data: {'tel': phone, 'code': code},
    );
    return response.data['token'];
  }
}
