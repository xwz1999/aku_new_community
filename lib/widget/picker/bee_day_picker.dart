import 'package:aku_new_community/models/facility/facility_type_detail_model.dart';
import 'package:aku_new_community/ui/community/facility/facility_preorder_date_picker.dart';
import 'package:aku_new_community/widget/picker/bee_choose_date_picker.dart';
import 'package:aku_new_community/widget/picker/bee_month_pick_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/widget/picker/bee_custom_picker.dart';

class BeeDayPicker {

  static Future<DateTime?> pick(
    DateTime initDate, {
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
    DateTime? min,
    DateTime? max,
  }) async {
    return await Get.bottomSheet(_BeeDayPicker(
      date: initDate,
      mode: mode,
      min: min ?? DateTime.now().subtract(Duration(days: 1)),
      max: max,
    ));
  }
}

class _BeeDayPicker extends StatefulWidget {
  final DateTime date;
  final bool use24H;
  final DateTime? max;
  final DateTime? min;
  final CupertinoDatePickerMode? mode;

  _BeeDayPicker({
    Key? key,
    required this.date,
    this.use24H = false,
    this.max,
    this.min,
    this.mode,
  }) : super(key: key);

  @override
  __BeeDayPickerState createState() => __BeeDayPickerState();
}

class __BeeDayPickerState extends State<_BeeDayPicker> {
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return BeeChooseDatePicker(
      onPressed: () async{
        Get.back();
         // await FacilityPreorderDatePicker();
      },
      body: CupertinoDatePicker(
        use24hFormat: widget.use24H,
        maximumDate: widget.max,
        minimumDate: widget.min,
        initialDateTime: _date,
        onDateTimeChanged: (date) => _date = date,
        mode: widget.mode ?? CupertinoDatePickerMode.date,
      ).expand(),
    );
  }
}
