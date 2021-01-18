import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoggerDioErr extends StatelessWidget {
  final DioError error;
  const LoggerDioErr({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      highlightElevation: 1,
      color: Colors.red[100],
      onPressed: () => Get.to(_LoggerErrDetail(error: error)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              5.wb,
              error.request.path.text.bold.make().expand(),
              Chip(
                backgroundColor: Colors.redAccent,
                label: Text(error.response?.statusCode?.toString() ?? 'UNKNOW'),
              ),
              5.wb,
              Chip(
                backgroundColor: Colors.greenAccent,
                label: Text(error.request.method),
              ),
            ],
          ),
          error.response.headers['date'].first.toString().text.make(),
          error.message.text.sm.light.make(),
        ],
      ),
    );
  }
}

class _LoggerErrDetail extends StatefulWidget {
  final DioError error;
  _LoggerErrDetail({Key key, this.error}) : super(key: key);

  @override
  __LoggerErrDetailState createState() => __LoggerErrDetailState();
}

class __LoggerErrDetailState extends State<_LoggerErrDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.error.request.path.text.make(),
      ),
    );
  }
}
