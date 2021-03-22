import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:dio/dio.dart';

import 'package:akuCommunity/model/common/real_time_weather_model.dart';

class WeatherUtil {
  static Location _location;
  static String baseURL = 'https://api.caiyunapp.com/v2.5/Rl2lmppO9q15q8W6';

  static Future<RealTimeWeatherModel> getWeather() async {
    _location = await AmapLocation.instance.fetchLocation();
    Response response = await Dio().get(
        '$baseURL/${_location.latLng.latitude},${_location.latLng.longitude}/realtime.json');
    if (response.data == null)
      return null;
    else
      return RealTimeWeatherModel.fromJson(response.data);
  }
}
