// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_picker/flutter_picker.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/picker/bee_date_picker.dart';
@Deprecated('s**t code should be remove')
class CommonPicker extends StatefulWidget {
  final String title;
  CommonPicker({Key key, this.title}) : super(key: key);

  @override
  _CommonPickerState createState() => _CommonPickerState();
}

class _CommonPickerState extends State<CommonPicker> {
  String pickerData = '请选择';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.w,
      padding: EdgeInsets.symmetric(vertical: 28.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 30.w),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
            ),
          ),
          InkWell(
            onTap: () {
              switch (widget.title) {
                case '出户时间':
                  BeeDatePicker.pick(DateTime.now());
                  // DatePicker.showDatePicker(context,
                  //     showTitleActions: true,
                  //     minTime: DateTime(2020, 1, 1),
                  //     maxTime: DateTime(2020, 12, 31), onChanged: (date) {
                  //   print('change $date in time zone ' +
                  //       date.timeZoneOffset.inHours.toString());
                  // }, onConfirm: (date) {
                  //   pickerData = date.toString().substring(0, 11);
                  //   setState(() {});
                  // }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  break;
                case '物品名称':
                  Picker(
                      adapter: PickerDataAdapter<String>(
                        pickerdata: [
                          ["全部", "家纺", "家具", "电器"]
                        ],
                        isArray: true,
                      ),
                      changeToFirst: true,
                      hideHeader: false,
                      title: Text(
                        "物品名称",
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Color(0xff333333),
                        ),
                      ),
                      confirmTextStyle: TextStyle(
                        fontSize: 28.sp,
                        color: Color(0xffffc40c),
                      ),
                      cancelTextStyle: TextStyle(
                        fontSize: 28.sp,
                        color: Color(0xff333333),
                      ),
                      onConfirm: (Picker picker, List value) {
                        pickerData = picker.getSelectedValues()[0];
                        setState(() {});
                        print(value.toString());
                        print(picker.getSelectedValues());
                      }).showModal(context);
                  break;
                default:
              }
            },
            child: Container(
              width: 538.w,
              height: 40.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pickerData,
                    style: TextStyle(fontSize: 28.sp, color: Color(0xff999999)),
                  ),
                  Icon(
                    AntDesign.right,
                    color: Color(0xff999999),
                    size: 32.sp,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
