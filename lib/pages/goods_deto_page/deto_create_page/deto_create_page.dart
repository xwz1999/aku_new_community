import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/widget/common_image_picker.dart';
import 'package:akuCommunity/widget/bottom_button.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'widget/common_radio.dart';
import 'widget/common_picker.dart';

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
      padding: EdgeInsets.only(bottom: Screenutil.length(24)),
      margin: EdgeInsets.only(bottom: Screenutil.length(40)),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Screenutil.length(32)),
            child: Text(
              '出户房屋',
              style: TextStyle(
                fontSize: Screenutil.size(28),
                color: Color(0xff333333),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: Screenutil.length(42)),
                child: Image.asset(
                  AssetsImage.HOUSEATTESTATION,
                  height: Screenutil.length(59),
                  width: Screenutil.length(59),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Screenutil.size(32),
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: Screenutil.length(10)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Screenutil.size(32),
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
        padding: EdgeInsets.only(bottom: Screenutil.length(24)),
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
                  fontSize: Screenutil.size(28),
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
              title,
              style: TextStyle(
                  fontSize: Screenutil.size(28), color: Color(0xff333333)),
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
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '物品出户',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Screenutil.length(32),
                right: Screenutil.length(32),
                top: Screenutil.length(32),
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
                    margin: EdgeInsets.only(
                        top: Screenutil.length(54),
                        bottom: Screenutil.length(24)),
                    child: Text(
                      '添加图片信息(0/9)',
                      style: TextStyle(
                        fontSize: Screenutil.size(28),
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                  CommonImagePicker(),
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
