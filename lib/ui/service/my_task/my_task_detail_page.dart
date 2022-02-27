import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/task/my_task_list_model.dart';
import 'package:aku_new_community/ui/service/task_map.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../task_func.dart';

class MyTaskDetailPage extends StatefulWidget {
  final MyTaskListModel model;

  const MyTaskDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _MyTaskDetailPageState createState() => _MyTaskDetailPageState();
}

class _MyTaskDetailPageState extends State<MyTaskDetailPage> {
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
                      colors: widget.model.status == 4
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
                              '${TaskMap.detailStatusToString[widget.model.status]}'
                                  .text
                                  .size(40.sp)
                                  .color(Colors.black)
                                  .bold
                                  .make(),
                              '${TaskMap.subStatus[widget.model.status]}'
                                  .text
                                  .size(24.sp)
                                  .color(Colors.black.withOpacity(0.45))
                                  .make(),
                            ],
                          ),
                        ),
                        Spacer(),
                        // Padding(
                        //   padding: EdgeInsets.only(right: 32.w),
                        //   child: MaterialButton(
                        //     color: Colors.white,
                        //     elevation: 0,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8.w),
                        //     ),
                        //     onPressed: () async {
                        //       var re = await TaskFunc.cancel(
                        //           taskId: widget.model.id);
                        //       if (re) {
                        //         Get.back();
                        //       }
                        //     },
                        //     child: '取消订单'
                        //         .text
                        //         .size(24.sp)
                        //         .color(Colors.black.withOpacity(0.65))
                        //         .make(),
                        //   ),
                        // )
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
      bottomNavi: widget.model.status != 3
          ? SizedBox()
          : BottomButton(
              onPressed: () async {
                await TaskFunc.confirm(taskId: widget.model.id);
              },
              child: Text('完成任务'),
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
                  .make()
            ],
          ),
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
          child: '#${TaskMap.typeToString[widget.model.type]}'
              .text
              .size(28.sp)
              .color(Color(0xFFFA8C16))
              .make(),
        ),
        Spacer(),
        Assets.icons.intergral.image(width: 24.w, height: 24.w),
        8.w.widthBox,
        '${widget.model.reward}'.text.size(32.sp).color(Colors.red).make()
      ],
    );
    return Container(
      width: 686.w,
      height: 500.w,
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
              Assets.icons.clockCircle.image(width: 36.w, height: 36.w),
              24.w.widthBox,
              '${DateUtil.formatDateStr(widget.model.appointmentDate)}'
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
              '${widget.model.appointmentAddress}'
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
                '#${TaskMap.typeToString[widget.model.type]}'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.85))
                    .make(),
                16.w.heightBox,
                widget.model.content.text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
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
              '¥${widget.model.reward}'
                  .text
                  .size(32.sp)
                  .color(Colors.red)
                  .make(),
            ],
          ),
        ],
      ),
    );
  }
}
