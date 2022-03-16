import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/stack_avatar.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/src/extensions/num_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class WorkOrderDetailPage extends StatefulWidget {
  const WorkOrderDetailPage({Key? key}) : super(key: key);

  @override
  _WorkOrderDetailPageState createState() => _WorkOrderDetailPageState();
}

class _WorkOrderDetailPageState extends State<WorkOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
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
                  colors: false
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
                          'detailStatusToString'
                              .text
                              .size(40.sp)
                              .color(Colors.black)
                              .bold
                              .make(),
                          'subStatusString'
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
              _head(),
              24.hb,
              _content(),
              24.w.heightBox,
              _taskInfo(),
            ],
          )),
        ],
      ),
    );
  }

  Widget _servicePeople() {
    return Container(
      padding: EdgeInsets.all(24.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        children: [
          '服务人员名单'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.85))
              .make(),
          24.hb,
          BeeDivider.horizontal(),
          24.hb,
          GestureDetector(
            onTap: () {},
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  StackAvatar(avatars: []),
                  Spacer(),
                  '点击查看'
                      .text
                      .size(28.sp)
                      .color(Colors.black.withOpacity(0.65))
                      .make(),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 24.w,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _head() {
    return Container(
      padding: EdgeInsets.all(24.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFBE6),
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: '家政服务'.text.size(24.sp).color(Color(0xFFD48806)).make(),
              ),
            ],
          ),
          16.hb,
          Row(
            children: [
              Assets.icons.alarmClock.image(width: 40.w, height: 40.w),
              24.wb,
              '2022.02.21 15:30'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ],
          ),
          16.hb,
          Row(
            children: [
              Assets.icons.taskLocation.image(width: 40.w, height: 40.w),
              24.wb,
              '绿城·碧桂园3好楼门外'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ],
          ),
          24.hb,
        ],
      ),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(24.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'xxxxxxxxxxxxxxxxxxxxxxxx'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.65))
              .make(),
          24.hb,
          BeeGridImageView(
            urls: [],
          ),
          24.hb,
        ],
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
              '${DateUtil.formatDateStr('')}'
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
              'widget.model.code}'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              24.w.widthBox,
              GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(
                        ClipboardData(text: 'widget.model.code'));
                    BotToast.showText(text: '已复制到粘贴板');
                  },
                  child: Assets.icons.copy.image(width: 40.w, height: 40.w)),
            ],
          )
        ],
      ),
    );
  }
}
