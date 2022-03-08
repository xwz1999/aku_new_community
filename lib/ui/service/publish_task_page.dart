import 'dart:io';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/ui/service/task_func.dart';
import 'package:aku_new_community/ui/service/task_remark_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_record_voice_widget.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/picker/bee_date_picker.dart';
import 'package:aku_new_community/widget/picker/bee_pick_image_widget.dart';
import 'package:aku_new_community/widget/picker/bee_picker_box.dart';
import 'package:aku_new_community/widget/voice_player.dart';
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
  TextEditingController _addressController = TextEditingController();
  TextEditingController _rewardController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  String? _content;
  List<File> _photos = [];
  String? _voiceUri;

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _rewardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '发布任务',
      extendBody: true,
      body: Stack(
        children: [
          ClipPath(
              clipper: _taskBackgroundClip(),
              child: Container(
                width: double.infinity,
                height: 400.w,
                color: kPrimaryColor,
              )),
          SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
              children: [
                _baseInfo(context),
                32.w.heightBox,
                _dateAndAddress(),
                24.w.heightBox,
                _remarkWidget(),
                24.w.heightBox,
                _photoAndVoice(),
                24.w.heightBox,
                _rewardWidget(),
              ],
            ),
          )
        ],
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
                      taskContent: _content ?? '',
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
    var sex = GestureDetector(
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
                .color(Colors.black.withOpacity(_sex == 0 ? 0.25 : 0.85))
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
    var servicePersonnel = GestureDetector(
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
                .color(Colors.black.withOpacity(_service == 0 ? 0.25 : 0.85))
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          32.w.heightBox,
          type,
          32.w.heightBox,
          BeeDivider.horizontal(),
          32.w.heightBox,
          sex,
          32.w.heightBox,
          BeeDivider.horizontal(),
          32.w.heightBox,
          servicePersonnel,
        ],
      ),
    );
  }

  Container _dateAndAddress() {
    var date = GestureDetector(
      onTap: () async {
        _appointDate = await BeeDatePicker.timePicker(DateTime.now());
      },
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 170.w,
              child: '预计时间'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ),
            '${DateUtil.formatDate(_appointDate)}'
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
    var contact = Row(
      children: [
        SizedBox(
          width: 170.w,
          child: '联系人'
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
            controller: _nameController,
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: '请输入姓名',
                hintStyle: TextStyle(
                  fontSize: 28.sp,
                  color: Colors.black.withOpacity(0.25),
                )),
          ),
        ),
      ],
    );
    var tel = Row(
      children: [
        SizedBox(
          width: 170.w,
          child: '联系电话'
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
            controller: _telController,
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: '请输入电话',
                hintStyle: TextStyle(
                  fontSize: 28.sp,
                  color: Colors.black.withOpacity(0.25),
                )),
          ),
        ),
      ],
    );
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(left: 32.w, right: 32.w, bottom: 32.w, top: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          date,
          32.w.heightBox,
          BeeDivider.horizontal(),
          32.w.heightBox,
          contact,
          32.w.heightBox,
          BeeDivider.horizontal(),
          32.w.heightBox,
          tel,
          32.w.heightBox,
          BeeDivider.horizontal(),
          32.w.heightBox,
          GestureDetector(
            onTap: () {},
            child: Material(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8.w),
                        width: 32.w,
                        height: 32.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.w)),
                        child: '取'.text.size(20.w).black.bold.make(),
                      ),
                      8.w.heightBox,
                      _connect(5),
                      8.w.heightBox,
                    ],
                  ),
                  20.w.widthBox,
                  SizedBox(
                    width: 430.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '鲍汁牛肉饭'.text.size(32.sp).black.bold.make(),
                        12.w.heightBox,
                        '江西省萍乡市莲花县良坊镇 19 幢 252 室daidjwoajdiowajdoiwa'
                            .text
                            .maxLines(1)
                            .overflow(TextOverflow.ellipsis)
                            .size(24.sp)
                            .color(Colors.black.withOpacity(0.45))
                            .make(),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      20.hb,
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 40.w,
                        color: Colors.black.withOpacity(0.45),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Assets.icons.connect.image(width: 40.w, height: 40.w),
              ),
              20.wb,
              BeeDivider.horizontal().expand(),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Material(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      8.w.heightBox,
                      _connect(5),
                      8.w.heightBox,
                      Container(
                        margin: EdgeInsets.only(left: 8.w),
                        width: 32.w,
                        height: 32.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.w)),
                        child: '送'.text.size(20.w).white.bold.make(),
                      ),
                    ],
                  ),
                  20.w.widthBox,
                  SizedBox(
                    width: 430.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '鲍汁牛肉饭'
                            .text
                            .size(32.sp)
                            .black
                            .lineHeight(1.1)
                            .bold
                            .make(),
                        12.w.heightBox,
                        '江西省萍乡市莲花县良坊镇 19 幢 252 室daidjwoajdiowajdoiwa'
                            .text
                            .maxLines(1)
                            .overflow(TextOverflow.ellipsis)
                            .size(24.sp)
                            .color(Colors.black.withOpacity(0.45))
                            .make(),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      20.hb,
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 40.w,
                        color: Colors.black.withOpacity(0.45),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _remarkWidget() {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(left: 32.w, right: 32.w, bottom: 32.w, top: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              _content = await Get.to(() => TaskRemarkPage());
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
                  '${_content == null ? '请输入任务备注' : _content}'
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
        ],
      ),
    );
  }

  Container _rewardWidget() {
    var type = GestureDetector(
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
                .color(Colors.black.withOpacity(_rewardType == 0 ? 0.25 : 0.85))
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
    var count = Row(
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
    );
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(left: 32.w, right: 32.w, bottom: 32.w, top: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          type,
          32.w.heightBox,
          BeeDivider.horizontal(),
          32.w.heightBox,
          count,
        ],
      ),
    );
  }

  Container _photoAndVoice() {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(left: 32.w, right: 32.w, bottom: 32.w, top: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
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
          24.w.heightBox,
          BeePickImageWidget(onChanged: (value) {
            _photos = value;
          }),
          24.w.heightBox,
          BeeDivider.horizontal(),
          24.w.heightBox,
          GestureDetector(
            onTap: () async {
              var re = await Get.bottomSheet(BeeRecordVoiceWidget());
              if (re != null) {
                _voiceUri = re;
              }
              setState(() {});
            },
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
                    width: 170.w,
                    child: '上传语音'
                        .text
                        .size(28.sp)
                        .color(Colors.black.withOpacity(0.45))
                        .make(),
                  ),
                  if (_voiceUri != null)
                    VoicePlayer(
                      path: _voiceUri,
                      showXmark: true,
                      onDelete: () {
                        _voiceUri = null;
                        setState(() {});
                      },
                    ),
                  Spacer(),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 24.w,
                  ),
                ],
              ),
            ),
          ),
        ],
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
    if (_content == null) {
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

  _connect(int num) {
    return Column(
      children: List.generate(
          num,
          (index) => Container(
                width: 4.w,
                height: 4.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.w),
                    color: Colors.black.withOpacity(0.25)),
              )).sepWidget(separate: 4.w.heightBox),
    );
  }
}

class _taskBackgroundClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var offset = size.height - 25.0;
    var path = Path();
    path.moveTo(0, offset);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, offset);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, offset);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
