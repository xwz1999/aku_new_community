import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';

class PickFacilityPage extends StatefulWidget {
  PickFacilityPage({Key key}) : super(key: key);

  @override
  _PickFacilityPageState createState() => _PickFacilityPageState();
}

class _PickFacilityPageState extends State<PickFacilityPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择设施',
    );
  }
}
