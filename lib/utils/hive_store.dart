import 'package:aku_new_community/model/user/province_model.dart';
import 'package:aku_new_community/models/login/china_region_model.dart';
import 'package:aku_new_community/models/login/history_login_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveStore {
  static Box? _appBox;

  static Box? get appBox => _appBox;
  static Box? _chinaRegionBox;
  static Box? get chinaRegionBox => _chinaRegionBox;

  static Future init() async {
    if (!kIsWeb) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      Hive.registerAdapter(ProvinceModelAdapter());
      Hive.registerAdapter(CityAdapter());
      Hive.registerAdapter(DistrictAdapter());
      Hive.registerAdapter(ChinaRegionModelAdapter());
      Hive.registerAdapter(HistoryLoginModelAdapter());
      _appBox = await Hive.openBox('app');
      _chinaRegionBox = await Hive.openBox('chinaRegionBox');
    }
  }
}
