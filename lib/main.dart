import 'package:akuCommunity/pages/splash/splash_page.dart';
import 'package:akuCommunity/provider/sign_up_provider.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/developer_util.dart';
import 'package:akuCommunity/utils/hive_store.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:ani_route/ani_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/provider/cart.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ARoute.init(true);
  await Hive.initFlutter();
  await HiveStore.init();
  AmapLocation.instance.init(iosKey: 'ios key');
  DeveloperUtil.setDev(true);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    registerWxApi(appId: 'wxd7bdef0d4849ddb8');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvidde()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ],
      child: GetMaterialApp(
        title: '智慧社区',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
        //国际化支持
        localizationsDelegates: [
          PickerLocalizationsDelegate.delegate,
          RefreshLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [const Locale('zh', 'CH')],
        locale: Locale('zh'),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  }
}
