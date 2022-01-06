import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/login/china_region_model.dart';
import 'package:aku_new_community/models/login/history_login_model.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  Future init() async {
    updateCityList();
    _loginHistories = HiveStore.dataBox!
            .get('historyLogin')
            ?.cast<HistoryLoginModel>()
            .toList() ??
        [];
  }

  List<ChinaRegionModel> _cityModel = [];

  List<ChinaRegionModel> get cityModel => _cityModel;

  Future<bool> updateCityList() async {
    var model = await NetUtil().get(SARSAPI.city.allCity);
    if (model.success) {
      _cityModel = (model.data as List)
          .map((e) => ChinaRegionModel.fromJson(e))
          .toList();
      HiveStore.dataBox!.put('cities', _cityModel);
      return true;
    } else {
      return false;
    }
  }

  List<HistoryLoginModel> _loginHistories = [];

  List<HistoryLoginModel> get loginHistories => _loginHistories;

  Future addHistories(HistoryLoginModel model) async {
    _loginHistories.insert(0, model);
    if (_loginHistories.length > 4) {
      _loginHistories.removeAt(_loginHistories.length - 1);
    }
    HiveStore.dataBox!.put('historyLogin', _loginHistories);
  }
}
