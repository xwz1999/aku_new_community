import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:aku_community/constants/api.dart';

class BeeDownloadView extends StatefulWidget {
  final String file;
  BeeDownloadView({Key key, this.file}) : super(key: key);

  @override
  _BeeDownloadViewState createState() => _BeeDownloadViewState();
}

class _BeeDownloadViewState extends State<BeeDownloadView> {
  Dio dio = Dio();
  double progress;
  Future download() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Directory docPath = Directory('${dir.path}/docs');
    if (!await (docPath.exists())) {
      await docPath.create();
    }
    await Future.delayed(Duration(milliseconds: 500));
    await dio.download(
      API.file(widget.file),
      '${docPath.path}/${widget.file.split('/').last}',
      onReceiveProgress: (start, all) {
        setState(() {
          progress = start / all;
        });
        print('$start,$all');
      },
    );
    Get.back(result: '${docPath.path}/${widget.file.split('/').last}');
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(value: progress),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
    );
  }
}
