import 'package:akuCommunity/model/user/user_info_model.dart';
import 'package:akuCommunity/pages/sign/sign_func.dart';
import 'package:akuCommunity/utils/hive_store.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  //登录状态管理
  bool _isSigned = false;
  get isSigned => _isSigned;
  setisSigned(bool state) {
    _isSigned = state;
    notifyListeners();
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  Future setLogin(int token) async {
    _isLogin = true;
    NetUtil().dio.options.headers.putIfAbsent('App-Admin-Token', () => token);
    HiveStore.appBox.put('token', token);
    await updateProfile();
    notifyListeners();
  }

  logout() {
    _isLogin = false;
    _token = null;
    _userInfoModel = null;
    NetUtil().dio.options.headers.remove('App-Admin-Token');
    HiveStore.appBox.delete('token');
    notifyListeners();
  }

  Future updateProfile() async {
    _userInfoModel = await SignFunc.getUserInfo();
    notifyListeners();
  }

  String _token;
  String get token => _token ?? '';

  UserInfoModel _userInfoModel;
  UserInfoModel get userInfoModel => _userInfoModel;
}
