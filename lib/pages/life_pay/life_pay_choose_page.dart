import 'package:aku_community/const/resource.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';
import 'package:aku_community/pages/life_pay/life_pay_page.dart';
import 'package:aku_community/pages/share_pay_page/share_pay_page.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LifePayChoosePage extends StatefulWidget {
  const LifePayChoosePage({Key? key}) : super(key: key);

  @override
  _LifePayChoosePageState createState() => _LifePayChoosePageState();
}

class _LifePayChoosePageState extends State<LifePayChoosePage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '生活缴费',
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 36.w),
        children: [
          _buidTile(R.ASSETS_ICONS_GOODS_BORROW_PNG, '生活缴费', true),
          _buidTile(R.ASSETS_ICONS_GOODS_BORROW_PNG, '公摊缴费', false),
        ].sepWidget(separate: 20.w.heightBox),
      ),
    );
  }

  Widget _buidTile(String iconPath, String text, bool isBorrow) {
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
      isBorrow ? Get.to(() => LifePayPage()) : Get.to(() => SharePayPage());
    }).material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.w),
      clipBehavior: Clip.antiAlias,
    );
  }
}
