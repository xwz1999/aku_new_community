import 'package:flutter/material.dart';

import 'package:akuCommunity/widget/bee_scaffold.dart';

class FacilityPage extends StatefulWidget {
  FacilityPage({Key key}) : super(key: key);

  @override
  _FacilityPageState createState() => _FacilityPageState();
}

class _FacilityPageState extends State<FacilityPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '设施预约',
      actions: [
        IconButton(
          icon: Icon(Icons.add_circle_outline_rounded, color: Colors.black87),
          onPressed: () {},
        ),
      ],
    );
  }
}
