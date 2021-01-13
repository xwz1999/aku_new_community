import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoggerCard extends StatelessWidget {
  final dynamic data;
  const LoggerCard({Key key, this.data}) : super(key: key);
  Widget _buildDioErr() {
    DioError error = data;
    return VxBox(
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              Chip(
                backgroundColor: Colors.greenAccent,
                label: Text(error.request.method),
              ),
            ],
          ),
          Text(error.message),
          Text(error.request.path),
          Text(error.request.method),
        ],
      ),
    )
        .height(200)
        .p4
        .red200
        .margin(EdgeInsets.all(5))
        .shadowSm
        .make()
        .material(color: Colors.transparent);
  }

  Widget _buildResponse() {
    Response response = data;
    return Card(
      child: Column(
        children: [
          Text(response.statusCode.toString()),
        ],
      ),
    );
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
