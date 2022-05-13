
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:power_logger/power_logger.dart';

import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/main_initialize.dart';
import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/pages/splash/app_verify_dialog.dart';
import 'package:aku_new_community/utils/developer_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';

// import 'package:amap_search_fluttify/amap_search_fluttify.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TapGestureRecognizer _agreementRecognizer = TapGestureRecognizer();
  TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer();

  Future<bool?> _showLoginVerify() async {
    var re = await Get.dialog(AppVerifyDialog());
    return re;
    // return await showCupertinoDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (context) {
    //     return CupertinoAlertDialog(
    //       title: Text('隐私政策和用户协议'),
    //       content: RichText(
    //         text: TextSpan(
    //             text: '点击登录即表示您已阅读并同意',
    //             style: TextStyle(color: Colors.black),
    //             children: [
    //               TextSpan(
    //                   text: '《用户协议》',
    //                   style: TextStyle(color: Colors.blue),
    //                   recognizer: _agreementRecognizer
    //                     ..onTap = () {
    //                       Get.to(() => AgreementPage());
    //                     }),
    //               TextSpan(
    //                   text: '《隐私政策》',
    //                   style: TextStyle(color: Colors.blue),
    //                   recognizer: _privacyRecognizer
    //                     ..onTap = () {
    //                       Get.to(() => PrivacyPage());
    //                     }),
    //               TextSpan(
    //                   style: TextStyle(color: Colors.black),
    //                   text:
    //                       '（特别是免除或限制责任、管辖等粗体下划线标注的条款）。如您不同意上述协议的任何条款，您应立即停止登录及使用本软件及服务。')
    //             ]),
    //       ),
    //
    //       // ),
    //       actions: [
    //         CupertinoDialogAction(
    //           child: Text('拒绝'),
    //           onPressed: () => Get.back(result: false),
    //         ),
    //         CupertinoDialogAction(
    //           child: Text('同意'),
    //           onPressed: () => Get.back(result: true),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  void initState() {
    super.initState();

    PowerLogger.start(
      context,
      debug: DeveloperUtil.dev,
    );

    Future.delayed(Duration(milliseconds: 1000), () async {
      //本地存储初始化在最前
      await Hive.initFlutter();
      await HiveStore.init();
      var agreement = await HiveStore.appBox?.get('agreement') ?? false;
      if (!agreement) {
        var result = await _showLoginVerify();
        if (result == null || !result) {
          SystemNavigator.pop();
          HiveStore.appBox!.put('agreement', false);
        } else {
          HiveStore.appBox!.put('agreement', true);
        }
      }
      //初始化AMap
      // await AmapLocation.instance.init(iosKey: 'ios key');
      // if (Platform.isAndroid || Platform.isIOS) {
      //   await Permission.locationWhenInUse.request();
      // }
      //第三方加载
      MainInitialize.initJPush();
      EquatableConfig.stringify = true;
      AMapFlutterLocation.updatePrivacyShow(true, true);
      AMapFlutterLocation.updatePrivacyAgree(true);
      MainInitialize.initTheme();
      MainInitialize.initWechat();
      MainInitialize.initWebSocket();
      // UserTool.appProvider.startLocation();
      UserTool.appProvider.initApplications();
      //获取城市列表等信息
      await UserTool.dataProvider.init();
      //从本地获取是否登录记录
      try {
        // await AmapCore.init('84041703f7ecb242685325796897eff4');
        if (HiveStore.appBox!.get('login') ?? false) {
          //更新用户信息后自动跳转首页/设置昵称/设置密码
          UserTool.userProvider.setLogin(HiveStore.appBox!.get('token'));
        } else {
          //暂时隐去一键登录页
          await Get.offAll(() => OtherLoginPage());
        }
      } catch (e) {
        LoggerData.addData(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '追\n求',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 40.sp,
                                height: 1.15),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 450.w),
                    ),
                    25.wb,
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '更\n便\n捷\n的\n生\n活\n方\n程\n式',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 40.sp,
                                height: 1.15),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 530.w),
                    ),
                    25.wb,
                    Container(
                      height: 400.w,
                      width: 2.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x99000000), Color(0x00000000)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                    ),
                  ],
                )),
            Positioned(
              child: Image.asset(
                R.ASSETS_IMAGES_CIRCLE_TEXT_PNG,
                width: 61.w,
                height: 72.w,
                fit: BoxFit.fill,
              ),
              top: 410.w,
              left: 275.w,
            ),
            Positioned(
              child: Image.asset(
                R.ASSETS_IMAGES_CIRCLE_RIGHT_TOP_PNG,
                width: 185.w,
                height: 249.w,
                fit: BoxFit.fill,
              ),
              top: 0.w,
              right: 0.w,
            ),
            Positioned(
              child: Image.asset(
                R.ASSETS_IMAGES_CIRCLE_LEFT_BOTTOM_PNG,
                width: 270.w,
                height: 504.w,
                fit: BoxFit.fill,
              ),
              bottom: 224.w,
              left: 0.w,
            ),
            Positioned(
              child: Image.asset(
                R.ASSETS_IMAGES_CIRCLE_RIGHT_BOTTOM_PNG,
                width: 88.w,
                height: 180.w,
                fit: BoxFit.fill,
              ),
              bottom: 150.w,
              right: 0.w,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: 60.w),
                height: 300.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      Assets.images.logo.path,
                      width: 140.w,
                      height: 140.w,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      '小蜜蜂',
                      style: TextStyle(
                          color: Color(0xD9000000),
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // SizedBox(
      //   height: 80,
      //   width: 80,
      //   child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
      // ).centered(),
      // bottomNavigationBar: SizedBox(
      //   child: CircularProgressIndicator().centered(),
      //   height: 100,
      // ),
    );
  }
}
