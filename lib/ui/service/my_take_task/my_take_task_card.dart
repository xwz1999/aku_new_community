import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/task/hall_list_model.dart';
import 'package:aku_new_community/ui/service/task_map.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/buttons/card_bottom_button.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTakeTaskCard extends StatelessWidget {
  final HallListModel model;
  final VoidCallback refresh;

  const MyTakeTaskCard({Key? key, required this.model, required this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(8.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
      child: Column(
        children: [
          Row(
            children: [
              '接单时间  ${DateUtil.formatDateStr(model.createDate)}'
                  .text
                  .size(26.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
              '${TaskMap.statusToString[model.status]}'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.85))
                  .bold
                  .make()
            ],
          ),
          20.w.heightBox,
          BeeDivider.horizontal(),
          34.w.heightBox,
          Row(
            children: [
              Assets.icons.clockCircle.image(width: 36.w, height: 36.w),
              24.w.widthBox,
              '${DateUtil.formatDateStr(model.appointmentDate)}'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.65))
                  .make(),
            ],
          ),
          20.w.heightBox,
          Row(
            children: [
              Assets.icons.environment.image(width: 36.w, height: 36.w),
              24.w.widthBox,
              '${model.appointmentAddress}'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.65))
                  .make(),
            ],
          ),
          34.w.heightBox,
          Container(
            width: 638.w,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.03),
                borderRadius: BorderRadius.circular(8.w)),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                '#${TaskMap.typeToString[model.type]}'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.85))
                    .make(),
                16.w.heightBox,
                model.content.text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              ],
            ),
          ),
          40.w.heightBox,
          Row(
            children: [
              Spacer(),
              RichText(
                text: TextSpan(
                  text: '实付 ',
                  children: model.rewardType == 2
                      ? [
                          WidgetSpan(
                            child: Assets.icons.intergral
                                .image(width: 24.w, height: 24.w),
                          ),
                          model.reward
                              .toString()
                              .textSpan
                              .size(32.sp)
                              .color(Colors.red)
                              .make(),
                        ]
                      : [
                          '¥ ${model.reward}'
                              .toString()
                              .textSpan
                              .size(32.sp)
                              .color(Colors.red)
                              .make(),
                        ],
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.65), fontSize: 24.sp),
                ),
              )
            ],
          ),
          _cardBottom(model.status),
        ],
      ),
    );
  }

  Widget _cardBottom(int) {
    switch (int) {
      case 1:
      case 2:
        return Column(
          children: [
            40.w.heightBox,
            Row(
              children: [
                CardBottomButton.white(text: '取消订单', onPressed: () {}),
                CardBottomButton.yellow(text: '确认完成', onPressed: () {}),
              ],
            )
          ],
        );
      case 4:
        return Column(
          children: [
            32.w.heightBox,
            Row(
              children: [
                '客户取消:暂不需要该服务'.text.size(24.sp).color(Colors.red).make(),
                Spacer(),
              ],
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }
}
