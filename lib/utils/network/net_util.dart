import 'dart:io';
import 'dart:typed_data';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/pages/splash/app_verify_dialog.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/utils/developer_util.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/widget/dialog/certification_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:power_logger/power_logger.dart';
import 'package:provider/provider.dart';

class NetUtil {
  Dio? _dio;
  static final NetUtil _netUtil = NetUtil._internal();

  factory NetUtil() => _netUtil;

  Dio? get dio => _dio;

  NetUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: SAASAPI.baseURL,
      connectTimeout: SAASAPI.networkTimeOut,
      receiveTimeout: SAASAPI.networkTimeOut,
      sendTimeout: SAASAPI.networkTimeOut,
      headers: {},
    );
    if (_dio == null) _dio = Dio(options);
    dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async => handler.next(options),
      onResponse: (response, handler) async {
        LoggerData.addData(response);
        return handler.next(response);
      },
      onError: (error, handler) async {
        _parseErr(error);
        return handler.next(error);
      },
    ));
  }

  ///call auth after login
  auth(String token) {
    _dio!.options.headers['app-login-token'] = token;
  }

  static String getDate(DateTime date) =>
      DateUtil.formatDate(date, format: 'yyyy-MM-dd HH:mm:ss');

  /// ## alias of Dio().get
  ///
  /// GET method
  Future<BaseModel> get(
    String path, {
    Map<String, dynamic>? params,
    bool showMessage = false,
  }) async {
    var _baseModel;
    try {
      Response res = await _dio!.get(path, queryParameters: params);
      if (!res.data['success']) {
        _baseModel = BaseModel.error(
            message: res.data['msg'],
            success: res.data['success'],
            data: res.data['data'],
            code: res.data['code']);
        _parseRequestError(_baseModel, showMessage: showMessage);
      } else {
        _baseModel = BaseModel.fromJson(res.data);
      }
    } on DioError catch (e) {
      _parseErr(e);
      _baseModel = BaseModel(code: 0, msg: '未知错误', success: false, data: null);
    }

    if (showMessage) {
      BotToast.showText(text: _baseModel.msg);
    }
    return _baseModel;
  }

  /// ## alias of Dio().post
  ///
  /// POST method
  ///
  /// only work with JSON.
  Future<BaseModel> post(
    String path, {
    Map<String, dynamic>? params,
    bool showMessage = false,
  }) async {
    var _baseModel;
    try {
      Response res = await _dio!.post(path, data: params);
      if (!res.data['success']) {
        _baseModel = BaseModel.error(
            message: res.data['msg'],
            success: res.data['success'],
            data: res.data['data'],
            code: res.data['code']);
        _parseRequestError(_baseModel, showMessage: showMessage);
      } else {
        _baseModel = BaseModel.fromJson(res.data);
      }
    } on DioError catch (e) {
      _parseErr(e);
      _baseModel = BaseModel(code: 0, msg: '未知错误', success: false, data: null);
    }

    if (showMessage) {
      BotToast.showText(text: _baseModel.msg);
    }
    return _baseModel;
  }

  Future<BaseListModel> getList(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    try {
      Response res = await _dio!.get(path, queryParameters: params);
      if (res.data['success']) {
        BaseListModel baseListModel = BaseListModel.fromJson(res.data['data']);
        return baseListModel;
      } else {
        return BaseListModel.err();
      }
    } on DioError catch (e) {
      _parseErr(e);
    }
    return BaseListModel.err();
  }

  Future<BaseModel> upload(String path, File file) async {
    try {
      Response res = await _dio!.post(path,
          data: FormData.fromMap({
            'file': await MultipartFile.fromFile(file.path),
          }));
      BaseModel baseListModel = BaseModel.fromJson(res.data);
      return baseListModel;
    } on DioError catch (e) {
      print(e);
    }
    return BaseModel.error();
  }

  Future<BaseModel> uploadUnit8List(String path, Uint8List bytes) async {
    try {
      Response res = await _dio!.post(path,
          data: FormData.fromMap({
            'file':
                await MultipartFile.fromBytes(bytes, filename: 'signName.png'),
          }));
      BaseModel baseListModel = BaseModel.fromJson(res.data);
      return baseListModel;
    } on DioError catch (e) {
      print(e);
    }
    return BaseModel.error();
  }

  Future<List<String>> uploadFiles(List<File> files, String api) async {
    List<String> urls = [];
    if (files.isEmpty) {
      return [];
    } else {
      for (var item in files) {
        BaseModel model = await NetUtil().upload(api, item);
        if (model.data != null) {
          urls.add(model.data as String);
        }
      }
    }
    return urls;
  }

  _parseErr(DioError err) {
    LoggerData.addData(err);
    _makeToast(String message) {
      if (DeveloperUtil.dev)
        BotToast.showText(text: '$message\_${err.response?.statusCode ?? ''}');
      else
        BotToast.showText(text: '网络出现问题');
    }

    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        _makeToast('连接超时');
        break;
      case DioErrorType.response:
        _makeToast('服务器出错');
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        _makeToast('未知错误');
        break;
    }
  }

  _parseRequestError(BaseModel model, {bool showMessage = false}) {
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);
    if (!model.success && (model.code == 10010 || model.msg == '登录失效，请重新登录')) {
      userProvider.logout();
      //暂时隐去一键登录页
      Get.offAll(() => OtherLoginPage());
    }
    if (model.msg=='该用户未实名认证') {
      BotToast.showText(text: '请先实名认证');
      Get.dialog(CertificationDialog());
    }
  }
}
