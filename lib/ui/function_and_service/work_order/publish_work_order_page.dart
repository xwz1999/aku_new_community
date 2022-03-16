import 'dart:io';

import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/ui/function_and_service/task/task_remark_page.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_map.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:aku_new_community/widget/picker/bee_date_picker.dart';
import 'package:aku_new_community/widget/picker/bee_pick_image_widget.dart';
import 'package:aku_new_community/widget/picker/bee_picker_box.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class PublishWorkOrderPage extends StatefulWidget {
  const PublishWorkOrderPage({Key? key}) : super(key: key);

  @override
  _PublishWorkOrderPageState createState() => _PublishWorkOrderPageState();
}

class _PublishWorkOrderPageState extends State<PublishWorkOrderPage> {
  int _type = 0;

  DateTime? _appointDate;

  DateTime? _appointEndDate;

  TextEditingController _addressController = TextEditingController();
  String _remark = '';
  List<File> _photos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '发布工单',
      body: SafeArea(
        child: ListView(
          children: [
            2.hb,
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 164.w,
              padding: EdgeInsets.all(32.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: 50.w,
                  ),
                  16.wb,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      '李一宣'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.85))
                          .make(),
                      Spacer(),
                      '租户 | 绿城·碧桂园3栋14单元104室'
                          .text
                          .size(24.sp)
                          .color(Colors.black.withOpacity(0.45))
                          .make(),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {},
                      child: Icon(
                        CupertinoIcons.chevron_right,
                        size: 40.w,
                      )),
                ],
              ),
            ),
            20.hb,
            _baseInfo(context),
          ],
        ),
      ),
      bottomNavi: BeeLongButton(onPressed: () {}, text: '确认发布'),
    );
  }

  Container _baseInfo(BuildContext context) {
    var type = GestureDetector(
      onTap: () async {
        _type = 1;
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return BeePickerBox(
                onPressed: () {
                  Get.back();
                  print(_type);
                  setState(() {});
                },
                child: CupertinoPicker.builder(
                    itemExtent: 60.w,
                    childCount: WorkOrderMap.orderType.values.length,
                    onSelectedItemChanged: (index) {
                      var typeStr =
                          WorkOrderMap.orderType.values.toList()[index];
                      WorkOrderMap.orderType.forEach((key, value) {
                        if (value == typeStr) {
                          _type = key;
                        }
                      });
                    },
                    itemBuilder: (context, index) {
                      var str = WorkOrderMap.orderType.values.toList()[index];
                      return Center(
                        child: str.text.size(32.sp).isIntrinsic.make(),
                      );
                    }));
          },
        );
      },
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 170.w,
              child: '分类'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ),
            '${_type == 0 ? '请选择分类' : WorkOrderMap.orderType[_type]}'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(_type == 0 ? 0.25 : 0.85))
                .make(),
            Spacer(),
            Icon(
              CupertinoIcons.chevron_right,
              size: 24.w,
            ),
          ],
        ),
      ),
    );
    var date = Row(
      children: [
        SizedBox(
          width: 170.w,
          child: '预计时间'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.45))
              .make(),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              _appointDate = await BeeDatePicker.timePicker(DateTime.now());
              setState(() {});
            },
            child: Material(
              color: Colors.transparent,
              child:
                  '${DateUtil.formatDate(_appointDate, format: DateFormats.zh_mo_d_h_m)}'
                      .text
                      .size(24.sp)
                      .color(Colors.black.withOpacity(0.85))
                      .make(),
            ),
          ),
        ),
        '-'.text.size(28.sp).color(Colors.black.withOpacity(0.85)).make(),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              _appointEndDate = await BeeDatePicker.timePicker(DateTime.now());
              setState(() {});
            },
            child: Material(
              color: Colors.transparent,
              child:
                  '${DateUtil.formatDate(_appointEndDate, format: DateFormats.zh_mo_d_h_m)}'
                      .text
                      .size(24.sp)
                      .color(Colors.black.withOpacity(_type == 0 ? 0.25 : 0.85))
                      .make(),
            ),
          ),
        ),
        Icon(
          CupertinoIcons.chevron_right,
          size: 24.w,
        ),
      ],
    );
    var address = Row(
      children: [
        SizedBox(
          width: 170.w,
          child: '工单地址'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.45))
              .make(),
        ),
        Expanded(
          child: TextField(
            textAlign: TextAlign.start,
            onChanged: (text) => setState(() {}),
            autofocus: false,
            controller: _addressController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: '请输入',
                hintStyle: TextStyle(
                  fontSize: 28.sp,
                  color: Colors.black.withOpacity(0.25),
                )),
          ),
        ),
      ],
    );
    var remark = GestureDetector(
      onTap: () async {
        _remark = await Get.to(() => TaskRemarkPage());
        setState(() {});
      },
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 170.w,
              child: '任务备注'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ),
            Expanded(
              child: '${_remark.isEmpty ? '请输入任务备注' : _remark}'
                  .text
                  .size(28.sp)
                  .color(
                      Colors.black.withOpacity(_remark.isEmpty ? 0.25 : 0.85))
                  .make(),
            ),
            20.wb,
            Icon(
              CupertinoIcons.chevron_right,
              size: 24.w,
            ),
          ],
        ),
      ),
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          32.hb,
          type,
          32.hb,
          BeeDivider.horizontal(),
          32.hb,
          date,
          32.hb,
          BeeDivider.horizontal(),
          32.hb,
          address,
          32.hb,
          BeeDivider.horizontal(),
          32.hb,
          remark,
          32.hb,
          BeeDivider.horizontal(),
          32.hb,
          Row(
            children: [
              '上传图片'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
              '建议上传图片不超过6张'
                  .text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.25))
                  .make(),
            ],
          ),
          24.hb,
          BeePickImageWidget(onChanged: (value) {
            _photos = value;
          }),
        ],
      ),
    );
  }
}
