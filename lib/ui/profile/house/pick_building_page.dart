import 'package:aku_new_community/model/user/pick_building_model.dart';
import 'package:aku_new_community/pages/sign/sign_func.dart';
import 'package:aku_new_community/ui/profile/house/house_item.dart';
import 'package:aku_new_community/ui/profile/house/pick_unit_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PickBuildingPage extends StatefulWidget {
  PickBuildingPage({Key? key}) : super(key: key);

  @override
  _PickBuildingPageState createState() => _PickBuildingPageState();
}

class _PickBuildingPageState extends State<PickBuildingPage> {
  List<PickBuildingModel> _buildingModels = [];

  _buildItem(PickBuildingModel model) {
    return ListTile(
      title: model.label!.text.make(),
      onTap: () async {
        List<PickBuildingModel?> houseModels =
            await Get.to(() => PickUnitPage(buildingId: model.value));
        if (houseModels.isNotEmpty) {
          HouseItem item = HouseItem(
              building: model, unit: houseModels[0]!, room: houseModels[1]!);
          Get.back(result: item);
        }
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
