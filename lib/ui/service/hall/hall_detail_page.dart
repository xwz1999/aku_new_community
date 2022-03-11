import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/task/hall_list_model.dart';
import 'package:aku_new_community/ui/service/task_func.dart';
import 'package:aku_new_community/ui/service/task_map.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';
import 'package:aku_new_community/widget/voice_player.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HallDetailPage extends StatefulWidget {
  final HallListModel model;

  const HallDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _HallDetailPageState createState() => _HallDetailPageState();
}

class _HallDetailPageState extends State<HallDetailPage> {
  bool get myself =>
      UserTool.userProvider.userInfoModel!.id == widget.model.createId;

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      extendBody: true,
      title: '',
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 380.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFFFB737),
                        Color(0xFFFFD361),
                      ]),
                ),
                child: Column(
                  children: [
                    150.w.heightBox,
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              '未领取'
                                  .text
                                  .size(40.sp)
                                  .color(Colors.black)
                                  .bold
                                  .make(),
                              '正在等待其他人接单'
                                  .text
                                  .size(24.sp)
                                  .color(Colors.black.withOpacity(0.45))
                                  .make(),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  color: Color(0xFFE5E5E5),
                ),
              ),
            ],
          ),
          Positioned(
              top: 280.w,
              left: 32.w,
              right: 32.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _content(),
                  24.w.heightBox,
                  _taskInfo(),
                ],
              )),
        ],
      ),
      bottomNavi: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(32.w),
        child: myself
            ? BeeLongButton.white(
                onPressed: () async {
                  var re = await TaskFunc.cancel(taskId: widget.model.id);
                  if (re) {
                    Get.back();
                  }
                },
                text: '取消任务')
            : BeeLongButton(
                onPressed: () async {
                  var re = await TaskFunc.take(taskId: widget.model.id);
                  if (re) {
                    Get.back();
                  }
                },
                text: '领取任务',
              ),
      ),
    );
  }

  Widget _taskInfo() {
    return Container(
      width: 686.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
      child: Column(
        children: [
          Row(
            children: [
              '任务信息'.text.size(28.sp).color(Colors.black).bold.make(),
              Spacer(),
            ],
          ),
          24.w.heightBox,
          BeeDivider.horizontal(),
          24.w.heightBox,
          Row(
            children: [
              '创建时间'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
              '${DateUtil.formatDateStr(widget.model.createDate)}'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              64.w.widthBox,
            ],
          ),
          24.w.heightBox,
          Row(
            children: [
              '任务单号'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
              '${widget.model.code}'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              24.w.widthBox,
              GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(
                        ClipboardData(text: widget.model.code));
                    BotToast.showText(text: '已复制到粘贴板');
                  },
                  child: Assets.icons.copy.image(width: 40.w, height: 40.w)),
            ],
          )
        ],
      ),
    );
  }

  Widget _content() {
    var head = Row(
      children: [
        Container(
          width: 100.w,
          height: 50.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFFFF7E6),
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: '#${TaskMap.taskType[widget.model.type]}'
              .text
              .size(28.sp)
              .color(Color(0xFFFA8C16))
              .make(),
        ),
        Spacer(),
      ],
    );
    return Container(
      width: 686.w,
      // height: 500.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
      child: Column(
        children: [
          head,
          34.w.heightBox,
          Row(
            children: [
              Assets.icons.watch.image(width: 40.w, height: 40.w),
              24.w.widthBox,
              '${widget.model.serviceTime ?? '0'}'
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
              '${widget.model.accessAddress}'
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
                widget.model.remarks.text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
                24.w.heightBox,
                VoicePlayer(
                  url: widget.model.voiceUrl,
                ),
                24.w.heightBox,
                BeeGridImageView(
                    urls:
                        widget.model.imgList?.map((e) => e.url).toList() ?? []),
              ],
            ),
          ),
          32.w.heightBox,
          BeeDivider.horizontal(),
          32.w.heightBox,
          Row(
            children: [
              Assets.icons.reward.image(width: 36.w, height: 36.w),
              24.w.widthBox,
              '报酬'
                  .text
                  .size(26.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
              widget.model.rewardType == 1
                  ? Text(
                      '¥ ',
                      style: TextStyle(color: Colors.red, fontSize: 32.sp),
                    )
                  : Assets.icons.intergral.image(width: 24.w, height: 24.w),
              8.w.widthBox,
              '${widget.model.reward}'.text.size(32.sp).color(Colors.red).make()
            ],
          ),
        ],
      ),
    );
  }
}
