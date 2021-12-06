import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillCard extends StatelessWidget {
  BillCard({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _listBill = [
    {'title': '账单月份', 'value': '2020年1月'},
    {'title': '账单金额', 'value': '¥19.40'},
    {'title': '已缴金额', 'value': '¥0.00'},
    {'title': '本次应收', 'value': '¥19.40'},
    {'title': '计费周期', 'value': '2019/12/11 - 2020/01/10'},
    {'title': '单位价格', 'value': '0.70/平方米/每月'},
    {'title': '面积/用量/数量', 'value': '0.00'}
  ];

  Container _billItem(String title, value) {
    return Container(
      margin: EdgeInsets.only(top: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: ktextSubColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize28,
              color: ktextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 32.w,
        left: 32.w,
        right: 32.w,
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 32.w,
        top: 2.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _listBill
            .map((item) => _billItem(item['title'], item['value']))
            .toList(),
      ),
    );
  }
}
