import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// sp获取动态类型型值
  static Future<dynamic> getDynamic(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get(key);
  }

  /// sp存储bool型值
  static Future<bool> saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  /// sp获取bool型值
  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  /// sp存储int型值
  static Future<bool> saveInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  /// sp获取int型值
  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  /// sp存储double型值
  static Future<bool> saveDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(key, value);
  }

  /// sp获取double型值
  static double getDouble(String key, double defValue) {
    if (_prefs == null) return defValue;
    return _prefs.getDouble(key) ?? defValue;
  }

  /// sp存储String型值
  static Future<bool> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  /// sp获取String型值
  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// sp存储List<String>型值
  static Future<bool> saveStrings(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(key, value);
  }

  /// sp获取List<String>型值
  static Future<List<String>> getStrings(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  /// sp清除所有缓存,返回bool型值,true为清除成功
  static Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  /// sp清除单个缓存
  static Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  /// sp获取所有已经存储的key值,返回结果为Set<String>类型
  static Future<Set<String>> getKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }
}
