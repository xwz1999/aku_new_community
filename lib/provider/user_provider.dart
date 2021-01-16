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
  setLogin(String token) {
    _isLogin = true;
    NetUtil().dio.options.headers.putIfAbsent('App-Admin-Token', () => token);
    HiveStore.appBox.put('token', token);
    notifyListeners();
  }

  logout() {
    _isLogin = false;
    _token = null;
    NetUtil().dio.options.headers.remove('App-Admin-Token');
    HiveStore.appBox.delete('token');
    notifyListeners();
  }

  updateProfile() async {
    // await
  }

  String _token;
  String get token => _token ?? '';
}
