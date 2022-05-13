import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/saas_model/work_order/work_order_progress_model.dart';
import 'package:aku_new_community/widget/bee_divider.dart';

class WorkOrderProgressDialog extends StatelessWidget {
  final List<WorkOrderProgressModel> models;

  const WorkOrderProgressDialog({Key? key, required this.models})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.w), color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 36.w),
            child: Row(
              children: [
                '工单进度'
                    .text
                    .size(28.sp)
                    .isIntrinsic
                    .color(Colors.black.withOpacity(0.85))
                    .make(),
              ],
            ),
          ),
          BeeDivider.horizontal(),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 36.w),
              child: Column(
                children: [
                  ...models
                      .mapIndexed((currentValue, index) => _buildLine(
                            currentValue,
                            index,
                          ))
                      .toList()
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildLine(WorkOrderProgressModel model, int index) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateUtil.formatDateStr(model.createDate, format: 'MM/dd')
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.45))
              .make(),
          16.wb,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.w),
                    border: index == 0
                        ? Border.all(color: Color(0xFFFAC058), width: 4.w)
                        : null,
                    color: index == 0
                        ? Colors.white
                        : Colors.black.withOpacity(0.25)),
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      color: index == 0
                          ? Color(0xFFFAC058)
                          : Colors.black.withOpacity(0.25)),
                ),
              ),
              Offstage(
                offstage: index == models.length - 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    16.hb,
                    Container(
                      width: 4.w,
                      height: 55.w,
                      color: index == 0
                          ? Color(0xFFFAC058)
                          : Colors.black.withOpacity(0.25),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.wb,
          DateUtil.formatDateStr(model.createDate, format: 'HH:mm')
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.85))
              .make(),
          32.wb,
          '${model.content}'
              .text
              .size(28.sp)
              .color(index == 0
                  ? Color(0xFFFAC058)
                  : Colors.black.withOpacity(0.65))
              .make()
        ],
      ),
    );
  }
}
