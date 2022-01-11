import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/ui/profile/new_house/add_house_page.dart';
import 'package:aku_new_community/ui/profile/new_house/widgets/add_house_button.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/dialog/certification_dialog.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHousePage extends StatefulWidget {
  const MyHousePage({Key? key}) : super(key: key);

  @override
  _MyHousePageState createState() => _MyHousePageState();
}

class _MyHousePageState extends State<MyHousePage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的房屋',
      body: SafeArea(
          child: UserTool.userProvider.myHouses.isEmpty
              ? _emptyWidget()
              : ListView()),
      bottomNavi: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
        child: AddHouseButton(
          onTap: () async {
            if (UserTool.userProvider.userInfoModel?.name == null) {
              await Get.dialog(CertificationDialog());
            } else {
              Get.to(() => AddHousePage());
            }
          },
          text: '添加房屋',
        ),
      ),
    );
  }

  Widget _houseCard() {
    return Stack(
      children: [
        Container(
          width: 686.w,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }

  Widget _emptyWidget() {
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
