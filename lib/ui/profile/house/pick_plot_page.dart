import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';

class PickPlotPage extends StatefulWidget {
  PickPlotPage({Key key}) : super(key: key);

  @override
  _PickPlotPageState createState() => _PickPlotPageState();
}

class _PickPlotPageState extends State<PickPlotPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择小区',
    );
  }
}
