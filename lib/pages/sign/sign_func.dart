import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/user/pick_building_model.dart';
import 'package:aku_new_community/models/user/my_house_model.dart';
import 'package:aku_new_community/models/user/user_info_model.dart';
import 'package:aku_new_community/pages/sign/login/set_nick_name_page.dart';
import 'package:aku_new_community/pages/sign/login/set_psd_page.dart';
import 'package:aku_new_community/pages/tab_navigator.dart';
import 'package:aku_new_community/provider/sign_up_provider.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';

class SignFunc {
  //发送手机号验证码
  static Future<BaseModel> sendMessageCode(
      String phone, int communityId) async {
    BaseModel baseModel = await NetUtil().post(
      SAASAPI.login.sendSMSCode,
      params: {'tel': phone, 'communityId': communityId},
      showMessage: true,
    );
    return baseModel;
  } //发送手机号验证码

  static Future<BaseModel> sendForgotMessageCode(
      String phone, int communityId) async {
    BaseModel baseModel = await NetUtil().post(
      SAASAPI.user.sendForgotTelCode,
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
      SAASAPI.login.login,
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
      SAASAPI.login.loginTelCode,
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

  ///更新用户信息
  static Future<UserInfoModel?> getUserInfo() async {
    BaseModel baseModel = await NetUtil().get(SAASAPI.user.userProfile);
    if (baseModel.data == null || !baseModel.success) return null;
    return UserInfoModel.fromJson(baseModel.data);
  }

  ///设置密码（密码不存在时调用
  static Future<bool> settingPsd(String psd) async {
    BaseModel baseModel = await NetUtil().get(SAASAPI.user.settingPsd,
        params: {'password': psd}, showMessage: true);
    if (baseModel.data == null || !baseModel.success) return false;
    return true;
  }

  ///提交修改的新密码（忘记密码）
  static Future<bool> settingForgotPsd(
      String psd, String tel, String telcode) async {
    BaseModel baseModel = await NetUtil().get(SAASAPI.user.settingForgotPsd,
        params: {
          'newPassword': psd,
          'tel': tel,
          'telCode': telcode,
          'communityId':
              UserTool.appProvider.pickedCityAndCommunity!.communityModel!.id
        },
        showMessage: true);
    if (baseModel.data == null || !baseModel.success) return false;
    return true;
  }

  ///获取用户房屋列表
  static Future<List<MyHouseModel>> getMyHouseInfo() async {
    BaseModel baseModel = await NetUtil().get(
      SAASAPI.profile.house.userHouse,
    );
    if ((baseModel.data as List).isEmpty) return [];
    return (baseModel.data as List)
        .map((e) => MyHouseModel.fromJson(e))
        .toList();
  }

  static Future checkNameAndAccount() async {
    if (!UserTool.userProvider.userInfoModel!.isExistPassword) {
      await Get.to(() => SetPsdPage());
    } else if (UserTool.userProvider.userInfoModel!.nickName == null) {
      await Get.to(() => SetNickNamePage());
    } else {
      Get.offAll(() => TabNavigator());
    }
  }

  ///检测昵称是否重复
  static Future<bool> checkNickRepeat(String nick) async {
    BaseModel baseModel = await NetUtil().get(SAASAPI.user.checkNickRepeat,
        params: {
          'nickName': nick,
        },
        showMessage: true);
    return baseModel.msg == '昵称可用';
  }

  ///设置昵称
  static Future<bool> setNickName(String nick) async {
    BaseModel baseModel = await NetUtil().get(SAASAPI.user.setNickName,
        params: {
          'nickName': nick,
        },
        showMessage: true);
    return baseModel.msg == '设置成功';
  }
}
