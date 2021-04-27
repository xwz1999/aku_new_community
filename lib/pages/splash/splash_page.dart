import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:power_logger/power_logger.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/pages/tab_navigator.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/provider/user_provider.dart';
import 'package:aku_community/utils/developer_util.dart';
import 'package:aku_community/utils/hive_store.dart';

//TODO splashPage
class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ///原生端耗时加载
  Future _originOp() async {
    //初始化HiveStore
    await Hive.initFlutter();
    await HiveStore.init();

    //初始化AMap
    // await AmapLocation.instance.init(iosKey: 'ios key');
    if (!kIsWeb && !Platform.isMacOS) {
      await Permission.locationWhenInUse.request();
    }
  }

  Future _initOp() async {
    //ensure call _originOp first.
    await _originOp();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.initApplications();
    appProvider.startLocation();
    if (HiveStore.appBox!.get('login') ?? false) {
      await userProvider.setLogin(HiveStore.appBox!.get('token'));
    }
  }

  @override
  void initState() {
    super.initState();
    PowerLogger.start(
      context,
      debug: DeveloperUtil.dev,
    );
    _initOp().then((value) => Get.offAll(() => TabNavigator()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 80,
        width: 80,
        child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
      ).centered(),
      bottomNavigationBar: SizedBox(
        child: CircularProgressIndicator().centered(),
        height: 100,
      ),
    );
  }
}
