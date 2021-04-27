import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/user/pick_building_model.dart';
import 'package:aku_community/model/user/user_detail_model.dart';
import 'package:aku_community/model/user/user_info_model.dart';
import 'package:aku_community/provider/sign_up_provider.dart';
import 'package:aku_community/provider/user_provider.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';

class SignFunc {
  static Future sendMessageCode(String phone) async {
    BaseModel baseModel = await NetUtil().post(
      API.login.sendSMSCode,
      params: {'tel': phone},
      showMessage: true,
    );
    return baseModel;
  }

  static Future sendNewMessageCode(String newTel) async {
    BaseModel baseModel = await NetUtil().post(
      API.login.sendNewMSCode,
      params: {'newTel': newTel},
      showMessage: true,
    );
    return baseModel;
  }

  static Future<Response> login(String phone, String code) async {
    Response response = await NetUtil().dio!.post(
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

  static Future<List<PickBuildingModel>> getUnitInfo(int? id) async {
    BaseModel model = await NetUtil().get(
      API.login.unitInfo,
      params: {"buildingId": id},
    );
    return (model.data as List)
        .map((e) => PickBuildingModel.fromJson(e))
        .toList();
  }

  ///注册
  static Future<bool> signUp() async {
    final signUpProvider =
        Provider.of<SignUpProvider>(Get.context!, listen: false);
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);
    Response response = await NetUtil().dio!.post(
          API.login.signUp,
          data: signUpProvider.toMap,
        );
    BotToast.showText(text: response.data['message']);
    if (response.data['status']) {
      userProvider.setLogin(response.data['token']);
      return true;
    } else
      return false;
  }

  static Future<UserInfoModel?> getUserInfo() async {
    BaseModel baseModel = await NetUtil().get(API.user.userProfile);
    if (baseModel.data == null) return null;
    return UserInfoModel.fromJson(baseModel.data);
  }

  static Future<UserDetailModel?> getUserDetail() async {
    BaseModel baseModel = await NetUtil().get(
      API.user.userDetail,
    );
    if (baseModel.data == null) return null;
    return UserDetailModel.fromJson(baseModel.data);
  }
}
