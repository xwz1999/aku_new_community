import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/widget/common_input.dart';

class VisitorAccessPage extends StatefulWidget {
  VisitorAccessPage({Key key}) : super(key: key);

  @override
  _VisitorAccessPageState createState() => _VisitorAccessPageState();
}

class _VisitorAccessPageState extends State<VisitorAccessPage> {
  TextEditingController _userName = new TextEditingController();
  TextEditingController _userCarNum = new TextEditingController();
  String dateTime = '请选择到访时间';
  List<Map<String, dynamic>> _sexList = [
    {'sex': '先生', 'sexIcon': AntDesign.man, 'isCheck': true},
    {'sex': '女士', 'sexIcon': AntDesign.woman, 'isCheck': false},
  ];

  Widget _house() {
    return Container(
      padding: EdgeInsets.only(
        left: 36.w,
        right: 36.w,
        top: 32.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '来访房屋',
            style: TextStyle(
                fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 32.w),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      AssetsImage.HOUSE,
                      height: 60.w,
                      width: 60.w,
                    ),
                    SizedBox(width: 40.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '宁波华茂悦峰',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 34.sp,
                              color: Color(0xff333333)),
                        ),
                        SizedBox(height: 10.w),
                        Text(
                          '1幢-1单元-702室',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 34.sp,
                              color: Color(0xff333333)),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 14.w,
                    horizontal: 21.w,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffFEC200),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Text(
                    '邀请客户填写',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28.sp,
                        color: Color(0xff333333)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 26.w),
          Divider(),
        ],
      ),
    );
  }

  Widget _input(String title, hintText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 36.w,
        right: 36.w,
        top: 32.w,
        bottom: 24.w,
      ),
      margin: EdgeInsets.only(bottom: 60.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 25.w),
          CommonInput(inputController: controller, hintText: hintText)
        ],
      ),
    );
  }

  Widget _sexButton(String sex, IconData sexIcon, bool isCheck, int index) {
    return InkWell(
      onTap: () {
        _sexList.forEach((item) {
          item['isCheck'] = false;
        });
        _sexList[index]['isCheck'] = true;
        setState(() {});
      },
      child: Container(
        height: 72.w,
        width: 176.w,
        padding: EdgeInsets.symmetric(
          vertical: 13.w,
        ),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.all(Radius.circular(36)),
            border: Border.all(
                color: isCheck ? Color(0xffffc40c) : Color(0xff979797),
                width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              sexIcon,
              size: 32.sp,
              color: isCheck ? Color(0xff333333) : Color(0xff979797),
            ),
            SizedBox(width: 9.w),
            Text(
              sex,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                  color: isCheck ? Color(0xff333333) : Color(0xff979797)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sexSelect() {
    return Container(
      padding: EdgeInsets.only(
        left: 36.w,
        right: 36.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '访客性别',
            style: TextStyle(
                fontSize: 28.sp, color: Color(0xff333333)),
          ),
          SizedBox(height: 32.w),
          Container(
            child: Row(
              children: [
                _sexButton(_sexList[0]['sex'], _sexList[0]['sexIcon'],
                    _sexList[0]['isCheck'], 0),
                SizedBox(width: 80.w),
                _sexButton(_sexList[1]['sex'], _sexList[1]['sexIcon'],
                    _sexList[1]['isCheck'], 1),
              ],
            ),
          ),
          SizedBox(height: 26.w),
        ],
      ),
    );
  }

  Widget _selectTime() {
    return InkWell(
      onTap: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2020, 1, 1),
            maxTime: DateTime(2020, 12, 31), onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          dateTime = date.toString().substring(0, 11);
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.zh);
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 36.w,
          right: 36.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '到访时间',
              style: TextStyle(
                  fontSize: 28.sp, color: Color(0xff333333)),
            ),
            SizedBox(height: 32.w),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$dateTime',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 34.sp,
                        color: Color(0xff333333)),
                  ),
                  Icon(
                    AntDesign.right,
                    size: 36.sp,
                    color: Color(0xffd8d8d8),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26.w),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _create() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 96.w,
        width: 686.w,
        padding: EdgeInsets.symmetric(
          vertical: 26.w,
        ),
        decoration: BoxDecoration(
            color: Color(0xffffc40c),
            borderRadius: BorderRadius.all(Radius.circular(48))),
        child: Text(
          '生成通行证',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.sp,
              color: Color(0xff333333)),
        ),
      ),
    );
  }

  Widget _tips() {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.w,
        ),
        child: Text(
          '通行证只在到访当天单次有效,逾期或超次需要重新生成',
          style: TextStyle(
              fontSize: 20.sp, color: Color(0xff999999)),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '访客通行',
          subtitle: '访客记录',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: [
                    _house(),
                    _input('访客姓名', '请输入访客姓名', _userName),
                    _sexSelect(),
                    _input('是否驾车', '请输入,例如浙A88888(没有驾车可不填)', _userCarNum),
                    _selectTime(),
                    SizedBox(height: 64.w),
                    _create(),
                    _tips(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
