import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondHandPage extends StatefulWidget {
  SecondHandPage({Key? key}) : super(key: key);

  @override
  _SecondHandPageState createState() => _SecondHandPageState();
}

class _SecondHandPageState extends State<SecondHandPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '二手市场',
      actions: [
        IconButton(
          icon: Icon(
            CupertinoIcons.add_circled,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
