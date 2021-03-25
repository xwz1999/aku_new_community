import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';

class HouseOwnersPage extends StatefulWidget {
  HouseOwnersPage({Key key}) : super(key: key);

  @override
  _HouseOwnersPageState createState() => _HouseOwnersPageState();
}

class _HouseOwnersPageState extends State<HouseOwnersPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(title: '我的房屋');
  }
}
