// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/bottom_button.dart';
import 'package:akuCommunity/widget/picker/grid_image_picker.dart';
import 'widget/common_picker.dart';
import 'widget/common_radio.dart';

class DetoCreatePage extends StatefulWidget {
  DetoCreatePage({Key key}) : super(key: key);

  @override
  _DetoCreatePageState createState() => _DetoCreatePageState();
}

class _DetoCreatePageState extends State<DetoCreatePage> {
  List<Map<String, dynamic>> _listWeight = [
    {'title': '< 50kg', 'isCheck': true},
    {'title': '50kg-100kg', 'isCheck': false},
    {'title': '> 100kg', 'isCheck': false}
  ];

  List<Map<String, dynamic>> _listMode = [
    {'title': '自己搬运', 'isCheck': true},
    {'title': '搬家公司', 'isCheck': false},
  ];

  bool isCheck = false;

  Widget _houseAddress(String title, subtitle) {
    return Container(
      padding: EdgeInsets.only(bottom: 24.w),
      margin: EdgeInsets.only(bottom: 40.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 32.w),
            child: Text(
              '出户房屋',
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 42.w),
                child: Image.asset(
                  AssetsImage.HOUSEATTESTATION,
                  height: 59.w,
                  width: 59.w,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32.sp,
                      color: Color(0xff333333),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inkWellCheckbox() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: this.isCheck,
              activeColor: Color(0xffffc40c),
              onChanged: (bool val) {
                this.setState(() {
                  this.isCheck = !this.isCheck;
                });
              },
            ),
            Container(
              child: Text(
                '是否需要物业提供搬家公司联系方式',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkCard(String title, List<Map<String, dynamic>> list) {
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
              title,
              style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
            ),
          ),
          CommonRadio(
            commonlist: list,
            fun: (int index) {
              setState(() {
                list.forEach((item) {
                  item['isCheck'] = false;
                });
                list[index]['isCheck'] = true;
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '物品出户',
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 32.w,
                right: 32.w,
                top: 32.w,
              ),
              child: ListView(
                children: [
                  _houseAddress('宁波华茂悦峰', '1幢-1单元-702室'),
                  _checkCard('物品重量', _listWeight),
                  CommonPicker(title: '出户时间'),
                  CommonPicker(title: '物品名称'),
                  _checkCard('搬运方式', _listMode),
                  _inkWellCheckbox(),
                  Container(
                    margin: EdgeInsets.only(top: 54.w, bottom: 24.w),
                    child: Text(
                      '添加图片信息(0/9)',
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                  GridImagePicker(onChange: (files) {}),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: BottomButton(title: '确认提交'),
            )
          ],
        ),
      ),
    );
  }
}
