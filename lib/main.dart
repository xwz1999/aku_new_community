import 'dart:io';

import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:ani_route/ani_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/provider/cart.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:akuCommunity/routers/router_init.dart';

void main() {
  ARoute.init(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    RouterInit.setupRouter();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvidde()),
      ],
      child: OKToast(
        textStyle: TextStyle(fontSize: 19.0, color: Colors.white),
        backgroundColor: Colors.grey,
        radius: 10.0,
        animationCurve: Curves.easeIn,
        animationBuilder: Miui10AnimBuilder(),
        animationDuration: Duration(milliseconds: 200),
        duration: Duration(seconds: 3),
        child: MaterialApp(
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
          home: SignInPage(),
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
        ),
      ),
    );
  }
}
