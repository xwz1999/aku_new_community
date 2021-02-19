// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';

class BeeCustomPicker extends StatefulWidget {
  final Widget body;
  final VoidCallback onPressed;
  BeeCustomPicker({Key key, this.body, this.onPressed}) : super(key: key);

  @override
  _BeeCustomPickerState createState() => _BeeCustomPickerState();
}

class _BeeCustomPickerState extends State<BeeCustomPicker> {
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
                leading: TextButton(
                  onPressed: Get.back,
                  child: '取消'.text.black.make(),
                ),
                trailing: TextButton(
                  onPressed: widget.onPressed,
                  child: '确定'.text.black.make(),
                ),
              ),
            ),
            widget.body,
          ],
        ),
      ),
      height: Get.height / 3,
    );
  }
}
