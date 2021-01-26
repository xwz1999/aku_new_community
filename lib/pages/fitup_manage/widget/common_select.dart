// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_picker/flutter_picker.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class CommonSelect extends StatefulWidget {
  final String title;
  CommonSelect({Key key, this.title}) : super(key: key);

  @override
  _CommonSelectState createState() => _CommonSelectState();
}

class _CommonSelectState extends State<CommonSelect> {
  String pickerData = '请选择';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          switch (widget.title) {
                case '时间':
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 1, 1),
                      maxTime: DateTime(2020, 12, 31), onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    pickerData = date.toString().substring(0, 11);
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  break;
                case '证件类型':
                  Picker(
                      adapter: PickerDataAdapter<String>(
                        pickerdata: [
                          ["身份证", "驾驶证", "护照"]
                        ],
                        isArray: true,
                      ),
                      changeToFirst: true,
                      hideHeader: false,
                      title: Text(
                        "证件类型",
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pickerData,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize36,
                  color: BaseStyle.color999999,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                AntDesign.right,
                color: BaseStyle.color999999,
                size: 32.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
