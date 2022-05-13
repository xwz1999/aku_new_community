import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:aku_new_community/model/user/province_model.dart';
import 'package:aku_new_community/models/user/user_config_model.dart';
import 'package:aku_new_community/saas_model/login/china_region_model.dart';
import 'package:aku_new_community/saas_model/login/community_model.dart';
import 'package:aku_new_community/saas_model/login/history_login_model.dart';
import 'package:aku_new_community/saas_model/login/picked_city_model.dart';

class HiveStore {
  static Box? _appBox;

  static Box? get appBox => _appBox;
  static Box? _userBox;

  static Box? get userBox => _userBox;
  static Box? _dataBox;

  static Box? get dataBox => _dataBox;
  static Box? _shortcutBox;

  static Box? get shortcutBox => _shortcutBox;

  static Box? _workOrderShortBox;

  static Box? get workOrderShortBox => _workOrderShortBox;

  static Future init() async {
    if (!kIsWeb) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      Hive.registerAdapter(ProvinceModelAdapter()); //HiveTypeId:0
      Hive.registerAdapter(CityAdapter()); //HiveTypeId:1
      Hive.registerAdapter(DistrictAdapter()); //HiveTypeId:2
      Hive.registerAdapter(ChinaRegionModelAdapter()); //HiveTypeId:3
      Hive.registerAdapter(HistoryLoginModelAdapter()); //HiveTypeId:4
      Hive.registerAdapter(UserConfigModelAdapter()); //HiveTypeId:5
      Hive.registerAdapter(PickedCityModelAdapter()); //HiveTypeId:6
      Hive.registerAdapter(CommunityModelAdapter()); //HiveTypeId:7
      _appBox = await Hive.openBox('app');
      _userBox = await Hive.openBox('userBox');
      _dataBox = await Hive.openBox('dataBox');
      _shortcutBox = await Hive.openBox('shortcut');
      _workOrderShortBox = await Hive.openBox('workOrderShort');
    }
  }
}
