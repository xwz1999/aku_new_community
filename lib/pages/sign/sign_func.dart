import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/user/pick_building_model.dart';
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

  static Future<Response> login(String phone, String code) async {
    Response response = await NetUtil().dio.post(
      API.login.loginBySMS,
      data: {'tel': phone, 'code': code},
    );
    return response;
  }

  static Future<List<PickBuildingModel>> getBuildingInfo() async {
    BaseModel model = await NetUtil().get(API.login.buildingInfo);
    return (model.data as List)
        .map((e) => PickBuildingModel.fromJson(e))
        .toList();
  }

  static Future<List<PickBuildingModel>> getUnitInfo(int id) async {
    BaseModel model = await NetUtil().get(
      API.login.unitInfo,
      params: {"buildingId": id},
    );
    return (model.data as List)
        .map((e) => PickBuildingModel.fromJson(e))
        .toList();
  }
}
