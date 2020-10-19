import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/widget/bottom_button.dart';

class PayModelSheet extends StatefulWidget {
  PayModelSheet({Key key}) : super(key: key);

  @override
  _PayModelSheetState createState() => _PayModelSheetState();
}

class _PayModelSheetState extends State<PayModelSheet> {
  List<Map<String, dynamic>> _listPay = [
    {
      'title': '支付宝支付',
      'widget': Icon(
        AntDesign.alipay_circle,
        color: Color(0xff06b4fd),
        size: Screenutil.length(50),
      ),
      'id': 'alipay',
      'isCheck': true
    },
    {
      'title': '微信支付',
      'widget': Image.asset(
        AssetsImage.WXPAY,
        height: Screenutil.length(60),
        width: Screenutil.length(60),
      ),
      'id': 'wxpay',
      'isCheck': false
    }
  ];

  int _currentindex = 0 ;

  void _showModelBotoomSheet() {
    showModalBottomSheet(
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
            top: Screenutil.length(20),
            left: Screenutil.length(20),
            right: Screenutil.length(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        AntDesign.left,
                        size: Screenutil.size(40),
                        color: BaseStyle.color999999,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(left: Screenutil.length(190)),
                      child: Text(
                        '选择付款方式',
                        style: TextStyle(
                          fontSize: BaseStyle.fontSize32,
                          color: BaseStyle.color333333,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: _listPay
                    .asMap()
                    .keys
                    .map((index) => _inkWellSelectPay(_listPay[index]['title'],
                        _listPay[index]['widget'], index))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  InkWell _inkWellSelectPay(String title, Widget logo, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _listPay.forEach((item) {
            item['isCheck'] = false;
          });
          _listPay[index]['isCheck'] = true;
          _currentindex = index;
          Navigator.pop(context);
        });
      },
      child: Container(
        padding: EdgeInsets.only(
          top: Screenutil.length(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            logo,
            SizedBox(width: Screenutil.length(24)),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: Screenutil.length(27),
                  top: Screenutil.length(28),
                ),
                decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize28,
                          color: BaseStyle.color333333),
                    ),
                    _listPay[index]['isCheck']
                        ? Icon(
                            AntDesign.check,
                            color: BaseStyle.colorffc40c,
                            size: Screenutil.length(50),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _inkWellDefaultPay() {
    return InkWell(
      onTap: _showModelBotoomSheet,
      child: Container(
        padding: EdgeInsets.only(
          bottom: Screenutil.length(27),
          top: Screenutil.length(28),
        ),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _listPay[_currentindex]['widget'],
                SizedBox(width: Screenutil.length(24)),
                Text(
                  _listPay[_currentindex]['title'],
                  style: TextStyle(
                      fontSize: BaseStyle.fontSize28,
                      color: BaseStyle.color333333),
                ),
              ],
            ),
            Icon(
              AntDesign.right,
              color: BaseStyle.color999999,
              size: Screenutil.length(32),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: Screenutil.length(36),
              left: Screenutil.length(32),
              right: Screenutil.length(32),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: BaseStyle.coloreeeeee, width: 0.5)),
                  ),
                  padding: EdgeInsets.only(bottom: Screenutil.length(20)),
                  child: Text(
                    '付款详情',
                    style: TextStyle(
                      fontSize: BaseStyle.fontSize32,
                      color: BaseStyle.color333333,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: Screenutil.length(80),
                    top: Screenutil.length(89),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: BaseStyle.coloreeeeee, width: 0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '￥${5300}',
                        style: TextStyle(
                          fontSize: BaseStyle.fontSize52,
                          color: Color(0xffe60e0e),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Screenutil.length(20)),
                      Text(
                        '注释：装修押金${5000}元，垃圾清理费${300}元',
                        style: TextStyle(
                            fontSize: BaseStyle.fontSize22,
                            color: BaseStyle.color999999),
                      ),
                    ],
                  ),
                ),
                _inkWellDefaultPay(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: BottomButton(
              title: '立即付款',
            ),
          )
        ],
      ),
    );
  }
}
