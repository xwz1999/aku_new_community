import 'dart:io';

import 'package:flutter/material.dart';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:dio/dio.dart';
import 'package:power_logger/power_logger.dart';

import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/constants/application_objects.dart';
import 'package:akuCommunity/model/common/real_time_weather_model.dart';
import 'package:akuCommunity/model/community/hot_topic_model.dart';
import 'package:akuCommunity/model/message/message_center_model.dart';
import 'package:akuCommunity/utils/hive_store.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';

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
    if (_myApplications.remove(obj)) {
      HiveStore.appBox.put('app', _myApplications.map((e) => e.title).toList());
      notifyListeners();
    }
  }

  List<HotTopicModel> _hotTopicModels = [];
  List<HotTopicModel> get hotTopicModels => _hotTopicModels;
  updateHotTopicModel() async {
    BaseModel model = await NetUtil().get(API.community.hotTopic);
    _hotTopicModels =
        (model.data as List).map((e) => HotTopicModel.fromJson(e)).toList();
    notifyListeners();
  }

  RealTimeWeatherModel _weatherModel;
  RealTimeWeatherModel get weatherModel => _weatherModel;

  String get weatherTemp =>
      _weatherModel?.result?.realtime?.temperature?.toStringAsFixed(0) ?? '';

  String get weatherType {
    if (_weatherModel?.result?.realtime?.skycon == null) return '';
    switch (_weatherModel.result.realtime.skycon) {
      case 'CLEAR_DAY':
      case 'CLEAR_NIGHT':
        return '晴';
      case 'PARTLY_CLOUDY_DAY':
      case 'PARTLY_CLOUDY_NIGHT':
        return '多云';
      case 'CLOUDY':
        return '阴';
      case 'LIGHT_HAZE':
        return '轻度雾霾';
      case 'MODERATE_HAZE':
        return '中度雾霾';
      case 'HEAVY_HAZE':
        return '重度雾霾';
      case 'LIGHT_RAIN':
        return '小雨';
      case 'MODERATE_RAIN':
        return '中雨';
      case 'HEAVY_RAIN':
        return '大雨';
      case 'STORM_RAIN':
        return '暴雨';
      case 'FOG':
        return '雾';
      case 'LIGHT_SNOW':
        return '小雪';
      case 'MODERATE_SNOW':
        return '中雪';
      case 'HEAVY_SNOW':
        return '大雪';
      case 'STORM_SNOW':
        return '暴雪';
      case 'DUST':
        return '浮尘';
      case 'SAND':
        return '沙尘';
      case 'WIND':
        return '大风';
      default:
        return '';
    }
  }

  Location _location;
  Location get location => _location;
  getWeather() async {
    _location = await AmapLocation.instance.fetchLocation();
    Response response = await Dio().get(
      'https://api.caiyunapp.com/v2.5/Rl2lmppO9q15q8W6/${_location.latLng.longitude},${_location.latLng.latitude}/realtime.json',
    );
    LoggerData.addData(response);
    _weatherModel = RealTimeWeatherModel.fromJson(response.data);
    notifyListeners();
  }

  /// 消息中心
  MessageCenterModel _messageCenterModel;
  MessageCenterModel get messageCenterModel =>
      _messageCenterModel ?? MessageCenterModel.zero();
  getMessageCenter() async {
    Response response = await NetUtil().dio.get(API.message.center);
    _messageCenterModel = MessageCenterModel.fromJson(response.data);
    notifyListeners();
  }
}
