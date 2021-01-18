import 'package:akuCommunity/utils/logger/logger_dio_err.dart';
import 'package:akuCommunity/utils/logger/logger_dio_success.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoggerCard extends StatelessWidget {
  final dynamic data;
  const LoggerCard({Key key, this.data}) : super(key: key);
  Widget _buildDioErr() {
    DioError error = data;
    return LoggerDioErr(error: error);
  }

  Widget _buildResponse() {
    Response response = data;
    return LoggerDioSuccess(response: response);
  }

  Widget _getLoggerView() {
    switch (data.runtimeType) {
      case DioError:
        return _buildDioErr();
      case Response:
        return _buildResponse();
      default:
        return Text("UNKNOW");
    }
  }

  @override
  Widget build(BuildContext context) => _getLoggerView();
}
