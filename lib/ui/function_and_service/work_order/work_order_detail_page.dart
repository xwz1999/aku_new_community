import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/src/extensions/num_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/saas_model/work_order/work_order_detail_model.dart';
import 'package:aku_new_community/ui/function_and_service/task/dialogs/task_evaluation_dialog.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/dialogs/urge_dialog.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/dialogs/work_order_finish_dialog.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/history_report_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/team_list_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_func.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_map.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:aku_new_community/widget/others/stack_avatar.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';

class WorkOrderDetailPage extends StatefulWidget {
  final int id;

  const WorkOrderDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _WorkOrderDetailPageState createState() => _WorkOrderDetailPageState();
}

class _WorkOrderDetailPageState extends State<WorkOrderDetailPage> {
  WorkOrderDetailModel? _model;
  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '',
      extendBody: true,
      body: Stack(
        children: [
          _model == null
              ? Container()
              : Container(
                  width: double.infinity,
                  height: 380.w,
                  decoration: BoxDecoration(
                    gradient: _getLiner,
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
                                GestureDetector(
                                  onTap: () async {
                                    await WorkOrderFuc.getProgress(
                                        workOrderId: widget.id);
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        '${WorkOrderMap.orderStatus[_model?.status] ?? ''}'
                                            .text
                                            .size(40.sp)
                                            .color(Colors.black)
                                            .bold
                                            .make(),
                                        16.wb,
                                        Icon(
                                          CupertinoIcons.chevron_right,
                                          size: 32.w,
                                          color: Colors.black.withOpacity(0.65),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                '${WorkOrderMap.subStatusString[_model?.status] ?? ''}'
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
              child: EasyRefresh(
            firstRefresh: true,
            header: MaterialHeader(),
            onRefresh: () async {
              var base = await NetUtil().get(SAASAPI.workOrder.findById,
                  params: {'workOrderId': widget.id});
              if (base.success) {
                _model = WorkOrderDetailModel.fromJson(base.data);
                setState(() {});
              }
            },
            child: _model == null
                ? Container()
                : ListView(
                    padding:
                        EdgeInsets.only(top: 120.w, left: 32.w, right: 32.w),
                    children: [
                      Offstage(
                          offstage: _model!.status < 5,
                          child: Column(
                            children: [
                              _historyReport(),
                              24.hb,
                            ],
                          )),
                      Offstage(
                          offstage: _model!.servicePersonnelImgList == null ||
                              _model!.servicePersonnelImgList!.isEmpty,
                          child: Column(
                            children: [
                              _servicePeople(),
                              24.hb,
                            ],
                          )),
                      _head(),
                      24.hb,
                      _content(),
                      24.w.heightBox,
                      _taskInfo(),
                    ],
                  ),
          )),
        ],
      ),
      bottomNavi: Padding(
          padding: EdgeInsets.only(
              left: 32.w,
              right: 32.w,
              bottom: MediaQuery.of(context).padding.bottom + 32.w),
          child: _getBottomButton()),
    );
  }

  LinearGradient get _getLiner {
    switch (_model?.status) {
      case 7:
      case 8:
        return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFA5A5A6).withOpacity(0),
              Color(0xFFE0DDDE),
            ]);
      case 9:
        return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFF0000).withOpacity(0),
              Color(0xFFFC5757),
            ]);
      default:
        return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFFD589).withOpacity(0),
              Color(0xFFFAC058),
            ]);
    }
  }

  Widget _getBottomButton() {
    switch (_model?.status) {
      case 1:
        return BeeLongButton(
            onPressed: () {
              launch('tel:');
            },
            text: '联系物业');
      case 2:
      case 3:
      case 4:
        return BeeLongButton(
          onPressed: () async {
            await Get.bottomSheet(UrgeDialog(onConfirm: () async {
              var re = await WorkOrderFuc.promotionRate(widget.id);
              if (re) {
                _refreshController.callRefresh();
              }
            }));
          },
          text: '催促进度',
        );
      case 5:
        return BeeLongButton(
            onPressed: () async {
              await Get.bottomSheet(WorkOrderFinishDialog(onConfirm: () async {
                var re = await WorkOrderFuc.confirmComplete(widget.id);
                if (re) {
                  Get.back();
                  _refreshController.callRefresh();
                }
              }));
            },
            text: '确认完成');
      case 6:
        return BeeLongButton(
            onPressed: () async {
              await WorkOrderFuc.getBill(workOrderId: widget.id);
              _refreshController.callRefresh();
            },
            text: '确认支付');
      case 7:
        return BeeLongButton(
            onPressed: () async {
              await Get.bottomSheet(TaskEvaluationDialog(
                evaluate: (star, content) async {
                  return await WorkOrderFuc.evaluate(
                      workOrderId: widget.id, star: star, evaluation: content);
                },
              ));
            },
            text: '点击评价');
      case 8:
        return SizedBox.shrink();
      case 9:
        return SizedBox.shrink();
      default:
        return SizedBox.shrink();
    }
  }

  Widget _historyReport() {
    return GestureDetector(
      onTap: () {
        Get.to(HistoryReportPage(id: widget.id));
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
          child: Row(
            children: [
              '历史报告'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
              Spacer(),
              '点击查看'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              24.wb,
              Icon(
                CupertinoIcons.chevron_right,
                size: 24.w,
                color: Colors.black.withOpacity(0.45),
              ),
            ],
          ),
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
            onTap: () {
              Get.to(() => TeamListPage(
                    workOderId: _model!.id,
                  ));
            },
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  StackAvatar(
                      avatars: (_model!.servicePersonnelImgList ?? [])
                          .map((e) => e.url)
                          .toList()),
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
                child: '${_model!.workOrderTypeName}'
                    .text
                    .size(24.sp)
                    .color(Color(0xFFD48806))
                    .make(),
              ),
            ],
          ),
          16.hb,
          Row(
            children: [
              Assets.icons.alarmClock.image(width: 40.w, height: 40.w),
              24.wb,
              '${DateUtil.formatDateStr(_model!.reserveDate)}'
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
              '${_model!.reserveAddress}'
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
          '${_model!.content}'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.65))
              .make(),
          24.hb,
          BeeGridImageView(
            urls: (_model!.imgList ?? []).map((e) => e.url).toList(),
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
              '${DateUtil.formatDateStr(_model!.createDate)}'
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
              '工单编号'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
              '${_model!.code}'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              24.w.widthBox,
              GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: _model!.code));
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
