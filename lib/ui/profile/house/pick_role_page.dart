import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

///选择身份
///
///业主  亲属  租客
class PickRolePage extends StatefulWidget {
  final int? init;

  PickRolePage({Key? key, this.init = 0}) : super(key: key);

  static String getType(int? index) {
    switch (index) {
      case 1:
        return '业主';
      case 2:
        return '亲属';
      case 3:
        return '租客';
      default:
        return '';
    }
  }

  @override
  _PickRolePageState createState() => _PickRolePageState();
}

class _PickRolePageState extends State<PickRolePage> {
  static const Map<int, String> _role = {
    1: '业主',
    2: '亲属',
    3: '租客',
  };
  int? _pickedValue;
  Widget _renderTile(int index, String title) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 28.w,
      ),
      onPressed: () {
        setState(() => _pickedValue = index);
        Get.back(result: _pickedValue);
      },
      child: Row(
        children: [
          Radio(
            value: index,
            groupValue: _pickedValue,
            onChanged: (dynamic value) {
              setState(() {
                _pickedValue = value;
              });
              Get.back(result: _pickedValue);
            },
          ),
          16.wb,
          Text(
            title,
            style: TextStyle(
              fontSize: 28.sp,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pickedValue = widget.init;
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择身份',
      body: ListView(
        children: _role.entries
            .map((e) => _renderTile(e.key, e.value))
            .toList()
            .sepWidget(),
      ),
    );
  }
}
