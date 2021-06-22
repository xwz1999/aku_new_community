import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/others/bee_input_row.dart';
import 'package:flutter/material.dart';

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
        children: [
          BeeInputRow(
            title: '承租人',
            controller: _nameController,
            hintText: '杨赟',
            isRequire: true,
          ),
          BeeInputRow.button(title: '性别', onPressed:(){} , hintText: _sex,isRequire: true,),
          BeeInputRow(title: '手机号码', controller: _phoneController, hintText: '13742494159',isRequire: true,),
          BeeInputRow(title: '身份证号', controller: _codeController, hintText: 'hintText',isRequire: true,),
          BeeInputRow(title: '紧急联系人', controller: _emergencyContactController, hintText: 'hintText'),
          BeeInputRow(title: '紧急联系人电话', controller: _emergencyPhoneController, hintText: 'hintText'),
          BeeInputRow(title: '通讯地址(含诉讼送达地址)', controller: _addressController, hintText: 'hintText'),
          BeeInputRow(title: '工作单位', controller: _workUnitController, hintText: 'hintText'),
          


        ],
      ),
    );
  }
}
