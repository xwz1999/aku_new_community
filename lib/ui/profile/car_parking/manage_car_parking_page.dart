import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';

class ManageCarParkingPage extends StatefulWidget {
  ManageCarParkingPage({Key key}) : super(key: key);

  @override
  _ManageCarParkingPageState createState() => _ManageCarParkingPageState();
}

class _ManageCarParkingPageState extends State<ManageCarParkingPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(title: '我的车位');
  }
}
