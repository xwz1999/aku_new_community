import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';

class ExpressPackagePage extends StatefulWidget {
  ExpressPackagePage({Key? key}) : super(key: key);

  @override
  _ExpressPackagePageState createState() => _ExpressPackagePageState();
}

class _ExpressPackagePageState extends State<ExpressPackagePage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '快递包裹',
    );
  }
}
