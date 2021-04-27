import 'package:flutter/material.dart';

import 'package:aku_community/widget/bee_scaffold.dart';

class PickPlotPage extends StatefulWidget {
  PickPlotPage({Key? key}) : super(key: key);

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
