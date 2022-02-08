import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/ui/service/task_func.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/picker/bee_date_picker.dart';
import 'package:aku_new_community/widget/picker/bee_picker_box.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PublishTaskPage extends StatefulWidget {
  const PublishTaskPage({Key? key}) : super(key: key);

  @override
  _PublishTaskPageState createState() => _PublishTaskPageState();
}

class _PublishTaskPageState extends State<PublishTaskPage> {
  List<String> _types = ['跑腿', '代驾', '装修', '陪玩', '家政', '维修', '搬家', '家教', '其他'];
  int _type = 0;
  List<String> _sexStr = ['男', '女', '不限'];
  int _sex = 0;
  int _service = 0;
  List<String> _serviceObject = ['住户', '物业', '不限'];
  List<String> _rewardTypes = ['赏金', '积分'];
  int _rewardType = 0;
  DateTime? _appointDate = DateTime.now();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _rewardController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _addressController.dispose();
    _rewardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '发布任务',
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 32.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: '标题'
                            .text
                            .size(28.sp)
                            .color(Colors.black.withOpacity(0.45))
                            .make(),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          onChanged: (text) => setState(() {}),
                          autofocus: false,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.black.withOpacity(0.25),
                            ),
                            border: InputBorder.none,
                            hintText: '请输入',
                          ),
                        ),
                      ),
                    ],
                  ),
                  BeeDivider.horizontal(),
                  32.w.heightBox,
                  GestureDetector(
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
                                  childCount: _types.length,
                                  onSelectedItemChanged: (index) {
                                    _type = index + 1;
                                  },
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: _types[index]
                                          .text
                                          .size(32.sp)
                                          .isIntrinsic
                                          .color(Colors.black.withOpacity(0.25))
                                          .make(),
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
                          '${_type == 0 ? '请选择分类' : _types[_type - 1]}'
                              .text
                              .size(28.sp)
                              .color(Colors.black
                                  .withOpacity(_type == 0 ? 0.25 : 0.85))
                              .make(),
                          Spacer(),
                          Icon(
                            CupertinoIcons.chevron_right,
                            size: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  32.w.heightBox,
                  BeeDivider.horizontal(),
                  32.w.heightBox,
                  GestureDetector(
                    onTap: () async {
                      await Get.bottomSheet(CupertinoActionSheet(
                        cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Get.back();
                            },
                            child: '取消'
                                .text
                                .size(28.sp)
                                .isIntrinsic
                                .color(Colors.black.withOpacity(0.85))
                                .make()),
                        actions: [
                          CupertinoActionSheetAction(
                              onPressed: () {
                                _sex = 1;
                                Get.back();
                                setState(() {});
                              },
                              child: '男'
                                  .text
                                  .size(28.sp)
                                  .isIntrinsic
                                  .color(Colors.black.withOpacity(0.85))
                                  .make()),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                _sex = 2;
                                Get.back();
                                setState(() {});
                              },
                              child: '女'
                                  .text
                                  .size(28.sp)
                                  .isIntrinsic
                                  .color(Colors.black.withOpacity(0.85))
                                  .make()),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                _sex = 3;
                                Get.back();
                                setState(() {});
                              },
                              child: '不限'
                                  .text
                                  .size(28.sp)
                                  .isIntrinsic
                                  .color(Colors.black.withOpacity(0.85))
                                  .make())
                        ],
                      ));
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: '性别'
                                .text
                                .size(28.sp)
                                .color(Colors.black.withOpacity(0.45))
                                .make(),
                          ),
                          '${_sex == 0 ? '请选择性别' : _sexStr[_sex - 1]}'
                              .text
                              .size(28.sp)
                              .color(Colors.black
                                  .withOpacity(_sex == 0 ? 0.25 : 0.85))
                              .make(),
                          Spacer(),
                          Icon(
                            CupertinoIcons.chevron_right,
                            size: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  32.w.heightBox,
                  BeeDivider.horizontal(),
                  32.w.heightBox,
                  GestureDetector(
                    onTap: () async {
                      await Get.bottomSheet(CupertinoActionSheet(
                        cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Get.back();
                            },
                            child: '取消'
                                .text
                                .size(28.sp)
                                .isIntrinsic
                                .color(Colors.black.withOpacity(0.85))
                                .make()),
                        actions: [
                          CupertinoActionSheetAction(
                              onPressed: () {
                                _service = 1;
                                Get.back();
                                setState(() {});
                              },
                              child: '住户'
                                  .text
                                  .size(28.sp)
                                  .isIntrinsic
                                  .color(Colors.black.withOpacity(0.85))
                                  .make()),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                _service = 2;
                                Get.back();
                                setState(() {});
                              },
                              child: '物业'
                                  .text
                                  .size(28.sp)
                                  .isIntrinsic
                                  .color(Colors.black.withOpacity(0.85))
                                  .make()),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                _service = 3;
                                Get.back();
                                setState(() {});
                              },
                              child: '不限'
                                  .text
                                  .size(28.sp)
                                  .isIntrinsic
                                  .color(Colors.black.withOpacity(0.85))
                                  .make())
                        ],
                      ));
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: '服务人员'
                                .text
                                .size(28.sp)
                                .color(Colors.black.withOpacity(0.45))
                                .make(),
                          ),
                          '${_service == 0 ? '请选择服务人员' : _serviceObject[_service - 1]}'
                              .text
                              .size(28.sp)
                              .color(Colors.black
                                  .withOpacity(_service == 0 ? 0.25 : 0.85))
                              .make(),
                          Spacer(),
                          Icon(
                            CupertinoIcons.chevron_right,
                            size: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  32.w.heightBox,
                  BeeDivider.horizontal(),
                  32.w.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      '任务内容'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.45))
                          .make(),
                    ],
                  ),
                  32.w.heightBox,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(16.w)),
                    child: TextField(
                      controller: _contentController,
                      autofocus: false,
                      onChanged: (text) => setState(() {}),
                      minLines: 5,
                      maxLength: 200,
                      maxLines: 20,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            32.w.heightBox,
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: 32.w, right: 32.w, bottom: 32.w, top: 32.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      _appointDate =
                          await BeeDatePicker.timePicker(DateTime.now());
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: '预约时间'
                                .text
                                .size(28.sp)
                                .color(Colors.black.withOpacity(0.45))
                                .make(),
                          ),
                          '${DateUtil.formatDate(_appointDate)}'
                              .text
                              .size(28.sp)
                              .color(Colors.black
                                  .withOpacity(_type == 0 ? 0.25 : 0.85))
                              .make(),
                          Spacer(),
                          Icon(
                            CupertinoIcons.chevron_right,
                            size: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  32.w.heightBox,
                  BeeDivider.horizontal(),
                  32.w.heightBox,
                  Row(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: '预约地址'
                            .text
                            .size(28.sp)
                            .color(Colors.black.withOpacity(0.45))
                            .make(),
                      ),
                      '${S.of(context)!.tempPlotName}'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.85))
                          .make(),
                      '｜'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.25))
                          .make(),
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          controller: _addressController,
                          onChanged: (text) => setState(() {}),
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
                  ),
                  32.w.heightBox,
                  BeeDivider.horizontal(),
                  32.w.heightBox,
                  GestureDetector(
                    onTap: () async {
                      await Get.bottomSheet(CupertinoActionSheet(
                        cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Get.back();
                            },
                            child: '取消'
                                .text
                                .size(28.sp)
                                .isIntrinsic
                                .color(Colors.black.withOpacity(0.85))
                                .make()),
                        actions: [
                          CupertinoActionSheetAction(
                              onPressed: () {
                                _rewardType = 1;
                                Get.back();
                                setState(() {});
                              },
                              child: '赏金'
                                  .text
                                  .size(28.sp)
                                  .isIntrinsic
                                  .color(Colors.black.withOpacity(0.85))
                                  .make()),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                _rewardType = 2;
                                Get.back();
                                setState(() {});
                              },
                              child: '积分'
                                  .text
                                  .size(28.sp)
                                  .isIntrinsic
                                  .color(Colors.black.withOpacity(0.85))
                                  .make()),
                        ],
                      ));
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: '报酬类型'
                                .text
                                .size(28.sp)
                                .color(Colors.black.withOpacity(0.45))
                                .make(),
                          ),
                          '${_rewardType == 0 ? '请选择报酬类型' : _rewardTypes[_rewardType - 1]}'
                              .text
                              .size(28.sp)
                              .color(Colors.black
                                  .withOpacity(_rewardType == 0 ? 0.25 : 0.85))
                              .make(),
                          Spacer(),
                          Icon(
                            CupertinoIcons.chevron_right,
                            size: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  32.w.heightBox,
                  BeeDivider.horizontal(),
                  32.w.heightBox,
                  Row(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: '${_rewardType == 1 ? '赏金金额' : '积分数量'}'
                            .text
                            .size(28.sp)
                            .color(Colors.black.withOpacity(0.45))
                            .make(),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.end,
                          onChanged: (text) => setState(() {}),
                          autofocus: false,
                          controller: _rewardController,
                          style: TextStyle(color: Colors.red),
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
                      '${_rewardType == 1 ? '元' : ''}'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.85))
                          .make(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavi: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
        child: MaterialButton(
          elevation: 0,
          height: 93.w,
          disabledColor: Colors.black.withOpacity(0.06),
          disabledTextColor: Colors.black.withOpacity(0.25),
          textColor: Colors.black.withOpacity(0.85),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(65.w)),
          color: kPrimaryColor,
          onPressed: !canTap
              ? null
              : () async {
                  var cancel = BotToast.showLoading();
                  var re = await TaskFunc.publish(
                      title: _titleController.text,
                      taskType: _type,
                      taskSex: _sex,
                      serviceObject: _service,
                      taskContent: _contentController.text,
                      taskDate: _appointDate.toString(),
                      taskAddress: _addressController.text,
                      rewardType: _rewardType,
                      reward: _rewardController.text);
                  if (re) {
                    Get.back();
                  }
                  cancel();
                },
          child: '确认发布'.text.size(32.sp).bold.make(),
        ),
      ),
    );
  }

  bool get canTap {
    if (_titleController.text.isEmpty) {
      return false;
    }
    if (_type == 0) {
      return false;
    }
    if (_rewardType == 0) {
      return false;
    }
    if (_sex == 0) {
      return false;
    }
    if (_appointDate == null) {
      return false;
    }
    if (_contentController.text.isEmpty) {
      return false;
    }
    if (_addressController.text.isEmpty) {
      return false;
    }
    if (_rewardController.text.isEmpty) {
      return false;
    }
    return true;
  }
}
