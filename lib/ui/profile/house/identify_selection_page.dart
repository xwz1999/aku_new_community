import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/ui/profile/house/lease_relevation/user_identify_page.dart';
import 'package:aku_new_community/ui/profile/house/my_house_list.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class IdentifySelectionPage extends StatelessWidget {
  const IdentifySelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '身份选择',
      body: ListView(
        children: [
          20.w.heightBox,
          _buidTile(R.ASSETS_ICONS_HOUSE_PNG, '业主', true),
          _buidTile(R.ASSETS_ICONS_HOUSE_PNG, '租户', false)
        ].sepWidget(separate: 20.w.heightBox),
      ),
    );
  }

  Widget _buidTile(String iconPath, String text, bool isOwner) {
    return Row(
      children: [
        SizedBox(
          width: 32.w,
          height: 32.w,
          child: Image.asset(iconPath),
        ),
        28.w.widthBox,
        text.text.black.size(30.sp).make(),
        Spacer(),
        Icon(
          CupertinoIcons.chevron_forward,
          size: 32.w,
        ),
      ],
    )
        .box
        .padding(EdgeInsets.symmetric(vertical: 40.w, horizontal: 32.w))
        .make()
        .onInkTap(() {
      Get.off(() => isOwner ? MyHouseList() : UserIdentifyPage());
    }).material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.w),
      clipBehavior: Clip.antiAlias,
    );
  }
}
