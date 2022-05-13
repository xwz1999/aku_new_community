import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import '../../../base/base_style.dart';
import '../../../constants/saas_api.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/user/my_house_model.dart';
import '../../../utils/network/net_util.dart';
import '../../../widget/bee_divider.dart';
import '../../../widget/others/user_tool.dart';
import '../../../widget/tag/bee_tag.dart';
import '../../profile/house/add_house_page.dart';
import '../../profile/new_house/apply_record_page.dart';
import '../../profile/new_house/my_house_page.dart';
import '../../profile/new_house/widgets/add_house_button.dart';

class AdviceHousePage extends StatefulWidget {
  const AdviceHousePage({Key? key}) : super(key: key);

  @override
  State<AdviceHousePage> createState() => _AdviceHousePageState();
}

class _AdviceHousePageState extends State<AdviceHousePage> {
  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的房屋',
      body: SafeArea(
          child: UserTool.userProvider.myHouses.isEmpty
              ? HouseEmptyWidget()
              : EasyRefresh(
            controller: _refreshController,
            firstRefresh: true,
            header: MaterialHeader(),
            onRefresh: () async {
              await UserTool.userProvider.updateMyHouseInfo();
              setState(() {});
            },
            child: ListView(
              padding:
              EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
              children: <Widget>[
                ...UserTool.userProvider.myHouses
                    .map((e) => _houseCard(e))
                    .toList()
              ].sepWidget(separate: 24.w.heightBox),
            ),
          )),
    );
  }
  Widget _houseCard(MyHouseModel model) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            var base = await NetUtil().get(
                SAASAPI.profile.house.switchDefaultEstate,
                params: {'estateId': model.id});
            if (base.success) {
              _refreshController.callRefresh();
              UserTool.userProvider.updateDefaultHouse();
              Get.back();
            } else {
              BotToast.showText(text: '切换默认房屋失败');
            }
          },
          child: Material(
            child: Container(
              width: 686.w,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.w)),
              child: Column(
                children: [
                  Row(
                    children: [
                      '${model.addressName}  ${model.communityName}'
                          .text
                          .size(24.sp)
                          .color(Colors.black.withOpacity(0.65))
                          .make(),
                    ],
                  ),
                  8.w.heightBox,
                  Row(
                    children: [
                      '${model.buildingName}栋${model.unitName}单元${model.estateName}'
                          .text
                          .size(36.sp)
                          .color(Colors.black.withOpacity(0.85))
                          .make(),
                      24.w.widthBox,
                      model.isDefault == 1
                          ? BeeTag.yellowSolid(
                          text: '${model.manageEstateTypeName}')
                          : BeeTag.blackSolid(
                          text: '${model.manageEstateTypeName}'),
                    ],
                  ),
                  24.w.heightBox,
                  BeeDivider.horizontal(),
                  24.w.heightBox,
                  Row(
                    children: [
                      model.isDefault == 1
                          ? BeeTag.yellowHollow(
                          text: '${model.manageEstateTypeName}')
                          : BeeTag.blackHollow(
                          text: '${model.manageEstateTypeName}'),
                      10.w.widthBox,
                      '${model.name}  ${model.tel}'
                          .text
                          .size(24.sp)
                          .color(Colors.black.withOpacity(0.65))
                          .make(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        if (model.isDefault == 1)
          Positioned(
            top: 0,
            right: 0,
            child: ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  width: 120.w,
                  height: 80.w,
                  color: kPrimaryColor,
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, top: 10.w),
                    child: Icon(
                      Icons.check,
                      size: 40.w,
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
      ],
    );
  }
}
