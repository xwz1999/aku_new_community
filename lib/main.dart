import 'dart:async';
import 'dart:io';

import 'package:akuCommunity/pages/tab_navigator.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/developer_util.dart';
import 'package:akuCommunity/utils/logger_view.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:ani_route/ani_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/provider/cart.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:akuCommunity/routers/router_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  ARoute.init(true);
  AmapLocation.instance.init(iosKey: 'ios key');
  DeveloperUtil.setDev(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
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
    RouterInit.setupRouter();
    registerWxApi(appId: 'wxd7bdef0d4849ddb8');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvidde()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: GetMaterialApp(
        title: '智慧社区',
        // builder: BotToastInit(),
        // navigatorObservers: [BotToastNavigatorObserver()],
        navigatorKey: RouterInit.navigatorKey,
        onGenerateRoute: RouterInit.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: TabNavigator(),
        home: TabNavigator(),
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
