import 'package:akuCommunity/pages/sign/sign_up/sign_up_pick_building_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/extensions/page_router.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpPickPlotPage extends StatefulWidget {
  SignUpPickPlotPage({Key key}) : super(key: key);

  @override
  _SignUpPickPlotPageState createState() => _SignUpPickPlotPageState();
}

class _SignUpPickPlotPageState extends State<SignUpPickPlotPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择小区',
      body: ListView(
        children: [
          ListTile(
            title: 'PLACEHOLDER PLOT'.text.make(),
            onTap: SignUpPickBuildingPage().to,
          ).material(color: Colors.white),
        ],
      ),
    );
  }
}
