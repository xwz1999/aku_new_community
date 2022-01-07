import 'dart:io';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/user/my_house_model.dart';
import 'package:aku_new_community/models/user/user_config_model.dart';
import 'package:aku_new_community/models/user/user_info_model.dart';
import 'package:aku_new_community/pages/sign/sign_func.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/profile/house/house_func.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/utils/websocket/web_socket_util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  bool get isNotLogin => !_isLogin;

  Future setLogin(int token) async {
    // try {
    final appProvider = Provider.of<AppProvider>(Get.context!, listen: false);
    _isLogin = true;
    NetUtil().dio!.options.headers['app-login-token'] = token;
    HiveStore.appBox!.put('token', token);
    HiveStore.appBox!.put('login', true);
    await updateUserInfo();
    // await updateMyHouseInfo();

    ///初始化用户配置
    _userConfig = await HiveStore.userBox!.get('${_userInfoModel!.id}') ??
        UserConfigModel(
            userId: _userInfoModel!.id,
            clockRemind: false,
            todayClocked: false);
    await appProvider.updateHouses(await HouseFunc.passedHouses);
    if (isLogin) {
      WebSocketUtil().setUser(userInfoModel!.id.toString());
      WebSocketUtil().startWebSocket();
    }
    notifyListeners();
    // } catch (e) {
    //   LoggerData.addData(e);
    // }
  }

  logout() {
    if (!kIsWeb && !Platform.isMacOS) JPush().deleteAlias();
    final appProvider = Provider.of<AppProvider>(Get.context!, listen: false);
    appProvider.setCurrentHouse(null);
    _isLogin = false;
    _token = null;
    _userInfoModel = null;
    _myHouses = [];
    NetUtil().get(API.user.logout, showMessage: true);
    NetUtil().dio!.options.headers.remove('app-login-token');
    HiveStore.appBox!.delete('token');
    HiveStore.appBox!.delete('login');
    WebSocketUtil().closeWebSocket();
    notifyListeners();
  }

  Future<bool> updateUserInfo() async {
    _userInfoModel = await SignFunc.getUserInfo();
    if (_userInfoModel == null) {
      BotToast.showText(text: '获取用户信息失败');
      return false;
    }
    if (_userInfoModel != null && !kIsWeb && !Platform.isMacOS) {
      SignFunc.checkNameAndAccount();
    }

    notifyListeners();
    return true;
  }

  Future updateMyHouseInfo() async {
    _myHouses = await SignFunc.getMyHouseInfo();
    notifyListeners();
  }

  String? _token;

  String get token => _token ?? '';

  UserInfoModel? _userInfoModel;

  UserInfoModel? get userInfoModel => _userInfoModel;

  List<MyHouseModel> _myHouses = [];

  List<MyHouseModel> get myHouses => _myHouses;

  ///设置性别
  Future setSex(int sex) async {
    BaseModel baseModel = await NetUtil().post(
      API.user.setSex,
      params: {'sex': sex},
      showMessage: true,
    );
    if (baseModel.success) {
      await updateUserInfo();
      notifyListeners();
    }
  }

  ///设置生日
  Future setBirthday(DateTime date) async {
    BaseModel baseModel = await NetUtil().post(
      API.user.setBirthday,
      params: {
        'birthday': DateUtil.formatDate(date, format: "yyyy-MM-dd HH:mm:ss")
      },
      showMessage: true,
    );
    if (baseModel.success) {
      // _userInfoModel!.birthday =
      //     DateUtil.formatDate(date, format: "yyyy-MM-dd HH:mm:ss");
      notifyListeners();
    }
  }

  //修改昵称
  Future setName(String name) async {
    BaseModel baseModel = await NetUtil().post(
      API.user.updateNickName,
      params: {'nickName': name},
      showMessage: true,
    );
    if (baseModel.success) {
      // _userInfoModel!.nickName = name;
      notifyListeners();
    }
  }

  //修改手机号
  Future updateTel(String oldTel, String newTel, String code) async {
    BaseModel baseModel = await NetUtil().post(
      API.user.updateTel,
      params: {'oldTel': oldTel, 'newTel': newTel, 'code': code},
      showMessage: true,
    );
    if (baseModel.success) {
      await updateUserInfo();
      notifyListeners();
    }
  }

  ///修改头像
  Future updateAvatar(String? path) async {
    BaseModel model = await NetUtil().post(
      API.user.udpdateAvatar,
      params: {
        'fileUrls': [path]
      },
      showMessage: true,
    );
    if (model.success) {
      await updateUserInfo();
    }
  }

  UserConfigModel _userConfig =
      UserConfigModel(userId: 0, clockRemind: false, todayClocked: false);

  UserConfigModel get userConfig => _userConfig;

  Future changeClockRemind() async {
    _userConfig.clockRemind = !_userConfig.clockRemind;
    await updateUserConfig();
    notifyListeners();
  }

  Future changeTodayClocked() async {
    _userConfig.todayClocked = true;
    await updateUserConfig();
    notifyListeners();
  }

  Future updateUserConfig() async {
    HiveStore.userBox!.put('${_userConfig.userId}', _userConfig);
  }
}
