import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/pages/sign/sign_up/sign_up_pick_building_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

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
            title: '五象新区人才公寓'.text.make(),
            onTap: () => Get.to(SignUpPickBuildingPage()),
          ).material(color: Colors.white),
        ],
      ),
    );
  }
}
