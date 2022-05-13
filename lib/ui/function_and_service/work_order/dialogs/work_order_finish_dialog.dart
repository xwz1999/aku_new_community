import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/widget/buttons/card_bottom_button.dart';

class WorkOrderFinishDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const WorkOrderFinishDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            borderRadius: BorderRadius.circular(16.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.w),
              ),
              width: 628.w,
              height: 555.w,
              child: Column(
                children: [
                  196.hb,
                  '是否确认工单完成'.text.color(Colors.black).isIntrinsic.make(),
                  40.hb,
                  '请确认问题是否已得到解决'
                      .text
                      .size(28.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .isIntrinsic
                      .make(),
                  80.hb,
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40.w, horizontal: 32.w),
                    child: Row(
                      children: [
                        CardBottomButton.white(
                            width: 270.w,
                            height: 64.w,
                            text: '查看报告',
                            onPressed: () {
                              Get.back();
                            }),
                        Spacer(),
                        CardBottomButton.yellow(
                            width: 270.w,
                            height: 64.w,
                            text: '确认完成',
                            onPressed: onConfirm),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 193.w,
            top: -150.w,
            child: Assets.icons.finishOrder.image(width: 293.w, height: 322.w),
          ),
        ],
      ),
    );
  }
}
