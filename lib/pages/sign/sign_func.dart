import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/model/user/pick_building_model.dart';
import 'package:aku_new_community/models/user/my_house_model.dart';
import 'package:aku_new_community/models/user/user_info_model.dart';
import 'package:aku_new_community/pages/sign/login/set_psd_page.dart';
import 'package:aku_new_community/pages/sign/sign_up/sign_up_set_nickname_page.dart';
import 'package:aku_new_community/provider/sign_up_provider.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';

import '../tab_navigator.dart';

class SignFunc {
  //发送手机号验证码
  static Future<BaseModel> sendMessageCode(
      String phone, int communityId) async {
    BaseModel baseModel = await NetUtil().post(
      SARSAPI.login.sendSMSCode,
      params: {'tel': phone, 'communityId': communityId},
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

  //登录
  static Future<Response> login(
      String phone, String code, int communityId) async {
    Response response = await NetUtil().dio!.post(
      API.login.login,
      data: {
        'tel': phone,
        'password': code,
        'communityId': communityId,
      },
    );
    return response;
  }

  //验证码登录
  static Future<Response> loginBySms(
      String phone, String code, int communityId) async {
    Response response = await NetUtil().dio!.post(
      API.login.login,
      data: {
        'tel': phone,
        'code': code,
        'communityId': communityId,
      },
    );
    return response;
  }

  ///获取楼栋
  static Future<List<PickBuildingModel>> getBuildingInfo() async {
    BaseModel model = await NetUtil().get(API.login.buildingInfo);
    return (model.data as List)
        .map((e) => PickBuildingModel.fromJson(e))
        .toList();
  }

  ///获取单元
  static Future<List<PickBuildingModel>> getUnitInfo(int? id) async {
    BaseModel model = await NetUtil().get(
      API.login.unitInfo,
      params: {"buildingId": id},
    );
    return (model.data as List)
        .map((e) => PickBuildingModel.fromJson(e))
        .toList();
  }

  ///获取房间
  static Future<List<PickBuildingModel>> getRoom(int? id) async {
    BaseModel model = await NetUtil().get(
      API.login.room,
      params: {"unitId": id},
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
    if (baseModel.data == null || !baseModel.success) return null;
    return UserInfoModel.fromJson(baseModel.data);
  }

  static Future<MyHouseModel?> getMyHouseInfo() async {
    BaseModel baseModel = await NetUtil().get(
      SARSAPI.profile.house.userHouse,
    );
    if (baseModel.data == null) return null;
    return MyHouseModel.fromJson(baseModel.data);
  }

  static Future checkNameAndAccount() async {
    if (!UserTool.userProvider.userInfoModel!.isExistPassword) {
      await Get.to(() => SetPsdPage());
    } else if (UserTool.userProvider.userInfoModel!.nickName == null) {
      await Get.to(() => SignUpSetNicknamePage());
    } else {
      Get.offAll(() => TabNavigator());
    }
  }
}
