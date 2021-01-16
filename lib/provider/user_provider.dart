import 'package:akuCommunity/utils/hive_store.dart';
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
  setLogin(bool state, String token) {
    _isLogin = state;
    HiveStore.appBox.put('token', token);
    notifyListeners();
  }

  logout() {
    _isLogin = false;
    _token = null;
    HiveStore.appBox.delete('token');
    notifyListeners();
  }

  String _token;
  String get token => _token ?? '';
}
