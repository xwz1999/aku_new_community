import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';

import 'package:akuCommunity/constants/app_theme.dart';
import 'package:akuCommunity/pages/splash/splash_page.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/provider/cart.dart';
import 'package:akuCommunity/provider/sign_up_provider.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/developer_util.dart';
import 'package:akuCommunity/utils/headers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
    ),
  );
  JPush jpush = new JPush();
  jpush.addEventHandler(
    // 接收通知回调方法。
    onReceiveNotification: (Map<String, dynamic> message) async {
      print("flutter onReceiveNotification: $message");
    },
    // 点击通知回调方法。
    onOpenNotification: (Map<String, dynamic> message) async {
      print("flutter onOpenNotification: $message");
    },
    // 接收自定义消息回调方法。
    onReceiveMessage: (Map<String, dynamic> message) async {
      print("flutter onReceiveMessage: $message");
    },
  );
  jpush.setup(
    appKey: "6a2c6507e3e8b3187ac1c9f9",
    channel: "developer-default",
    production: false,
    debug: true, // 设置是否打印 debug 日志
  );
  jpush.applyPushAuthority(
      new NotificationSettingsIOS(sound: true, alert: true, badge: true));
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
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          //点击输入框外部隐藏键盘⌨️
          //只能响应点击非手势识别的组件
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: ScreenUtilInit(
          designSize: Size(750, 1334),
          allowFontScaling: true,
          builder: () => GetMaterialApp(
            onGenerateTitle: (context) => S.of(context).appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            home: SplashPage(),
            //国际化支持
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [const Locale('zh')],
            locale: Locale('zh'),
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        ),
      ),
    );
  }
}
