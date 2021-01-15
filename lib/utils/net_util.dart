import 'dart:convert';

import 'package:akuCommunity/utils/logger/logger_data.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

import 'package:akuCommunity/constants/api.dart';
import 'package:logger/logger.dart';

class NetUtil {
  Dio _dio;
  Logger _logger;
  static final NetUtil _netUtil = NetUtil._internal();

  factory NetUtil() => _netUtil;

  NetUtil._internal() {
    _logger = Logger(
        printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 4,
    ));
    BaseOptions options = BaseOptions(
      baseUrl: API.host,
      connectTimeout: API.networkTimeOut,
      receiveTimeout: API.networkTimeOut,
      sendTimeout: API.networkTimeOut,
      headers: {},
    );
    if (_dio == null) _dio = Dio(options);
  }

  ///call auth after login
  auth(String token) {
    _logger.d('setToken@$token');
    _dio.options.headers.putIfAbsent('App-Admin-Token', () => token);
  }

  Future<BaseModel> get(
    String path, {
    Map<String, dynamic> params,
  }) async {
    try {
      Response res = await _dio.get(path, queryParameters: params);
      _logger.v({
        'path': res.request.path,
        'header': res.request.headers,
        'params': res.request.queryParameters,
        'data': res.data,
      });
      LoggerData.addData(res);
      return BaseModel.fromJson(res.data);
    } on DioError catch (e) {
      _parseErr(e);
    }
    return BaseModel.err();
  }

  _parseErr(DioError err) {
    _logger.v({
      'type': err.type.toString(),
      'message': err.message,
    });
    LoggerData.addData(err);
    _makeToast(String message) {
      BotToast.showText(text: '$message\_${err?.response?.statusCode ?? ''}');
    }

    switch (err.type) {
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        _makeToast('连接超时');
        break;
      case DioErrorType.RESPONSE:
        _makeToast('服务器出错');
        break;
      case DioErrorType.CANCEL:
        break;
      case DioErrorType.DEFAULT:
        _makeToast('未知错误');
        break;
    }
  }
}

class BaseModel {
  int code;
  String message;
  dynamic data;
  BaseModel({
    this.code,
    this.message,
    this.data,
  });

  BaseModel.err({this.message = '未知错误', this.code = 0});

  factory BaseModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return BaseModel(
      code: map['code'] ?? 0,
      message: map['message'] ?? '',
      data: map['data'],
    );
  }

  factory BaseModel.fromJson(String source) =>
      BaseModel.fromMap(json.decode(source));
}
