import 'dart:io';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/models/house/lease_detail_model.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/ui/profile/house/house_information_check_page.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/bee_input_row.dart';
import 'package:aku_community/widget/others/user_tool.dart';
import 'package:aku_community/widget/picker/identify_card_picker.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SupplementInformationPage extends StatefulWidget {
  final int leaseId;
  SupplementInformationPage({Key? key, required this.leaseId})
      : super(key: key);

  @override
  _SupplementInformationPageState createState() =>
      _SupplementInformationPageState();
}

class _SupplementInformationPageState extends State<SupplementInformationPage> {
  ///姓名
  TextEditingController _nameController = TextEditingController();
  String _sex = '请选择性别';

  ///电话
  String _tel = UserTool.userProvider.userInfoModel!.tel!;

  ///身份证号
  TextEditingController _codeController = TextEditingController();

  ///紧急联系人
  TextEditingController _emergencyContactController = TextEditingController();

  ///紧急联系人电话
  TextEditingController _emergencyPhoneController = TextEditingController();

  ///通讯地址
  TextEditingController _addressController = TextEditingController();

  ///工作单位
  TextEditingController _workUnitController = TextEditingController();

  ///代缴银行名称
  TextEditingController _bankNameController = TextEditingController();

  ///代缴银行账户
  TextEditingController _bankCodeController = TextEditingController();

  ///身份证照片正面
  File? _idCardFront;
  ///身份证照片反面
  File? _idCardBack;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 300), () async {
      LeaseDetailModel? model = await HouseFunc().leaseDetail(widget.leaseId);
      if (model != null) {
        initModel(model);
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    _addressController.dispose();
    _workUnitController.dispose();
    super.dispose();
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
            hintText: '',
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
          BeeInputRow.button(
            title: '手机号码',
            hintText: _tel,
            onPressed: () {},
            isRequire: true,
          ),
          BeeInputRow(
            title: '身份证号',
            controller: _codeController,
            hintText: '',
            isRequire: true,
          ),
          BeeInputRow(
              title: '紧急联系人',
              controller: _emergencyContactController,
              hintText: '填写紧急联系人'),
          BeeInputRow(
              title: '紧急联系人电话',
              controller: _emergencyPhoneController,
              hintText: '填写紧急联系人电话'),
          BeeInputRow(
              title: '通讯地址(含诉讼送达地址)',
              controller: _addressController,
              hintText: '填写地址'),
          BeeInputRow(
              title: '工作单位',
              controller: _workUnitController,
              hintText: '填写工作单位'),
          BeeInputRow(
              title: '代缴银行',
              controller: _bankNameController,
              hintText: '填写代缴银行'),
          BeeInputRow(
              title: '代缴银行账户',
              controller: _bankCodeController,
              hintText: '填写代缴银行账户'),
          IdentifyCardPicker.front((file) => () {
                _idCardFront = file;
              }),
          IdentifyCardPicker.back((file) => () {
                _idCardBack = file;
              }),
        ].sepWidget(separate: 24.w.heightBox),
      ),
      bottomNavi: BottomButton(
          onPressed: () {
            if (canSubmit) {

              Get.to(() => HouseInformationCheckPage());
            }
          },
          child: '下一步'.text.size(32.sp).bold.color(ktextPrimary).make()),
    );
  }

  //初始化model,基本信息回显
  initModel(LeaseDetailModel? model) {
    if (model != null) {
      _nameController.text = model.name;
      _sex = HouseFunc.toSex[model.sex]!;
      _codeController.text = model.idCard;
      if (!model.emergencyContact.isEmptyOrNull) {
        _emergencyContactController.text = model.emergencyContact!;
      }
      if (!model.emergencyContactNumber.isEmptyOrNull) {
        _emergencyPhoneController.text = model.emergencyContactNumber!;
      }
      if (!model.bankAccountName.isEmptyOrNull) {
        _bankNameController.text = model.bankAccountName!;
      }
      if (!model.bankAccount.isEmptyOrNull) {
        _bankCodeController.text = model.bankAccount!;
      }
      if (!model.workUnits.isEmptyOrNull) {
        _workUnitController.text = model.workUnits!;
      }
      if (!model.correspondenceAddress.isEmptyOrNull) {
        _addressController.text = model.correspondenceAddress!;
      }
    }
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

  bool get canSubmit {
    if (_nameController.text.isEmpty) {
      BotToast.showText(text: '姓名不能为空！');
      return false;
    }
    if (_codeController.text.isEmpty) {
      BotToast.showText(text: '身份证号码不能为空！');
      return false;
    }
    if (_sex == '请选择性别') {
      BotToast.showText(text: '请先选择性别');
      return false;
    }
    if (_addressController.text.isEmpty) {
      BotToast.showText(text: '请填写地址');
      return false;
    }
    if (_bankNameController.text.isEmpty) {
      BotToast.showText(text: '请填写代缴银行名称');
      return false;
    }
    if (_bankCodeController.text.isEmpty) {
      BotToast.showText(text: '请填写代缴银行账户');
      return false;
    }
    if (_addressController.text.isEmpty) {
      BotToast.showText(text: '请填写地址');
      return false;
    }
    if (_workUnitController.text.isEmpty) {
      BotToast.showText(text: '请填写单位名称');
    }
    if (_emergencyContactController.text.isEmpty) {
      BotToast.showText(text: '请填写紧急联系人');
      return false;
    }
    if (_emergencyPhoneController.text.isEmpty) {
      BotToast.showText(text: '请填写紧急联系人电话');
      return false;
    }
    if (_idCardFront == null) {
      BotToast.showText(text: '请选择身份证正面照片');
      return false;
    }
    if (_idCardBack == null) {
      BotToast.showText(text: '请选择身份证背面照片');
      return false;
    }
    return true;
  }
}
