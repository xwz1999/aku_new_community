import 'package:aku_new_community/model/user/pick_building_model.dart';
import 'package:aku_new_community/pages/sign/sign_func.dart';
import 'package:aku_new_community/ui/profile/house/pick_room_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PickUnitPage extends StatefulWidget {
  final int? buildingId;

  PickUnitPage({Key? key, this.buildingId}) : super(key: key);

  @override
  _PickUnitPageState createState() => _PickUnitPageState();
}

class _PickUnitPageState extends State<PickUnitPage> {
  List<PickBuildingModel> _buildingModels = [];

  _buildItem(PickBuildingModel model) {
    return ListTile(
      title: model.label!.text.make(),
      onTap: () async {
        PickBuildingModel? houseModel =
            await Get.to(() => PickRoomPage(unitId: model.value!));
        if (houseModel != null) {
          Get.back(result: [model, houseModel]);
        }
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
