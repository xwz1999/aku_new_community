// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/constants/application_objects.dart';
import 'package:akuCommunity/utils/hive_store.dart';

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

  ///初始化我的应用
  initApplications() {
    if (HiveStore.appBox.containsKey('app'))
      _myApplications = (HiveStore.appBox.get('app') as List<String>)
          .map((e) => AO.fromRaw(e))
          .toList();
    notifyListeners();
  }

  ///添加我的应用
  insertApplication(AO app) {
    if (!_myApplications.contains(app) && _myApplications.length < 7)
      _myApplications.insert(0, app);
    if (!_myApplications.contains(app) && _myApplications.length >= 7) {
      _myApplications.insert(0, app);
      _myApplications.removeLast();
    }
    HiveStore.appBox.put('app', _myApplications.map((e) => e.title).toList());
    notifyListeners();
  }

  ///移除我的应用
  removeApplication(AO obj) {
    if (_myApplications.remove(obj)) notifyListeners();
  }
}
