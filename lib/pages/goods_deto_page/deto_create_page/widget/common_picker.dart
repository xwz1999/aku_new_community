import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:akuCommunity/utils/screenutil.dart';

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
      height: Screenutil.length(96),
      padding: EdgeInsets.symmetric(vertical: Screenutil.length(28)),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: Screenutil.length(30)),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: Screenutil.size(28), color: Color(0xff333333)),
            ),
          ),
          InkWell(
            onTap: () {
              switch (widget.title) {
                case '出户时间':
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
                          fontSize: Screenutil.size(32),
                          color: Color(0xff333333),
                        ),
                      ),
                      confirmTextStyle: TextStyle(
                        fontSize: Screenutil.size(28),
                        color: Color(0xffffc40c),
                      ),
                      cancelTextStyle: TextStyle(
                        fontSize: Screenutil.size(28),
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
              width: Screenutil.length(538),
              height: Screenutil.length(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pickerData,
                    style: TextStyle(
                        fontSize: Screenutil.size(28),
                        color: Color(0xff999999)),
                  ),
                  Icon(
                    AntDesign.right,
                    color: Color(0xff999999),
                    size: Screenutil.size(32),
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
