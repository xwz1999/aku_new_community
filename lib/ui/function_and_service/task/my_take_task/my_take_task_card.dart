import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/saas_model/task/my_take_task_list_model.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/buttons/card_bottom_button.dart';
import 'package:aku_new_community/widget/views/bee_hor_image_view.dart';
import 'package:aku_new_community/widget/voice_player.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../task_func.dart';
import '../task_map.dart';
import 'my_take_task_detail_page.dart';

class MyTakeTaskCard extends StatelessWidget {
  final MyTakeTaskListModel model;
  final VoidCallback refresh;

  const MyTakeTaskCard({Key? key, required this.model, required this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appointment = Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xFFFA8C16),
              borderRadius: BorderRadius.circular(8.w)),
          child: Text(
            '预',
            style: TextStyle(color: Colors.white, fontSize: 24.sp),
          ),
        ),
        24.w.widthBox,
        '${DateUtil.formatDateStr(model.readyEndTime, format: 'MM月dd日 HH:mm')}前'
            .text
            .size(24.sp)
            .color(Colors.black.withOpacity(0.65))
            .make(),
      ],
    );
    return GestureDetector(
      onTap: () async {
        await Get.to(() => MyTakeTaskDetailPage(model: model));
        refresh();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
        child: Column(
          children: [
            Row(
              children: [
                '接单时间  ${DateUtil.formatDateStr(model.updateDate)}'
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
            24.w.heightBox,
            appointment,
            20.w.heightBox,
            Row(
              children: [
                Assets.icons.watch.image(width: 40.w, height: 40.w),
                24.w.widthBox,
                '${model.serviceTime ?? '0'}'
                    .richText
                    .withTextSpanChildren([
                      ' 分钟'.textSpan.size(28.sp).color(Colors.black).make(),
                    ])
                    .size(28.sp)
                    .color(Color(0xFFFA8C16))
                    .make(),
              ],
            ),
            24.w.heightBox,
            Row(
              children: [
                Assets.icons.environment.image(width: 40.w, height: 40.w),
                24.w.widthBox,
                '${model.accessAddress}'
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
                  (model.remarks ?? "")
                      .text
                      .size(28.sp)
                      .color(Colors.black.withOpacity(0.65))
                      .make(),
                  24.w.heightBox,
                  VoicePlayer(
                    url: model.voiceUrl,
                  ),
                  24.w.heightBox,
                  BeeHorImageView(
                      maxCount: 4,
                      onPressed: () {
                        Get.to(() => MyTakeTaskDetailPage(model: model));
                      },
                      imgs: model.imgList ?? [],
                      imgWidth: 135.w,
                      imgHeight: 135.w),
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
            _cardBottom(),
          ],
        ),
      ),
    );
  }

  Widget _cardBottom() {
    switch (model.status) {
      case 2:
        return CardBottomButton.yellow(
            text: '开始服务',
            onPressed: () async {
              var re = await TaskFunc.start(taskId: model.id);
              if (re) {
                refresh();
              }
            });
      case 3:
        return Column(
          children: [
            40.w.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // CardBottomButton.white(
                //     text: '取消订单',
                //     onPressed: () async {
                //       var re = await TaskFunc.cancel(taskId: model.id);
                //       if (re) {
                //         refresh();
                //       }
                //     }),
                CardBottomButton.yellow(
                    text: '完成任务',
                    onPressed: () async {
                      var re = await TaskFunc.finish(taskId: model.id);
                      if (re) {
                        refresh();
                      }
                    }),
              ].sepWidget(separate: 10.w.widthBox),
            )
          ],
        );
      case 9:
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
