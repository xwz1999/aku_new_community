import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/saas_model/work_order/work_order_report_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/dotted_line.dart';
import 'package:aku_new_community/widget/views/bee_grid_image_view.dart';

class HistoryReportPage extends StatefulWidget {
  final int id;

  const HistoryReportPage({Key? key, required this.id}) : super(key: key);

  @override
  _HistoryReportPageState createState() => _HistoryReportPageState();
}

class _HistoryReportPageState extends State<HistoryReportPage> {
  List<WorkOrderReportModel> _models = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '历史报告',
      body: EasyRefresh(
          firstRefresh: true,
          header: MaterialHeader(),
          onRefresh: () async {
            var base =
                await NetUtil().get(SAASAPI.workOrder.findRRById, params: {
              'workOrderId': widget.id,
            });
            if (base.success) {
              _models = (base.data as List)
                  .map((e) => WorkOrderReportModel.fromJson(e))
                  .toList();
              setState(() {});
            }
            setState(() {});
          },
          child: _models.isEmpty
              ? Container()
              : ListView(children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(32.w),
                    margin: EdgeInsets.only(top: 10.w),
                    color: Colors.white,
                    child: Column(
                      children: _models
                          .mapIndexed((e, index) => LineCard(
                                key: ValueKey(e.id),
                                model: e,
                                index: index,
                                length: _models.length,
                              ))
                          .toList(),
                    ),
                  )
                ])),
    );
  }
}

class LineCard extends StatefulWidget {
  final WorkOrderReportModel model;
  final int index;
  final int length;

  const LineCard(
      {Key? key,
      required this.model,
      required this.index,
      required this.length})
      : super(key: key);

  @override
  _LineCardState createState() => _LineCardState();
}

class _LineCardState extends State<LineCard> {
  double _height = 0;

  double get total {
    double sum = 0;
    for (var item in widget.model.reportRecordVoList) {
      sum = sum + item.price;
    }
    return sum;
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _height = context.size?.height ?? 0;
      print(context.size?.height);
      setState(() {});
    });
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant LineCard oldWidget) {
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   _height = context.size?.height ?? 0;
    //   print(context.size?.height);
    // });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.index == 0
                ? Container(
                    alignment: Alignment.center,
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                        color: Color(0xFFFAC058),
                        borderRadius: BorderRadius.circular(20.w)),
                    child: Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Colors.white,
                      size: 24.w,
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(4.w),
                    width: 32.w,
                    height: 32.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.w),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.25), width: 4.w),
                    ),
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                    ),
                  ),
            if (widget.index != widget.length - 1)
              SizedBox(
                height: _height,
                child: DottedLine(
                  width: 10.w,
                  color: Colors.black.withOpacity(0.25),
                  proportion: 0.5,
                  direction: Axis.vertical,
                ),
              ),
          ],
        ),
        40.wb,
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  '${widget.model.type == 1 ? '工单报告' : '完结报告'}'
                      .text
                      .size(28.sp)
                      .color(Colors.black.withOpacity(0.85))
                      .make(),
                  16.wb,
                  DateUtil.formatDateStr(widget.model.createDate,
                          format: 'MM-dd HH:ss')
                      .text
                      .size(26.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .make(),
                  Spacer(),
                  '${widget.model.userType == 1 ? '负责人' : '协同人'}'
                      .text
                      .size(26.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .make(),
                  16.wb,
                  widget.model.createName.text
                      .size(26.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .make(),
                ],
              ),
              SizedBox(
                width: 606.w,
                child: Text(
                  widget.model.content,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.45), fontSize: 26.sp),
                ),
              ),
              Offstage(
                offstage: widget.model.imgList.isEmpty,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    24.hb,
                    BeeGridImageView(
                        urls: widget.model.imgList.map((e) => e.url).toList()),
                  ],
                ),
              ),
              Offstage(
                offstage: widget.model.reportRecordVoList.isEmpty,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    24.hb,
                    ...widget.model.reportRecordVoList
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
                    24.hb,
                    BeeDivider.horizontal(),
                    24.hb,
                    Row(
                      children: [
                        '工单总费用'
                            .text
                            .size(28.sp)
                            .color(Colors.black.withOpacity(0.65))
                            .make(),
                        Spacer(),
                        '¥${total}'
                            .text
                            .size(28.sp)
                            .color(Color(0xFFF5222D))
                            .make(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
