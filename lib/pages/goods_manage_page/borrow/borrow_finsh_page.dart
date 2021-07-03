import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/pages/tab_navigator.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class BorrowFinshPage extends StatefulWidget {
  final bool? isSuccess;
  final String? failText;
  BorrowFinshPage({Key? key, this.isSuccess, this.failText}) : super(key: key);

  @override
  _BorrowFinshPageState createState() => _BorrowFinshPageState();
}

class _BorrowFinshPageState extends State<BorrowFinshPage> {
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
              child: Image.asset(widget.isSuccess!
                  ? R.ASSETS_ICONS_BORROW_SUCCESS_PNG
                  : R.ASSETS_ICONS_BORROW_FAILURE_PNG),
            ),
            48.w.heightBox,
            '${widget.isSuccess! ? '出借成功' : '出借失败'}'
                .text
                .color(ktextPrimary)
                .size(36.sp)
                .bold
                .make(),
            16.w.heightBox,
            '${widget.isSuccess! ? '使用后请记得归还' : widget.failText}'
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
              onPressed: widget.isSuccess!
                  ? () {
                      Get.offAll(() => TabNavigator());
                    }
                  : () {
                      Get.back();
                    },
              child: '${widget.isSuccess! ? '返回首页' : '重新提交'}'
                  .text
                  .color(widget.isSuccess! ? ktextPrimary : Colors.white)
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
