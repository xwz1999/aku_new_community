// Flutter imports:

import 'dart:io';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/buttons/bee_check_box.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';
import 'package:akuCommunity/widget/buttons/radio_button.dart';
import 'package:akuCommunity/widget/picker/bee_custom_picker.dart';
import 'package:akuCommunity/widget/picker/bee_date_picker.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/picker/grid_image_picker.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'widget/common_picker.dart';
import 'widget/common_radio.dart';
import 'package:akuCommunity/const/resource.dart';

class DetoCreatePage extends StatefulWidget {
  DetoCreatePage({Key key}) : super(key: key);

  @override
  _DetoCreatePageState createState() => _DetoCreatePageState();
}

class _DetoCreatePageState extends State<DetoCreatePage> {
  List<File> _files = [];
  UserProvider get userProvider => Provider.of<UserProvider>(context);
  String get firstEstateName {
    return userProvider.userDetailModel.estateNames.isEmpty
        ? ''
        : userProvider.userDetailModel.estateNames[0];
  }

  String _itemName;
  DateTime _date;
  int _selectWeight;
  List<String> _listWeight = [
    '< 50kg',
    '50kg-100kg',
    '> 100kg',
  ];
  int _selectApproach;
  List<String> _listMode = [
    '自己搬运',
    '搬家公司',
  ];

  List<String> _itemClass = [
    '全部',
    '家纺',
    '家具',
    '电器',
  ];

  bool needMoveCompany = false;

  Widget _houseAddress(String title, subtitle) {
    return Container(
      padding: EdgeInsets.only(bottom: 24.w),
      margin: EdgeInsets.only(bottom: 40.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 32.w),
            child: Text(
              '出户房屋',
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 42.w),
                child: Image.asset(
                  R.ASSETS_IMAGES_HOUSE_ATTESTATION_PNG,
                  height: 59.w,
                  width: 59.w,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32.sp,
                      color: Color(0xff333333),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inkWellCheckbox() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: 24.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BeeCheckBox(
              onChange: (value) {
                needMoveCompany = value;
              },
            ),
            10.w.widthBox,
            Container(
              child: Text(
                '是否需要物业提供搬家公司联系方式',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getWeight() {
    return Container(
      height: 96.w,
      padding: EdgeInsets.symmetric(vertical: 28.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 30.w),
            child: Text(
              '物品重量',
              style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
            ),
          ),
          ...List.generate(
              _listWeight.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectWeight = index;
                      });
                    },
                    child: CommonRadio(
                      size: 30.w,
                      text: _listWeight[index]
                          .text
                          .color(ktextPrimary)
                          .size(28.sp)
                          .make(),
                      value: index,
                      groupValue: _selectWeight,
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _getApproach() {
    return Container(
      height: 96.w,
      padding: EdgeInsets.symmetric(vertical: 28.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 30.w),
            child: Text(
              '搬运方式',
              style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
            ),
          ),
          ...List.generate(
              _listMode.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectApproach = index;
                      });
                    },
                    child: CommonRadio(
                      size: 30.w,
                      text: _listMode[index]
                          .text
                          .color(ktextPrimary)
                          .size(28.sp)
                          .make(),
                      value: index,
                      groupValue: _selectApproach,
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _itemPicker(String title, String select, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 28.w),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                title.text.color(ktextPrimary).size(28.sp).make(),
                36.w.widthBox,
                (select.isEmptyOrNull ? '请选择' : select)
                    .text
                    .color(select.isEmptyOrNull ? ktextSubColor : ktextPrimary)
                    .size(28.sp)
                    .make(),
                Spacer(),
                Icon(
                  CupertinoIcons.chevron_right,
                  size: 30.w,
                ),
              ],
            ),
          ),
        ),
        BeeDivider.horizontal(),
      ],
    );
  }

  _showItmePicker() async {
    _itemName = await Get.bottomSheet(
      SizedBox(
        child: Material(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.w),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._itemClass
                  .map((e) => Material(
                        child: InkWell(
                          onTap: () {
                            Get.back(result: e);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 112.w,
                              width: double.infinity,
                              child: e.text
                                  .color(ktextPrimary)
                                  .isIntrinsic
                                  .size(28.sp)
                                  .make()),
                        ),
                      ))
                  .toList(),
              Container(
                height: 16.w,
                color: Color(0xFFF7F7F7),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 112.w,
                      width: double.infinity,
                      child: '取消'
                          .text
                          .color(ktextPrimary)
                          .isIntrinsic
                          .size(28.sp)
                          .make()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '物品出户',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          _houseAddress(kEstateName, firstEstateName),
          _getWeight(),
          _itemPicker(
              '出户时间', DateUtil.formatDate(_date, format: "yyyy-MM-dd HH:mm:ss"),
              () async {
            _date = await BeeDatePicker.timePicker(DateTime.now());
            setState(() {});
          }),
          _itemPicker('物品名称', _itemName, () {
            _showItmePicker();
          }),
          _getApproach(),
          _selectApproach == 0 ? SizedBox() : _inkWellCheckbox(),
          Container(
            margin: EdgeInsets.only(top: 54.w, bottom: 24.w),
            child: Text(
              '添加图片信息(${_files.length}/9)',
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          GridImagePicker(onChange: (files) {
            _files = files;
            setState(() {});
          }),
        ],
      ),
      bottomNavi: BottomButton(
        child: '确认提交'.text.color(ktextPrimary).bold.make(),
        onPressed: () {},
      ),
    );
    //     Positioned(
    //       bottom: 0,
    //       child: BottomButton(title: '确认提交'),
    //     )
    //   ],
    // ),
  }
}
