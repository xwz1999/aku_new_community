import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/pages/manager_func.dart';
import 'package:aku_new_community/pages/things_page/widget/finish_fixed_submit_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_check_button.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/others/house_head_card.dart';
import 'package:aku_new_community/widget/picker/grid_image_picker.dart';

class AddFixedSubmitPage extends StatefulWidget {
  AddFixedSubmitPage({Key? key}) : super(key: key);

  @override
  _AddFixedSubmitPageState createState() => _AddFixedSubmitPageState();
}

class _AddFixedSubmitPageState extends State<AddFixedSubmitPage> {
  TextEditingController? _textEditingController;
  String? reportText;
  List<String> _buttons = ['公区保修', '家庭维修'];
  int? _selectType;
  List<File> _files = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  // Widget _buildHouseCard() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       '报修房屋'.text.black.size(28.sp).make().pSymmetric(h: 32.w),
  //       8.w.heightBox,
  //       BeeHousePicker(),
  //       BeeDivider.horizontal(indent: 32.w, endIndent: 32.w),
  //     ],
  //   );
  // }

  // Widget _selectButton(
  //   String title,
  //   int value,
  // ) {
  //   return BeeCheckButton(
  //     title: '',
  //     onChange: (value) {},
  //     value: 1,
  //     groupValue: 1,
  //   );
  // }

  Widget _getType() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '请选择服务类型'.text.black.size(28.sp).make(),
          24.w.heightBox,
          Row(
            children: <Widget>[
              ...List.generate(
                  _buttons.length,
                  (index) => BeeCheckButton(
                        groupValue: _selectType,
                        onChange: (value) {
                          _selectType = index;
                          setState(() {});
                        },
                        title: _buttons[index],
                        value: index,
                      )),
            ].sepWidget(separate: 20.w.widthBox),
          ),
          16.w.heightBox,
        ],
      ),
    );
  }

  Widget _buildReportCard() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '请输入报修内容'.text.black.size(28.sp).make(),
          24.w.heightBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                border: Border.all(color: Color(0xFFD4CFBE), width: 1.w)),
            constraints: BoxConstraints(
              minHeight: 304.w,
            ),
            width: 686.w,
            child: TextField(
              controller: _textEditingController,
              onChanged: (value) {
                setState(() {});
              },
              maxLines: 10,
              minLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请简要描述一下你要告知我的事情，以便于我们更好的处理……',
                hintStyle: TextStyle(color: ktextSubColor, fontSize: 28.sp),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addImages() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '添加图片信息(${_files.length}/9)'.text.black.size(28.sp).make(),
          24.w.heightBox,
          GridImagePicker(onChange: (files) {
            _files = files;
            setState(() {});
          })
        ],
      ),
    );
  }

  bool _canSubmit(int? seletType, String text) {
    if (seletType == null) {
      return false;
    } else if (text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return WillPopScope(
      child: BeeScaffold(
        bodyColor: Colors.white,
        systemStyle: SystemStyle.yellowBottomBar,
        title: '报事报修',
        body: ListView(
          children: [
            HouseHeadCard(
              context: context,
            ),
            _getType(),
            _buildReportCard(),
            _addImages(),
          ],
        ),
        bottomNavi: BottomButton(
          onPressed: _canSubmit(_selectType, _textEditingController!.text)
              ? () async {
                  VoidCallback cancel = BotToast.showLoading();
                  List<String?> urls = await NetUtil()
                      .uploadFiles(_files, API.upload.uploadRepair);
                  BaseModel baseModel = await ManagerFunc.reportRepairInsert(
                      appProvider.selectedHouse!.estateId,
                      _selectType! + 1,
                      _textEditingController!.text,
                      urls);
                  if (baseModel.success) {
                    Get.off(() => FinishFixedSubmitPage());
                  } else
                    BotToast.showText(text: baseModel.msg);
                  cancel();
                }
              : () {
                  BotToast.showText(text: '请填写完整报修信息！');
                },
          child: '确认提交'.text.black.bold.size(32.sp).make(),
        ),
      ),
      onWillPop: () async {
        Get.back(result: true);
        return false;
      },
    );
  }
}
