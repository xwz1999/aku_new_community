import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/bee_input_row.dart';
import 'package:aku_community/widget/picker/identify_card_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SupplementInformationPage extends StatefulWidget {
  SupplementInformationPage({Key? key}) : super(key: key);

  @override
  _SupplementInformationPageState createState() =>
      _SupplementInformationPageState();
}

class _SupplementInformationPageState extends State<SupplementInformationPage> {
  TextEditingController _nameController = TextEditingController();
  String _sex = '请选择性别';
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _emergencyContactController = TextEditingController();
  TextEditingController _emergencyPhoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _workUnitController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '补充个人信息',
      bodyColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        children: [
          BeeInputRow(
            title: '承租人',
            controller: _nameController,
            hintText: '杨赟',
            isRequire: true,
          ),
          BeeInputRow.button(
            title: '性别',
            onPressed: () async {
              await Get.bottomSheet(_sexBottomSheet());
              setState(() {});
            },
            hintText: _sex,
            isRequire: true,
          ),
          BeeInputRow(
            title: '手机号码',
            controller: _phoneController,
            hintText: '13742494159',
            isRequire: true,
          ),
          BeeInputRow(
            title: '身份证号',
            controller: _codeController,
            hintText: 'hintText',
            isRequire: true,
          ),
          BeeInputRow(
              title: '紧急联系人',
              controller: _emergencyContactController,
              hintText: 'hintText'),
          BeeInputRow(
              title: '紧急联系人电话',
              controller: _emergencyPhoneController,
              hintText: 'hintText'),
          BeeInputRow(
              title: '通讯地址(含诉讼送达地址)',
              controller: _addressController,
              hintText: 'hintText'),
          BeeInputRow(
              title: '工作单位',
              controller: _workUnitController,
              hintText: 'hintText'),
          IdentifyCardPicker.front((file) => () {}),
          IdentifyCardPicker.back((file) => () {}),
        ].sepWidget(separate: 24.w.heightBox),
      ),
      bottomNavi: BottomButton(
          onPressed: () {},
          child: '下一步'.text.size(32.sp).bold.color(ktextPrimary).make()),
    );
  }

  Widget _sexBottomSheet() {
    return CupertinoActionSheet(
      title:
          '选择性别'.text.size(32.sp).bold.color(ktextPrimary).isIntrinsic.make(),
      cancelButton: TextButton(
          onPressed: () => Get.back(),
          child: '取消'.text.size(28.sp).color(ktextSubColor).isIntrinsic.make()),
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              _sex = '男';
              Get.back();
            },
            child: '男'.text.size(30.sp).color(ktextPrimary).isIntrinsic.make()),
        CupertinoActionSheetAction(
            onPressed: () {
              _sex = '女';
              Get.back();
            },
            child: '女'.text.size(30.sp).color(ktextPrimary).isIntrinsic.make())
      ],
    );
  }
}
