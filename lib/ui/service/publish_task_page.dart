import 'dart:io';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/ui/service/add_appointment_address_page.dart';
import 'package:aku_new_community/ui/service/task_func.dart';
import 'package:aku_new_community/ui/service/task_remark_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_record_voice_widget.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
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
  List<String> _types = ['跑腿', '家政', '维修', '家教', '其他'];

  //类型
  int _type = 0;
  List<String> _sexStr = ['男', '女', '不限'];
  int _sex = 0;

  //服务人员
  int _service = 0;
  List<String> _serviceObject = [
    '住户',
  ];
  List<String> _rewardTypes = ['赏金', '积分'];

  //报酬类型
  int _rewardType = 0;
  DateTime? _appointDate;

  DateTime? _appointEndDate;
  TextEditingController _rewardController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  String? _content;
  List<File> _photos = [];
  String? _voiceUri;
  String? _accessAddress;
  String? _accessAddressDetail;
  String? _serviceAddress;
  String? _serviceAddressDetail;

  @override
  void dispose() {
    _rewardController.dispose();
    _nameController.dispose();
    _telController.dispose();
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
        child: BeeLongButton(
          onPressed: !canTap
              ? null
              : () async {
                  var cancel = BotToast.showLoading();
                  var _voiceUrl;
                  if (_voiceUri != null) {
                    try {
                      _voiceUrl = await NetUtil().upload(
                          SARSAPI.uploadFile.uploadImg,
                          File.fromUri(Uri(path: _voiceUri)));
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                  var imgs;
                  if (_photos.isNotEmpty) {
                    try {
                      imgs = await NetUtil()
                          .uploadFiles(_photos, SARSAPI.uploadFile.uploadImg);
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                  var re = await TaskFunc.publish(
                      type: _type,
                      sex: _sex,
                      servicePersonnel: _service,
                      readyStartTime: _appointDate.toString(),
                      readyEndTime: _appointEndDate.toString(),
                      contact: _nameController.text,
                      tel: _telController.text,
                      accessAddress: _accessAddress!,
                      accessAddressDetail: _accessAddressDetail!,
                      serviceAddress: _serviceAddress,
                      serviceAddressDetail: _serviceAddressDetail,
                      remarks: _content,
                      voiceUrl: _voiceUrl,
                      imgUrls: imgs,
                      rewardType: _rewardType,
                      reward: _rewardController.text);
                  if (re) {
                    Get.back();
                  }
                  cancel();
                },
          text: '确认发布',
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
            ..._serviceObject
                .mapIndexed((e, index) => CupertinoActionSheetAction(
                    onPressed: () {
                      _service = index + 1;
                      Get.back();
                      setState(() {});
                    },
                    child: 'e'
                        .text
                        .size(28.sp)
                        .isIntrinsic
                        .color(Colors.black.withOpacity(0.85))
                        .make()))
                .toList(),
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
                      .size(28.sp)
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
                      .size(28.sp)
                      .color(Colors.black.withOpacity(_type == 0 ? 0.25 : 0.85))
                      .make(),
            ),
          ),
        ),
        Spacer(),
        Icon(
          CupertinoIcons.chevron_right,
          size: 24.w,
        ),
      ],
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
            onTap: () async {
              var re = await Get.to(() => AddAppointmentAddressPage());
              if (re != null) {
                _accessAddress = re['address'];
                _accessAddressDetail = re['addressDetail'];
                setState(() {});
              }
            },
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
                        '${_accessAddress ?? ''}'
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
            onTap: () async {
              var re = await Get.to(() => AddAppointmentAddressPage());
              if (re != null) {
                _serviceAddress = re['address'];
                _serviceAddressDetail = re['addressDetail'];
                setState(() {});
              }
            },
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
                        '${_serviceAddress ?? ''}'
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
                    child: '${_content == null ? '请输入任务备注' : _content}'
                        .text
                        .size(28.sp)
                        .color(Colors.black
                            .withOpacity(_rewardType == 0 ? 0.25 : 0.85))
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
    if (_type == 0) {
      return false;
    }
    if (_service == 0) {
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
    if (_appointEndDate == null) {
      return false;
    }
    if (_accessAddress == null) {
      return false;
    }
    if (_accessAddressDetail == null) {
      return false;
    }
    if (_rewardController.text.isEmpty) {
      return false;
    }
    if (_nameController.text.isEmpty) {
      return false;
    }
    if (_telController.text.isEmpty) {
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
