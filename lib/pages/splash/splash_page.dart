import 'package:akuCommunity/pages/tab_navigator.dart';
import 'package:akuCommunity/utils/hive_store.dart';
import 'package:akuCommunity/utils/logger/logger_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

//TODO splashPage
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future _initOp() async {
    await Future.delayed(Duration(seconds: 2));
    print(HiveStore.appBox.get('token'));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) LoggerFAB.openLogger(context);
    });
    _initOp().then((value) => Get.offAll(TabNavigator()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 80,
        width: 80,
        child: Placeholder(),
      ).centered(),
      bottomNavigationBar: SizedBox(
        child: CircularProgressIndicator().centered(),
        height: 100,
      ),
    );
  }
}