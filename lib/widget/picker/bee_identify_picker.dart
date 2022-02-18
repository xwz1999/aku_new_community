import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:aku_new_community/utils/bee_map.dart';
import 'package:aku_new_community/utils/enum/identify.dart';
import 'package:aku_new_community/widget/picker/bee_picker_box.dart';

class BeeIdentifyPicker extends StatefulWidget {
  static Future<Identify> pick(BuildContext context) async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return BeeIdentifyPicker();
        });
    return result;
  }

  const BeeIdentifyPicker({
    Key? key,
  }) : super(key: key);

  @override
  _BeeIdentifyPickerState createState() => _BeeIdentifyPickerState();
}

class _BeeIdentifyPickerState extends State<BeeIdentifyPicker> {
  Identify _identify = Identify.OWNER;

  @override
  Widget build(BuildContext context) {
    return BeePickerBox(
        onPressed: () {
          Get.back(result: _identify);
        },
        title: '选择身份',
        child: CupertinoPicker(
          onSelectedItemChanged: (int value) {
            _identify = Identify.values[value];
          },
          itemExtent: 80.w,
          children: Identify.values
              .map((e) => Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 40.w),
                      child: Text(BeeMap.getIdentify(e),
                          textAlign: TextAlign.center),
                    ),
                  ))
              .toList(),
        ));
  }
}
