import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_new_community/utils/headers.dart';

class BeeChooseDatePicker extends StatefulWidget {
  final Widget? body;
  final VoidCallback? onPressed;
  final double? height;

  BeeChooseDatePicker({Key? key, this.body, this.onPressed, this.height}) : super(key: key);

  @override
  _BeeChooseDatePickerState createState() => _BeeChooseDatePickerState();
}

class _BeeChooseDatePickerState extends State<BeeChooseDatePicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: NavigationToolbar(
                leading: Text(
                  '选择日期',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ).paddingAll(25.w),
                trailing: TextButton(
                  onPressed: widget.onPressed,
                  child: '下一步'.text.color(Colors.blue).make(),
                ),
              ),
            ),
            widget.body!,
          ],
        ),
      ),
      height: widget.height??Get.height / 3,
    );
  }
}
