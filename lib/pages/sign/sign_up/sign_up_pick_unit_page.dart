import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/model/user/pick_building_model.dart';
import 'package:akuCommunity/pages/sign/sign_func.dart';
import 'package:akuCommunity/pages/sign/sign_up/sign_up_pick_role_page.dart';
import 'package:akuCommunity/provider/sign_up_provider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class SignUpPickUnitPage extends StatefulWidget {
  final int buildingId;
  SignUpPickUnitPage({Key key, this.buildingId}) : super(key: key);

  @override
  _SignUpPickUnitPageState createState() => _SignUpPickUnitPageState();
}

class _SignUpPickUnitPageState extends State<SignUpPickUnitPage> {
  List<PickBuildingModel> _buildingModels = [];
  _buildItem(PickBuildingModel model) {
    return ListTile(
      title: model.label.text.make(),
      onTap: () {
        final signUpProvider =
            Provider.of<SignUpProvider>(context, listen: false);
        signUpProvider.setEstateId(model.value);
        Get.off(SignUpPickRolePage());
      },
    ).material(color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择单元',
      body: EasyRefresh(
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          _buildingModels = await SignFunc.getUnitInfo(widget.buildingId);
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
