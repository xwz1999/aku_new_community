// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:power_logger/power_logger.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/pages/tab_navigator.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/hive_store.dart';
import 'package:akuCommunity/utils/weather/weather_util.dart';

//TODO splashPage
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

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
    await AmapLocation.instance.init(iosKey: 'ios key');
  }

  Future _initOp() async {
    //ensure call _originOp first.
    await _originOp();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.initApplications();
    appProvider.getWeather();
    //app init delay 2 second
    await Future.delayed(Duration(seconds: 2));
    if (HiveStore.appBox.get('login') ?? false) {
      await userProvider.setLogin(HiveStore.appBox.get('token'));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) PowerLogger.init(context);
    });
    _initOp().then((value) => Get.offAll(TabNavigator()));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
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
