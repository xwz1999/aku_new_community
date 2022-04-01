import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/saas_model/work_order/work_order_bill_model.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class WorkOrderBillDialog extends StatelessWidget {
  final List<WorkOrderBillModel> models;

  const WorkOrderBillDialog({Key? key, required this.models}) : super(key: key);

  double get total {
    double sum = 0;
    for (var item in models) {
      sum = sum + item.price;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          40.hb,
          '确认账单'
              .text
              .size(32.sp)
              .isIntrinsic
              .color(Colors.black.withOpacity(0.65))
              .make(),
          80.hb,
          ...models
              .map((e) => Row(
                    children: [
                      '${e.costType == 1 ? '人工费' : '耗材费'}${e.name}${e.costType == 1 ? '' : '*${e.number}'}'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.65))
                          .isIntrinsic
                          .make(),
                      Spacer(),
                      '¥${e.price}'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.65))
                          .isIntrinsic
                          .make(),
                    ],
                  ))
              .toList()
              .sepWidget(
                separate: 16.hb,
              ),
          BeeDivider.horizontal(),
          Row(
            children: [
              '工单总费用'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.65))
                  .isIntrinsic
                  .make(),
              Spacer(),
              '¥${total}'
                  .text
                  .size(28.sp)
                  .color(Color(0xFFF5222D))
                  .isIntrinsic
                  .make(),
            ],
          ),
          80.hb,
          BeeLongButton(
              onPressed: () {
                Get.back();
              },
              text: '确认支付'),
        ],
      ),
    );
  }
}
