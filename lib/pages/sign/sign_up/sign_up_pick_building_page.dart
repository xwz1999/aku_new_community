// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/model/user/pick_building_model.dart';
import 'package:akuCommunity/pages/sign/sign_func.dart';
import 'package:akuCommunity/pages/sign/sign_up/sign_up_pick_unit_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class SignUpPickBuildingPage extends StatefulWidget {
  SignUpPickBuildingPage({Key key}) : super(key: key);

  @override
  _SignUpPickBuildingPageState createState() => _SignUpPickBuildingPageState();
}

class _SignUpPickBuildingPageState extends State<SignUpPickBuildingPage> {
  List<PickBuildingModel> _buildingModels = [];
  _buildItem(PickBuildingModel model) {
    return ListTile(
      title: model.label.text.make(),
      onTap: () {
        Get.off(SignUpPickUnitPage(buildingId: model.value));
      },
    ).material(color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择楼栋',
      body: EasyRefresh(
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          _buildingModels = await SignFunc.getBuildingInfo();
          setState(() {});
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildItem(_buildingModels[index]);
          },
          itemCount: _buildingModels.length,
        ),
      ),
    );
  }
}
