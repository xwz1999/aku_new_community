import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';

class MyOrderDetailPage extends StatefulWidget {
  MyOrderDetailPage({Key? key}) : super(key: key);

  @override
  _MyOrderDetailPageState createState() => _MyOrderDetailPageState();
}

class _MyOrderDetailPageState extends State<MyOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '订单详情',
      body: ListView(),
    );
  }
}
