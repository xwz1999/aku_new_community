import 'package:flutter/material.dart';
class UserProvider extends ChangeNotifier{
  //登录状态管理
  bool _isSigned =false;
  get isSigned => _isSigned;
  setisSigned(bool state){
    _isSigned=state;
    notifyListeners();
  }
}