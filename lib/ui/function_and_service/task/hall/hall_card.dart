import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/task/hall_list_model.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/buttons/card_bottom_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:aku_new_community/widget/views/bee_hor_image_view.dart';
import 'package:aku_new_community/widget/voice_player.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../task_func.dart';
import '../task_map.dart';
import 'hall_detail_page.dart';

class HallCard extends StatelessWidget {
  final HallListModel model;
  final VoidCallback refresh;

  const HallCard({Key? key, required this.model, required this.refresh})
      : super(key: key);

  bool get myself => UserTool.userProvider.userInfoModel!.id == model.createId;

  @override
  Widget build(BuildContext context) {
    var head = Row(
      children: [
        Container(
          width: 100.w,
          height: 50.w,
          alignment: Alignment.center,
          color: Color(0xFFFFF7E6),
          child: '#${TaskMap.typeToString[model.type]}'
              .text
              .size(28.sp)
              .color(Color(0xFFFA8C16))
              .make(),
        ),
        8.w.widthBox,
        Offstage(
          offstage: !myself,
          child: Container(
            width: 128.w,
            height: 50.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xFFFFE7BA),
                borderRadius: BorderRadius.circular(8.w)),
            child: '我发布的'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.85))
                .make(),
          ),
        ),
        Spacer(),
        Assets.icons.intergral.image(width: 24.w, height: 24.w),
        8.w.widthBox,
        '${model.reward}'.text.size(32.sp).color(Colors.red).make()
      ],
    );
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
        await Get.to(() => HallDetailPage(model: model));
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
            head,
            24.w.heightBox,
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
                Assets.icons.environment.image(width: 36.w, height: 36.w),
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
                  '${model.remarks ?? ''}'
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
                        Get.to(() => HallDetailPage(model: model));
                      },
                      imgs: model.imgList ?? [],
                      imgWidth: 135.w,
                      imgHeight: 135.w),
                ],
              ),
            ),
            24.w.heightBox,
            BeeDivider.horizontal(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                40.w.heightBox,
                Row(
                  children: [
                    Spacer(),
                    Offstage(
                      offstage: !myself,
                      child: CardBottomButton.white(
                          text: '取消发布',
                          onPressed: () async {
                            var re = await TaskFunc.cancel(taskId: model.id);
                            if (re) {
                              refresh();
                            }
                          }),
                    ),
                    Offstage(
                      offstage: myself,
                      child: CardBottomButton.yellow(
                          text: '领取任务',
                          onPressed: () async {
                            var re = await TaskFunc.take(taskId: model.id);
                            if (re) {
                              refresh();
                            }
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardBottom(int) {
    switch (int) {
      case 1:
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            40.w.heightBox,
            CardBottomButton.white(
                text: '取消订单',
                onPressed: () async {
                  var re = await TaskFunc.cancel(taskId: model.id);
                  if (re) {
                    refresh();
                  }
                }),
            CardBottomButton.yellow(
                text: '确认完成',
                onPressed: () async {
                  var re = await TaskFunc.finish(taskId: model.id);
                  if (re) {
                    refresh();
                  }
                }),
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
