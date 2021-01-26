// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:logger/logger.dart';
import 'package:power_logger/power_logger.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/network/base_file_model.dart';
import 'package:akuCommunity/utils/network/base_list_model.dart';
import 'package:akuCommunity/utils/network/base_model.dart';

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
      baseUrl: API.baseURL,
      connectTimeout: API.networkTimeOut,
      receiveTimeout: API.networkTimeOut,
      sendTimeout: API.networkTimeOut,
      headers: {},
    );
    if (_dio == null) _dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async => options,
      onResponse: (Response response) async {
        _logger.v({
          'path': response.request.path,
          'header': response.request.headers,
          'params': response.request.queryParameters,
          'data': response.data,
        });
        LoggerData.addData(response);
        return response;
      },
      onError: (DioError error) async {
        _parseErr(error);
        return error;
      },
    ));
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

  Future<BaseFileModel> upload(String path, File file) async {
    try {
      Response res = await _dio.post(path,
          data: FormData.fromMap({
            'file': await MultipartFile.fromFile(file.path),
          }));
      BaseFileModel baseListModel = BaseFileModel.fromJson(res.data);
      return baseListModel;
    } on DioError catch (e) {
      print(e);
    }
    return BaseFileModel.err();
  }

  Future<List<String>> uploadFiles(List<File> files, String api) async {
    List<String> urls = [];
    if (files.isEmpty) {
      return [];
    } else {
      for (var item in files) {
        BaseFileModel model = await NetUtil().upload(api, item);
        urls.add(model.url);
      }
    }

    return urls;
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
    final userProvider = Provider.of<UserProvider>(Get.context, listen: false);
    if (!model.status && model.message == '登录失效，请登录') {
      userProvider.logout();
      Get.offAll(SignInPage());
    }
    if (!model.status || showMessage) {
      BotToast.showText(text: model.message);
    }
  }
}
