import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/ui/profile/new_house/certification/certification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CertificationDialog extends StatelessWidget {
  const CertificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          width: 623.w,
          height: 394.w,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Column(
            children: [
              '实名认证提醒'.text.size(32.sp).black.bold.isIntrinsic.make(),
              48.w.heightBox,
              '添加房屋需要填写住户的真实信息，请在选择房屋前完成实名认证。'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.65))
                  .isIntrinsic
                  .make(),
              64.w.heightBox,
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.w),
                        side:
                            BorderSide(color: Colors.black.withOpacity(0.25))),
                    color: Colors.white,
                    minWidth: 260.w,
                    height: 70.w,
                    elevation: 0,
                    child: '取消'
                        .text
                        .size(28.sp)
                        .color(Colors.black.withOpacity(0.65))
                        .isIntrinsic
                        .make(),
                  ),
                  Spacer(),
                  MaterialButton(
                    onPressed: () {
                      Get.off(() => CertificationPage());
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    elevation: 0,
                    color: kPrimaryColor,
                    minWidth: 260.w,
                    height: 70.w,
                    child: '进行实名认证'
                        .text
                        .size(28.sp)
                        .color(Colors.black)
                        .bold
                        .isIntrinsic
                        .make(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
