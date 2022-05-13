import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/tab_navigator.dart';
import 'package:aku_new_community/ui/profile/house/add_house_page.dart';
import 'package:aku_new_community/ui/profile/new_house/widgets/add_house_button.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class CertificationSuccessPage extends StatefulWidget {
  const CertificationSuccessPage({Key? key}) : super(key: key);

  @override
  _CertificationSuccessPageState createState() =>
      _CertificationSuccessPageState();
}

class _CertificationSuccessPageState extends State<CertificationSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '认证结果',
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Assets.images.success.image(width: 320.w, height: 320.w),
            34.w.heightBox,
            '提交成功'.text.size(40.sp).color(Colors.black).bold.make(),
            94.w.heightBox,
            AddHouseButton(text: '添加房屋', onTap: () {
              Get.to(() => AddHousePage());
            }),
            40.w.heightBox,
            AddHouseButton(
                text: '返回首页',
                hollow: true,
                onTap: () {
                  Get.offAll(() => TabNavigator());
                })
          ],
        ),
      )),
    );
  }
}
