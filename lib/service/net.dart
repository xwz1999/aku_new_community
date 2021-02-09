// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'base_model.dart';

// import 'net_header.dart';
// import 'package:light_wave/utils/global_toast.dart';
// import 'package:light_wave/pages/login/login_page.dart';
// import 'package:light_wave/routers/application.dart';
// import 'package:fluttertoast/fluttertoast.dart';

/// 自定义枚举
enum Method { get, post }

class Net {
  // 工厂模式
  factory Net() => _getInstance();
  static Net get instance => _getInstance();
  static Net _instance;

  Dio dio;
  Net._internal() {
    // 初始化
    dio = Dio(
      BaseOptions(
        connectTimeout: 60000, // 连接服务器超时时间，单位是毫秒.
        receiveTimeout: 10000, // 响应流上前后两次接受到数据的间隔，单位为毫秒, 这并不是接收数据的总时限.
        // contentType: ContentType.parse('x-www-form-urlencoded').toString(),
        // responseType: ResponseType.plain,
        // responseType: ResponseType.json,
      ),
    );

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        //TODO
        return true;
      };
    };
  }

  /// 打印拦截器(便于调试)
  static final interceptors = InterceptorsWrapper(
    /// 请求发送前处理处理一些事情
    onRequest: (RequestOptions options) {
      print("--------------------请求参数---------------------");
      print(json.encode(options.headers));
      print(options.method);
      print(options.queryParameters);
      print(options.baseUrl + options.path);
      print(options.data);
      print("--------------------请求参数---------------------");
      return options;
    },

    /// 在数据响应前做一些预处理
    onResponse: (Response response) {
      // Log.i("--------------------响应结果---------------------");
      // Log.e("response.statusCode", "${response.statusCode}");
      // Log.e("response.data", "${json.encode(response.data)}");
      // Log.e("response.headers", "${response.headers}");
      // Log.i("--------------------响应结果---------------------");
      return response;
    },

    /// 错误处理
    onError: (DioError e) {
      // Log.e("DioError", "$e");
      return e;
    },
  );
  // 单列模式
  static Net _getInstance() {
    if (_instance == null) {
      _instance = Net._internal();
    }
    return _instance;
  }

  get(String url, Map<String, dynamic> params,
      {Function success, Function failure}) {
    _doRequest(url, params, Method.get, success, failure);
  }

  post(String url, Map<String, dynamic> params,
      {Function success, Function failure}) {
    _doRequest(url, params, Method.post, success, failure);
  }

  void _doRequest(String url, Map<String, dynamic> params, Method method,
      Function successCallBack, Function failureCallBack) async {
    try {
      /// 可以添加header
      // if (isIntelligent) {
      //   dio.options.headers.addAll(await NetHeader.getZnToken());
      // } else {
      //   if (isContentType) {
      //     dio.options.contentType =
      //         ContentType.parse("application/x-www-form-urlencoded").toString();
      //   }
      //   dio.options.headers.addAll(NetHeader.dmsHeaders);
      // }
      dio.interceptors.add(interceptors);
      Response response;
      switch (method) {
        case Method.get:
          if (params != null && params.isNotEmpty) {
            response = await dio.get(url, queryParameters: params);
          } else {
            response = await dio.get(url);
          }
          break;
        case Method.post:
          if (params != null && params.isNotEmpty) {
            response = await dio.post(url, data: params);
          } else {
            response = await dio.post(url);
          }
          break;
      }
      Map<String, dynamic> result = json.decode(response.toString());
      // 打印信息
      print('''api: $url\nparams: $params\nresult: $result''');
      // 转化为model
      BaseModel model = BaseModel.fromJson(result);
      if (model.code == 100 || model.code == 0) {
        // 100 请求成功
        if (successCallBack != null) {
          //返回请求数据
          if (model.result == null) {
            successCallBack(model.message);
          } else {
            successCallBack(model.result);
          }
        }
      } else {
        //TODO
        //直接使用Toast弹出错误信息
        //返回失败信息
        // GlobalToast.globalToast('${model.message}!~');
        if (failureCallBack != null) {
          failureCallBack(model.code);
          // if (model.code == 1 && model.message == 'token过期') {
          //   Application.navigatorKey.currentState.pushNamedAndRemoveUntil(
          //       "/LoginPage", ModalRoute.withName("/"));
          // }
          // failureCallBack(model.message);
        }
      }
    } catch (exception) {
      print('错误：${exception.toString()}');
      // FlutterToast.showToast(msg: "请求失败，请稍后再试");
      if (failureCallBack != null) {
        failureCallBack(exception.toString());
      }
    }
  }

// 上传文件（图片）
// doUploadFile(String url, File file, String loadingText,Function successCallBack,
//       Function failureCallBack) async {
//     try {
//       String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
//       FormData formData = FormData.from({
//         'file': UploadFileInfo(file, '$timeStamp.jpg',
//             contentType: ContentType.parse("image/jpeg"))
//       });
//       Response response = await dio.post(url, data: formData);
//       print('$response'); // 在需要生成model时需要json格式
//       Map<String, dynamic> result = json.decode(response.toString());
//       assert(() {
//         // assert只会在debug模式下执行，release模式下不会执行
//         // 打印信息
//         print('''api: $url\nresult: $result''');
//         return true;
//       }());

//       BaseModel model = BaseModel.fromJson(result);
//       if (model.code == 200) {
//         // 200 请求成功
//         if (successCallBack != null) {
//           if (model.data != null) {
//             successCallBack(model.data);
//           } else {
//             successCallBack({});
//           }
//         }
//       } else {
//         //Fluttertoast.showToast(msg: "${model.msg}");
//         if (failureCallBack != null) {
//           failureCallBack(model.msg);
//         }
//       }
//     } catch (exception) {
//       assert(() {
//         // 打印信息
//         print('''api: $url\n错误：${exception.toString()}''');
//         return true;
//       }());

//     //  Fluttertoast.showToast(msg: '加载失败');
//       if (failureCallBack != null) {
//         failureCallBack(exception.toString());
//       }
//     }
//   }

}
