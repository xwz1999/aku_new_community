import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/bee_input_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';

class UserIdentifyPage extends StatefulWidget {
  UserIdentifyPage({Key? key}) : super(key: key);

  @override
  _UserIdentifyPageState createState() => _UserIdentifyPageState();
}

class _UserIdentifyPageState extends State<UserIdentifyPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _indentifyCodeController = TextEditingController();
  String _sex = '请选择性别';
  String _identify = '请选择身份';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _indentifyCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '用户认证',
      bodyColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          BeeInputRow(
            title: '承租人',
            controller: _nameController,
            hintText: '请输入姓名',
            isRequire: true,
          ),
          BeeInputRow.button(
            title: '性别',
            hintText: _sex,
            isRequire: true,
            onPressed: () async {
              await Get.bottomSheet(_sexBottomSheet());
              setState(() {});
            },
          ),
          BeeInputRow(
            title: '手机号码',
            controller: _phoneController,
            formatters: [FilteringTextInputFormatter.digitsOnly],
            hintText: '请输入手机号',
            isRequire: true,
          ),
          BeeInputRow(
            title: '身份证号码',
            controller: _indentifyCodeController,
            formatters: [FilteringTextInputFormatter.digitsOnly],
            hintText: '请输入身份证号',
            isRequire: true,
          ),
          BeeInputRow.button(
            title: '身份',
            hintText: _identify,
            isRequire: true,
            onPressed: () async {
              await Get.bottomSheet(_identifyBottomSheet());
              setState(() {});
            },
          )
        ].sepWidget(separate: 32.w.heightBox),
      ),
      bottomNavi: BottomButton(
          onPressed: () async {
            await Get.dialog(_errorDialog());
          },
          child: '提交'.text.size(32.sp).bold.color(ktextPrimary).make()),
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

  Widget _identifyBottomSheet() {
    return CupertinoActionSheet(
      title:
          '选择身份'.text.size(32.sp).bold.color(ktextPrimary).isIntrinsic.make(),
      cancelButton: TextButton(
          onPressed: () => Get.back(),
          child: '取消'.text.size(28.sp).color(ktextSubColor).isIntrinsic.make()),
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              _identify = '业主';
              Get.back();
            },
            child:
                '业主'.text.size(30.sp).color(ktextPrimary).isIntrinsic.make()),
        CupertinoActionSheetAction(
            onPressed: () {
              _identify = '租户';
              Get.back();
            },
            child: '租户'.text.size(30.sp).color(ktextPrimary).isIntrinsic.make())
      ],
    );
  }

  Widget _errorDialog() {
    return CupertinoAlertDialog(
      title:
          '账户不存在'.text.size(34.sp).color(ktextPrimary).bold.isIntrinsic.make(),
      content: '原因:用户未具备相关资格'
          .text
          .size(26.sp)
          .color(ktextPrimary)
          .bold
          .isIntrinsic
          .make(),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            child:
                '返回'.text.size(34.sp).isIntrinsic.color(ktextPrimary).make()),
        CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            child: '修改信息'
                .text
                .size(34.sp)
                .isIntrinsic
                .color(Color(0xFFFF8200))
                .make()),
      ],
    );
  }
}
