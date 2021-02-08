// Flutter imports:

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/pages/goods_deto_page/select_move_company_page.dart';
import 'package:akuCommunity/pages/life_pay/widget/my_house_page.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/bee_parse.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/bee_check_button.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';
import 'package:akuCommunity/widget/picker/bee_date_picker.dart';
import 'package:akuCommunity/widget/picker/grid_image_picker.dart';

class DetoCreatePage extends StatefulWidget {
  DetoCreatePage({Key key}) : super(key: key);

  @override
  _DetoCreatePageState createState() => _DetoCreatePageState();
}

class _DetoCreatePageState extends State<DetoCreatePage> {
  List<File> _files = [];
  UserProvider get userProvider => Provider.of<UserProvider>(context);

  String _itemName;
  DateTime _date;
  String get datetime =>
      DateUtil.formatDate(_date, format: "yyyy-MM-dd HH:mm:ss");
  int _selectWeight;
  String _selectTel;
  List<String> _listWeight = [
    '< 50kg',
    '50kg-100kg',
    '> 100kg',
  ];
  int _selectApproach=0;
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

  Widget _houseAddress(String subtitle) {
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
          GestureDetector(
            onTap: () {
              MyHousePage().to();
            },
            child: Row(
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
                      kEstateName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 32.sp,
                        color: Color(0xff333333),
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      BeeParse.getEstateName(subtitle),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 32.sp,
                        color: Color(0xff333333),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.chevron_forward,
                  size: 40.w,
                ),
              ],
            ).material(color: Colors.transparent),
          ),
        ],
      ),
    );
  }

  // Widget _inkWellCheckbox() {
  //   return InkWell(
  //     child: Container(
  //       padding: EdgeInsets.only(bottom: 24.w),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           BeeCheckBox(
  //             onChange: (value) {
  //               needMoveCompany = value;
  //             },
  //           ),
  //           10.w.widthBox,
  //           Container(
  //             child: Text(
  //               '是否需要物业提供搬家公司联系方式',
  //               style: TextStyle(
  //                 fontSize: 28.sp,
  //                 color: Color(0xff333333),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _getWeight() {
    return Container(
      // margin: EdgeInsets.fromLTRB(0, 40.w, 0, 40.w),
      // child: Row(
      //   children: [
      //     Container(
      //       margin: EdgeInsets.only(right: 30.w),
      //       child: Text(
      //         '物品重量',
      //         style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
      //       ),
      //     ),
      //     ...List.generate(
      //         _listWeight.length,
      //         (index) => GestureDetector(
      //               onTap: () {
      //                 setState(() {
      //                   _selectWeight = index;
      //                 });
      //               },
      //               child: CommonRadio(
      //                 size: 30.w,
      //                 text: _listWeight[index]
      //                     .text
      //                     .color(ktextPrimary)
      //                     .size(28.sp)
      //                     .make(),
      //                 value: index,
      //                 groupValue: _selectWeight,
      //               ),
      //             )),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '物品重量'.text.color(ktextPrimary).size(28.sp).make(),
          24.w.heightBox,
          Wrap(
            spacing: 40.w,
            children: [
              ..._listWeight
                  .map((e) => BeeCheckButton(
                        title: e,
                        value: _listWeight.indexOf(e),
                        groupValue: _selectWeight,
                        onChange: (value) {
                          _selectWeight = value;
                          setState(() {});
                        },
                      ))
                  .toList()
            ],
          ),
        ],
      ),
    );
  }

  Widget _getApproach() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '搬运方式'.text.color(ktextPrimary).size(28.sp).make(),
          24.w.heightBox,
          Wrap(
            spacing: 40.w,
            children: [
              ..._listMode
                  .map((e) => BeeCheckButton(
                        title: e,
                        value: _listMode.indexOf(e),
                        groupValue: _selectApproach,
                        onChange: (value) {
                          _selectApproach = value;
                          setState(() {});
                        },
                      ))
                  .toList()
            ],
          ),
          20.w.heightBox,
        ],
      ),
    );
  }

  Widget _itemPicker(String title, String select, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        40.w.heightBox,
        title.text.color(ktextPrimary).size(28.sp).make(),
        16.w.widthBox,
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.w),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                (select.isEmptyOrNull ? '请选择' : select)
                    .text
                    .color(select.isEmptyOrNull ? ktextSubColor : ktextPrimary)
                    .size(36.sp)
                    .fontWeight(select.isEmptyOrNull
                        ? FontWeight.normal
                        : FontWeight.bold)
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

  Widget _getMovingCompany() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '搬家公司信息'.text.color(ktextPrimary).size(28.sp).make(),
          16.w.heightBox,
          InkWell(
            onTap: () async {
              _selectTel = await SelectMoveCompanyPage().to();
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.w),
              child: Row(
                children: [
                  (_selectTel.isEmptyOrNull ? '请选择搬家公司' : _selectTel)
                      .text
                      .color(ktextSubColor)
                      .size(36.sp)
                      .bold
                      .make(),
                  Spacer(),
                  Icon(CupertinoIcons.chevron_right, size: 30.w),
                ],
              ),
            ),
          ),
          BeeDivider.horizontal(),
        ],
      ),
    );
  }

  bool _canSubmit(int weight, int approach, DateTime dateTime, String item) {
    if (weight == null) {
      return false;
    } else if (approach == null) {
      return false;
    } else if (dateTime == null) {
      return false;
    } else if (item.isEmptyOrNull) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '物品出户',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          _houseAddress(userProvider.currentHouse),
          _getWeight(),
          _itemPicker('出户时间', datetime, () async {
            _date = await BeeDatePicker.timePicker(DateTime.now());
            setState(() {});
          }),
          _itemPicker('物品名称', _itemName, () {
            _showItmePicker();
          }),
          _getApproach(),
          _selectApproach == 0 ? SizedBox() : _getMovingCompany(),
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
        onPressed: _canSubmit(_selectWeight, _selectApproach, _date, _itemName)
            ? () async {
                VoidCallback cancel = BotToast.showLoading();
                List<String> urls = await NetUtil()
                    .uploadFiles(_files, API.upload.uploadRepair);
                BaseModel baseModel = await ManagerFunc.articleOutSubmit(
                  id: BeeParse.getEstateNameId(
                      userProvider.userDetailModel.estateNames[0]),
                  name: _itemName,
                  weight: _selectWeight + 1,
                  approach: _selectApproach + 1,
                  tel: _selectTel,
                  time: datetime,
                  urls: urls,
                );
                if (baseModel.status) {
                  Get.back();
                } else
                  BotToast.showText(text: baseModel.message);
                cancel();
              }
            : () {
                BotToast.showText(text: '请填写完整物品出户信息！');
              },
      ),
    );
    //
  }
}
