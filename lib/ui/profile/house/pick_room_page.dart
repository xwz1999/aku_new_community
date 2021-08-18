import 'package:aku_community/model/user/pick_building_model.dart';
import 'package:aku_community/pages/sign/sign_func.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PickRoomPage extends StatefulWidget {
  final int unitId;
  const PickRoomPage({Key? key, required this.unitId}) : super(key: key);

  @override
  _PickRoomPageState createState() => _PickRoomPageState();
}

class _PickRoomPageState extends State<PickRoomPage> {
  List<PickBuildingModel> _buildingModels = [];
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择房间',
      body: EasyRefresh(
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          _buildingModels = await SignFunc.getRoom(widget.unitId);
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

  _buildItem(PickBuildingModel model) {
    return ListTile(
      title: model.label!.text.make(),
      onTap: () async {
        Get.back(result: model);
      },
    ).material(color: Colors.white);
  }
}
