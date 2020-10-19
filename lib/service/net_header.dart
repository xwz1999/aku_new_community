import 'package:akuCommunity/utils/sp_key.dart';
import 'package:akuCommunity/utils/sp_util.dart';

class NetHeader {
  /// 自定义Header
  static String appID = 'MOBILE-APP-ZNY';
  static String appSecret = '293FCB579B80BC1D5E6414F0B41C6FF4';
  static Map<String, dynamic> dmsHeaders = {
    'AppID': appID,
    'AppSecret': appSecret,
  };
  static Future<Map<String, dynamic>> getZnToken() async {
    String znToken = await SpUtil.getString(SpKey.zntoken);
    return {'Authorization': znToken ?? ''};
  }
}
