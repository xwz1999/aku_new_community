import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:power_logger/power_logger.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';
import 'package:aku_community/ui/manager/house_keeping/house_keeping_func.dart';
import 'package:aku_community/ui/manager/house_keeping/house_keeping_submit_page.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bee_check_button.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/house_head_card.dart';
import 'package:aku_community/widget/others/user_tool.dart';
import 'package:aku_community/widget/picker/grid_image_picker.dart';

class AddHouseKeepingPage extends StatefulWidget {
  AddHouseKeepingPage({Key? key}) : super(key: key);

  @override
  _AddHouseKeepingPageState createState() => _AddHouseKeepingPageState();
}

class _AddHouseKeepingPageState extends State<AddHouseKeepingPage> {
  late TextEditingController _editingController;
  List<String> _buttons = ['公区保修', '家庭维修'];
  int? _selectType;
  List<File> _files = [];
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      bodyColor: Colors.white,
      title: '家政服务',
      body: ListView(
        children: [
          HouseHeadCard(context: context),
          _getType(),
          _buildReportCard(),
          _addImages(),
        ],
      ),
      bottomNavi: BottomButton(
        onPressed: _canSubmit(_selectType, _editingController.text)
            ? () async {
                VoidCallback cancel = BotToast.showLoading();
                try {
                  List<String> urls = await NetUtil()
                      .uploadFiles(_files, API.upload.uploadHouseKeepingPhotos);
                  bool result = await HouseKeepingFunc.submitHouseKeeping(
                      UserTool.appProveider.selectedHouse!.estateId,
                      _selectType! + 1,
                      _editingController.text,
                      urls);
                  if (result) {
                    Get.off(() => HouseKeepingSubmitPage());
                  } else
                    BotToast.showText(text: '提交失败');
                } catch (e) {
                  LoggerData.addData(e);
                }
                cancel();
              }
            : () {
                BotToast.showText(text: '请填写完整服务信息！');
              },
        child: '确认提交'.text.black.bold.size(32.sp).make(),
      ),
    );
  }

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
          '请输入服务内容'.text.black.size(28.sp).make(),
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
              controller: _editingController,
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
}
