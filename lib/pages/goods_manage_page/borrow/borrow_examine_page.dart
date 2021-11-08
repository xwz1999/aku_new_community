import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/pages/tab_navigator.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class BorrowExaminePage extends StatefulWidget {

  BorrowExaminePage({Key? key}) : super(key: key);

  @override
  _BorrowExaminePageState createState() => _BorrowExaminePageState();
}

class _BorrowExaminePageState extends State<BorrowExaminePage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '出借结果',
      body: Center(
        child: Column(
          children: [
            75.w.heightBox,
            SizedBox(
              width: 110.w,
              height: 110.w,
              child: Image.asset(R.ASSETS_ICONS_EXAMINE_PNG
                 ),
            ),
            48.w.heightBox,
            '正在审核中'
                .text
                .color(ktextPrimary)
                .size(36.sp)
                .bold
                .make(),
            16.w.heightBox,
            '使用后请记得归还'
                .text
                .color(ktextSubColor)
                .size(26.sp)
                .make(),
            95.w.heightBox,
            MaterialButton(
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.w)),
              elevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              focusElevation: 0,
              disabledElevation: 0,
              padding: EdgeInsets.symmetric(vertical: 24.w),
              minWidth: double.infinity,
              onPressed: () {
                      Get.back();},
              child: '返回物品借还列表'
                  .text
                  .color( ktextPrimary )
                  .size(36.sp)
                  .make(),
            )
          ],
        ),
      ).pSymmetric(
        h: 24.w,
      ),
    );
  }
}
