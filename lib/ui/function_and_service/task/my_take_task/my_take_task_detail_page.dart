import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/task/my_take_task_list_model.dart';
import 'package:aku_new_community/ui/function_and_service/task/dialogs/task_cancel_dialog.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';
import 'package:aku_new_community/widget/voice_player.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../task_func.dart';
import '../task_map.dart';

class MyTakeTaskDetailPage extends StatefulWidget {
  final MyTakeTaskListModel model;

  const MyTakeTaskDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _MyTakeTaskDetailPageState createState() => _MyTakeTaskDetailPageState();
}

class _MyTakeTaskDetailPageState extends State<MyTakeTaskDetailPage> {
  String get detailStatusToString {
    switch (widget.model.status) {
      case 1:
        return '待服务';
      case 2:
        if (widget.model.endTime?.isBefore(DateTime.now()) ?? false) {
          return '已超时(原预计${DateUtil.formatDate(widget.model.endTime, format: DateFormats.h_m)}';
        } else {
          return '服务中';
        }
      case 3:
        return '等待用户确认';
      case 4:
        return '已完成';
      case 5:
        return '已评价';
      case 9:
        return '已取消';
      default:
        return '';
    }
  }

  String get subStatusString {
    switch (widget.model.status) {
      case 1:
        return '请与发布人确认后开始服务';
      case 2:
        if (widget.model.endTime?.isBefore(DateTime.now()) ?? false) {
          return '请及时提醒帮手完成任务';
        } else {
          return '帮手正在为您服务中';
        }
      case 3:
        return '请注意及时确认帮手的工作内容';
      case 4:
        return '欢迎对骑手及本次任务进行评价';
      case 5:
        return '感谢信任与支持，欢迎再次光临';
      case 9:
        return '请及时提醒帮手完成任务';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      extendBody: true,
      title: '',
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 380.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: widget.model.status == 9
                      ? [
                          Colors.white,
                          Color(0xFFADACAC),
                        ]
                      : [
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
                          '${detailStatusToString}'
                              .text
                              .size(40.sp)
                              .color(Colors.black)
                              .bold
                              .make(),
                          '${subStatusString}'
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
          SafeArea(
            child: ListView(
              padding: EdgeInsets.only(top: 120.w, left: 32.w, right: 32.w),
              children: [
                _content(),
                24.w.heightBox,
                _taskInfo(),
              ],
            ),
          ),
        ],
      ),
      bottomNavi: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(32.w),
        child: Row(
          children: [
            MaterialButton(
              onPressed: () async {
                var re = await Get.bottomSheet(
                    TaskCancelDialog(taskId: widget.model.id));
                if (re) {
                  Get.back();
                }
              },
              minWidth: 330.w,
              height: 80.w,
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.w),
                side: BorderSide(color: Colors.black.withOpacity(0.25)),
              ),
              child: Text(
                '取消订单',
                style: TextStyle(
                    fontSize: 28.sp, color: Colors.black.withOpacity(0.65)),
              ),
            ),
            Spacer(),
            buttonByStatus,
          ],
        ),
      ),
    );
  }

  Widget get buttonByStatus {
    switch (widget.model.status) {
      case 1:
        return MaterialButton(
          onPressed: () async {
            var re = await TaskFunc.start(taskId: widget.model.id);
            if (re) {
              Get.back();
            }
          },
          minWidth: 330.w,
          height: 80.w,
          elevation: 0,
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.w),
          ),
          child: Text(
            '开始服务',
            style: TextStyle(
                fontSize: 28.sp, color: Colors.black.withOpacity(0.85)),
          ),
        );
      case 2:
        return MaterialButton(
          onPressed: () {},
          minWidth: 330.w,
          height: 80.w,
          elevation: 0,
          color: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.w),
          ),
          child: Text(
            '完成任务',
            style: TextStyle(
                fontSize: 28.sp, color: Colors.black.withOpacity(0.85)),
          ),
        );
      case 3:
        return BeeLongButton(
          onPressed: () async {},
          text: '提醒用户',
        );
      case 4:
      case 5:
      case 9:
      default:
        return SizedBox.shrink();
    }
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
