import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/utils/logger/logger_data.dart';
import 'package:akuCommunity/utils/network/base_list_model.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

import 'package:akuCommunity/constants/api.dart';
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';

class NetUtil {
  Dio _dio;
  Logger _logger;
  static final NetUtil _netUtil = NetUtil._internal();

  factory NetUtil() => _netUtil;

  Dio get dio => _dio;

  NetUtil._internal() {
    _logger = Logger(
        printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 4,
    ));
    BaseOptions options = BaseOptions(
      baseUrl: '${API.host}/app',
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

  /// ## alias of Dio().get
  ///
  /// GET method
  Future<BaseModel> get(
    String path, {
    Map<String, dynamic> params,
    bool showMessage = false,
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
      BaseModel baseModel = BaseModel.fromJson(res.data);
      _parseRequestError(baseModel, showMessage: showMessage);
      return baseModel;
    } on DioError catch (e) {
      _parseErr(e);
    }
    return BaseModel.err();
  }

  /// ## alias of Dio().post
  ///
  /// POST method
  ///
  /// only work with JSON.
  Future<BaseModel> post(
    String path, {
    Map<String, dynamic> params,
    bool showMessage = false,
  }) async {
    try {
      Response res = await _dio.post(path, data: params);
      _logger.v({
        'path': res.request.path,
        'header': res.request.headers,
        'params': res.request.queryParameters,
        'data': res.data,
      });
      LoggerData.addData(res);
      BaseModel baseModel = BaseModel.fromJson(res.data);
      _parseRequestError(baseModel, showMessage: showMessage);

      return baseModel;
    } on DioError catch (e) {
      _parseErr(e);
    }
    return BaseModel.err();
  }

  Future<BaseListModel> getList(
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
      BaseListModel baseListModel = BaseListModel.fromJson(res.data);
      return baseListModel;
    } on DioError catch (e) {
      _parseErr(e);
    }
    return BaseListModel.err();
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

  _parseRequestError(BaseModel model, {bool showMessage = false}) {
    if (!model.status&&model.message=='登录失效，请登录'){
      Get.offAll(SignInPage());
    }
    if (!model.status || showMessage) {
      BotToast.showText(text: model.message);
    }
  }
}
