// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class BeeDatePicker {
  static Future<DateTime> pick(DateTime initDate) async {
    return await Get.bottomSheet(_BeeDatePicker(date: initDate));
  }

  static Future<DateTime> timePicker(DateTime initDate) async {
    return await Get.bottomSheet(_BeeDatePicker(
      date: initDate,
      min: initDate,
      max: initDate.add(Duration(days: 7)),
      mode: CupertinoDatePickerMode.dateAndTime,
    ));
  }
}

class _BeeDatePicker extends StatefulWidget {
  final DateTime date;
  final bool use24H;
  final DateTime max;
  final DateTime min;
  final CupertinoDatePickerMode mode;
  _BeeDatePicker(
      {Key key,
      @required this.date,
      this.use24H = false,
      this.max,
      this.min,
      this.mode})
      : super(key: key);

  @override
  __BeeDatePickerState createState() => __BeeDatePickerState();
}

class __BeeDatePickerState extends State<_BeeDatePicker> {
  DateTime _date = DateTime.now();
  @override
  void initState() {
    super.initState();
    _date = widget.date ?? DateTime.now();
  }

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
                  onPressed: () => Get.back(result: _date),
                  child: '确定'.text.black.make(),
                ),
              ),
            ),
            CupertinoDatePicker(
              use24hFormat: widget.use24H,
              maximumDate: widget.max,
              minimumDate: widget.min,
              initialDateTime: _date,
              onDateTimeChanged: (date) => _date = date,
              mode:widget.mode?? CupertinoDatePickerMode.date,
            ).expand(),
          ],
        ),
      ),
      height: Get.height / 3,
    );
  }
}
