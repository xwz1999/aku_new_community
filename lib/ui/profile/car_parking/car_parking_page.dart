import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CarParkingPage extends StatefulWidget {
  CarParkingPage({Key key}) : super(key: key);

  @override
  _CarParkingPageState createState() => _CarParkingPageState();
}

class _CarParkingPageState extends State<CarParkingPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的车位',
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('管理车位'),
        ),
      ],
      body: EasyRefresh(
        onRefresh: () async {},
        child: ListView(),
      ),
    );
  }
}
