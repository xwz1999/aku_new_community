import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:akuCommunity/utils/headers.dart';

class FixedEvaluatePage extends StatefulWidget {
  FixedEvaluatePage({Key key}) : super(key: key);

  @override
  _FixedEvaluatePageState createState() => _FixedEvaluatePageState();
}

class _FixedEvaluatePageState extends State<FixedEvaluatePage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(title: '评价',body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 42.w,vertical: 52.w),
      children: [],
    ).expand(),);
  }
}