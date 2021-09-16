import 'dart:async';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OpeningCodePage extends StatefulWidget {
  OpeningCodePage({Key? key}) : super(key: key);

  @override
  _OpeningCodePageState createState() => _OpeningCodePageState();
}

class _OpeningCodePageState extends State<OpeningCodePage> {
  bool _onload = true;
  late String _qrCode;
  late bool _overDate;
  late EasyRefreshController _refreshController;
  static const int seconds = 300; //有效时间
  Timer? _overDateTimer;
  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future getQrcode() async {
    DateTime _currentTime = DateTime.now();
    BaseModel baseModel =
        await NetUtil().get(API.manager.getDoorQrCode, params: {
      "startTime":
          DateUtil.formatDate(_currentTime, format: 'yyyy/MM/dd HH:mm:ss'),
      "endTime": DateUtil.formatDate(
          _currentTime.add(Duration(seconds: seconds)),
          format: 'yyyy/MM/dd HH:mm:ss'),
    });
    if ((baseModel.status ?? false) && baseModel.data != null) {
      _qrCode = baseModel.data;
      _onload = false;
      _overDate = false;
      endTimer();
      startTimer();
      setState(() {});
    } else {
      BotToast.showText(text: '网络请求错误');
    }
  }

  startTimer() {
    _overDateTimer = Timer.periodic(Duration(seconds: seconds), (timer) {
      _overDate = true;
      endTimer();
      setState(() {});
    });
  }

  endTimer() {
    _overDateTimer?.cancel();
    _overDateTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      bgColor: Colors.white,
      title: '开门码',
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          await getQrcode();
        },
        child: _onload
            ? Container()
            : ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 70.w,
                      left: 32.w,
                      right: 32.w,
                      bottom: 76.w,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 32.w,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    ),
                    height: 746.w,
                    width: 686.w,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 44.w,
                            bottom: 32.w,
                          ),
                          height: 460.w,
                          width: 460.w,
                          child: QrImage(
                            padding: EdgeInsets.zero,
                            data: _qrCode,
                            size: 460.w,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 29.w,
                            vertical: 33.w,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xfffffbf6),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.w)),
                          ),
                          width: 646.w,
                          height: 146.w,
                          child: Text(
                            '扫一扫，你的专属二维码，人人文明出行，路路畅通安宁，智慧小区祝您一路顺风',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Color(0xff666666),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          AntDesign.checkcircleo,
                          color: Color(0xffffc40c),
                          size: 32.sp,
                        ),
                        SizedBox(width: 19.w),
                        Text(
                          _overDate ? '已过期' : '已刷新',
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: Color(0xff999999),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
