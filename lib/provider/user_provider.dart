import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/models/user/my_house_model.dart';
import 'package:aku_new_community/models/user/user_config_model.dart';
import 'package:aku_new_community/models/user/user_info_model.dart';
import 'package:aku_new_community/pages/sign/sign_func.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/utils/websocket/web_socket_util.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  bool get isNotLogin => !_isLogin;

  Future init() async {
    if (isLogin) {
      await updateUserInfo();
      WebSocketUtil().startWebSocket();
      await updateMyHouseInfo();

      ///初始化用户配置
      _userConfig = await HiveStore.userBox!.get('${_userInfoModel!.id}') ??
          UserConfigModel(
              userId: _userInfoModel!.id,
              clockRemind: false,
              todayClocked: false);
      SignFunc.checkNameAndAccount();
    }
  }

  Future setLogin(int token) async {
    final appProvider = Provider.of<AppProvider>(Get.context!, listen: false);
    _isLogin = true;
    NetUtil().dio!.options.headers['app-login-token'] = token;
    HiveStore.appBox!.put('token', token);
    HiveStore.appBox!.put('login', true);
    await init();
    notifyListeners();
  }

  logout() {
    if (!kIsWeb && !Platform.isMacOS) JPush().deleteAlias();
    final appProvider = Provider.of<AppProvider>(Get.context!, listen: false);
    appProvider.setCurrentHouse(null);
    if (_isLogin) {
      NetUtil().post(SAASAPI.login.logOut, showMessage: true);
      NetUtil().dio!.options.headers.remove('app-login-token');
      _isLogin = false;
    }
    _token = null;
    _userInfoModel = null;
    _myHouses = [];
    HiveStore.appBox!.delete('token');
    HiveStore.appBox!.delete('login');
    WebSocketUtil().closeWebSocket();
    notifyListeners();
  }

  ///更新用户信息
  Future updateUserInfo() async {
    _userInfoModel = await SignFunc.getUserInfo();
    if (_userInfoModel == null) {
      BotToast.showText(text: '获取用户信息失败');
    }
    if (_userInfoModel != null && !kIsWeb && !Platform.isMacOS) {}
    notifyListeners();
  }

  ///更新我的房屋列表
  Future updateMyHouseInfo() async {
    _myHouses = await SignFunc.getMyHouseInfo();
    if (_myHouses.isEmpty) {
      _defaultHouse = null;
    } else {
      for (var item in _myHouses) {
        if (item.isDefault == 1) {
          _defaultHouse = item;
        }
      }
    }
    notifyListeners();
  }

  String? _token;

  String get token => _token ?? '';

  UserInfoModel? _userInfoModel;

  UserInfoModel? get userInfoModel => _userInfoModel;

  ///我的房屋列表
  List<MyHouseModel> _myHouses = [];

  List<MyHouseModel> get myHouses => _myHouses;
  MyHouseModel? _defaultHouse;

  MyHouseModel? get defaultHouse => _defaultHouse;

  void updateDefaultHouse() => notifyListeners();

  String get defaultHouseString {
    if (_defaultHouse == null) {
      return '暂无绑定房屋';
    } else {
      return _defaultHouse!.buildingName +
          '栋' +
          _defaultHouse!.unitName +
          '单元' +
          _defaultHouse!.estateName +
          '室';
    }
  }

  ///设置性别
  Future setSex(int sex) async {
    BaseModel baseModel = await NetUtil().get(
      SAASAPI.user.updateSex,
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
      await updateUserInfo();
      notifyListeners();
    }
  }

  //修改昵称
  Future setName(String name) async {
    var re = await SignFunc.setNickName(name);
    if (re) {
      await updateUserInfo();
      notifyListeners();
    }
  }

  //修改手机号
  Future updateTel(String oldTel, String newTel, String code) async {
    BaseModel baseModel = await NetUtil().post(
      SAASAPI.user.updateTel,
      params: {'tel': oldTel, 'newTel': newTel, 'telCode': code},
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
      SAASAPI.user.updateAvatar,
      params: {
        'imgUrls': [path]
      },
      showMessage: true,
    );
    if (model.success) {
      await updateUserInfo();
    }
    notifyListeners();
  }

  ///用户配置
  ///签到提醒
  ///今日签到
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
