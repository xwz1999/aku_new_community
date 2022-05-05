import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/user/my_house_model.dart';
import 'package:aku_new_community/ui/profile/new_house/add_house_page.dart';
import 'package:aku_new_community/ui/profile/new_house/apply_record_page.dart';
import 'package:aku_new_community/ui/profile/new_house/widgets/add_house_button.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/dialog/certification_dialog.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:aku_new_community/widget/tag/bee_tag.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHousePage extends StatefulWidget {
  const MyHousePage({Key? key}) : super(key: key);

  @override
  _MyHousePageState createState() => _MyHousePageState();
}

class _MyHousePageState extends State<MyHousePage> {
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
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => ApplyRecordPage());
            },
            icon: Assets.icons.record.image(width: 40.w, height: 40.w))
      ],
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
      bottomNavi: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
        child: AddHouseButton(
          onTap: () async {
              Get.to(() => AddHousePage());

          },
          text: '添加房屋',
        ),
      ),
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

class HouseEmptyWidget extends StatelessWidget {
  const HouseEmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          180.w.heightBox,
          Assets.images.houseEmpty.image(width: 480.w, height: 480.w),
          '当前没有绑定任何房屋'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.25))
              .make(),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
