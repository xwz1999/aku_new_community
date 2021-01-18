import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoggerDioSuccess extends StatelessWidget {
  final Response response;
  const LoggerDioSuccess({Key key, this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      highlightElevation: 1,
      color: Colors.white,
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              5.wb,
              response.request.path.text.bold.make().expand(),
              Chip(
                backgroundColor: Colors.redAccent,
                label: Text(response?.statusCode?.toString() ?? 'UNKNOW'),
              ),
              5.wb,
              Chip(
                backgroundColor: Colors.greenAccent,
                label: Text(response.request.method),
              ),
            ],
          ),
          response.headers['date'].first.toString().text.make(),
        ],
      ),
    );
  }
}
