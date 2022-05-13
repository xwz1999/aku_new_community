import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/saas_model/work_order/work_order_type_model.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_func.dart';
import 'package:aku_new_community/ui/function_and_service/work_order/work_order_remark_page.dart';
import 'package:aku_new_community/ui/profile/new_house/my_house_page.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_image_network.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:aku_new_community/widget/picker/bee_date_picker.dart';
import 'package:aku_new_community/widget/picker/bee_pick_image_widget.dart';
import 'package:aku_new_community/widget/picker/bee_picker_box.dart';

class PublishWorkOrderPage extends StatefulWidget {
  const PublishWorkOrderPage({Key? key}) : super(key: key);

  @override
  _PublishWorkOrderPageState createState() => _PublishWorkOrderPageState();
}

class _PublishWorkOrderPageState extends State<PublishWorkOrderPage> {
  int _typeIndex = -1;

  DateTime? _appointDate;

  DateTime? _appointEndDate;

  TextEditingController _addressController = TextEditingController();
  String _remark = '';
  List<File> _photos = [];
  List<WorkOrderTypeModel> _types = [];

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
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '发布工单',
      body: SafeArea(
        child: ListView(
          children: [
            2.hb,
            GestureDetector(
              onTap: () {
                Get.to(MyHousePage());
              },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  height: 164.w,
                  padding: EdgeInsets.all(32.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: BeeImageNetwork(
                          width: 100.w,
                          height: 100.w,
                          imgs: UserTool.userProvider.userInfoModel?.imgList ??
                              [],
                        ),
                      ),
                      16.wb,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          '${UserTool.userProvider.userInfoModel!.nickName}'
                              .text
                              .size(28.sp)
                              .color(Colors.black.withOpacity(0.85))
                              .make(),
                          Spacer(),
                          '${userProvider.defaultHouseString}'
                              .text
                              .size(24.sp)
                              .color(Colors.black.withOpacity(0.45))
                              .make(),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: Colors.black.withOpacity(0.25),
                        size: 32.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            20.hb,
            _baseInfo(context),
          ],
        ),
      ),
      bottomNavi: Padding(
        padding: EdgeInsets.only(
            left: 32.w,
            right: 32.w,
            bottom: MediaQuery.of(context).padding.bottom + 32.w),
        child: BeeLongButton(
            onPressed: () async {
              if (!canTap) {
                return;
              }
              var cancel = BotToast.showLoading();
              var imgUrls = <String>[];
              try {
                imgUrls = await NetUtil()
                    .uploadFiles(_photos, SAASAPI.uploadFile.uploadImg);
              } catch (e) {
                print(e.toString());
              }
              try {
                var re = await WorkOrderFuc.publish(
                    estateId: 1,
                    workOrderTypeId: _types[_typeIndex].id,
                    reserveDate: _appointDate.toString(),
                    reserveAddress: _addressController.text.toString(),
                    content: _remark,
                    imgUrls: imgUrls);
                if (re) {
                  Get.back();
                }
              } catch (e) {
                print(e.toString());
              }
              cancel();
            },
            text: '确认发布'),
      ),
    );
  }

  bool get canTap {
    if (_appointDate == null) {
      BotToast.showText(text: '请选择预约开始时间');
      return false;
    }
    if (_appointEndDate == null) {
      BotToast.showText(text: '请选择预约结束时间');
      return false;
    }
    if (_typeIndex == -1) {
      BotToast.showText(text: '请选择类型');
      return false;
    }
    if (_addressController.text.isEmpty) {
      BotToast.showText(text: '请输入地址');
      return false;
    }

    if (_remark.isEmpty) {
      BotToast.showText(text: '请输入具体需求');
      return false;
    }
    return true;
  }

  Container _baseInfo(BuildContext context) {
    var type = GestureDetector(
      onTap: () async {
        _typeIndex = 0;
        var base = await NetUtil().get(SAASAPI.workOrder.typeList);
        if (base.success) {
          _types = (base.data as List)
              .map((e) => WorkOrderTypeModel.fromJson(e))
              .toList();
          await showModalBottomSheet(
            context: context,
            builder: (context) {
              return BeePickerBox(
                  onPressed: () {
                    Get.back();
                    setState(() {});
                  },
                  child: CupertinoPicker.builder(
                      itemExtent: 60.w,
                      childCount: _types.length,
                      onSelectedItemChanged: (index) {
                        _typeIndex = index;
                      },
                      itemBuilder: (context, index) {
                        var str = _types[index].name;
                        return Center(
                          child: str.text.size(32.sp).isIntrinsic.make(),
                        );
                      }));
            },
          );
        }
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
            '${_typeIndex == -1 ? '请选择分类' : _types[_typeIndex].name}'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(_typeIndex == -1 ? 0.25 : 0.85))
                .make(),
            Spacer(),
            Icon(
              CupertinoIcons.chevron_right,
              color: Colors.black.withOpacity(0.25),
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
                  '${_appointDate == null ? '请选择开始时间' : DateUtil.formatDate(_appointDate, format: DateFormats.zh_mo_d_h_m)}'
                      .text
                      .size(24.sp)
                      .align(TextAlign.start)
                      .color(Colors.black
                          .withOpacity(_appointDate == null ? 0.25 : 0.85))
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
                  '${_appointDate == null ? '请选择结束时间' : DateUtil.formatDate(_appointEndDate, format: DateFormats.zh_mo_d_h_m)}'
                      .text
                      .size(24.sp)
                      .align(TextAlign.end)
                      .color(Colors.black
                          .withOpacity(_appointEndDate == null ? 0.25 : 0.85))
                      .make(),
            ),
          ),
        ),
        24.wb,
        Icon(
          CupertinoIcons.chevron_right,
          color: Colors.black.withOpacity(0.25),
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
        _remark = await Get.to(() => WorkOrderRemarkPage(
                  text: _remark,
                )) ??
            '';
        setState(() {});
      },
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 170.w,
              child: '具体需求'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ),
            Expanded(
              child: '${_remark.isEmpty ? '请输入具体需求' : _remark}'
                  .text
                  .size(28.sp)
                  .color(
                      Colors.black.withOpacity(_remark.isEmpty ? 0.25 : 0.85))
                  .make(),
            ),
            20.wb,
            Icon(
              CupertinoIcons.chevron_right,
              color: Colors.black.withOpacity(0.25),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          BeePickImageWidget(
              maxCount: 6,
              onChanged: (value) {
                _photos = value;
              }),
        ],
      ),
    );
  }
}
