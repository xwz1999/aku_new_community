import 'package:flutter/material.dart';

import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'widget/bill_card.dart';

class LifePayBillPage extends StatefulWidget {
  LifePayBillPage({Key? key}) : super(key: key);

  @override
  _LifePayBillPageState createState() => _LifePayBillPageState();
}

class _LifePayBillPageState extends State<LifePayBillPage> {
  Widget _cardList(String title, subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28.sp,
            color: Color(0xff666666),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28.sp,
            color: Color(0xff333333),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '账单详情',
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32.w, left: 32.w, right: 32.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 32.w,
            ),
            child: Column(
              children: [
                _cardList('收费项目', '公共能耗费'),
                SizedBox(height: 30.w),
                _cardList('收费地址', '深蓝公寓 1幢1单元306室'),
              ],
            ),
          ),
          BillCard(),
        ],
      ),
    );
  }
}
