import 'package:akuCommunity/main_initialize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:akuCommunity/constants/app_theme.dart';
import 'package:akuCommunity/pages/splash/splash_page.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/provider/sign_up_provider.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/developer_util.dart';
import 'package:akuCommunity/utils/headers.dart';

void main() async {
  DeveloperUtil.setDev(true);
  WidgetsFlutterBinding.ensureInitialized();

  ///firebase crashlytics initalize
  await MainInitialize.initFirebase();
  MainInitialize.initTheme();
  await MainInitialize.initJPush();
  MainInitialize.initWechat();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
