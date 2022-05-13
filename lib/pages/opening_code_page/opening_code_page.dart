import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/ui/profile/new_house/certification/certification_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_image_network.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';

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
    if ((baseModel.success) && baseModel.data != null) {
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xFFFFD487),
                Color(0xFFFFD76F).withOpacity(0.19)
              ])),
          child: EasyRefresh(
            firstRefresh: true,
            header: MaterialHeader(),
            onRefresh: () async {
              // await getQrcode();
              _qrCode = DateTime.now().toString();
              _overDate = true;
              _onload = false;
              setState(() {});
            },
            child: _onload
                ? Container()
                : ListView(
                    padding: EdgeInsets.only(
                      top: 123.w,
                      left: 32.w,
                      right: 32.w,
                    ),
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 32.w,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFEFDF3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.w)),
                            ),
                            height: 952.w,
                            child: Column(
                              children: [
                                107.hb,
                                // Container(
                                //   width: 192.w,
                                //   height: 42.w,
                                //   decoration: BoxDecoration(
                                //       color: Colors.black.withOpacity(0.06),
                                //       borderRadius:
                                //           BorderRadius.circular(45.w)),
                                //   alignment: Alignment.center,
                                //   child: Text(
                                //     UserTool.userProvider.userInfoModel!
                                //             .nickName ??
                                //         "",
                                //     style: TextStyle(
                                //         color: Colors.black, fontSize: 24.sp),
                                //   ),
                                // ),
                                // 48.hb,
                                Text(
                                  '${UserTool.userProvider.defaultHouseString}',
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                24.hb,
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 65.w),
                                  height: 556.w,
                                  width: 556.w,
                                  color: Colors.white,
                                  padding: EdgeInsets.all(56.w),
                                  child: QrImage(
                                    padding: EdgeInsets.zero,
                                    data: _qrCode,
                                    size: 460.w,
                                  ),
                                ),
                                36.hb,
                                if (UserTool.userProvider.defaultHouse != null)
                                  Center(
                                    child: '本小区尚未配置门禁设备'
                                        .text
                                        .size(28.sp)
                                        .color(Colors.red)
                                        .make(),
                                  ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -80.w,
                            left: 257.w,
                            child: Container(
                              width: 160.w,
                              height: 160.w,
                              decoration: BoxDecoration(
                                color: Color(0xFFFEFDF3),
                                borderRadius: BorderRadius.circular(80.w),
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                width: 146.w,
                                height: 146.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(73.w),
                                ),
                                child: BeeImageNetwork(
                                  width: 146.w,
                                  height: 146.w,
                                  imgs: UserTool
                                      .userProvider.userInfoModel!.imgList,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      32.hb,
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.w),
                        ),
                        child: Column(
                          children: [
                            buildRow(
                                onTap: () {
                                  BotToast.showText(text: '当前小区未接入开门码功能');
                                },
                                text: '开门记录',
                                suffix: ''),
                            buildRow(
                                onTap: () {
                                  BotToast.showText(text: '当前小区未接入人脸识别功能');
                                },
                                text: '人脸识别',
                                suffix: ''),
                            buildRow(
                                onTap: () {
                                  UserTool.userProvider.userInfoModel!.idCard ==
                                          null
                                      ? Get.off(() => CertificationPage())
                                      : BotToast.showText(text: '已实名认证');
                                },
                                text: '住户认证',
                                suffix: UserTool.userProvider.userInfoModel!
                                            .idCard ==
                                        null
                                    ? '未认证'
                                    : '已认证')
                          ].sepWidget(
                              separate: BeeDivider.horizontal(
                            indent: 32.w,
                            endIndent: 32.w,
                          )),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildRow(
      {required VoidCallback onTap,
      required String text,
      required String suffix}) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
          child: Row(
            children: [
              text.text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
              Spacer(),
              suffix.text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              24.wb,
              Icon(
                CupertinoIcons.chevron_right,
                size: 24.w,
                color: Colors.black.withOpacity(0.25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
