import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RecordCard extends StatelessWidget {
  final Function fun;
  RecordCard({Key key, this.fun}) : super(key: key);

  List<Map<String, dynamic>> _listBill = [
    {
      'title': '物业管理费',
      'value': '深蓝公寓 1幢1单元306',
      'titleStyle': TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: BaseStyle.fontSize30,
        color: BaseStyle.color333333,
      ),
      'valueStyle': TextStyle(
        fontSize: BaseStyle.fontSize24,
        color: BaseStyle.color999999,
      ),
      'top': 30,
      'isShow': false,
    },
    {
      'title': '2019年',
      'value': '- ¥1000.00',
      'titleStyle': TextStyle(
        fontSize: BaseStyle.fontSize28,
        color: BaseStyle.color666666,
      ),
      'valueStyle': TextStyle(
        fontSize: BaseStyle.fontSize28,
        color: Color(0xfffc361d),
      ),
      'top': 50,
      'isShow': true,
    },
    {
      'title': '创建时间',
      'value': '2020/08/01 10:00',
      'titleStyle': TextStyle(
        fontSize: BaseStyle.fontSize28,
        color: BaseStyle.color666666,
      ),
      'valueStyle': TextStyle(
        fontSize: BaseStyle.fontSize28,
        color: BaseStyle.color333333,
      ),
      'top': 30,
      'isShow': false,
    },
    {
      'title': '付款方式',
      'value': '支付宝',
      'titleStyle': TextStyle(
        fontSize: BaseStyle.fontSize28,
        color: BaseStyle.color666666,
      ),
      'valueStyle': TextStyle(
        fontSize: BaseStyle.fontSize28,
        color: BaseStyle.color333333,
      ),
      'top': 30,
      'isShow': false,
    },
    {
      'title': '订单号',
      'value': '2020080100030001433244',
      'titleStyle': TextStyle(
        fontSize: BaseStyle.fontSize28,
        color: BaseStyle.color666666,
      ),
      'valueStyle': TextStyle(
        fontSize: BaseStyle.fontSize28,
        color: BaseStyle.color333333,
      ),
      'top': 30,
      'isShow': false,
    },
  ];

  Container _billItem(String title, value, TextStyle titleStyle, valueStyle,
      double top, bool isShow, Function fun) {
    return Container(
      margin: EdgeInsets.only(top: Screenutil.length(top)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          isShow
              ? InkWell(
                  onTap: fun,
                  child: Row(
                    children: [
                      Text(
                        value,
                        style: valueStyle,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Screenutil.length(24)),
                        child: Icon(
                          AntDesign.right,
                          color: BaseStyle.color999999,
                          size: Screenutil.length(30),
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  value,
                  style: valueStyle,
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(32),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      padding: EdgeInsets.only(
        left: Screenutil.length(20),
        right: Screenutil.length(20),
        bottom: Screenutil.length(32),
        top: Screenutil.length(2),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _listBill
            .map((item) => _billItem(
                item['title'],
                item['value'],
                item['titleStyle'],
                item['valueStyle'],
                item['top'].toDouble(),
                item['isShow'],
                fun))
            .toList(),
      ),
    );
  }
}
