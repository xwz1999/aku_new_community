import 'package:akuCommunity/constants/application_objects.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  ///初始值为
  ///
  ///```
  ///'一键开门',
  /// '访客邀请',
  /// '报事报修',
  /// '生活缴费',
  /// '业委会',
  /// '建议投诉',
  /// '便民电话',
  ///```
  List<AO> _myApplications = [
    '一键开门',
    '访客邀请',
    '报事报修',
    '生活缴费',
    '业委会',
    '建议咨询',
    '便民电话',
  ].map((e) => AO.fromRaw(e)).toList();

  ///我的应用
  List<AO> get myApplications {
    return _myApplications;
  }

  ///添加我的应用
  insertApplication(AO app) {
    if (!_myApplications.contains(app) && _myApplications.length < 7)
      _myApplications.insert(0, app);
    notifyListeners();
  }

  ///移除我的应用
  removeApplication(AO obj) {
    if (_myApplications.remove(obj)) notifyListeners();
  }
}
